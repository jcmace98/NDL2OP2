///////////////////////////////////////////////////////
//Kikaichu Summon..Redone
//////////////////////////
mob/var/tmp/SummonedNumber=0
mob/var/tmp/list/BugsInWorld=list()
mob/proc/DelBugs()
	set background = 1
	for(var/mob/Bugs/Kekkai/A in src.BugsInWorld)
		A.loc=src.loc;
		sleep(1);
		src.Konchuu+=3*5;
		src.BugsInWorld-=A
		del(A)
	src.SummonedNumber=0
	if(prob(50))
		src.BugMastery+=1;if(src.BugMastery>50) src.BugMastery=50
	if(prob(50))
		if(src.BugMastery>=50)
			src.BugKeeper+=0.5
mob/proc/SummonKonchuu()
	set background = 1
//	if(src.SummonedNumber>5)
//		src<<"You've summoned enough Konchuu.";return
	if(src.AFK) return
	if(src.Konchuu<10)
		src<<"You don't have enough Konchuu.";return
	else
		var/mob/Bugs/Kekkai/S=new()
		src.SummonedNumber++
		src.BugsInWorld.Add(S)
		src.Konchuu-=10;

//		S.BugsInWorld.Add(S)
		if(S)
			S.health=15+(src.KekkaiHealth*7);S.maxhealth=15+(src.KekkaiHealth*7)
			S.Owner=src;S.tai=src.Feast;if(S.tai>50) S.tai=50;S.loc=locate(src.x, src.y, src.z)
			S.pixel_x+=rand(-5,5)
			S.pixel_y+=rand(-5,5)
		sleep(30);src.firing=0
mob/proc/unsummonkonchuu()
	for(var/mob/Bugs/Kekkai/S in src.BugsInWorld)
		src.Konchuu+=3;del(S)
mob/Bugs/Kekkai
	name="Kikaichu"
	icon='Icons/Jutsus/KekkaiMale.dmi'
	icon_state="Bugs"
	density=1
	maxhealth=25
	health=25
	stamina=0
	Konchuu=1
	MoveDelay=2//Was2
	NPC=1
	var/IsArashi=0
	proc/Devour(mob/M)
		if(M==Owner||M.name==src.name&&!M.Clone)
			..()
		else
			var/Damage=src.tai
			var/mob/P=M
			var/mob/O=src.Owner
			if(Damage>=250)
				Damage=250
			while(src&&P&&O&&P.loc==src.loc)
				if(P.knockedout&&P.StruggleAgainstDeath==0)
					if(src.Dead&&findtext(P.name,"corpse",1,0)==1)
						O<<"Your Kikaichu devours [P]!";src.tai+=(1+(O.Feast));O.FeastStrength+=0.5;P.health=0;//P.chakra=0
						O.Feast+=1;del(P)
					else
						O<<"Your Kikaichu devours [P]!";//src.tai+=(1+(O.Feast));
						O.FeastStrength+=0.5
						P.health=0;
					//	P.chakra=0;
						P.Death(O)
						if(prob(1))
							O.Feast+=1
					return
				else if(!P.knockedout)
					if(!src.firing)
						if(P.RaiArmor)
							if(prob(20))
								view(6,src)<<"The bug swarm is fried by [P]'s raiton armor!"
							del(src)
						if(M.name!=src.name&&!M.Clone)
							src.firing=1;

							if(P.Kaiten)
								del(src)
							if(P.chakra<0)
								sleep(50)
								Damage=Damage*0.4
							if(P&&!P.knockedout&&!P.ImmuneToDeath)
								P.chakra-=Damage
							if(P&&P.chakra<=0)
								walk(src,0)
				//			spawn() P.Death(src.Owner)
				sleep(40)
	New()
		..()
		spawn()
			while(src)
				var/mob/O=src.Owner
				if(src.IsArashi)
					src.tai=src.tai*0.25
				hearers(4,src)<<sound('SFX/Bugs.wav',0,0,rand(1,3),80)
				if(src.stamina<0)
					var/A=src.stamina
					src.health+=A
					if(src.health<0)
						src.Death(src)
				if(!src.Clone)
					if(O&&src.tai>150)//(10+O.KekkaiCap))
						src.tai=150//10+O.KekkaiCap
					//		if(src.tai>=150)
					//			src.tai=150
				if(src.firing&&prob(40))//was prob(33)
					src.firing=0
				sleep(10)
		spawn(600)
			del(src)
	Bump(A)
		if(ismob(A))
			var/mob/M = A
			if(M.Kaiten||M.sphere)
				return
			else
				if(src.Clone&&!src.firing)
					var/ZX=rand(1,3)
					if(ZX==1)
						src.AttackVerb()
					if(ZX==2)
						src.AttackVerb2()
					if(ZX==3)
						src.AttackVerb2()
					src.firing=1;spawn(10) src.firing=0
				else
					if(!src.Clone)
						src.loc=M.loc
						src.Devour(M)
///////////////////////////////////////////////////////
//Place Konchuu..Redone
//////////////////////////
mob/var/tmp/havekonchuu=0
mob/var/tmp/konchuuperson
mob/var/tmp/konchuudraining=0
mob/proc/Konchuutracking()
	if(src.AFK) return
	if(src.Konchuu<=1000)
		src<<"You don't have enough Konchuu!";return
	src<<"You search for your Konchuus."
	var/obj/X=new()
	X.icon='Icons/Jutsus/KekkaiMale.dmi'
	X.icon_state="tracking"
	X.name="Kikaichu"
	usr.Frozen=1
	sleep(30)
	for(var/mob/M in world)
		if(M.konchuuperson==src&&M.havekonchuu)
			if(M.z==src.z)
				src<<"[M] is located at [M.x],[M.y]!"
	usr.Frozen=0
	del(X)
mob/proc/Placekonchuu()
	if(src.AFK) return
	if(src.KBunshinOn)
		usr=src.controlled
	else
		usr=src
	if(usr.firing)
		return
	if(usr.Konchuu<=0)
		usr<<"You don't have enough Konchuu!!";return
	if(src.target)
		src.dir=get_dir(src,src.target)
	for(var/mob/M in oview(1))
		if(M)
			if(M.havekonchuu)
				src<<"You already have a bug on [M].";return
			if(M.knockedout)
				src<<"Because [M] is knocked out his chakra feels light and your bug is unable to sense it.";return
			src<<"You place a Female bug on [M]!"
			spawn(1200)
				if(M)
					if(M.havekonchuu&&M.konchuuperson==src)
						src<<"Your bug has fallen off."
						M<<"A bug has fallen off your shoulder?!"
						M.konchuudraining=0;M.havekonchuu=0;M.konchuuperson=""
			if(M.Kaiten||M.sphere)
				src<<"Your Konchuu died on [M]!";return
			src.Konchuu-=1;M.havekonchuu=1;M.konchuuperson=src
mob/proc/KonchuuDrain()
	if(src.AFK) return
	for(var/mob/M in world)
		if(M.konchuuperson==src&&M.havekonchuu)
			if(M.konchuudraining)
				if((M.shari||M.bya)&&prob(25))
					M<<"You notice the Bug on your shoulder and shake it off!"
					src<<"[M] has noticed your Bug and has removed it!"
					M.konchuudraining=0
					M.havekonchuu=0
					M.konchuuperson=""
				M.konchuudraining=0
				src<<"Your bug has fallen off."
				M<<"A bug has fallen off your shoulder?!"
				M.konchuudraining=0;M.havekonchuu=0;M.konchuuperson=""
				src<<"You stop draining [M]'s chakra.";sleep(20);return
			else
				M.konchuudraining=1
				src<<"You begin to drain [M]'s chakra."
				while(M&&M.konchuudraining)
					if(M.RaiArmor)
						M<<"Your Raiton Armor shocks a hidden bug that was draining your chakra!"
						src<<"[M]'s electric Armor shocked the bug, killing it!"
						M.konchuudraining=0
						M.havekonchuu=0
						M.konchuuperson=""
						return
					if(((M.shari||M.bya)&&prob(2))||((M.shari||M.bya)&&M.Guarding&&prob(20)))
						M<<"You notice the Bug on your shoulder and shake it off!"
						src<<"[M] has noticed your Bug and has removed it!"
						M.konchuudraining=0
						M.havekonchuu=0
						M.konchuuperson=""
						return
					if(!M.knockedout)
						M.chakra-=rand(20,45)
					sleep(11)
				return

mob/proc/DestroyKonchuu()
	if(src.AFK) return
	for(var/mob/M in world)
		if(M.konchuuperson==src&&M.havekonchuu)
			M<<"A Konchuu has fallen off your shoulder?";M.konchuudraining=0;M.havekonchuu=0;M.konchuuperson="";src<<"You take off the bug on [M]'s shoulder"
///////////////////////////////////////////////////////
//Kekkai Konchuu Bunshin No Jutsu..Redone
//////////////////////////
mob/proc/KekkaiKonchuuBunshinnoJutsu()
	if(src.AFK) return
	for(var/mob/Bugs/Kekkai/A in view(5,src))
		if(A.icon!=src.icon&&A.Clone==0)
			A.icon=src.icon;A.Clone=1;A.overlays=src.overlays;A.density=1;A.tai=src.tai
		return


///////////////////////////////////////////////////////
//Mushi Kabe No Jutsu..Redone
//////////////////////////
mob/Bugs
	BugShield
		name="Kikaichu"
		icon='Icons/Jutsus/Swarm.dmi'
		density=1
		MoveDelay=2
		health=1000
		stamina=0
		NPC=1

		New()
			src.pixel_x+=rand(-5,5)
			src.pixel_y+=rand(-5,5)
			.=..()
			spawn()
				while(src)
					sleep(7)//was sleep(2)
			//		hearers(4,src)<<sound('SFX/Bugs.wav',0,0,rand(1,3),80)
				//	view(src)<<sound('SFX/Bugs.wav',0,0,rand(1,3))
					if(src.stamina<0)
						var/A=src.stamina
						src.health+=A
						if(src.health<0)
							src.Death(src)
					for(var/mob/M in src.loc)//oview(0,src))
						if(M==Owner||M.name==src.name)
							..()
						else
							var/mob/P=M
							if(P.knockedout)
								var/mob/O=src.Owner
								if(P.knockedout&&P.StruggleAgainstDeath==0)
									if(src.Dead&&findtext(P.name,"corpse",1,0)==1)
										O<<"Your Kikaichu devours [P]!";src.tai+=(1+(O.Feast));O.FeastStrength+=1;P.health=0;//P.chakra=0
										O.Feast+=1;del(P)
									else
										O<<"Your Kikaichu devours [P]!";src.tai+=(1+(O.Feast));if(src.tai>=30) src.tai=30;O.FeastStrength+=1;P.health=0;//P.chakra=0;
										P.Death(src.Owner)
										if(prob(1))
											O.Feast+=1
				sleep(50)
			spawn(1200)
				del(src)
		Bump(A)
			if(ismob(A))
				var/mob/M = A
				if(M.Kaiten||M.sphere)
					return
				else
					src.loc=M.loc
					if(M==src.Owner)
						M.Konchuu++
						del(src)
			if(isobj(A))
				var/obj/M=A
				if(M.density)
					src.loc=M
			if(isturf(A))
				var/turf/M=A
				if(M.density)
					src.loc=M
mob/proc/KonchuuShield()
	if(src.AFK) return
	if(src.Konchuu<350)
		src<<"Not enough bugs!";return
	else
		src.UsingBugShield=1
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src<<output("You release a torrent of bugs!","Attack")
//		if(prob(50))
	//		view() << "<font color=silver><b><font face=verdana>[src] says: Mushi Kabe no Jutsu!"
		src.Konchuu-=350
		for(var/turf/T in oview(4))
			var/mob/Bugs/BugShield/S=new();S.Owner=src;S.tai=src.Feast;if(S.tai>50) S.tai=50;S.loc=T//was S.tai=src.FeastStrength
			src.BugsInWorld.Add(S)
			S.health=100+(src.KekkaiHealth*50)//was *100
			if(S.health>1000) S.health=1000
mob/var/tmp/UsingBugShield=0
///////////////////////////////////////////////////////
//Mushi Dama No Jutsu..Redone
//////////////////////////
mob/proc/MushiDama()
	if(src.AFK) return
	if(src.Konchuu<350)
		src<<"Not enough bugs!";return
	src.Konchuu-=350
	if(src.firing)
		return
	src<<output("You send off a swarm of bugs!","Attack")
	for(var/turf/T in oview(1))
		var/mob/Bugs/Swarm/S=new()
		S.Owner=src
		src.BugsInWorld.Add(S)
		S.health=15+(src.KekkaiHealth*7);S.maxhealth=15+(src.KekkaiHealth*7)
		S.tai=src.Feast;if(S.tai>30) S.tai=30//was src.FeastStrength
		S.pixel_x+=rand(-5,5)
		S.pixel_y+=rand(-5,5)
		S.loc=T
		if(src.target)
			src.dir=get_dir(src,src.target)
			var/mob/M=src.target
			walk_towards(S,M)
		else
			walk_rand(S)
	sleep(150)
	for(var/mob/Bugs/Swarm/B in src.BugsInWorld)
		B.Owner=null;src.BugsInWorld.Remove(B);B.loc=null;del(B)

mob/proc
	SpecialSwarm(Mode="Health",Controllable=0,Number=1,Line=0,Circle=0,RequiredBugs=100)
		if(src.AFK) return
		if(src.Konchuu<RequiredBugs)
			src<<"Not enough bugs! ([src.Konchuu]/[RequiredBugs])";return
		if(src.firing)
			return
		view()<<"[src] sends off a swarm of bugs!"
		if(!Line&&!Circle)
			while(Number>0)
				var/mob/Bugs/SpecialSwarm/S=new()
				src.BugsInWorld.Add(S)
				S.health=25+(src.KekkaiHealth*25);S.Owner=src
				S.pixel_x+=rand(-5,5);S.pixel_y+=rand(-5,5)
				S.loc=src.loc
				S.Mode=Mode;S.Controllable=Controllable
				if(!Controllable)
					walk(S,src.dir)
				Number--
				sleep(1)
		else if(Circle)
			for(var/turf/T in getcircle(src,2))
				var/mob/Bugs/SpecialSwarm/S=new()
				src.BugsInWorld.Add(S)
				S.health=25+(src.KekkaiHealth*25);S.Owner=src
				S.pixel_x+=rand(-5,5);S.pixel_y+=rand(-5,5)
				S.loc=T
				S.Mode=Mode;S.Controllable=Controllable
				if(!Controllable)
					walk(S,get_dir(src,S))
		else
			while(Number>0)
				for(var/turf/T in oview(2,src))
					if(src.dir==get_dir(src,T)||src.dir==turn(get_dir(src,T),45)||src.dir==turn(get_dir(src,T),-45))
						var/mob/Bugs/SpecialSwarm/S=new()
						src.BugsInWorld.Add(S)
						S.health=25+(src.KekkaiHealth*25);S.Owner=src
						S.pixel_x+=rand(-5,5);S.pixel_y+=rand(-5,5)
						S.loc=T
						S.Mode=Mode;S.Controllable=Controllable
						if(!Controllable)
							walk(S,src.dir)
						Number--
				sleep(1)
mob/Bugs
	SpecialSwarm
		Swarm
		name="Mites"
		icon='Icons/Jutsus/Swarm.dmi'
		density=1
		stamina=0
		NPC=1
		var/Mode="Health"
		var/Controllable=0
		New()
			..()
			spawn(150)
				src.Owner=null
				src.loc=null
	//			del(src)
		Bump(A)
			if(ismob(A))
				var/mob/M = A
				if(M.Kaiten||M.sphere)
					return
				if(src.type==M.type)
					return
				else
					src.loc=M.loc
					walk(src,0)
					src.Drain(M,src.Owner)
		proc/Drain(mob/M,mob/Owner)

			if(M!=Owner&&M.name!=src.name&&!M.Clone)
				while(src.loc==M.loc)
					if(M.knockedout&&M.StruggleAgainstDeath==0)
						Owner<<"Your Kikaichu devours [M]!";M.health=0;//M.chakra=0;
						M.Death(Owner)
						if(prob(1))
							Owner.Feast+=1

					else
						if(M.name!=src.name&&!M.Clone)
							src.firing=1
							var/Damage=Owner.GenSkill+Owner.BugManipulation
							if(src.Mode=="Health Heal")
								Damage*=-1
							if(M.Kaiten||M.SusanooIn)
								del(src)
							if(M.RaiArmor)
								if(prob(20)||M.key=="")
									view(6,src)<<"The bug swarm is fried by [M]'s raiton armor!"
								del(src)
							if(!M.knockedout&&!M.ImmuneToDeath)
								if(Damage<0&&M.health<M.maxhealth)
									M.DamageProc(Damage,"Health",Owner)
									if(prob(4))
										M<<"The nano mites are healing your wounds!"
								else if(Damage>0)
									if(Damage>17)//Was 40
										Damage=17
									M.DamageProc(Damage,"Health",Owner)
							if(M.knockedout)
								walk(src,0)
					sleep(7)
				return


	Swarm
		name="Kikaichu"
		icon='Icons/Jutsus/Swarm.dmi'
		density=1
		stamina=0
		NPC=1

		New()
			.=..()
			spawn()
				while(src)
					var/mob/O=src.Owner
					if(src.tai>150)//(5+O.KekkaiCap*5))
						src.tai=150//5+O.KekkaiCap*5
					hearers(4,src)<<sound('SFX/Bugs.wav',0,0,rand(1,3),80)
				//	view(src)<<sound('SFX/Bugs.wav',0,0,rand(1,3))
					sleep(7)
					if(src.stamina<0)
						var/A=src.stamina
						src.health+=A
						if(src.health<0)
							src.Death(src)
					for(var/mob/M in oview(0,src))
						if(M!=O&&M.name!=src.name&&!M.Clone)
							var/mob/P=M


							if(!src.firing)
								if(M.name!=src.name&&!M.Clone)
									src.firing=1;var/Damage=src.tai
									if(Damage>=150)
										Damage=150
									if(P.Kaiten)
										del(src)
									if(P.RaiArmor)
										if(prob(20))
											view(6,src)<<"The bug swarm is fried by [P]'s raiton armor!"
										del(src)
									if(P.chakra<0)
										sleep(50)
										Damage=Damage*0.7
									if(!P.knockedout&&!P.ImmuneToDeath)
										P.chakra-=Damage
									if(P.chakra<=0)
										walk(src,0)
								//	P.Death(src.Owner)
							sleep(60);src.firing=0
					if(O==null)
						del(src)

		Bump(A)
			if(ismob(A))
				var/mob/M = A
				if(M.Kaiten||M.sphere)
					return
				else
					src.loc=M.loc
///////////////////////////////////////////////////////
//Kekkai Arashi No Jutsu
//////////////////////////
mob/proc/KekkaiArashi()
	if(src.AFK) return
	if(src.Konchuu<4000)
		src<<"Not enough bugs!";return
	if(src.firing)
		return
	src.Konchuu-=4000
	src<<output("You send off a swarm of bugs!","Attack")
	var/Z=4
	while(Z>0)
		for(var/turf/T in oview(Z))
			if(!(T in oview(Z-1)))
				var/mob/Bugs/Kekkai/S=new()
				//sleep(2)
				src.BugsInWorld.Add(S)
				S.health=50+(src.KekkaiHealth*50);S.maxhealth=50+(src.KekkaiHealth*50)
				S.pixel_x+=rand(-5,5)
				S.pixel_y+=rand(-5,5)
				S.Owner=src;S.tai=src.Feast;if(S.tai>40) S.tai=40;S.loc=T;S.IsArashi=1;S.icon='Icons/Jutsus/Swarm.dmi'//was tai=src.FeastStrength
		Z--
		sleep(1)
	spawn(300)
		for(var/mob/Bugs/Kekkai/S in src.BugsInWorld)
			if(S.IsArashi)
				S.Owner=null;src.BugsInWorld.Remove(S);S.loc=null;del(S)

///////////////////////////
//Kekkai Teleport/Shushin
//////////////////////////
mob/owner/verb/LolBugTeleportJutsu_xD(mob/M in world)
	var/location=get_step(M,SOUTH)
	spawn(30)
		src.loc=location
	for(var/turf/T in oview(8,M))
		if(prob(20))
			var/mob/Bugs/Kekkai/S=new()
			S.health=50+(src.KekkaiHealth*50);S.maxhealth=50+(src.KekkaiHealth*50)
			S.pixel_x+=rand(-5,5)
			S.pixel_y+=rand(-5,5)
			S.MoveDelay=0;S.Owner=src;S.tai=src.Feast;if(S.tai>150) S.tai=150;S.loc=T;S.IsArashi=1;S.icon='Icons/Jutsus/Swarm.dmi'
			spawn()
				walk_towards(S,location,0)
				spawn(45)
					walk_away(S,location,0)
					spawn(40)
						del(S)

