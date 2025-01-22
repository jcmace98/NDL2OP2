//time spent standing still to lose our running bonus
var/const/RUN_TIMEOUT = 30
//number of steps we must take to speed up 1 tick
var/const/STEPS_PER_SPEEDUP = 5
//number of steps we lose for turning
var/const/PENALTY_FOR_TURN = 5//is 5
mob
  var/tmp/runningspeed = 0
  //steps after maxrunning won't count.  In this case, our speed is reduced by 3 ticks at most
  var/maxrunning = 2 * STEPS_PER_SPEEDUP
  var/tmp/nextmove = 0
  var/minspeed = 3
  proc
    //tell us how long we should delay between steps
    getMoveDelay()
      if(!src.Running)
        src.runningspeed=0
      if(src.Running&&!src.controlled)
        src.RunDrain()
      return minspeed - round(runningspeed / STEPS_PER_SPEEDUP)
    speedUp()
      var/TheMaximumRunningSpeed=(maxrunning+src.RunningSpeed)+(src.shika?20:0)
      if(src.CheckForAutoRun()&&!src.LegSliced)
        TheMaximumRunningSpeed=15+(src.shika?20:0)
        if(src.runningspeed<(10+(src.shika?20:0)))
          src.runningspeed=10+(src.shika?20:0)
        src.Running=1
      else if((src.stamina/src.maxstamina)<0.1||src.BaikaCharged>=1&&!src.intank||src.LegSliced)
        src.Running=0
      else if(src.deathcount>=6&&src.Running)
        src<<"You're too tired to run anymore. Get some rest quick."
        src.Running=0
      if(!src.Running)
        src.icon_state="";return
      var/SpeedIncrease=round(src.Acceleration/2)+(src.shika?3:0)
      if(src.LegSliced||src.DragPerson!="None")
        SpeedIncrease=0
      if(src.SusanooIn||src.TailedBeastMode)
        SpeedIncrease=0.05
      runningspeed+=(1+SpeedIncrease)+(src.shika?20:0)//added 6/23/12
      runningspeed = min(runningspeed, TheMaximumRunningSpeed)
    //  src<<"You speed up to [runningspeed] runningspeed. Time until next move. [src.nextmove]"
      if(runningspeed>=10)
        if(prob(4))
          if(prob(5)&&src.Clan!="Ketsueki")
            src.hunger++
          else if(prob(5))
            src.thirst++
          if(src.RunningSpeed<5)
            src.RunningSpeed+=0.05
            if(src.Trait=="Speedy")
              src.RunningSpeed+=(rand(1,5)*0.01)
            if(src.RunningSpeed>5)
              src.RunningSpeed=5
      src.CheckForIconState()
    slowDown()
      //world<<"Slow down proc called."
      if(src.controlled)
        src.runningspeed=15;
        return
      if(!src.Running)
        src.icon_state="";return
      var/TheLostSpeed=(PENALTY_FOR_TURN-(src.RunningSpeed-1))
      if(src.GateIn!=""&&src.GateIn!="Initial"&&src.GateIn!="Heal")
        TheLostSpeed=0
      if(src.Trait2=="Hyperactivity"&&src.deathcount>=2)
        TheLostSpeed=0
      if(runningspeed>7)
        if(prob(4))
          src.Acceleration+=pick(0.05,0.1,0.25,0.5)
          if(src.Trait=="Speedy")
            src.Acceleration+=0.25
          if(src.Acceleration>10)
            src.Acceleration=10
      runningspeed = max((runningspeed - TheLostSpeed), 0)
    //  src<<"You slowed down to [runningspeed] runningspeed."
      src.CheckForIconState()

client
	Move(Loc, Dir)
		if(mob.Shibari)
			if(Dir!=NORTH&&Dir!=SOUTH&&Dir!=EAST&&Dir!=WEST)
				return
		if(mob.RestrictOwnMovement)
			return
		if(mob.AFK)
			mob.AFK=0
			mob.overlays-='Icons/AFKTag.dmi'
		if(!mob.NewMovementStyle)
		//	if(!mob.controlled&&mob.runningspeed==0&&mob.dir!=Dir&&!mob.Frozen&&!mob.FrozenBind)//3/13/2013
			if(!mob.controlled&&mob.runningspeed==0&&mob.dir!=Dir&&!mob.Frozen&&(!mob.FrozenBind||mob.FrozenBind=="Mane"))
				mob.dir=Dir;return
			if(mob.UsingBow)
				mob.dir=Dir
				return
			if(mob.Kumosenkyuu)//Place stuff here if you want to make actual legit bow and Arrows!
				for(var/obj/Jutsu/Spider/bow/B in view(1,mob))
					if(B.Owner==mob)
						B.dir=mob.dir;
					break
				for(var/obj/Jutsu/Spider/bowU/B2 in view(1,mob))
					if(B2.Owner==mob)
						B2.dir=mob.dir;
					break
	    //restrict movement speed
			if(mob.nextmove != 0 && mob.nextmove > world.time)
				return 0
			if(mob.CheckIfFrozen() && !mob.controlled)
				return 0
	    //reset the running counter if we stand still for too long
			if(mob.nextmove + RUN_TIMEOUT < world.time)
				mob.runningspeed = 0
				mob.icon_state=""
				//mob<<"You've lost your running speed because you stayed still for too long."
	    //store our mob's current dir because it will change after we move
			var/D = mob.dir
			var/L = mob.loc
			if(mob.screwed||mob.Status=="Screwed")
				var/direction=pick(NORTH,EAST,SOUTH,WEST,NORTHEAST,SOUTHEAST,SOUTHWEST,NORTHWEST)
				step(mob,direction)
				mob.nextmove = world.time + mob.getMoveDelay()
				return
	    //perform the default action
			.=..()
			//if(.)
	      //if we are taking steps in the same direction, increase the running counter
			if(mob.InJibashi) // May want to replace this variable with a universal CurrentJutsuUsing="Jibashi" or something like that in the future
				for(var/obj/Jutsu/Elemental/Raiton/Electro/E in oview(15,mob))
					if(E.Owner==mob) del(E)
				mob.InJibashi=0;mob.firing=0
			if(mob.truthorbsout)
				for(var/obj/truthorbs/S in mob.truthorbs) if(S) if(S.Owner==mob&&!S.fired) S.loc=mob.loc
			if(mob.SelfHeal)
				mob.SelfHeal=0
			if(mob.InMirror)
				if(L!=Loc)
					mob.InMirror=0
			if(D == Dir)
				mob.CheckForQuickStep()
				mob.speedUp()
			  //otherwise, reduce it
			else if(!(mob.CheckForQuickStep()))
	//		if(!(mob.CheckForQuickStep()))
				mob.slowDown()
			//set when we can move next
			mob.nextmove = world.time + mob.getMoveDelay()
		else
			if(mob.InJibashi) // May want to replace this variable with a universal CurrentJutsuUsing="Jibashi" or something like that in the future
				for(var/obj/Jutsu/Elemental/Raiton/Electro/E in oview(15,mob))
					if(E.Owner==mob) del(E)
				mob.InJibashi=0;mob.firing=0
			if(mob.InMirror)
				if(L!=Loc)
					mob.InMirror=0
			if(mob.Sprinting)
				mob.CheckForQuickStep()
			return ..()


mob
	Move()
		if(!src.client)
			if(src.CNNPC)
				return
			if(src.isdog)
				src.icon_state="beastman"
			if(src.Clone&&!src.client)
				src.icon_state="running"
			if(src.nextmove != 0 && src.nextmove > world.time)
				return 0
			if(src.CheckIfFrozen())
				return 0
			.=..()
			src.nextmove = world.time + src.MoveDelay
			if(src.isdog)
				src.nextmove = world.time
		else
			if(!src.NewMovementStyle)
				if(src.CheckIfFrozen())
					return 0
				.=..()
			else
				return ..()
/*mob

    var/north,west,south,east = 0


    Login()
        ..()
        winset(client, "north", "parent=macro;name=north;command=keydown+north")
        winset(client, "north+up", "parent=macro;name=north+up;command=keyup+north")

        winset(client, "west", "parent=macro;name=west;command=keydown+west")
        winset(client, "west+up", "parent=macro;name=west+up;command=keyup+west")

        winset(client, "south", "parent=macro;name=south;command=keydown+south")
        winset(client, "south+up", "parent=macro;name=south+up;command=keyup+south")

        winset(client, "east", "parent=macro;name=east;command=keydown+east")
        winset(client, "east+up", "parent=macro;name=east+up;command=keyup+east")

        spawn move_loop()

    proc/move_loop()
        walk(src,0)
        if(src.Moving)  return;src.Moving=1
        var/FirstStep=1
        if(!step(src, (south && (SOUTH || south)) | (north && (NORTH || north)) | (west && (WEST || west)) | (east && (EAST || east)))) //try desired direction
            if(!step(src, (south && (SOUTH || south)) | (north && (NORTH || north)))) //that failed, try north or south
                step(src, (west && (WEST || west)) | (east && (EAST || EAST))) //that failed, try east or west
            if(FirstStep)   {sleep(1);FirstStep=0}
            sleep(src.GetMovementSpeed())
        spawn(GetMovementSpeed()) move_loop() //return, and do it again
        src.Moving=0


    verb/keydown(k as text)
        set hidden = 1
        set instant = 1
        if(k == "north") north = 1;SprintCheck("North");MN = 1
        if(k == "west") west = 1;SprintCheck("West");MW = 1
        if(k == "south") south = 1;SprintCheck("South");MS = 1
        if(k == "east") east = 1;SprintCheck("East");ME =1

    verb/keyup(k as text)
        set hidden = 1
        set instant = 1
        if(k == "north") north = 0;SprintCancel();MW = 0
        if(k == "west") west = 0;SprintCancel();MW = 0
        if(k == "south") south = 0;SprintCancel();MS =0
        if(k == "east") east = 0;SprintCancel();ME= 0*/
/////////////////////////////////////////////////
/////////////////////////////////////////////////
//Procs for the Running System///////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/RunDrain()
  if(src.Clan=="Ketsueki"||src.Clan2=="Ketsueki")
    if(src.Banpaia&&prob(15-(src.BloodManipulation/10)))
      src.thirst+=(4-src.ThirstHold)
  if(src.Clan!="Basic")
    if(src.ItemWeight>(500+src.Mtai))
      src.stamina-=src.ItemWeight*0.1
  else
    if(src.ItemWeight>(700+src.Mtai))
      src.stamina-=src.ItemWeight*0.05
  if(prob(25))
    src.calories-=pick(0,1)
    if(src.calories<=0)
      src.calories=0
      src.stamina-=rand(1,4)
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckIfFrozen()
	if(src.FrozenBind!=""||src.Frozen||src.UsingHealthPack||src.resting||src.CastingGenjutsu||src.Status=="Asleep"||src.UsingBow||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
		src.UsingHealthPack=0
		return 1
	else
		return 0
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckForAutoRun()
  if(src.Clone||(src.shika&&src.stamina>(src.maxstamina*0.20))||src.GateIn!=""||src.intank||src.ingat||src.Banpaia||src.SageMode!=""||src.EffectsofDrinking||src.HoshiAutoRun||src.ARank=="Infiltrator"||(src.Bijuu=="Nibi"&&src.TailState!=0))
    return 1
  else
    return 0
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckForQuickStep()
  if(src.GateIn=="Limit"||src.GateIn=="View"||src.Banpaia||src.QuickFeet&&src.Running)
    if(src.QuickFeet)
      src.chakra-=rand(15,30)
    src.Quick()
    //world<<"return 1"
    return 1
  else if(src.ARank=="Infiltrator"&&src.HoldingS||src.RunningSpeed>=10&&src.runningspeed>=20&&src.HoldingS||src.RunningSpeed>=10&&src.runningspeed>20&&src.GateIn!=""||src.RaiArmor==2&&src.HoldingS||src.SageMode!=""&&src.HoldingS||(src.Bijuu=="Nibi"&&src.TailState>=1&&src.HoldingS&&src.deathcount<=5))
    src.StaminaDrain(225)
    src.Quickness()
    //world<<"return 1"
    return 1
  else
    //world<<"return 0"
    return 0
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/proc/CheckForIconState()
	if(runningspeed<=7&&src.icon_state!="handseals")
		src.icon_state=""
	if(runningspeed>7)
		if(src.icon!='Icons/Jutsus/IwazukaTechniques.dmi'&&src.icon_state!="rest"&&src.icon_state!="Garouga"&&src.icon_state!="handseals"||src.Clone)
			src.icon_state = "running"
			if(src.CurrentMission=="Jog Walk")
				src.NumberOfSteps++
				if(src.NumberOfSteps>=1000)
					src.MissionComplete()
		if(src.TimeToAttack==5)
			if(runningspeed>=10)
				src.TimeToAttack=6
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				sd_Alert(usr, "You successfully reached full speed!","[src]",,,,0,"400x150",,style)
	if(src.shika&&src.icon_state!="Garouga"||src.isdog||src.TailState>=1)
		if(src.icon!='Icons/Jutsus/IwazukaTechniques.dmi')
			src.icon_state = "beastman"
	if(src.RightHandSheath&&src.icon_state!="Garouga")
		var/A=src.WeaponInRightHand
		if(A!=null&&!(istype(A,/obj/WEAPONS/Kunai))&&!(istype(A,/obj/WEAPONS/Senbon))&&!(istype(A,/obj/WEAPONS/Shuriken))&&!(istype(A,/obj/WEAPONS/Bow))&&!(istype(A,/obj/WEAPONS/KnuckleKnives))&&A!="Spider"&&A!="Bird"&&A!="Wall"&&A!="Flower")
			src.icon_state="weapon"
	if(src.LeftHandSheath&&src.icon_state!="Garouga")
		var/A=src.WeaponInLeftHand
		if(A!=null&&!(istype(A,/obj/WEAPONS/Kunai))&&!(istype(A,/obj/WEAPONS/Senbon))&&!(istype(A,/obj/WEAPONS/Bow))&&!(istype(A,/obj/WEAPONS/Shuriken))&&!(istype(A,/obj/WEAPONS/KnuckleKnives))&&A!="Spider"&&A!="Bird"&&A!="Wall"&&A!="Flower")
			src.icon_state="weapon"
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
mob/var
	Running=0
	Frozen=0
	MoveDelay=0
	NewMovementStyle=0
	Max_Running_Speed=10
mob/GainedAfterLogIn/verb
	X()
		set hidden=1
		if(usr.CantRunTimer&&!usr.CursedSealActivated)
			usr<<"You are too tired to run at the moment."
			usr.Running=0
			return
		if(usr.Running)
			usr.Running=0
			usr<<"You begin to walk."
			return
		else
			usr.Running=1
			usr<<"You begin to run."
			return

mob/var/tmp
	ControlClients
	Moving
	MN;MS;ME;MW
	QueN;QueS;QueE;QueW
	Sprinting=0
	MovementSpeed=3.5
	list/SprintDirs
//mob/Move(var/turf/NewLoc,NewDir)
//	if(src.Sprinting && !src.density && NewLoc.Enter(src))
//	if(src.client)
	//	if(src.client.eye!=src)	return
	//	src.overlays-=PressF
	//	if(NewLoc.Enter(src))	for(var/mob/NPCs/Humans/Generic_Talkers/N in get_step(NewLoc,NewDir))
	//		src.overlays-=PressF;src.overlays+=PressF	//if they can move check 2 in front

//	return ..()
mob/proc
	ScreenShake()
		if(!src.client)
			return
		if(src.knockedout||src.Dead)
			return
		for(var/client/C in src.ControlClients)
			for(var/i=1;i<=5;i++)
				var/PickedAmt=rand(4,8)
				var/PickedDir=pick("pixel_x","pixel_y")
				C.vars[PickedDir]+=PickedAmt
				sleep(1);if(!src || !C)	return
				C.vars[PickedDir]-=PickedAmt
mob/proc
	ResetIS(/**/)
		if(src.Sprinting&&src.icon_state!="swimming"&&src.icon_state!="shika")
			src.icon_state="running"
		else
			if(src.icon_state!="swimming"&&src.icon_state!="shika")
				src.icon_state=""
	ResetFocus()
		if(src.client.eye==locate(289,100,1))	src.client.eye=src
	MovementLoop()
		walk(src,0)
		if(src.Moving)	return;src.Moving=1
		var/FirstStep=1
		while(src.MN || src.ME || src.MW || src.MS || src.QueN || src.QueS || src.QueE || src.QueW)
			if(src.MN || src.QueN)
				if(src.ME || src.QueE)	if(!step(src,NORTHEAST) && !step(src,NORTH))	step(src,NORTHEAST)
				else if(src.MW || src.QueW)	if(!step(src,NORTHWEST) && !step(src,NORTH))	step(src,NORTHWEST)
				else	step(src,NORTH)
			else	if(src.MS || src.QueS)
				if(src.ME || src.QueE)	if(!step(src,SOUTHEAST) && !step(src,SOUTH))	step(src,SOUTHEAST)
				else if(src.MW || src.QueW)	if(!step(src,SOUTHWEST) && !step(src,SOUTH))	step(src,SOUTHWEST)
				else	step(src,SOUTH)
			else	if(src.ME || src.QueE)	step(src,EAST)
			else	if(src.MW || src.QueW)	step(src,WEST)
			src.QueN=0;src.QueS=0;src.QueE=0;src.QueW=0
			if(FirstStep)	{sleep(1);FirstStep=0}
			sleep(src.GetMovementSpeed())
		src.Moving=0

	stepDiagonal()
		var
			dir_x
			dir_y
		switch(MN)
			if(NORTH)if(MS!=SOUTH&&ME!=SOUTH&&MW!=SOUTH)dir_y=NORTH
			if(SOUTH)if(MS!=NORTH&&ME!=NORTH&&MW!=NORTH)dir_y=SOUTH
			if(EAST)if(MS!=WEST&&ME!=WEST&&MW!=WEST)dir_x=EAST
			if(WEST)if(MS!=EAST&&ME!=EAST&&MW!=EAST)dir_x=WEST
		switch(MS)
			if(NORTH)if(MN!=SOUTH&&ME!=SOUTH&&MW!=SOUTH)dir_y=NORTH
			if(SOUTH)if(MN!=NORTH&&ME!=NORTH&&MW!=NORTH)dir_y=SOUTH
			if(EAST)if(MN!=WEST&&ME!=WEST&&MW!=WEST)dir_x=EAST
			if(WEST)if(MN!=EAST&&ME!=EAST&&MW!=EAST)dir_x=WEST
		switch(ME)
			if(NORTH)if(MN!=SOUTH&&MS!=SOUTH&&MW!=SOUTH)dir_y=NORTH
			if(SOUTH)if(MN!=NORTH&&MS!=NORTH&&MW!=NORTH)dir_y=SOUTH
			if(EAST)if(MN!=WEST&&MS!=WEST&&MW!=WEST)dir_x=EAST
			if(WEST)if(MN!=EAST&&MS!=EAST&&MW!=EAST)dir_x=WEST
		switch(MW)
			if(NORTH)if(MN!=SOUTH&&MS!=SOUTH&&ME!=SOUTH)dir_y=NORTH
			if(SOUTH)if(MN!=NORTH&&MS!=NORTH&&ME!=NORTH)dir_y=SOUTH
			if(EAST)if(MN!=WEST&&MS!=WEST&&ME!=WEST)dir_x=EAST
			if(WEST)if(MN!=EAST&&MS!=EAST&&ME!=EAST)dir_x=WEST

		if(dir_x)
			if(dir_y)
			//	step(src,dir_x)
			//	step(src,dir_y)

				//	If you don't want diagonal steps broken in two use this line.
				step(src,dir_x+dir_y)

				dir=dir_x+dir_y
				return 1
			else
				step(src,dir_x)
				dir=dir_x
				return 1
		else
			if(dir_y)
				step(src,dir_y)
				dir=dir_y
				return 1
			else return 0

			//	keySet() and keyDel() are used to change the order in which the player
			//	has pressed their movement keys. It's crucial to preserve the sequence
			//	of key presses in order to determine which directions are prioritized.
	keySet(dir)
		if(MN)
			if(MS)
				if(ME)MW=dir
				else ME=dir
			else MS=dir
		else MN=dir

	keyDel(dir)
		if(MN==dir)
			MN=MS
			MS=ME
			ME=MW
			MW=0
		else
			if(MS==dir)
				MS=ME
				ME=MW
				MW=0
			else
				if(ME==dir)
					ME=MW
					MW=0
				else MW=0

/*	MovementLoop()
		var/loop_delay=0
		while(src)
			if(loop_delay>=1)
				sleep(world.tick_lag)
				loop_delay--
			else
				if(key1||key2||key3||key4)
					if(Control)
						step(Control,key1)
					if(canMove())
						if(stepDiagonal())
							loop_delay+=MovementSpeed()
				sleep(world.tick_lag)*/
mob/verb
	MoveNorth()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("North")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.UsingBow||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.MN=1;src.MS=0;QueN=1;src.keySet(NORTH);src.MovementLoop()
	StopNorth()
		set hidden=1;set instant=1
		src.MN=0;src.keyDel(NORTH);src.SprintCancel()

	MoveSouth()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("South")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.MN=0;src.MS=1;QueS=1;src.keySet(SOUTH);src.MovementLoop()
	StopSouth()
		set hidden=1;set instant=1
		src.MS=0;src.keyDel(SOUTH);src.SprintCancel()

	MoveEast()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("East")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.ME=1;src.MW=0;QueE=1;src.keySet(EAST);src.MovementLoop()
	StopEast()
		set hidden=1;set instant=1
		src.ME=0;src.keyDel(EAST);src.SprintCancel()

	MoveWest()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("West")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.ME=0;src.MW=1;QueW=1;src.keySet(WEST);src.MovementLoop()
	StopWest()
		set hidden=1;set instant=1
		src.MW=0;src.keyDel(WEST);src.SprintCancel()

	MoveNorthEast()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("NorthEast")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.UsingBow||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.MN=1;src.ME=1;src.MW=0;src.MS=0;QueN=1;QueE=1;src.keySet(NORTH);src.keySet(EAST);src.MovementLoop()
	StopNorthEast()
		set hidden=1;set instant=1
		src.MN=0;src.ME=0;src.keyDel(NORTH);src.keyDel(EAST);src.SprintCancel()

	MoveSouthEast()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("SouthEast")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.MN=0;src.MW=0;src.MS=1;src.ME=1;QueS=1;QueE=1;src.keySet(SOUTH);src.keySet(EAST);src.MovementLoop()
	StopSouthEast()
		set hidden=1;set instant=1
		src.MS=0;src.ME=0;src.keyDel(SOUTH);src.keyDel(EAST);src.SprintCancel()

	MoveNorthWest()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("NorthWest")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.ME=0;src.MS=0;src.MN=1;src.MW=1;QueN=1;QueW=1;src.keySet(NORTH);src.keySet(WEST);src.MovementLoop()
	StopNorthWest()
		set hidden=1;set instant=1
		src.MN=0;src.MW=0;src.keyDel(NORTH);src.keyDel(WEST);src.SprintCancel()

	MoveSouthWest()
		set hidden=1;set instant=1
		src.ResetFocus()
		src.SprintCheck("SouthWest")
		if(src.FrozenBind!=""||src.icon_state=="Katon"||src.Frozen||src.CastingGenjutsu||src.Status=="Asleep"||src.Kumosenkyuu||src.Guarding||src.Stun>0||src.knockedout||src.SoundSpinningKick||src.icon_state=="handseal"||src.icon_state=="Controlling"||src.icon_state=="BeingCarried"||src.icon_state=="Power"||src.alreadytalkingtohim)
			return
		src.ME=0;src.MN=0;src.MS=1;src.MW=1;QueW=1;QueS=1;src.keySet(SOUTH);src.keySet(WEST);src.MovementLoop()
	StopSouthWest()
		set hidden=1;set instant=1
		src.MS=0;src.MW=0;src.keyDel(SOUTH);src.keyDel(WEST);src.SprintCancel()

mob/proc/SprintCheck(var/TapDir)
	if(!src.SprintDirs)	src.SprintDirs=list()
	if(TapDir in src.SprintDirs)
		if(!src.Sprinting&&src.stamina>src.maxstamina/10)
			src.Sprinting=1
			src.MovementSpeed-=((1+(src.Max_Running_Speed/5))+src.shika)
			if(!src.icon_state || src.icon_state=="running")	src.ResetIS()
		if(src.Sprinting&&src.icon_state=="")
			src.icon_state="running"
	else
		src.SprintDirs+=TapDir
		spawn(4)	src.SprintDirs-=TapDir

mob/proc/SprintCancel()
	if(!src.Sprinting)	return
	if(!src.MN && !src.MS && !src.ME && !src.MW && src.Acceleration<10)
		src.MovementSpeed=initial(src.MovementSpeed)
		src.Sprinting=0
		//PlaySound(view(),'2860__prz__zigzig.ogg')
		if(!src.icon_state || src.icon_state=="running")	src.ResetIS()

mob/proc/GetMovementSpeed()
	var/MovementDelay=src.MovementSpeed
	return	max(1,MovementDelay)

mob/proc/CancelMovement()
	src.MN=0;src.MS=0;src.MW=0;src.ME=0
	src.SprintCancel()


/////////////////////////////////////////

