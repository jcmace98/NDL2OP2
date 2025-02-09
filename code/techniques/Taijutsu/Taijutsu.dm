/*mob/proc/DodgeCalculation(mob/M,Involvement="Taijutsu")
	var/UserHittingRatio=src.Reflex
	var/EnemyDodgingRatio=M.Reflex
	var/PlusAmount
	var/Constant=1.5 // Change if you need to
	if(UserHittingRatio>EnemyDodgingRatio)
		PlusAmount=round(EnemyDodgingRatio/UserHittingRatio)*100
		if(PlusAmount>90) PlusAmount=90
	if(UserHittingRatio<EnemyDodgingRatio)
		PlusAmount=round(UserHittingRatio/EnemyDodgingRatio)*100
		PlusAmount=100-PlusAmount
		PlusAmount=Constant*PlusAmount
	if(prob(PlusAmount)&&M.FrozenBind=="")
		M.Dodging=1
mob/proc/Dodge2()
	if(src.FrozenBind!=""||src.name=="Sand"&&!src.client)
		return
	src<<"You dodge the technique!"
	flick("zan",src)
	src.Dodging=0
	var/TheProbabilityOfReflexIncreasing=100
	var/HowMuchItDivides=(src.Reflex/100)*2
	TheProbabilityOfReflexIncreasing=TheProbabilityOfReflexIncreasing-HowMuchItDivides
	if(prob(TheProbabilityOfReflexIncreasing)&&src.Reflex<1000)
		src.Reflex+=pick(0.1,0.2,0.5)
mob/proc/Dodge()
	if(src.FrozenBind!=""||src.Frozen||src.resting||src.Stun>1)
		return
	src<<"You dodge the technique!"
	if(src.Dodging==2)
		var/TheProbabilityOfReflexIncreasing=50
		var/HowMuchItDivides=(src.Reflex/100)*2
		TheProbabilityOfReflexIncreasing=TheProbabilityOfReflexIncreasing-HowMuchItDivides
		if(prob(TheProbabilityOfReflexIncreasing)&&src.Reflex<1000)
			src.Reflex+=pick(0.1,0.2,0.5)
	if(src.Clan=="Hyuuga"&&src.bya)
		if(prob(5)&&src.Rejection<5)
			src.Rejection+=0.1
		if(prob(5)&&src.SensoryRange<5)
			src.SensoryRange+=0.1
	src.Dodging=0
	flick("zan",src)
	if(src.target)
		src.dir=get_dir(src,src.target)
		var/mob/M=src.target
		if(M.dir==NORTH)
			var/turf/T = locate(M.x,M.y+1,M.z)
			if(!T.density)
				src.loc=locate(M.x,M.y+1,M.z)
		if(M.dir==EAST)
			var/turf/T = locate(M.x+1,M.y,M.z)
			if(!T.density)
				src.loc=locate(M.x+1,M.y,M.z)
		if(M.dir==SOUTH)
			var/turf/T = locate(M.x,M.y-1,M.z)
			if(!T.density)
				src.loc=locate(M.x,M.y-1,M.z)
		if(M.dir==WEST)
			var/turf/T = locate(M.x-1,M.y,M.z)
			if(!T.density)
				src.loc=locate(M.x-1,M.y,M.z)
		if(M.dir==NORTHEAST)
			var/turf/T = locate(M.x+1,M.y+1,M.z)
			if(!T.density)
				src.loc=locate(M.x+1,M.y+1,M.z)
		if(M.dir==NORTHWEST)
			var/turf/T = locate(M.x-1,M.y+1,M.z)
			if(!T.density)
				src.loc=locate(M.x-1,M.y+1,M.z)
		if(M.dir==SOUTHEAST)
			var/turf/T = locate(M.x-1,M.y-1,M.z)
			if(!T.density)
				src.loc=locate(M.x-1,M.y-1,M.z)
		if(M.dir==SOUTHWEST)
			var/turf/T = locate(M.x+1,M.y-1,M.z)
			if(!T.density)
				src.loc=locate(M.x+1,M.y-1,M.z)
	else
		var/turf/T = locate(src.x+1,src.y,src.z)
		if(!T.density)
			src.loc=locate(src.x+1,src.y,src.z)
mob/proc/Quick()
	if(src.knockedout||src.Stun>0||src.FrozenBind!=""||src.Frozen)
		return
	flick("zan",src)
	var/turf/T=get_steps(src,src.dir,2)
	for(var/turf/LA in getline(src,T))
		for(var/atom/A in LA)
			if(A.density&&A!=src)
				return
		if(istype(LA,/turf/Buildings/zDensity))
			return
		else if(LA.density)
			return
		else
			usr.loc=LA
		sleep(0)

*/
///////////////////////////////////////////////////////
//Finger Push
//////////////////////////
mob/proc/TheFingerPush()
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenArms)
		return
	else
		flick("throw",src);src<<sound('SFX/AttackSwish1.wav')
		for(var/mob/M in get_step(src,src.dir))
			if((M.ReactionAbove&&prob(45)&&M.tai<src.tai)||(M.ReactionAbove&&prob(65)&&M.tai>=src.tai))
				M<<"You grab [src]'s finger, then grab around his arm and throw him back!"
				src<<"[M] quickly grabs your finger and then your arm. [M] then threw you back!"
				if(M.tai<src.tai)
					M.StaminaDrain(100)
				else
					M.StaminaDrain(50)
				src.HitBack(10,M.dir)
				if(M.ReactionAboveCounter&&prob(25))
					src<<"Your arms were broken!"
					src.BrokenArms=1
					src.BrokenArmsTime=50
				return
			if(!M.Mogu)
				if(M.Dodging)
					M.Dodge();return
				if(M.Kaiten||M.sphere)
					return
				else
					src.firing=1;viewers()<<sound('SFX/HitStrong.wav',0,0,1)
					view(src)<<"<i><font size = 2>[src] raises his finger to [M]'s forehead.";sleep(11);view(src)<<"<i><font size = 2>[src] flicks with amazing force sending [M] flying backwards!";src.firing=0
					M.HitBack(5,M.dir)
///////////////////////////////////////////////////////
//Dodge
//////////////////////////
mob/proc/Karakuri()
	if(src.Sliced||src.LegSliced||src.Frozen||src.FrozenBind!=""||src.Stun||src.knockedout||src.Status=="Asleep")
		return
	if(src.Shibari||src.hyoushou||src.resting||src.caught||src.firing||Labyrinth)
		return
	var/Destination = get_steps(src,src.dir,2);var/CurrentLocation = src.loc
	var/Route = getline(src,Destination)-src.loc
	for(var/turf/T in Route)
		if(locate(/obj/Doors) in T)
			return
		if(locate(/obj/Jutsu/Elemental/Mokuton/JukaiKoutan2) in T)
			return
		if(locate(/mob/IndigoRingBarrier) in T)
			return
		if(T.density)
			return
		if(locate(/obj/Jutsu/Elemental/Hyouton/DemonMirror) in T || locate(/obj/Jutsu/Elemental/Shoton/CrystalLabyrinth) in T|| locate(/mob/AkatRingBarrier) in T || locate(/obj/Jutsu/Elemental/Mokuton/JukaiKoutan2) in T)
			return
	src.StaminaDrain(75)
	src.stamina-=(src.maxstamina*0.005)
	flick("zan",src)
	src.loc=Destination
	src.dir=get_dir(src,CurrentLocation)


/*	if(src.Frozen||src.FrozenBind!=""||src.Stun||src.knockedout||src.Status=="Asleep")
		return
	if(src.Shibari||src.hyoushou||src.resting||src.caught||src.firing)
		return
	var/True=0
	for(var/obj/Jutsu/Elemental/Hyouton/DemonMirror/T in oview(1))
		if(T.Owner!=src)
			True=1
	for(var/turf/Buildings/zDensity/T in oview(1))
		if(T.density)
			True=1
	if(src.z==1||src.z==35)
		True=1
	if(True)
		return
	src.StaminaDrain(15)
	for(var/turf/T in oview(2))
		if(T.density)
			return
		else
			if(src.dir==1)
				flick("zan",src)
				src.loc=locate(src.x,(src.y+2),src.z)
				src.dir=2
			else if(src.dir==8)
				flick("zan",src)
				src.loc=locate((src.x-2),src.y,src.z)
				src.dir = 4
			else if(src.dir==4)
				flick("zan",src)
				src.loc=locate((src.x+2),src.y,src.z)
				src.dir = 8
			else if(src.dir==2)
				flick("zan",src)
				src.loc=locate(src.x,(src.y-2),src.z)
				src.dir = 1
			else if(src.dir==5)
				flick("zan",src)
				src.loc=locate((src.x+2),(src.y+2),src.z)
				src.dir=10
			else if(src.dir==6)
				flick("zan",src)
				src.loc=locate((src.x+2),(src.y-2),src.z)
				src.dir=9
			else if(src.dir==9)
				flick("zan",src)
				src.loc=locate((src.x-2),(src.y+2),src.z)
				src.dir=6
			else if(src.dir==10)
				flick("zan",src)
				src.loc=locate((src.x-2),(src.y-2),src.z)
				src.dir=5
				*/
///////////////////////////////////////////////////////////////////////////////////////////////
//E Rank Taijutsu
/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////
//D Rank Taijutsu
/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//Choke
//////////////////////////
mob/var/tmp
	inchoke = 0
	choking = 0
mob/proc/Choke()
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenArms)
		return
	for(var/mob/M in get_step(src,src.dir))
		if(M.ImmuneToDeath)
			return
		if((M.SoothingSlam&&prob(45)&&M.tai<src.tai)||(M.SoothingSlam&&prob(65)&&M.tai>=src.tai))
			M<<"You grab [src]'s hand before it reaches your throat, and you throw him to the side on the ground!"
			src<<"[M] grabbed your arm while you tried to choke him and then threw you to the side!"
			if(M.tai<src.tai)
				M.StaminaDrain(100)
			else
				M.StaminaDrain(50)
			src.HitBack(10,M.dir)
			src.stamina-=(M.tai*2)
			if(M.SoothingCounter&&prob(25))
				src<<"You feel really dizzy!"
				src.DizzyProc(50)
			return
		if(M.sphere)
			return
		if(M.KagDance=="Karamatsu")
			src.health-=rand(150,300)
			src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
			if(M.Deflection)
				src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
			return
		if(!M.Mogu&&M.FrozenBind!="DoBind"&&!M.InHydro)
			if(M.Kaiten)
				return
			M.Frozen=1;M.firing=1;M.inchoke=1
			usr.firing=1;usr.choking=1;usr.Frozen=1;usr.inchoke=1
			spawn(50)
				usr.firing=0;usr.choking=0;usr.Frozen=0;usr.inchoke=0;M.inchoke=0
				M.Frozen=0;M.firing=0
			usr.icon_state = "throw"
			view(M) << "[usr] picks [M] by the neck and begins choking him"
			var/damage=round(src.tai)/(M.BaikaCharged+1)
			sleep(50)
			if(!M)
				return
			else
				M.health-=damage
				view(M) << "[M] is hurt by the chokehold! ([damage] damage)"
				view(M) << "[usr] releases [M] from the chokehold!"
				src.icon_state = ""
				M.Death(src)

mob/proc/ChokeSlamProc()
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
		return
	for(var/mob/M in get_step(src,src.dir))
		if(M.Kaiten||M.InHydro)
			return
		if(M.KagDance=="Karamatsu")
			src.health-=rand(150,300)
			src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
			if(M.Deflection)
				src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
			return
		M.Frozen=1;M.firing=1
		usr.firing=1;usr.choking=1;usr.Frozen=1;usr.inchoke=1
		spawn(50)
			usr.firing=0;usr.choking=0;usr.Frozen=0;usr.inchoke=0
			M.Frozen=0;M.firing=0
		usr.icon_state = "throw"
		view(M) << "[usr] picks [M] by the neck and begins choking him"
		var/damage=round(src.tai)/(M.BaikaCharged+1)
		sleep(50)
		if(!M)
			return
		else
			M.health-=damage
			view(M) << "[M] is hurt by the chokehold! ([damage] damage)"
			view(M) << "[usr] releases [M] from the chokehold and slams them to the ground!"
			src.icon_state = ""
			M.icon_state="dead"
			M.DamageProc(damage,"Health",src)
			damage+=src.TaijutsuMastery*5
			M.DamageProc(damage*2,"Stamina",src)
			M.Running=0;
			M.Frozen=1;
			spawn(10)
				M.Frozen=0;
				M.icon_state=""
			M.Death(src)
///////////////////////////////////////////////////////
//Asshou
//////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
//C Rank Taijutsu
/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//Konoha Dai Senkou
//////////////////////////

///////////////////////////////////////////////////////
//Shoushitsu
//////////////////////////

///////////////////////////////////////////////////////
//Quick Feet
//////////////////////////



///////////////////////////////////////////////////////
//Shi-Shi Rendan
//////////////////////////
mob/proc/Shishi()
	src.Target()
	if(src.ntarget)
		return
	var/mob/M=src.target
	if(get_dist(src,M)>5)
		src<<"You need to be closer!"
		return
	if(src.firing)
		return
	else
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenLegs)
			return
		else
			if((M.ReactionBelow&&prob(55)&&M.tai<src.tai)||(M.ReactionBelow&&prob(70)&&M.tai>=src.tai))
				M<<"You grab [src]'s leg before it launches you into the air, and you take him down to the ground!"
				src<<"[M] grabs your leg as you attempt to launch him into the air and he takes you down to the ground!"
				if(M.tai<src.tai)
					M.StaminaDrain(100)
				else
					M.StaminaDrain(50)
				src.stamina-=(M.tai*2)
				src.Status="Asleep"
				src.StatusEffected=(M.tai*2)
				if(M.ReactionBelowCounter&&prob(25))
					M<<"You managed to break [src]'s legs while you were wrestling him down to the ground!"
					src<<"You can't feel your legs anymore!"
					src.BrokenLegs=1
					src.BrokenLegsTime=(M.tai*2)
				return
			if(!M.Mogu)
				if(M.Kaiten)
					return
				if(M.KagDance=="Karamatsu")
					src.health-=rand(150,300)
					src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					if(M.Deflection)
						src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
					return
				src.firing=1
				spawn(30)
					src.firing=0
				src.StaminaDrain(300)
				var/damage=round(src.Mtai*1.6)*rand(1,2.2)
				if(src.Trait=="Powerful")
					damage*=1.25
				src.DodgeCalculation(M)
				if(M.Dodging || M.InHydro)
					M.Dodge();return
				view()<<"<font color=silver><center><b><font face=verdana>[src] says:<font color=red><b><font size=2> ShiShi Rendan!"
				view()<<"<center><font color=red>[usr] hit [M] for [damage] damage!"
				spawn()AttackEfx(M.x,M.y,M.z)
				M.stamina-=(damage)/(M.BaikaCharged+1)
				step(M,src.dir)
				sleep(5)
				src.loc=locate(M.x-1,y,M.z)
				src.DodgeCalculation(M)
				if(M.Dodging)
					M.Dodge();return
				M.stamina-=(damage)/(M.BaikaCharged+1)
				view()<<"<B><center><font size=2><font color=red>[src] hit [M] for [damage] damage!"
				spawn()AttackEfx(M.x,M.y,M.z)
				step(M,src.dir)
				sleep(5)
				src.loc = locate(M.x,M.y-1,M.z)
				src.DodgeCalculation(M)
				if(M.Dodging)
					M.Dodge();return
				M.stamina-=(damage)/(M.BaikaCharged+1)
				view()<<"<B><font size=2><center><font color=red>[src] hit [M] for [damage] damage!"
				spawn()AttackEfx(M.x,M.y,M.z)
				step(M,src.dir)
				sleep(5)
				src.loc=locate(M.x+1,M.y,M.z)
				src.DodgeCalculation(M)
				if(M.Dodging)
					M.Dodge();return
				M.stamina-=(damage)/(M.BaikaCharged+1)
				view()<<"<B><font size=2><center><font color=red>[src] hit [M] for [damage] damage!"
				spawn()AttackEfx(M.x,M.y,M.z)
				step(M,src.dir)
				src.loc=locate(M.x,M.y+1,M.z)
				src.DodgeCalculation(M)
				if(M.Dodging)
					M.Dodge();return
				view()<<"<font color=red>[M] Crashes to the ground for [damage] Damage!"
				spawn()AttackEfx(M.x,M.y,M.z)
				M.stamina-=(damage)/(M.BaikaCharged+1)
				M.Death(src)
				step(M,src.dir)
				step(M,src.dir)
///////////////////////////////////////////////////////////////////////////////////////////////
//B Rank Taijutsu
/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//Konoha Kage Buyou..Redone
//////////////////////////
mob/var/tmp/buyou=0
mob/proc/KageBuyou()

	src.Target()
	if(src.ntarget)
		return
	var/mob/m=src.target
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
		return
	if(m.hyoushou)
		return
	else
		src.StaminaDrain(100)//the principle behind this is that with "Control" as represented by GenSkill, you should hurt your body less.
//		if(prob(30))
//			view(6) << "<b>[src] says: <font color = blue>Kage Buyou!</font></b>"
		if(m.z!=src.z)
			return
		var/BehindLoc
		if(m.dir==NORTH) BehindLoc=locate(m.x,m.y-1,m.z)
		if(m.dir==SOUTH) BehindLoc=locate(m.x,m.y+1,m.z)
		if(m.dir==EAST) BehindLoc=locate(m.x-1,m.y,m.z)
		if(m.dir==WEST) BehindLoc=locate(m.x+1,m.y,m.z)
		if(m.dir==NORTHEAST) BehindLoc=locate(m.x-1,m.y-1,m.z)
		if(m.dir==SOUTHEAST) BehindLoc=locate(m.x-1,m.y+1,m.z)
		if(m.dir==NORTHWEST) BehindLoc=locate(m.x+1,m.y-1,m.z)
		if(m.dir==SOUTHWEST) BehindLoc=locate(m.x+1,m.y+1,m.z)
		var/turf/T = BehindLoc

		src.buyou=1
		spawn(20)
			src.buyou=0
		if(!T.density)
			src.StaminaDrain(100*get_dist(src,BehindLoc))
			src.loc=BehindLoc
		flick("zan",src)
		src.dir=get_dir(src,m)
		var/Amount=rand(30,75)
		src.tai+=Amount
		spawn(50)
			src.tai-=Amount
///////////////////////////////////////////////////////
//Konoha Dai Senpuu
//////////////////////////

///////////////////////////////////////////////////////
//Omote Renge
//////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
//A Rank Taijutsu
/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//Ura Renge
//////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
//S Rank Taijutsu
/////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////
//Uchiha Style
////////////////////////
//
mob/proc
	Axe_Kick()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
			return
		else
			src.StaminaDrain(300);var/I=10
			while(I>=1)
				flick("zan",src);step(src,src.dir)
				if(prob(50)) step(src,src.dir)
				for(var/mob/M in get_step(src,src.dir))
					I=0
				sleep(1)
				I--
			for(var/mob/M in get_step(src,src.dir))
				if((M.ReactionBelow&&prob(55)&&M.tai<src.tai)||(M.ReactionBelow&&prob(70)&&M.tai>=src.tai))
					M<<"You grab [src]'s leg as he flies at you and slam him into the ground face first!"
					src<<"[M] grabs your leg as you make contact with him and he slams your face into the ground!"
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
					src.stamina-=(M.tai*2)
					src.Bloody();src.Bloody();src.Bloody()
					src.DamageProc(M.tai*2,"Health",M)
					if(M.ReactionBelowCounter&&prob(25))
						M<<"You managed to break [src]'s legs while you threw him down to the ground!"
						src<<"You can't feel your legs anymore!"
						src.BrokenLegs=1
						src.BrokenLegsTime=(M.tai*2)
					if(M.ReactionBelowCounter&&prob(25))
						M<<"Your face first impact managed to give [src] slight head trauma!"
						src<<"You feel a bit dizzy."
						src.DizzyProc(50)
					return
				flick("highkick",src);var/damage=round(rand(src.tai*100,src.tai*135))
				if(src.Trait=="Powerful")
					damage*=1.25
				damage/=(M.Endurance/15)
				if(damage>2000)
					damage=2000
				if(!M.Mogu && !M.InHydro)
					if(damage>=1500)
						for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
							del(P)
					if(M.Kaiten|M.ingat|M.intank)
						spawn() src.HitBack(4,turn(src.dir,180))
						return
					if(M.sphere)
						viewers()<<sound('SFX/Guard.wav',0)
					else
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitStrong.wav',0)
						view(M)<<output("<font color=green size=2>[M] has been hit by Axe Kick!([damage])</font>","Attack")
						M.DamageProc(damage,"Stamina",src)
						spawn() M.HitBack(rand(5,10),src.dir)
						spawn()AttackEfx(M.x,M.y,M.z)
						//if(M.RaiArmor)
						//	src.DamageProc(100,"Health",M);src.HitBack(1,(src.dir-4))
	LionPunch()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenArms)
			return
		else
			src.Target()
			if(src.ntarget)
				return
			var/mob/m=src.target
			src.StaminaDrain(300)
			src.firing=1
			if(m.hyoushou)
				return
			else
				src.StaminaDrain(300)
				if(m.z!=src.z)
					spawn(10) src.firing=0
					return
				if(get_dist(src,m)>2)
					src<<"Your target is too far to use this attack!"
					src.firing=0
					return
				var/turf/T
				if(m.dir==NORTH) T=locate(m.x,m.y-1,m.z)
				if(m.dir==SOUTH) T=locate(m.x,m.y+1,m.z)
				if(m.dir==EAST) T=locate(m.x-1,m.y,m.z)
				if(m.dir==WEST) T=locate(m.x+1,m.y,m.z)
				if(m.dir==NORTHEAST) T=locate(m.x-1,m.y-1,m.z)
				if(m.dir==SOUTHEAST) T=locate(m.x-1,m.y+1,m.z)
				if(m.dir==NORTHWEST) T=locate(m.x+1,m.y-1,m.z)
				if(m.dir==SOUTHWEST) T=locate(m.x+1,m.y+1,m.z)
				if(T&&!T.density)
					src.loc=T
				flick("zan",src);src.dir=get_dir(src,m)
				if(prob(50))
					flick("Attack1",src)
				else
					flick("Attack2",src)
				src.buyou=1
				src.firing=1
				spawn(15)
					src.firing=0
					src.buyou=0
				for(var/mob/M in get_step(src,src.dir))
					if((M.ReactionAbove&&prob(55)&&M.tai<src.tai)||(M.ReactionAbove&&prob(70)&&M.tai>=src.tai))
						M<<"You grab [src]'s arm as they appear behind you and flip them over your head!"
						src<<"[M] grabs your arm as you appear behind them and they flip you over their head!"
						if(M.dir==NORTH) T=locate(M.x,M.y+1,M.z)
						if(M.dir==SOUTH) T=locate(M.x,M.y-1,M.z)
						if(M.dir==EAST) T=locate(M.x+1,M.y,M.z)
						if(M.dir==WEST) T=locate(M.x-1,M.y,M.z)
						if(M.dir==NORTHEAST) T=locate(M.x+1,M.y+1,M.z)
						if(M.dir==SOUTHEAST) T=locate(M.x+1,M.y-1,M.z)
						if(M.dir==NORTHWEST) T=locate(M.x-1,M.y+1,M.z)
						if(M.dir==SOUTHWEST) T=locate(M.x-1,M.y-1,M.z)
						if(T&&!T.density)
							src.loc=T
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.Status="Asleep"
						src.StatusEffected=(M.tai*1.5)
						src.stamina-=(M.tai*2)
						src.Bloody();src.Bloody();src.Bloody()
						src.DamageProc(M.tai*2,"Health",M)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"You managed to break [src]'s arms while you threw him down to the ground!"
							src<<"You can't feel your arms anymore!"
							src.BrokenArms=1
							src.BrokenArmsTime=(M.tai*2)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"Your face first impact managed to give [src] slight head trauma!"
							src<<"You feel a bit dizzy."
							src.DizzyProc(50)
							src.firing=0
						return
					if(!M.Mogu && !M.InHydro)
						src.DodgeCalculation(M)
						if(M.Dodging)
							M.Dodge();return
						if(M.Kaiten|M.ingat|M.intank)
							spawn() src.HitBack(4,(src.dir-4))
							return
						if(M.intank|M.sphere||M.Mogu)
							viewers()<<sound('SFX/Guard.wav',0);return
						else
							spawn()AttackEfx(M.x,M.y,M.z)
							var/damage=round(rand(usr.tai*50,usr.tai*70));var/Damage=(damage/(M.Endurance/12))/(M.BaikaCharged+1)
							if(Damage>1500)
								Damage=1500
							if(Damage>=1500)
								for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
									del(P)
							if(src.Trait=="Powerful")
								Damage*=1.25
							if(M.Guarding)
								viewers()<<sound('SFX/Guard.wav',0)
							else
								viewers()<<sound('SFX/HitMedium.wav',0)
								flick("hit",M)
						//	view(M)<<output("<font color=green size=2>[M] has been hit by Lion Punch!([Damage])</font>","Attack")
							M.DamageProc(Damage,"Stamina",src);src.ExpGain(M,damage)
							spawn() M.HitBack(1,src.dir)
							flick("Attack2",src)
							step(src,src.dir)
							view(M)<<output("<font color=green size=2>[M] has been hit by Lion Punch!([Damage])</font>","Attack")
							M.DamageProc(Damage,"Stamina",src)
							spawn() M.HitBack(rand(3,6),src.dir)
							if(M.RaiArmor)
								src.DamageProc(100,"Health",M);src.HitBack(1,(turn(src.dir,180)))