mob/var/tmp/RinneganOn=0
mob/proc
	Rinnegan_Activate()
		if(src.RinneganOn)
			src.RinneganOn=0
			src<<"You deactivate the Rinnegan."
			var/list/Techniques=list("ShinraTensei","BashoTenin","SoulRip","ChakraAbsorption","RinneganSummon","AsuraRealm","NarakaSoulRip","NarakaRestoration","ChakraRod","ChibakuTensei")
			while(Techniques.len>0)
				var/Choice=pick(Techniques)
				Techniques.Remove(Choice)
				var/Path=text2path("/obj/SkillCards/[Choice]")
				var/obj/SkillCards/S = locate(Path) in src.LearnedJutsus
				if(!S)
					continue
				else
					S.NonKeepable=1
					src.LearnedJutsus-=S
			var/X=0
			for(var/obj/SkillCards/O in src.LearnedJutsus)//Loop through all the items in the players contents
				winset(src, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
				src << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
			winset(src,"Jutsu.Jutsus", "cells=[X]")
		else
			src.RinneganOn=1
			view(9,src)<<"[src]'s eyes turn into a beautiful purple-silver and begin to ripple outwards.."
			var/obj/I=new()
			I.icon='Rinnegan.dmi'
			I.icon_state="Rinnegan"
			I.pixel_y=16
			src.overlays+=I
			spawn(12)
				src.overlays-=I
				del(I)
			var/list/Techniques=list("ShinraTensei","BashoTenin","ChakraAbsorption","RinneganSummon","AsuraRealm","NarakaSoulRip","NarakaRestoration","ChakraRod","ChibakuTensei")
			while(Techniques.len>0)
				var/Choice=pick(Techniques)
				Techniques.Remove(Choice)
				var/Path=text2path("/obj/SkillCards/[Choice]")
				var/obj/SkillCards/S = new Path
				S.NonKeepable=1
				src.LearnedJutsus+=S
			var/X=0
			for(var/obj/SkillCards/O in src.LearnedJutsus)//Loop through all the items in the players contents
				winset(src, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
				src << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
			winset(src,"Jutsu.Jutsus", "cells=[X]")
			src.nin=src.Mnin*1.5
			src.gen=src.Mgen*1.5
			src.tai=src.Mtai*1.5
			while(src.RinneganOn)
				src.chakra-=rand(15,30)
				sleep(15)
			src.nin=src.Mnin
			src.gen=src.Mgen
			src.tai=src.Mtai
			/*
			//Deva
			var/obj/SkillCards/ShinraTensei/S=new()
			S.NonKeepable=1
			src.LearnedJutsus+=S
			var/obj/SkillCards/BashoTenin/B=new()
			B.NonKeepable=1
			src.LearnedJutsus+=B
			//Human
			var/obj/SkillCards/SoulRip/SR=new()
			SR.NonKeepable=1
			src.LearnedJutsus+=SR
			//Animal
			var/obj/SkillCards/RinneganSummon/RS=new()
			RS.NonKeepable=1
			src.LearnedJutsus+=RS*/

	ShinraTensei()
		var/RepulsionRange=15
		src.chakra-=400
		spawn()
			for(var/obj/Jutsu/J in oview(src,6))
				spawn()
					walk(J,get_dir(src,J))
					sleep(40)
					walk(J,0)

			for(var/obj/Jutsu/A in src.loc)
				if(A.Owner!=src.Owner)
					del(A)

			for(var/mob/M in oview(src,8))
				spawn()
					var/Mdir=get_dir(M,src)
					if(M.Mogu)
						return
					M<<"You feel a strong force repel you away from [src]!"
					if(Mdir==NORTH)
						M.dir=SOUTH
					if(Mdir==EAST)
						M.dir=WEST
					if(Mdir==WEST)
						M.dir=EAST
					if(Mdir==SOUTH)
						M.dir=NORTH
					if(Mdir==NORTHEAST)
						M.dir=SOUTHWEST
					if(Mdir==SOUTHWEST)
						M.dir=NORTHEAST
					if(Mdir==NORTHWEST)
						M.dir=SOUTHEAST
					if(Mdir==SOUTHEAST)
						M.dir=NORTHWEST
					M.HitBack(RepulsionRange,M.dir)
/*
		for(var/mob/M in getcircle(src,6))
			spawn()
				M.Strafe()
				M.HitBack(10,get_dir(src,M))
				M.DamageProc(800,"Stamina",M)
				M.Normal()	*/
	BashoTenin()
		src.chakra-=(src.chakra*0.01)
		var/turf/T = src.loc
		spawn()
		for(var/obj/Jutsu/A in oview(src,6))
			spawn(1)
			if(A&&A.JutsuLevel>0)
				spawn(1)
					step_towards(A,T);sleep(2);step_towards(A,T);sleep(2);step_towards(A,T);sleep(2);step_towards(A,T);sleep(4)
					step_towards(A,T);sleep(4);step_towards(A,T)
		for(var/mob/M in oview(src,6))
			spawn(1)
				if(M!=src.Owner)
					step_towards(M,T);sleep(2);step_towards(M,T);sleep(2);step_towards(M,T);sleep(2);step_towards(M,T);sleep(2);
					step_towards(M,T);sleep(4);step_towards(M,T)

	ChibakuTensei()
		if(src.Clone)
			src.health=0
			src.Death(src)
			return
		if(src.firing&&src.Clone)
			if(src.Clone)
				src.health=0
				src.Death(src)
				return
			return
		else
			src.icon_state="handseal"
			src.firing=1;
			src.Frozen=1
			src<<"You create a sphere of energy."
			view()<<"[src] creates a small black sphere in their palm."
			var/obj/Chibaku/P=new();
			src.ChakraDrain(95000)
			var/Height=5
			while(Height>0)
				P.pixel_y+=16
				P.density=0
				Height--
				sleep(4)
			if(Height==0)
				P.loc=locate(src.x,src.y+4,src.z)
				P.pixel_y=0
				P.dir=src.dir;
				P.Owner=src

/*	ChouChibakuTensei()
		if(src.knockedout||src.Frozen||src.firing)
			return
		if(src.ChibakuMode==1)
			src<<"You deactivate the rapid manipulation of your chakra."
			src.ChibakuMode=0
		src.ChakraDrain(15000)
		src.icon_state="handseal"
		view()<<"[src] begins to force their chakra into an intense manipulated state!"
		sleep(15)
		while(src.icon_state=="handseal")
			sleep(11)
			src.ChakraDrain(16000)
			src.ChibakuMode=1
			if(src.knockedout||src.icon_state!="handseal"||src.chakra<=0)
				src.ChibakuMode=0
				src<<"You are forced to stop the rapid manipulation of your chakra.";return	*/


	SoulRemove()
		if(src.knockedout)
			return
		else
			src.chakra-=2500
			for(var/mob/M in get_step(src,src.dir))
				src<<"You begin to rip out [M]'s soul. Wait 25 seconds!"
				src.FrozenBind="Rinnegan"
				M.FrozenBind="Rinnegan"
				M<<"You feel something terribly wrong! Move now!"
				oview()<<"[src] grabs ahold of [M] and seems to be pulling something from them..?"
				sleep(250)
				if(src.knockedout)
					src<<"The jutsu failed because you lost consciousness!"
					src.FrozenBind="";M.FrozenBind="";return
				src.Frozen=0
				if(M in get_step(src,src.dir))
					src<<"You pull out [M]'s soul!"
					M<<"You feel your soul being released from your body!"
					src.FrozenBind="";M.FrozenBind=""
					M.health=0
					M.knockedout=1
					M.icon_state="dead"
					M.DeathStruggle(src,1)
					src<<"[M]'s max vitality is [M.maxhealth]"
					src<<"[M]'s max stamina is [M.maxstamina]"
					src<<"[M]'s max chakra is [M.Mchakra]"
					src<<"[M]'s Village is [M.Village]"
					src<<"[M]'s Age is [M.Age]"
					src<<"[M]'s Death Age is [M.DeclineAge]"
					src<<"[M]'s rank is [M.rank]"
					src<<"[M]'s Clan is [M.Clan]"
					src<<"[M]'s Sub Clan is [M.Clan2]"
					src<<"[M] has [M.LearnedJutsus.len] Jutsu."
					var/input=input(src,"Would you like a readout of all their jutsu?") in list("Yes","No")
					if(input=="Yes")
						for(var/obj/SkillCards/A in M.LearnedJutsus)
							src<<"They have <b>[A]</b> with <b>[A.Uses]</b>."
							sleep(1)
					return
				else
					src<<"It seemed the target moved."
					return

	RinneganSummon(mob/M)
//		if(global.contestantTwo == src||global.contestantOne == src)
//			src<<"Arena is meant for one on one, not two on one."
//			world<<"[src] tried summoning [M] while he was in the arena, and auto loses the match!"
//			del(src)
//			del(M)
		if(!M)
			return
		if(!M.client)
			var/obj/O=new()
			src.chakra-=500
			O.icon='Icons/Jutsus/NarutoStuff.dmi'
			O.loc=get_step(src,src.dir)
			flick("Smoke",O)
			sleep(3)
			M.loc=O.loc
			sleep(3)
			O.loc=null
		else
			src<<"You attempt to summon [M]."
			src.chakra=0
			src.Mchakra-=50
			src.deathcount+=5
			M<<"[src] is trying to summon you. To accept, click the icon in the lower left hand corner of your screen."
			M<<"If you do not accept within 15 seconds the option expires."
			var/obj/SummonRequest/A=new /obj/SummonRequest
			A.Requester=src;A.Requestee=M
			M.client.screen+=A

	NarakaRestoration()
		if(src.firing||src.knockedout)
			return
		if(src.target)
			src.dir=get_dir(src,src.target)
		flick("throw",src)
		src.chakra-=400
		for(var/mob/M in get_step(src,src.dir))
			M<<"[src] uses the Rinnegan to restore your body."
			src<<"You begin to heal [M]"

			if(M.StruggleAgainstDeath>0)

				M.Struggle+=rand(80,100)

			if(M.health<M.maxhealth)
				M.health+=rand(750,1200)
				M.deathcount--
				if(M.deathcount<0)
					M.deathcount=0
				if(M.health>M.maxhealth)
					M.health=M.maxhealth
			if(M.client&&M.Dead&&M.health>=M.maxhealth/2&&!PermDeath&&!M.CBleeding)
				M.Dead=0
				M.icon_state=""
				M.FrozenBind=""
				M.deathcount=0
				M.sight&=~(SEE_SELF|BLIND)
				orange(12,M)<<"<font size = 2>[M] was brought back from the brink of death!</font>"
			if(M.stamina<M.maxstamina)
				M.stamina+=rand(600,800)
				if(M.stamina>M.maxstamina)
					M.stamina=M.maxstamina
			M.chakra+=rand(100,200)
			M.ChakraPool+=rand(300,600)
			if(M.screwed)
				if(prob(src.Focus*rand(-5,5)))
					M.screwed=0;M<<"Your nerves were healed.";src<<"You healed their nerves."
			if(M.CBleeding)
				if(prob(usr.Focus*rand(-5,5)))
					M.CBleeding=0;M<<"You're no longer bleeding.";src<<"You healed their internal bleeding."

	NarakaSoulRemove()
		if(src.knockedout)
			return
		else
			src.chakra-=1000
			for(var/mob/M in get_step(src,src.dir))
				if(M.knockedout)
					return
				src<<"You begin to rip out [M]'s soul. You have 15 seconds, rapidly tap the space bar to rip their soul out!"
				src.FrozenBind="Rinnegan"
				M.FrozenBind="Rinnegan"
				src.Struggle=0
				M.Struggle=0
				M<<"Your soul is being ripped out! Quick struggle to keep it inside you! Tap the space bar quickly!"
				var/i=15
				while(i>0&&!src.knockedout&&M in get_step(src,src.dir))
					i--
					sleep(10)
				if(src.knockedout)
					src<<"The jutsu failed because you lost consciousness!"
					src.FrozenBind="";M.FrozenBind=""
					return
				src.FrozenBind=""
				M.FrozenBind=""
				if(M in get_step(src,src.dir))
					if(src.Struggle+35>M.Struggle)
						src<<"You pull out [M]'s soul!"
						M<<"Your soul is ripped out from you! Your body begins to go limp.."
						M.health=0
						M.knockedout=1
						M.icon_state="dead"
						M.deathcount+=2.5
						M<<"You feel your life force weaken severely..."
						return
					else
						src<<"[M] managed to struggle enough to keep their soul inside them. The technique failed."
						M<<"You pull your soul completely back inside you and break free from [src]'s technique!"
				else
					src<<"It seemed the target moved."
					return
	PretaAbsorb()
		if(src.Clone)
			src.health=0
			src.Death(src)
			return
		if(src.firing&&src.Clone)
			if(src.Clone)
				src.health=0
				src.Death(src)
				return
			return
		else
			var/JutsuCost=60
			src.icon_state="Power"
			src.firing=1;
			src.Frozen=1
			src<<"You begin to absorb nearby chakra with your Rinnegan."
			var/absorbrange=5
	//		var/heal=((src.NinSkill+src.GenSkill)/rand(1,2))
			if(absorbrange>5) absorbrange=5
			while(src.icon_state=="Power")
				for(var/mob/M in oview(absorbrange,src))
	//				sleep(12)
					if(M in OnlinePlayers)
						M.chakra-=150
						src.chakra+=100
						src.chakra-=JutsuCost
				for(var/obj/Jutsu/A in oview(2,src))
					walk(A,0);step_towards(A,src)
					if(A.Owner!=src.Owner)
						del(A)
						src.chakra+=100
				for(var/obj/Jutsu/A in src.loc)
					if(A.Owner!=src.Owner)
						del(A)
						src.chakra+=100
				sleep(6)
		src.firing=0;src.Frozen=0
	ChakraReceiver()
		if(src.firing)
			return
		if(src.ChakraReceiver)
			src<<"The rod recedes.";src.WeaponInLeftHand="";src.LeftHandSheath=0;ChakraReceiver=0
			src.underlays-='Icons/New Base/Weapons/ChakraReceiverU.dmi'
			src.overlays-='Icons/New Base/Weapons/ChakraReceiverO.dmi';return
		else
			src.ChakraReceiver=1
			var/obj/WEAPONS/ChakraRod/T=new();src.WeaponInLeftHand=T;src.LeftHandSheath=1
			view()<<"[src] generates a black rod, propelling out from their left palm."
			while(src.ChakraReceiver)
				src.WeaponInLeftHand=T;src.LeftHandSheath=1
				src.underlays+='Icons/New Base/Weapons/ChakraReceiverU.dmi'
				src.overlays+='Icons/New Base/Weapons/ChakraReceiverO.dmi'
				src.ChakraReceiver=1
				if(src.knockedout)
					src<<"As you fall unconcious your chakra receiver recedes back into your body."
					src.ChakraReceiver=0
					src.WeaponInLeftHand=""
					src.LeftHandSheath=0
					src.underlays-='Icons/New Base/Weapons/ChakraReceiverU.dmi'
					src.overlays-='Icons/New Base/Weapons/ChakraReceiverO.dmi'
				sleep(4)
/*	SixPaths()
		var/Number=input(usr,"How many?") as num
		var/which=input(usr,"Which ones?") in list("Asura","Human","Animal","Preta","Naraka")
		var/mob/N=new T
		var/list/C = list("NarakaSoulRip","ChakraAbsorbtion","AsuraPunch","AsuraRocket","NarakaRestoration","ChakraRod")
		var/Path=text2path("/obj/SkillCards/[C]")
		if(which=="Asura"
		var/obj/SkillCards/S = new Path
		S.NonKeepable=1
		src.LearnedJutsus+=S
		N.Mnin=src.Mnin;N.Mtai=src.Mtai;N.Mgen=src.Mgen
		N.Age=src.Age
		N.loc=usr.loc
		N.x-=(rand(-3,3));N.y-=(rand(-3,3))
		if((N.Mtai+N.Mnin+N.Mgen+N.Age)>225)
			N.Inferno=3;N.HousenkaExpert=2;N.RaikyuuExpert=3;N.Static=3;N.Electromagnetivity=3;N.ChidoriSenbonExpert=2;N.NagashiExpert=2;N.ReppushouExpert=2;N.WindVelocity=3;N.VacuumSphereExpert=2;N.DragonsRage=2;N.DragonTamer=3;
			N.rank=src.rank;N.TaijutsuMastery=randsrc.TaijutsuMastery;N.HandsealsMastery=3;N.HandsealSpeed=src.HandsealSpeed;

			while(b>0)
				var/P=pick(C);C-=P;var/Q = text2path("/obj/SkillCards/[P]");var/obj/SkillCards/A = new Q
				A.Uses=rand(500,1000);N.LearnedJutsus+=A;b--
		if(prob(30)){var/obj/WEAPONS/Katana/K=new();N.WeaponInLeftHand=K;N.LeftHandSheath=1}
		if(N.Village=="Leaf")
			if(prob(25)){N.Clan="Hyuuga";N.TaijutsuStyle="Jyuken";N.ChakraPercision=5;N.TenketsuAccuracy=20;N.SensoryRange=5;N.Rejection=5;N.bya=1}
		if(N.Village=="Sound")
			if(prob(25))
				if(prob(30)){var/obj/WEAPONS/Katana/K=new();N.WeaponInLeftHand=K;N.LeftHandSheath=1;N.Kenjutsu=100}
				N.Clan="Uchiha";N.SharinganMastery=rand(40,1000);N.reflexNew=rand(1,4);spawn()
					N.Sharingan()
		N.name="[N.name]([N.rank])"
		if(N.Clan=="Hyuuga"||N.Clan=="Uchiha")
			N.name="[N.Clan] [N.name]"
		N.RandomFace()
		Number--*/

	EdoTensei()
		if(!usr.controlled)
			var/list/people=list()
			for(var/mob/P in oview(8))
				if(findtext(P.name,"'s corpse")&&P.FrozenBind=="Dead")
					people += P
			var/who = input("Which corpse would you like to possess?") in people+"Cancel"
			if(who=="Cancel") return
			var/mob/M = who
			M.FrozenBind="";M.knockedout=0;M.Dead=0
			usr.controlled=M
			usr.client.eye=M
			usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			usr.KBunshinOn=1
			M.RestrictOwnMovement=1
			if(!M.client)
				M.icon_state="running"
			var/X=0
			for(var/obj/SkillCards/O in M.LearnedJutsus)//Loop through all the items in the players contents
				winset(usr, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
				usr << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
				winset(usr,"Jutsu.Jutsus", "cells=[X]")
		else
			var/mob/O=usr.controlled
			if(O)
				O.RestrictOwnMovement=0
			usr.KBunshinOn=0
			usr.controlled=null
			usr.client.eye=usr
			usr.client.perspective=MOB_PERSPECTIVE
			usr.UpdateInv()



	EdoGetStats(mob/M) //proc corpses call to get the original's vars...
		for(var/V in src.vars)
			var/list/BAD = list("locs","cansave","key","ckey","client","type","parent_type","verbs","vars","group","x","y","z","loc","contents","controlled","alterV","alterC","alterR","OriginalVillage","Orank","OClan","ImmuneToDeath","Owner","KBunshinOn")
			if(!BAD.Find(V))
				src.vars[V] = M.vars[V]
obj
	SummonRequest
		icon='Something.dmi'
		screen_loc="1,1"
		var
			Requester
			Requestee
		New()
			..()
			spawn(150)
				del(src)
		Click()
			if(usr==src.Requestee)
				if(usr.knockedout)
					usr<<"noep"
					del(src)
				var/obj/O=new()
				var/mob/M=Requester
				O.icon='Icons/Jutsus/NarutoStuff.dmi'
				O.loc=get_step(M,M.dir)
				flick("Smoke",O)
				sleep(3)
				usr.loc=O.loc
				sleep(3)
				O.loc=null
			else
				usr<<"You aren't supposed to be the one clicking this."
				return
	Chibaku
		icon='New Icons(Con4)/Chibaku.dmi'
		icon_state = ""
		density=1
		layer=MOB_LAYER+2
		var/Owner
		Del()
			for(var/turf/T in getcircle(src,2))
				var/obj/Jutsu/Explosion/K=new();K.loc=T;K.Owner=src.Owner
			..()
		New()
			..()
			spawn()
				var/distance=0
				distance=6
				if(distance<1) distance=1
				while(src)
					sleep(1)
					spawn(1)
						for(var/obj/Jutsu/Kiriame/S2 in src.loc)
							del(src)
						for(var/obj/Jutsu/A in oview(distance))
							spawn(1)
							if(A&&A.JutsuLevel>0)
								spawn(1)
									step_towards(A,src);sleep(1);step_towards(A,src)

						for(var/obj/WEAPONS/A in oview(distance))
							if(istype(A,/obj/WEAPONS/Shuriken))
								spawn(1)
									if(A)
										spawn(1)
											walk(A,0);step_towards(A,src);sleep(1);step(A,get_dir(src,A));sleep(1);step(A,get_dir(src,A));sleep(1);step(A,get_dir(src,A))
											if(A.speeding) walk(A,A.dir)
							if(istype(A,/obj/WEAPONS/Kunai))
								spawn(1)
									if(A)
										spawn(1)
											walk(A,0);step_towards(A,src);sleep(1);step(A,get_dir(src,A));sleep(1);step(A,get_dir(src,A));sleep(1);step(A,get_dir(src,A))
											if(A.speeding) walk(A,A.dir)
							if(istype(A,/obj/WEAPONS/Senbon))
								spawn(1)
									if(A)
										spawn(1)
											walk(A,0);step_towards(A,src);sleep(1);step(A,get_dir(src,A));sleep(1);step(A,get_dir(src,A));sleep(1);step(A,get_dir(src,A))
											if(A.speeding) walk(A,A.dir)




					for(var/mob/M in oview(distance))
						spawn(1)
							if(M!=src.Owner)
								step_towards(M,src);sleep(3)
					for(var/mob/M in oview(1))
						if(istype(M,/mob/Bugs/)) M.health=0
mob/var/tmp/AsuraRealm=0
mob/proc/ToggleAsura()
	if(src.AsuraRealm)
		src.AsuraRealm=0
		src<<"You deactivate the Asura Realm."
		for(var/obj/SkillCards/AsuraPunch/A in src.LearnedJutsus)
			del(A)
		for(var/obj/SkillCards/AsuraRocket/A in src.LearnedJutsus)
			del(A)
		return
	else
		src.AsuraRealm=1
		src<<"You activate the Asura Realm."
		src<<"While in this mode you can use a Rocket Punch dealing weak stamina damage, a straight forward powerful missle Rocket, or click to send a weaker rocket that homes in on that targeted spot."
		src.LearnedJutsus+=new/obj/SkillCards/AsuraPunch
		src.LearnedJutsus+=new/obj/SkillCards/AsuraRocket
		while(src.AsuraRealm)
			src.chakra-=150
			sleep(rand(20,40))
mob/proc/AsuraRealmPunch()
	flick("Attack1",src)
	var/obj/Android/RocketPunch/A=new()
	A.icon+=rgb(src.BaseR,src.BaseG,src.BaseB)
	A.loc=src.loc
	A.Owner=src
	A.dir=src.dir
	walk(A,A.dir)

mob/proc/AsuraMissle(Strong=0,atom/Target)
	src.chakra-=150
	var/obj/Android/Missle/M=new()
	M.Owner=src
	M.loc=src.loc
	if(Strong)
		src.chakra-=200
		M.StrongMissle=1
	if(Target)
		walk_to(M,Target)
	else
		walk(M,src.dir)
obj/Android/Missle
	icon='Rinnegan.dmi'
	icon_state="Missile"
	density=1
	var/StrongMissle=0
	var/Owner
	New()
		spawn(25)
			del(src)
	Bump(A)
		if(ismob(A))
			var/mob/M = A
			if(M.sphere) return
			if(M.Kaiten)
				src.dir=turn(src.dir,pick(90,-90,180))
				return
			del(src)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj/))
			del(src)
	Del()
		if(src.StrongMissle)
			var/obj/Jutsu/StrongExplosion/K=new()
			K.loc=src.loc
			K.Owner=src.Owner
		else
			var/obj/Jutsu/Explosion/K=new()
			K.loc=src.loc
			K.Owner=src.Owner
		..()
obj/Android/RocketPunch
	icon='Rinnegan.dmi'
	icon_state="RocketPunch"
	density=1
	var/Owner
	New()
		spawn(25)
			del(src)
	Bump(A)
		if(ismob(A))
			var/mob/M = A
			var/mob/O=src.Owner
			if(M.sphere) return
			if(M.Kaiten)
				if(prob(25))
					src.dir=turn(src.dir,90)
					return
				if(prob(25))
					src.dir=turn(src.dir,-90)
					return
				else
					src.dir=turn(src.dir,180)
					return
			M.DamageProc(200,"Stamina",O)
			del(src)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
		if(istype(A,/obj/))
			del(src)
	Del()
		for(var/mob/Q in oview(2,src))
			spawn()
				Q.HitBack(10,get_dir(src,Q))
		sleep(3)
		..()

mob/proc/ShinraTenseiObj(Uses)
	if(src.knockedout||src.firing)
		return
	else
		var/X=Uses*0.1
		if(X<5)
			X=5
		if(X>15)
			X=15
		var/ChakraLoss=1000
	//	if(src.RinneganActivated>=500)
	//		ChakraLoss=100
		src.chakra-=ChakraLoss
		src<<"You bring everything towards you!"
		for(var/mob/M in oview(X,src))
			walk_towards(M,src)
			spawn(5)
				walk(M,0)
		for(var/obj/M in oview(X,src))
			if(istype(M,/obj/Hidden_Ninja_Scroll))
				return
			if(istype(M,/obj/VillageScrollPost))
				return
			if(istype(M,/obj/VillageScrollPostBottom))
				return
			walk_towards(M,src)
			spawn(5)
				walk(M,0)

mob/proc/BanshoTeninObj(Uses)
	if(src.knockedout||src.firing)
		return
	else
		var/X=Uses*0.1
		if(X<5)
			X=5
		if(X>15)
			X=15
		var/ChakraLoss=1
	//	if(src.RinneganActivated>=500)
//			ChakraLoss=1
		src.chakra-=ChakraLoss
		src<<"You bring everything away from you!"
		for(var/mob/M in oview(X,src))
			walk_away(M,src)
			spawn(5)
				walk(M,0)
		for(var/obj/M in oview(X,src))
			if(istype(M,/obj/Hidden_Ninja_Scroll))
				return
			if(istype(M,/obj/VillageScrollPost))
				return
			if(istype(M,/obj/VillageScrollPostBottom))
				return
			walk_away(M,src)
			spawn(5)
				walk(M,0)

