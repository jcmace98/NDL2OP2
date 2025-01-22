mob/var/tmp
	SunaNoTate=0
	SunaMode=0
	sphere=0
	usingS=0
	StruggleOutOfKyuu=35//was 50 going to try 40
	sandeye=0
	NotBlock=0
	SandWaterfallBurial=0
	InSandManip=0
	IronArmor=0
	SandFist=0
	Suspension=0


mob/var
	SunaReflexes=0
	AutoSphere=0
//New v4 passive that allows the user to immediately activate their Sand Sphere
//Skillcard by pressing Z and holding X. Z doesn't have to be held to keep it up
//But when X is released, the sphere is taken down. Still keeps true to the cooldown of the skillcard however.

mob/var/tmp/list/F=new
mob/proc/SandAmountPassiveCheck()
	src.MaxSandAmount=((src.SandPackage*25)+100)
	for(var/obj/Clothes/Gourd/O in usr.contents)
		if(O.worn)
			usr.MaxSandAmount+=SandCapacity*80

mob/proc/KyuuCatcher()
	if(src.ImmuneToDeath)
		src.StruggleOutOfKyuu=0
	if(src.FrozenBind=="Sand")
		src<<"Press space rapidly to break out!"
		while(src&&src.FrozenBind=="Sand"&&src.Struggle<src.StruggleOutOfKyuu)
			src.FrozenBind="Sand"
			if(src.NotBlock==1)
				src.icon_state=""
				src.Guarding=0
			sleep(5)
	src<<"You broke out of the Sand!";src.StruggleOutOfKyuu=0;src.Struggle=0;src.FrozenBind="";src.NotBlock=0
obj/proc/Sousou()
	var/obj/Jutsu/Sand/kyuu/ACDC=src
	var/mob/O=ACDC.Owner;flick("sousou",ACDC);var/damage=rand(O.nin*600,O.nin*650)//(O.nin*1000,O.nin*1500)
	if(O.Bijuu=="Ichibi"&&O.TailState>0||O.HasGoldSand) damage*=1.5
	for(var/mob/M in ACDC.loc)
		if(ACDC.NoBlock)
			M.DamageProc(damage/100,"Health",O)
		else
			M.DamageProc((damage/M.Endurance),"Health",O)
		spawn()
			M.Bloody();M.Bloody();M.Bloody()
		if(!M.knockedout)
			M.AwardMedal("This Guy Is Tough!")
	del(ACDC)
mob/Click()
	for(var/mob/Sand/SunaNoTate/B in world)
		if(B.Owner==usr)
			walk_towards(B,src,1)
	for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/B in world)
		if(B.Owner==usr)
			walk_to(B,src,,1)

			//sleep(70)
			//walk(B,0)
//	for(var/mob/M in world)
//		if(M==usr)
//			world<<"Mob/Click Walk_towards activated."
//			world<<"Mob using this is [M]. User is [usr]. The src of the proc is [src]."
//			walk_to(M,src,0,1)
//mob/Click()
//	world<<"Test." < But this works wtf?
//	..()
turf/Click()
	for(var/mob/Sand/SunaNoTate/B in world)
		if(B.Owner==usr)
			walk_to(B,src,,1)
	for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/B in world)
		if(B.Owner==usr)
			walk_to(B,src,,1)

obj/Click()
	for(var/mob/Sand/SunaNoTate/B in world)
		if(B.Owner==usr)
			walk_to(B,src,,1)
	for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/B in world)
		if(B.Owner==usr)
			walk_to(B,src,,1)

obj/Jutsu/Sand
	icon='Icons/Jutsus/Suna.dmi'
		//if(usr.HasGoldSand)	icon='Icons/Jutsus/GoldSuna.dmi'
	Suna2
		icon = 'Icons/Jutsus/Suna2.dmi'
		//if(usr.HasGoldSand)	icon='Icons/Jutsus/GoldSuna2.dmi'
		icon_state = "straight"
		density = 1
		New()
			..()
			spawn(60)
			while(src)
				sleep(30)
				for(var/obj/Jutsu/Elemental/Suiton/Owater/A in src.loc)
					viewers(src)<<"The sand turns to mush.";del(src)
				for(var/turf/water/A in src.loc)
					viewers(src)<<"The sand turns to mush.";del(src)
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					viewers(src)<<"The sand turns to mush.";del(src)
				del(src)
	Spikes
		New()
			..()
			spawn()
				for(var/mob/M in src.loc)
					var/mob/O=src.Owner
					if(M==O||M.ingat|M.intank|M.Kaiten|M.sphere)
						return
					var/damage=rand(M.maxhealth*0.078,M.maxhealth*0.25);if(O.Bijuu=="Ichibi"&&O.TailState>0||O.HasGoldSand) damage*=1.3;M.SoundEngine('SFX/Slice.wav',5);M.DamageProc(damage,"Health",O)
					spawn()
						M.Bloody();M.Bloody();M.Bloody()
			spawn(30)
				del(src)
		North icon_state = "north";density=1
		South icon_state = "south";density=1
		West icon_state = "west";density=1
		East icon_state = "east";density=1
	Sphere
		density=1
		icon_state="SunaSphere"
		layer=MOB_LAYER+1


	SandWhip
		icon_state = "SandWhip"
		density=1
		New()
			..()

			spawn(13)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A;var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				var/damage=round(rand(M.maxstamina*0.15,M.maxstamina*0.20))
				if(O.Bijuu=="Ichibi"&&O.TailState>0||O.HasGoldSand)
					damage*=1.3
				M.DamageProc(damage,"Stamina",O,"sand","yellow")
				if(prob(O.NinjutsuKnowledge/25)||(O.Bijuu=="Ichibi"&&O.TailState>0)) //Was originally /200
					M.StunAdd(10)
					M.Running=0
			//	view()<<sound('SFX/HitStrong.wav',0,volume=35);view(M) << "[M] was hit by Sand for [damage] damage!!"
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
	Sshuriken
		icon_state = "Shuriken"
		density=1
		var/Type=0
		New()
			..()
			spawn(20)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				var/damage=round(rand(75,200)) //This is meant to be stamina. Buffed the damage a bit though.
				if(src.icon_state=="Shuriken2")
					damage=round(rand(100,230)) //The reasoning is that these are just sand pellets until mastered where they have a slight edge
																			//Then it has a chance based on nin knowledge to cut the target. Lowered the delay also so its more practical.
				M.DamageProc(damage,"Stamina",O,"Suna Shuriken","yellow")
				if(src.icon_state=="Shuriken2")
					if(prob(O.NinjutsuKnowledge/50))
						spawn()M.Bloody()
						M.DamageProc(rand(75,80),"Health",O)
						view(M)<<sound('SFX/Slice.wav',0,volume=49)
				del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
	IronNeedles
		icon='Icons/Jutsus/IronSand_Techniques.dmi'
		icon_state = "IronNeedles"
		density=1
		var/Type=0
		New()
			..()
			spawn(20)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				var/damage=round(rand(75,200)) //This is meant to be stamina. Buffed the damage a bit though.
																			//Then it has a chance based on nin knowledge to cut the target. Lowered the delay also so its more practical.
				M.DamageProc(damage,"Health",O,"Iron Needles","grey")
				del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
	IronWeapons
		icon='Icons/Jutsus/IronSand_Techniques.dmi'
		icon_state = "IronWeaponry"
		density=1
		layer=MOB_LAYER+1
		Move_Delay=0
		var/TilesA=0
		var/TilesMax=14
		New()
			..()
			spawn(45)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				if(M.Kaiten||M.sphere)
					return
				if(M.Deflection)
					walk(src,0);src.dir=turn(src.dir,pick(45,-45));walk(src,src.dir);return
				var/mob/O=src.Owner;var/damage=M.maxhealth
				damage=((M.maxhealth*0.04)+(damage+O.SandMastery)/2);M.StunAdd(3);src.density=0;src.loc=M.loc;walk(src,0)
				if(damage>120)
					damage=120
				M.DamageProc(damage,"Health",O,"Iron Sand","grey")
				spawn() M.Bloody()
				spawn(25) del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			else if(istype(A,/obj/Doors/))
				var/obj/O=A
				O.DamageProc(rand(50,150),"Health",src.Owner)

			else
				del(src)


		Move()
			..()
			if(src.TilesA<src.TilesMax)
				src.TilesA++


	kyuu
		icon_state="KyuuTrail"
		density=1
		var/hit=0
		var/NoBlock=0
		New()
			var/mob/O=src.Owner
			if(O.HasGoldSand)
				src.icon='Icons/Jutsus/GoldSuna.dmi'
			spawn()
		//	var/mob/O=src.Owner
				while(src&&O.icon_state=="handseal")
					sleep(7)
					if(O.icon_state!="handseal")
						del(src)
				//	var/mob/O=src.Owner
					for(var/mob/A in src.loc)
						if(src.NoBlock==1)
							if(A.client&&(A in OnlinePlayers))
								A.icon_state=""
						else
							A.icon_state="Block"
					if(locate(/obj/Jutsu/Elemental/Suiton/Owater) in src.loc)//added 11/16/12
						for(var/obj/Jutsu/Elemental/Suiton/Owater/A in src.loc)
							if(O.Shukaku==1&&O.Bijuu!="Ichibi")
								viewers(src)<<"The sand turns to mush";del(src) //people want the Sand to always be absorbed...sooo..GG
							else if(O.Bijuu!="Ichibi"&&O.TailState!=0)
								viewers(src)<<"The sand turns to mush.";del(src)
							if(O.Shukaku==0)
								viewers(src)<<"The sand turns to mush.";del(src)
					for(var/obj/Jutsu/Kiriame/S2 in src.loc)
						viewers(src)<<"The sand turns to mush.";del(src)
				if(O.icon_state!="handseal")
					del(src)
			spawn(180)
				if(src)
					del(src)
		Bump(A)
			..()
			if(isobj(A))
				var/obj/O=A
				if(O.density)
					src.density=0;sleep(11);src.density=1
				else
					..()
			if(ismob(A))
				var/mob/M=A;var/mob/O=src.Owner
				if(!src.hit)
					src.hit=1
					if(M!=O&&!M.knockedout)
						if(M.icon_state!="Block"&&!M.Guarding)
							src.NoBlock=1
						viewers(10,M) << "[M] was captured by the sand!!";M.FrozenBind="Sand";M.caughtby="[O]";src.layer=MOB_LAYER+1;src.loc=M.loc;src.icon_state="KyuuCapture";walk(M,0);M.StruggleOutOfKyuu=rand(30,40)
						spawn() M.KyuuCatcher()
						spawn(100) del(src)
						for(var/obj/Jutsu/Sand/kyuutrail/L in world)
							if(L != src&&L.Owner==src.Owner)
								del(L)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
		Move()
			var/obj/Jutsu/Sand/kyuutrail/L=new()
			if(src.icon=='Icons/Jutsus/GoldSuna.dmi')
				L.icon='Icons/Jutsus/GoldSuna.dmi'
			L.loc=src.loc;L.dir=src.dir;L.Owner=src.Owner;..()
		Del()
			var/mob/O=src.Owner
			for(var/mob/M in world)
				if(M&&M.caughtby=="[O]"&&M!=O)
					M.caughtby=null
					if(M.FrozenBind=="Sand")
						M.FrozenBind=""
			..()
	kyuutrail
		icon_state="KyuuTrail"
		density=1
		New()
			spawn(15)
				if(src)
					del(src)
	SandTurf
		icon_state = "sand"
		density = 0
		layer = MOB_LAYER+3
		var/list/PeopleCaught=list()
		New()
			spawn(220)
				del(src)
			..()
			var/mob/O=src.Owner
			if(O.HasGoldSand)
				src.icon='Icons/Jutsus/GoldSuna.dmi'
			spawn()
				while(src)
					sleep(3)
					for(var/mob/M in src.loc)
						if(!(M in PeopleCaught))
							if(M in OnlinePlayers)
								PeopleCaught+=M
						if(M==O)
							return
						if(!M.knockedout&&M.FrozenBind=="")
							M.StunAdd(15)
						if(prob(55))
							if(M.FrozenBind=="")
								M.FrozenBind="Sand Waterfall"
								spawn(20)
									M.FrozenBind=""
					for(var/obj/Jutsu/Elemental/Suiton/Owater/A in src.loc)
						var/mob/OO=src.Owner
						if(OO.Shukaku==1&&OO.Bijuu=="")
							viewers(src)<<"The sand turns to mush";del(src)
						else if(OO.Bijuu!="Ichibi"&&OO.TailState!=0)
							viewers(src)<<"The sand turns to mush.";del(src)
					var/mob/OOO=src.Owner
					if(OOO.Shukaku==0)
						for(var/turf/water/A in src.loc)
							viewers(src)<<"The sand turns to mush.";del(src)
					for(var/obj/Jutsu/Kiriame/S2 in src.loc)
						viewers(src)<<"The sand turns to mush.";del(src)
		Del()
			for(var/mob/P in PeopleCaught)
				if(P.FrozenBind=="Sand Waterfall")
					P.FrozenBind=""
			..()
	SandField
		icon_state = "sand"
		density = 0
		layer = MOB_LAYER+3
		var/PullingIn=0
		var/Shukaku=0
		New()
			spawn(220)
				del(src)
			..()
			var/mob/O=src.Owner
			if(O.HasGoldSand)
				src.icon='Icons/Jutsus/GoldSuna.dmi'
			spawn()
				while(src)
					sleep(6)
					for(var/mob/M in src.loc)
						if(M==O)
							return
						PullingIn++
						if(PullingIn==1)
					//		walk_towards(M,O)
							step_to(M,O)
							PullingIn=0
						M.Running=0
					for(var/obj/Jutsu/Elemental/Suiton/Owater/A in src.loc)
						if(O.Shukaku==1&&O.Bijuu=="")
							viewers(src)<<"The sand turns to mush.";del(src)
						else if(O.Bijuu!="Ichibi"&&O.TailState!=0)
							viewers(src)<<"The sand turns to mush.";del(src)
					if(O.Shukaku==0)
						for(var/turf/water/A in src.loc)
							viewers(src)<<"The sand turns to mush.";del(src)
					for(var/obj/Jutsu/Kiriame/S2 in src.loc)
						viewers(src)<<"The sand turns to mush.";del(src)
	SandWave
		icon_state="Wave"
		density=0
		pixel_step_size=32
		Move()
			var/mob/O=src.Owner

			var/turf/prevloc=src.loc
			..()
			if(src.loc!=prevloc)
				var/obj/Jutsu/Sand/SandTurf/L=new()
				if(O.HasGoldSand)
					L.icon='Icons/Jutsus/GoldSuna.dmi'
				L.loc=src.loc;L.Owner=src.Owner
				O.JutsuList.Add(L)

	IronSandWave
		icon='Icons/Jutsus/IronSand_Techniques.dmi'
		var
			nin=10
			prestep=0
			laststep=0
		New()
			..()
			spawn(1)
				var/mob/O=src.Owner
				while(src)

					for(var/mob/M in src.loc)
						if(!M.client)
							return
						if(M.UsingDomu||M.Mogu||M.UsingCDome)
							return
						if(M.knockedout)
							return
						var/damage=src.nin;damage=round((damage*(300))*((O.SandMastery*0.02)+0.7));damage=damage/M.Endurance
						M.DamageProc(damage,"Health",O,"IronSand","grey")
					//	step(M,src.dir)
						spawn()
							walk(M,src.dir);
				//		step(M,src.dir);
				//		step(M,src.dir)
					sleep(4)
			spawn(70)
				del(src)
		Bump(A)
			..()
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
		IronL
			icon_state = "l2"
			density = 0
			layer = FLY_LAYER+1
			Move()
				src.laststep=src.loc
				..()
				var/obj/Jutsu/Sand/IronSandWave/IronSandWaveL1/L=new();L.loc = src.laststep;L.dir = src.dir;L.Owner=src.Owner;L.nin=src.nin
		IronSandWaveL1
			icon_state = "l1"
			layer = MOB_LAYER+1
			density = 0
			New()
				..()
				spawn(1)
					var/mob/O=src.Owner
					while(src)
						sleep(1)
					//	src.SoundEngine('SFX/WaterSFX.wav',10,50)
						sleep(1)
						for(var/mob/M in src.loc)
							if(M.UsingDomu||M.Mogu||M.UsingCDome)
								return
							if(M.knockedout)
								return
							var/damage=src.nin;damage=round((damage*(175))*((O.SandMastery*0.06)+0.7));damage=damage/M.Endurance;view(M)<<output("<font color=grey>[M] has been crushed by the IronSand for [damage] damage!</font>","Attack")
							M.DamageProc(damage,"Health",O,"IronSand","grey")
							spawn()
								walk(M,src.dir)
							//	step(M,src.dir);step(M,src.dir);step(M,src.dir)
						sleep(4)
				spawn(50)
					del(src)
		IronM
			icon_state = "m2"
			density = 0
			layer = FLY_LAYER+1
			Move()
				src.laststep=src.loc
				..()
				var/obj/Jutsu/Sand/IronSandWave/IronSandWaveM1/L=new();L.loc = src.laststep;L.dir = src.dir;L.Owner=src.Owner;L.nin=src.nin;
		IronSandWaveM1
			icon_state = "m1"
			density = 0
			layer = MOB_LAYER+1
			New()
				..()
				spawn(1)
					var/mob/O=src.Owner
					while(src)
						sleep(1)
					//	src.SoundEngine('SFX/WaterSFX.wav',1,50)
						sleep(1)
						for(var/mob/M in src.loc)
							if(M.UsingDomu||M.Mogu||M.UsingCDome)
								return
							if(M.knockedout)
								return
							var/damage=src.nin;damage=round((damage*(175))*((O.SandMastery*0.06)+0.7));damage=damage/M.Endurance;view(M)<<output("<font color=grey>[M] has been crushed by the IronSand for [damage] damage!</font>","Attack")
							M.DamageProc(damage,"Health",O,"IronSand","grey")
							spawn()
								walk(M,src.dir)
							//	step(M,src.dir);step(M,src.dir);step(M,src.dir)
						sleep(4)
				spawn(50)
					del(src)
		IronR
			icon_state = "r2"
			density = 0
			layer = FLY_LAYER+1
			Move()
				src.laststep=src.loc
				..()
				var/obj/Jutsu/Sand/IronSandWave/IronSandWaveR1/L=new();L.loc = src.laststep;L.dir = src.dir;L.Owner=src.Owner;L.nin=src.nin
		IronSandWaveR1
			icon_state = "r1"
			density = 0
			layer = MOB_LAYER+1
			New()
				..()
				spawn(1)
					var/mob/O=src.Owner
					while(src)
						sleep(1)
					//	src.SoundEngine('SFX/WaterSFX.wav',10,50)
						sleep(1)
						for(var/mob/M in src.loc)
							if(M.UsingDomu||M.Mogu||M.UsingCDome)
								return
							if(M.knockedout)
								return
							var/damage=src.nin;damage=round((damage*(175))*((O.SandMastery*0.06)+0.7));damage=damage/M.Endurance;view(M)<<output("<font color=grey>[M] has been crushed by the IronSand for [damage] damage!</font>","Attack")
							M.DamageProc(damage,"Stamina",O,"IronSand","grey")
							spawn()
								walk(M,src.dir)
							//	step(M,src.dir);step(M,src.dir);step(M,src.dir)
						sleep(4)
				spawn(50)
					del(src)

	SandArm2
		icon = 'Icons/Jutsus/Suna3.dmi'
		icon_state = ""
		density = 1
		var
			first=0
			hit=0
		New()
			..()
			spawn(70)
				del(src)
		Move()
			var/obj/Jutsu/Sand/SandArmTrail2/L=new();
			if(src.icon=='Icons/Jutsus/GoldSuna3.dmi')
				L.icon='Icons/Jutsus/GoldSuna3.dmi'
			L.loc = src.loc;L.dir = src.dir;L.Owner = src.Owner;..()
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A;var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				var/damage=round(rand(O.NinSkill*5,O.NinSkill*7.5));if(O.Bijuu=="Ichibi"&&O.TailState>0||O.HasGoldSand) damage*=2.5;M.DamageProc(damage,"Stamina",O);view(M)<<"[M] was hit by the Sand Arm!!";M.HitBack(10,src.dir)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
	SandArmTrail2
		icon = 'Icons/Jutsus/Suna3.dmi'
		icon_state = "trail"
		density = 1
		New()
			..()
			spawn(70)
				del(src)

	IronSandCreation
		icon='Icons/Jutsus/IronSand_Techniques.dmi'
		icon_state="1"
		density=1
		layer=MOB_LAYER+1
		New()
			..()
			spawn(7)
				walk(src,src.dir)
		Bump(A)
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					del(src)
				var/damage=round(O.SandMastery*1.6,O.SandMastery*2.25)
				M.DamageProc(damage,"Health",O,"Iron Sand","grey")
				spawn() M.Bloody();M.Bloody();M.Bloody()
				var/turf/X=src.loc
				spawn() src.CreateSmoke("Strong")
				spawn() X.PushBackOfEpicProportions(src.Owner)
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
mob/Sand
	icon='Icons/Jutsus/Suna.dmi'
	SunaNoTate
		name="Sand"
		icon_state="Sand1"
		var/StunChance=0
		health=500
		density=1
		MoveDelay=2
		layer=MOB_LAYER+1
		New()
			..()
			spawn()
			while(src)
				var/mob/O=src.Owner;sleep(11);src.Running=0
				if(src.Stun>0)
					if(prob(90))
						src.Stun--
				if(src.loc==O.loc)
					src.icon_state="Tate"
					src.dir=O.dir
				else
					src.icon_state="Sand1"
				if(O.Shukaku==0)
					for(var/obj/Jutsu/Elemental/Suiton/Owater/A in src.loc)
						if(src.icon_state!="Tate"&&O.Bijuu=="")
							viewers(src)<<"The sand turns to mush.";del(src)
					for(var/turf/water/A in src.loc)
						if(src.icon_state!="Tate"&&O.Bijuu=="")
							viewers(src)<<"The sand turns to mush.";del(src)
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					viewers(src)<<"The sand turns to mush.";del(src)
			spawn(1000)
				viewers(src)<<"The sand falls back into dust.";del(src)
		Bump(A)
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M==O)
					src.loc=O.loc;return
				var/DamagePlus=rand(O.SandMastery*rand(1.1,1.5));var/damage=((src.nin+DamagePlus)/(M.Endurance/10))
				if(!src.firing)
					if(M.Kaiten)
						viewers(src)<<"The sand falls back into dust.";del(src)
					spawn()AttackEfx(M.x,M.y,M.z);view(M)<<output("[M] was hit by the sand!([damage])","Attack")
					if(O.Bijuu=="Ichibi"&&O.TailState>0||O.HasGoldSand) damage*=1.3
					M.DamageProc(damage,"Stamina",O);viewers()<<sound('SFX/HitMedium.wav',0);src.firing=1
					if(StunChance==1)
						if(!M.knockedout)
							M.Stun+=pick(5,6)
					spawn(25)
						src.firing=0
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					return 0
			if(istype(A,/obj/))
				return 0
	CarrierSand
		name="Carrier Sand"
		icon='Icons/Jutsus/IronSand_Techniques.dmi'
		icon_state="Suspension"
		density=0
		Running=1
		layer=MOB_LAYER+3
		New()
			..()

		Move()
			..()
			var/mob/O = src.Owner
			O.loc=src.loc;O.dir=src.dir
	Suna
		name="Sand"
		icon = 'Icons/Jutsus/Suna2.dmi'
		icon_state="head"
		health=10000000000000000000000000000
		density=1
		MoveDelay=1
		Running=1
		New()
			..()
			spawn()
			while(src)
				sleep(11)
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					viewers(src)<<"The sand turns to mush.";del(src)
			spawn(70)
				if(src.icon_state!="head")
					del(src)
		Del()
			flick("die",src)
			sleep(6)
			..()
		Move(Loc,Dir)
			var/prevdir=src.dir
			if(Dir!=prevdir&&Dir!=turn(prevdir,45)&&Dir!=turn(prevdir,-45)&&Dir!=turn(prevdir,90)&&Dir!=turn(prevdir,-90))
				return 0
			var/obj/Jutsu/Sand/Suna2/A = new()
			if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
				A.icon='Icons/Jutsus/GoldSuna2.dmi'
			var/mob/O=src.Owner;var/ChakraLoss=(O.Mchakra*0.001);O.chakra-=ChakraLoss
			if(src.icon=='Icons/Jutsus/Suna3.dmi')
				A.icon='Icons/Jutsus/Suna3.dmi'
			A.loc=src.loc;A.dir=src.dir;A.Owner=src.Owner
			..()
			if(prevdir==src.dir)
				A.dir=prevdir
				if(src.dir==NORTHEAST||src.dir==NORTHWEST||src.dir==SOUTHWEST||src.dir==SOUTHEAST)
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=A.dir;B.icon_state="fillin"
					if(B.dir==NORTHEAST){B.pixel_x=16;B.pixel_y=16}
					if(B.dir==NORTHWEST){B.pixel_x=-16;B.pixel_y=16}
					if(B.dir==SOUTHEAST){B.pixel_x=16;B.pixel_y=-16}
					if(B.dir==SOUTHWEST){B.pixel_x=-16;B.pixel_y=-16}
			else if(prevdir==(turn(src.dir,180)))
				A.dir=prevdir
			else
				//Cardinal to Cardinal
				if(prevdir==NORTH&&src.dir==EAST)
					A.dir=EAST;A.icon_state="turn"
				if(prevdir==EAST&&src.dir==NORTH)
					A.dir=NORTH;A.icon_state="turn"
				if(prevdir==SOUTH&&src.dir==EAST)
					A.dir=SOUTH;A.icon_state="turn"
				if(prevdir==EAST&&src.dir==SOUTH)
					A.dir=WEST;A.icon_state="turn"
				if(prevdir==WEST&&src.dir==NORTH)
					A.dir=SOUTH;A.icon_state="turn"
				if(prevdir==NORTH&&src.dir==WEST)
					A.dir=WEST;A.icon_state="turn"
				if(prevdir==SOUTH&&src.dir==WEST)
					A.dir=NORTH;A.icon_state="turn"
				if(prevdir==WEST&&src.dir==SOUTH)
					A.dir=EAST;A.icon_state="turn"



				//Diagonal to Cardinal
				if(prevdir==NORTHEAST&&src.dir==NORTH)
					A.dir=SOUTHWEST;A.icon_state="turn"
				if(prevdir==NORTHWEST&&src.dir==NORTH)
					A.dir=SOUTHEAST;A.icon_state="turn"
				if(prevdir==SOUTHEAST&&src.dir==SOUTH)
					A.dir=NORTHWEST;A.icon_state="turn"
				if(prevdir==SOUTHWEST&&src.dir==SOUTH)
					A.dir=NORTHEAST;A.icon_state="turn"
				if(prevdir==NORTHEAST&&src.dir==EAST)
					A.dir=NORTHEAST;A.icon_state="turn 2"
				if(prevdir==NORTHWEST&&src.dir==WEST)
					A.dir=NORTHWEST;A.icon_state="turn 2"
				if(prevdir==SOUTHEAST&&src.dir==EAST)
					A.dir=SOUTHEAST;A.icon_state="turn 2"
				if(prevdir==SOUTHWEST&&src.dir==WEST)
					A.dir=SOUTHWEST;A.icon_state="turn 2"



				//Cardinal to Diagonal
				if(prevdir==NORTH&&src.dir==NORTHEAST)
					A.dir=NORTHEAST;A.icon_state="turn"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=16
				if(prevdir==NORTH&&src.dir==NORTHWEST)
					A.dir=NORTHWEST;A.icon_state="turn"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=16
				if(prevdir==SOUTH&&src.dir==SOUTHEAST)
					A.dir=SOUTHEAST;A.icon_state="turn"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=-16
				if(prevdir==SOUTH&&src.dir==SOUTHWEST)
					A.dir=SOUTHWEST;A.icon_state="turn"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=-16
				if(prevdir==EAST&&src.dir==NORTHEAST)
					A.dir=SOUTHWEST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=16
				if(prevdir==WEST&&src.dir==NORTHWEST)
					A.dir=SOUTHEAST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=16
				if(prevdir==EAST&&src.dir==SOUTHEAST)
					A.dir=NORTHWEST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=-16
				if(prevdir==WEST&&src.dir==SOUTHWEST)
					A.dir=NORTHEAST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=-16



				//Diagonal to Diagonal
				if(prevdir==NORTHWEST&&src.dir==NORTHEAST)
					A.dir=SOUTH;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=16
				if(prevdir==NORTHEAST&&src.dir==NORTHWEST)
					A.dir=NORTH;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=16
				if(prevdir==SOUTHEAST&&src.dir==SOUTHWEST)
					A.dir=NORTH;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=-16
				if(prevdir==SOUTHWEST&&src.dir==SOUTHEAST)
					A.dir=SOUTH;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=-16
				if(prevdir==NORTHEAST&&src.dir==SOUTHEAST)
					A.dir=WEST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=-16
				if(prevdir==NORTHWEST&&src.dir==SOUTHWEST)
					A.dir=WEST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=-16
				if(prevdir==SOUTHEAST&&src.dir==NORTHEAST)
					A.dir=EAST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=16;B.pixel_y=16
				if(prevdir==SOUTHWEST&&src.dir==NORTHWEST)
					A.dir=EAST;A.icon_state="turn 2"
					var/obj/Jutsu/Sand/Suna2/B = new()
					if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
						B.icon='Icons/Jutsus/GoldSuna2.dmi'
					B.loc=A.loc;B.dir=src.dir;B.icon_state="fillin"
					B.pixel_x=-16;B.pixel_y=16
		Bump(A)
			if(ismob(A))
				var/mob/M=A;var/mob/O=src.Owner;var/DamagePlus=rand(O.SandMastery*rand(1.5,2))
				if(src.icon=='Icons/Jutsus/Suna3.dmi')
					DamagePlus=rand(O.SandMastery*rand(2,3))
			//	if(src.icon=='Icons/Jutsus/GoldSuna2.dmi')
			//		DamagePlus=rand(O.SandMastery*rand(4,6))
				var/damage=(((src.nin*rand(75,125))/M.Endurance)+DamagePlus)+rand(100,200)
				if(O.Bijuu=="Ichibi"&&O.TailState>0||O.HasGoldSand) damage*=1.3
				if(!src.firing)
					spawn()AttackEfx(M.x,M.y,M.z);M.DamageProc(damage,"Stamina",O);viewers()<<sound('SFX/HitMedium.wav',0);view(M)<<output("[M] was hit by the sand!([damage])","Attack");src.firing=1
					spawn(10)
						src.firing=0
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					return 0
			if(istype(A,/obj/Jutsu/Sand/Suna2/))
				var/obj/Jutsu/Sand/Suna2/B = A
				src.loc=B.loc
			if(istype(A,/obj/))
				return 0
mob/var/tmp/list/SandMonsters=list()
// Can possibly allow in future for multiple Suna Tates out at once, making Sabakus far more versatile.
//Also allows us to not have to loop through the whole world to find the object, saving lots of CPU usage
mob/proc
	SandCheck(Amount)
		var/turf/W = src.loc
		for(var/obj/Jutsu/Sand/SandTurf/T in W)
			return 1
		for(var/obj/Jutsu/Sand/SandField/F in W)
			return 1
		if(src.SandAmount>Amount)
			SandAmount-=Amount;
			return 1
	//	viewers(src)<<"Theres not enough sand to use this jutsu."
		return 0

	Sandeye()
		if(!src.sandeye)
			src.Handseals(1-src.HandsealSpeed)
			if(src.HandsSlipped) return
			src.overlays-='Icons/Jutsus/Sand eye.dmi';src.overlays+='Icons/Jutsus/Sand eye.dmi';src.sandeye=1
			while(src.sandeye)
				src.ChakraDrain(100);sleep(11)
		else
			src.sandeye=0;src<<"You Take down the Sand eye";src.overlays-='Icons/Jutsus/Sand eye.dmi'
	SunaNoTate()
		usr=src
		src.ChakraDrain(1000)
		if(src.SunaNoTate)
			src.SunaNoTate=0
			for(var/mob/Sand/SunaNoTate/B in src.SandMonsters)
				del(B)
			return
		else
			src.SunaNoTate=1
			var/mob/Sand/SunaNoTate/A=new()
			if(src.HasGoldSand)
				A.icon='Icons/Jutsus/GoldSuna.dmi'
			A.loc=src.loc;A.nin=src.nin;A.Owner=src;A.MoveDelay=5
			A.MoveDelay-=round(src.SandMastery/20)
			src.SandMonsters.Add(A)
			while(A)
				if(prob(1))
					src.SandMastery+=pick(0.01,0.1);if(src.SandMastery>100) src.SandMastery=100
				var/ChakraLoss=60-(src.SandMastery/3);src.ChakraDrain(ChakraLoss*1.3)
				sleep(11)
			src.SunaNoTate=0
	SunaBunshin()
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/GoodToGo=0
		for(var/mob/Sand/SunaNoTate/A in world)
			if(A.Owner==src)
				GoodToGo=1
		if(GoodToGo)
			for(var/mob/Sand/SunaNoTate/A in src.SandMonsters)
				A.icon='Icons/New Base/Base.dmi';A.overlays+=src.overlays;A.icon+=rgb(165,140,115)
				A.tai=src.tai*2;A.nin=src.nin*2;A.gen=src.gen*2;A.health=300000;A.StunChance=1
				src.ChakraDrain(1500)
		else
			src<<"Suna Tate must be out!";return
	SunaShuriken(Uses)
		if(usr.Stun>=1|usr.DoingHandseals|src.Kaiten|usr.resting|usr.meditating|usr.sphere|usr.ingat|usr.firing)
			return
		else
			src.ChakraDrain(3000)
			src<<"Holding down Z will cause Sand Shuriken to be shot from your Sand Monster instead of you."
			if(Uses>=500)
				var/obj/Jutsu/Sand/Sshuriken/K=new();K.icon_state="Shuriken2";K.name="[src]";K.dir=src.dir;K.Owner=src;sleep(1)
				var/obj/Jutsu/Sand/Sshuriken/G=new();G.icon_state="Shuriken2";G.name="[src]";G.dir=src.dir;G.Owner=src;sleep(1)
				var/obj/Jutsu/Sand/Sshuriken/B=new();B.icon_state="Shuriken2";B.name="[src]";B.dir=src.dir;B.Owner=src
				if(src.HasGoldSand)
					K.icon='Icons/Jutsus/GoldSuna.dmi';G.icon='Icons/Jutsus/GoldSuna.dmi';B.icon='Icons/Jutsus/GoldSuna.dmi'
				if(src.Charging&&src.SandMonsters.len>0)
					src.ChakraDrain(3000)
					for(var/mob/Sand/SunaNoTate/A in src.SandMonsters)
						G.loc=A.loc;K.loc=A.loc;B.loc=A.loc;walk(K,A.dir);walk(G,A.dir);walk(B,A.dir)
				else
					G.loc=src.loc;K.loc=src.loc;B.loc=src.loc;walk(K,src.dir);walk(G,src.dir);walk(B,src.dir)
			else
				var/obj/Jutsu/Sand/Sshuriken/K=new();K.name="[src]";K.dir=src.dir;K.Owner=src
				var/obj/Jutsu/Sand/Sshuriken/G=new();G.name="[src]";G.dir=src.dir;G.Owner=src
				var/obj/Jutsu/Sand/Sshuriken/B=new();B.name="[src]";B.dir=src.dir;B.Owner=src
				if(src.HasGoldSand)
					K.icon='Icons/Jutsus/GoldSuna.dmi';G.icon='Icons/Jutsus/GoldSuna.dmi';B.icon='Icons/Jutsus/GoldSuna.dmi'
				G.loc=src.loc;K.loc=get_step(src,turn(src.dir,90));B.loc=get_step(src,turn(src.dir,-90));walk(K,src.dir);walk(G,src.dir);walk(B,src.dir)
	SunaWhip()
		if(usr.Stun>=1|usr.DoingHandseals|src.Kaiten|usr.resting|usr.meditating|usr.sphere|usr.ingat|usr.firing)
			return
		else
			src.ChakraDrain(15000)
			var/obj/Jutsu/Sand/SandWhip/K=new()
			if(src.HasGoldSand)
				K.icon='Icons/Jutsus/GoldSuna.dmi'
			K.name="[src]";K.dir=src.dir;K.Owner=src;sleep(1)
			K.loc=src.loc;walk(K,src.dir)
	Sunasoujuu()
		if(!src.SunaMode)
			var/turf/T = get_step(src,src.dir)
			var/mob/Sand/Suna/P=new();
			if(src.HasGoldSand);
				P.icon='Icons/Jutsus/GoldSuna2.dmi'
			else
				P.icon='Icons/Jutsus/Suna2.dmi';
			P.loc=T;P.Owner=src;P.dir=src.dir;P.nin=src.nin;src.SunaMode=1
			//if(src.Shukaku) P.icon='Icons/Jutsus/Suna3.dmi'
	SandSphere(Uses)
		if(Uses>=2500)
			src.AutoSphere=1
		if(src.firing|src.resting)
			return
//		src.SandCheck(30)
		if(!src.sphere)
			src.FrozenBind="Jutsu";src.firing=0
			var/obj/Jutsu/Sand/Sphere/A=new()
			if(src.HasGoldSand)
				A.icon='Icons/Jutsus/GoldSuna.dmi'
			A.loc=src.loc;flick("SunaSphere2",A);A.Owner=src;src.sphere=1
			while(src.sphere)
				for(var/obj/Jutsu/Elemental/Suiton/Owater/AXAX in src.loc)
					if(src.Bijuu!="Ichibi"||src.HasGoldSand)
						viewers(src)<<"The sand becomes heavy due to the water, taking a toll on your chakra."
						src.ChakraDrain(150)
				for(var/obj/Jutsu/Kiriame/S2 in oview(1))
					viewers(src)<<"The sand turns to mush."
					src.FrozenBind="";src.firing=0;src.sphere=0
					for(var/obj/Jutsu/Sand/Sphere/ZzZ in world)
						if(ZzZ.Owner== src)
							del(ZzZ)
				for(var/turf/water/AXAX in oview(1))
					if(src.Bijuu!="Ichibi"||!src.HasGoldSand)
						viewers(src)<<"The sand becomes heavy due to the water, taking a toll on your chakra."
						src.chakra-=rand(15,40)
				var/ChakraDrain=5;src.chakra-=ChakraDrain
				if(src.chakra<ChakraDrain)
					src.FrozenBind="";src.firing=0;src.sphere=0
					for(var/obj/Jutsu/Sand/Sphere/ZzZ in world)
						if(ZzZ.Owner== src)
							del(ZzZ)
					src.usingS=0;return
				else
					sleep(4)
	SandAttack()
		set background = 1
		if(src.usingS==0)
			src.ChakraDrain(350)
			src.usingS=1
			var/obj/Jutsu/Sand/Spikes/North/N=new();N.Owner=src;N.loc=locate(src.x,src.y+1,src.z);var/obj/Jutsu/Sand/Spikes/South/S=new();S.Owner=src;S.loc=locate(src.x,src.y-1,src.z)
			var/obj/Jutsu/Sand/Spikes/West/W=new();W.Owner=src;W.loc=locate(src.x-1,src.y,src.z);var/obj/Jutsu/Sand/Spikes/East/E=new();E.Owner=src;E.loc=locate(src.x+1,src.y,src.z)
			if(src.HasGoldSand)
				N.icon='Icons/Jutsus/GoldSuna.dmi';S.icon='Icons/Jutsus/GoldSuna.dmi';E.icon='Icons/Jutsus/GoldSuna.dmi';W.icon='Icons/Jutsus/GoldSuna.dmi'
		else
			spawn()
				for(var/obj/Jutsu/Sand/Spikes/N in world)
					if(N.Owner==src)
						del(N)
			sleep(11);src.usingS=0
	SabakuKyuu()
		var/mob/M=src.target
		src<<"Holding down Z will cause your Sand Monster to Kyuu them instead of you."
		if(src.firing||src.FrozenBind=="Shibari")
			return
		if(src.target!=null)
			if(M.FrozenBind=="Sand")
				src<<"They're already caught!";return
		src.ChakraDrain(19500);src.icon_state="handseal";var/obj/Jutsu/Sand/kyuu/K=new()
		if(src.HasGoldSand)
			K.icon='Icons/Jutsus/GoldSuna.dmi'
		if(src.Charging)
			for(var/mob/Sand/SunaNoTate/A in src.SandMonsters)
				K.loc=A.loc;walk_towards(K,M,2);K.Owner=usr
		else
			K.loc=src.loc;walk_towards(K,M,2);K.Owner=usr
//		spawn(100)
//			if(src.Frozen==1)
//				src.Frozen=0

	SabakuSousou()
		if(src.FrozenBind=="Shibari")
			return
		src.ChakraDrain(35500);src.icon_state=""
		for(var/obj/Jutsu/Sand/kyuu/L in world)
			if(L.Owner==src)
				L.Sousou()
	SandArm()
		if(src.firing||src.Kaiten == 1)
			return
		else
			src.ChakraDrain(16500)
			spawn(70)
				src.firing=0;src.Frozen=0
			flick("Attack1",src);var/obj/Jutsu/Sand/SandArm2/K=new()
			if(src.HasGoldSand)
				K.icon='Icons/Jutsus/GoldSuna3.dmi'
			K.loc=get_step(src,src.dir);K.Move_Delay=1;K.dir=src.dir;K.name="[src]";K.Owner=src;walk(K,src.dir)
	Bakuryu_Ryusa(Uses)
		src.Handseals(40-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/Distance=2
		var/X=src.x
		var/Y=src.y
		var/Z=src.z
		var/G=1
		var/H=0
		var/HC=0
		if(Uses>100) Distance++
		if(Uses>250) Distance++
		if(Uses>550) Distance+=2
		var/GG=20*Distance
		if(Uses>550&&src.HoldingR)
			src.ChakraDrain(66000);sleep(1);src.icon_state="handseal"
			if(src.dir==NORTH)
				while(G<=GG)
					while(H<=HC)
						var/obj/Jutsu/Sand/SandWave/A=new()
						if(src.HasGoldSand)
							A.icon='Icons/Jutsus/GoldSuna.dmi'
						A.loc=locate(X+H,Y+G,Z);A.Owner=src;A.dir=src.dir;
						H++
					sleep(1)
					if(G>5)
						H=0
						HC+=1
						H=HC*(-1)
					else if(G==5)
						H=-3
						HC=3
					else if(G<3)
						H=0
						H-=G
						HC+=1
					else
						H=-2
						HC=2
					G++
			if(src.dir==SOUTH)
				while(G<=GG)
					while(H<=HC)
						var/obj/Jutsu/Sand/SandWave/A=new()
						if(src.HasGoldSand)
							A.icon='Icons/Jutsus/GoldSuna.dmi'
						A.loc=locate(X+H,Y+G,Z);A.Owner=src;A.dir=src.dir;
						H++
					sleep(1)
					if(G>5)
						H=0
						HC+=1
						H=HC*(-1)
					else if(G==5)
						H=-3
						HC=3
					else if(G<3)
						H=0
						H-=G
						HC+=1
					else
						H=-2
						HC=2
					G++
			if(src.dir==WEST)
				while(G<=GG)
					while(H<=HC)
						var/obj/Jutsu/Sand/SandWave/A=new()
						if(src.HasGoldSand)
							A.icon='Icons/Jutsus/GoldSuna.dmi'
						A.loc=locate(X+H,Y+G,Z);A.Owner=src;A.dir=src.dir;
						H++
					sleep(1)
					if(G>5)
						H=0
						HC+=1
						H=HC*(-1)
					else if(G==5)
						H=-3
						HC=3
					else if(G<3)
						H=0
						H-=G
						HC+=1
					else
						H=-2
						HC=2
					G++
			if(src.dir==EAST)
				while(G<=GG)
					while(H<=HC)
						var/obj/Jutsu/Sand/SandWave/A=new()
						if(src.HasGoldSand)
							A.icon='Icons/Jutsus/GoldSuna.dmi'
						A.loc=locate(X+H,Y+G,Z);A.Owner=src;A.dir=src.dir;
						H++
					sleep(1)
					if(G>5)
						H=0
						HC+=1
						H=HC*(-1)
					else if(G==5)
						H=-3
						HC=3
					else if(G<3)
						H=0
						H-=G
						HC+=1
					else
						H=-2
						HC=2
					G++
			src.firing=1
			spawn(20)
				src.icon_state=""
				src.firing=0
			spawn(250)
				for(var/obj/Jutsu/Sand/SandWave/S2 in src.JutsuList)
					del(S2)

		SandCheck(GG)
		src.ChakraDrain(33000);sleep(1);src.icon_state="handseal"
		for(var/turf/T in range(Distance,src))
			if(src.dir==NORTH||src.dir==SOUTH)
				if(T.y==src.y)
					var/obj/Jutsu/Sand/SandWave/A=new();
					if(src.HasGoldSand)
						A.icon='Icons/Jutsus/GoldSuna.dmi'
					A.name="[src]";A.Owner=src;A.JutsuLevel=1;A.loc=T;A.dir=src.dir;walk(A,src.dir)
					src.JutsuList.Add(A)
			if(src.dir==WEST||src.dir==EAST)
				if(T.x==src.x)
					var/obj/Jutsu/Sand/SandWave/A=new()
					if(src.HasGoldSand)
						A.icon='Icons/Jutsus/GoldSuna.dmi'
					A.name="[src]";A.Owner=src;A.JutsuLevel=1;A.loc=T;A.dir=src.dir;walk(A,src.dir)
					src.JutsuList.Add(A)

		src.firing=1
		spawn(20)
			src.icon_state=""
			src.firing=0
		spawn(250)
			for(var/obj/Jutsu/Sand/SandWave/S2 in src.JutsuList)
				del(S2)
	Sabaku_Taisou()
		if(src.firing||src.knockedout)
			return
		src.ChakraDrain(250)
		src.Handseals(30-src.HandsealSpeed)
		if(src.HandsSlipped) return
		sleep(2);src.icon_state=""
		for(var/obj/Jutsu/Sand/SandTurf/S in src.JutsuList)
			spawn()
				for(var/mob/M in S.loc)
					spawn()
						if(M.ImmuneToDeath)
							del(src)
						if(M!=src)
							var/damage=rand(src.nin*1500,src.nin*2500);damage=damage/(M.Endurance/5);M.DamageProc(damage,"Health",src)
							M.Bloody();M.Bloody();M.Bloody();M.Bloody()
							if(M.FrozenBind=="Sand Waterfall")
								M.FrozenBind=""
			S.icon_state="shock"
			spawn(9)
				if(S)
					S.icon_state="sand"
		sleep(50)
		src.firing=0
		for(var/obj/Jutsu/Sand/SandTurf/S in src.JutsuList)
			del(S)
	Sabaku_SandField()
		src.F=new;
		src.Handseals(40-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src.ChakraDrain(10000);
		sleep(1);
		src.icon_state="handseal"
		var/X=0
		var/obj/Jutsu/Sand/SandField/C=new();
		C.Owner=src;
		C.loc=src.loc;
		C.layer = MOB_LAYER-1;
		src.F.Add(C);
		C.Shukaku=src.Shukaku;
		while(X<8&&src.icon_state=="handseal")
			for(var/turf/D in oview(X,src))
				if(!(D in oview(X-1)))
					var/obj/Jutsu/Sand/SandField/B=new()
					if(src.HasGoldSand)
						B.icon='Icons/Jutsus/GoldSuna.dmi'
					B.Owner=src;B.loc=D;B.Shukaku=src.Shukaku;
					src.F.Add(B)
			X++
			sleep(2)
		if(src.icon_state=="handseal")
			src.icon_state="running"
	Sabaku_SandFieldBurial()
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src.ChakraDrain(50000);sleep(1);src.icon_state="handseal"
		src.firing=1;
		for(var/obj/Jutsu/Sand/SandField/B in src.F)
			spawn()
				for(var/mob/M in B.loc)
					var/Distance=get_dist(usr,M)
					spawn()
						if(M!=src)
							var/damage=rand((src.nin*1500/Distance),(src.nin*3000/Distance));damage=damage/M.Endurance;M.DamageProc(damage,"Health",src) //Was Originally var/damage=rand(src.nin*1500,src.nin*2500)
							M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();
			B.icon_state="shock"
			spawn(9)
				if(B)
					B.icon_state="sand"
		sleep(50)
		src.firing=0
		var/T=0;
		for(var/obj/Jutsu/Sand/SandField/C in src.F)
			del(C)
			T++;
			if(T>=5)
				T=0;
				sleep(2)
		spawn()
			src.F=new
		src.firing=0;
	Erosion()
		src.Handseals(30-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src.ChakraDrain(10000);sleep(1);src.icon_state="beastman"
		src.Frozen=1;
		src.firing=1;
		src.SandAmountPassiveCheck()
		for(var/obj/Jutsu/Elemental/Doton/B in view(10,src))
			if(B.Owner==src)
				spawn()
					var/obj/Jutsu/Sand/SandTurf/S;S.Owner=src;S.loc=B.loc
					del(B)
					src.SandAmount+=10
					if(src.SandAmount>src.MaxSandAmount)
						src.SandAmount=src.MaxSandAmount
		src.icon_state=""
		src.Frozen=0;
		src.firing=0;
/////////////////////////////////////////////
//Iron Sand
////////////////////////////////////////
	DesertSuspension()
		if(src.Status=="Asleep"||src.Guarding||src.doingG||src.resting||src.firing&&!src.Mogu||src.AttackDelay||src.meditating)
			return
		if(src.FrozenBind!="")
			if(src.FrozenBind!="Spider Web") return
		src.chakra-=2000;src<<"You begin to generate your Iron Sand below your feet."
		src.icon_state="beastman";src.Frozen=1
		sleep(25)
		if(!src.knockedout)
			var/mob/Sand/CarrierSand/A=new();A.Running=1;A.Owner=src;A.layer=src.layer+1;A.loc=src.loc;src.Suspension=1
			src.controlled=A;src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;src.client.eye=A;src.Frozen=0
			Create_Shadow(src)
			Flight(src)
			while(A)
				src.icon_state=""
				src.layer=A.layer-1;src.Suspension=1
				A.pixel_x=src.pixel_x;A.pixel_y=src.pixel_y;A.pixel_z=src.pixel_z
				Shadow_Chase(src)
				if(src.icon_state=="Power")
					del(A);
				sleep(1)
			src.client.perspective=MOB_PERSPECTIVE;src.client.eye=src;src.controlled=null;src.layer=MOB_LAYER
			src.Suspension=0
	IronNeedles()
		if(usr.Stun>=1|usr.DoingHandseals|src.Kaiten|usr.resting|usr.meditating|usr.sphere|usr.ingat|usr.firing)
			return
		else
			src.ChakraDrain(6000)

			var/obj/Jutsu/Sand/IronNeedles/K=new();K.name="[src]";K.dir=src.dir;K.Owner=src
			var/obj/Jutsu/Sand/IronNeedles/G=new();G.name="[src]";G.dir=src.dir;G.Owner=src
			var/obj/Jutsu/Sand/IronNeedles/B=new();B.name="[src]";B.dir=src.dir;B.Owner=src
			G.loc=src.loc;K.loc=get_step(src,turn(src.dir,90));B.loc=get_step(src,turn(src.dir,-90));walk(K,src.dir);walk(G,src.dir);walk(B,src.dir)


	IronSandWeaponry()
		usr.Target()
		if(usr.ntarget)
			usr<<"You need a Target!"
			return
		else
			var/mob/M=src.target
			src.ChakraDrain(50000)
			src.Handseals(35-src.HandsealSpeed)
			if(src.HandsSlipped) return
			src.icon_state="handseal"
			var/CurrentLoc = src.loc
			var/radius = 3
			for(var/turf/T in getring(M, radius))
				spawn()
					var/obj/Jutsu/Sand/IronWeapons/K=new();K.loc=T;K.Owner=src;sleep(8)
					while(CurrentLoc==src.loc && src.icon_state=="handseal" && get_dist(K,CurrentLoc) > 1)
						walk_towards(K,M)	//Rapidly move towards the center
						sleep(2)
					src.icon_state=""


	IronArmor()
		if(src.sphere||src.Kaiten||src.firing||src.knockedout)
			return
		if(src.RaiArmor&&src.RaiArmor!=2)
			src.overlays-='Icons/Jutsus/RaiArmor.dmi';src.tempmix='Icons/Jutsus/ChakraAura.dmi';src.tempmix+=rgb(224,197,2);var/icon/Q=icon(src.tempmix);src.overlays-=Q;src.RaiArmor=0;src.Touei=0
		src.overlays+='Icons/Jutsus/IronArmor.dmi'
		src.IronArmor=1
		view()<<"[src] surrounds their body in their Iron Sand."
		src.Endurance+=400
		while(src.IronArmor)
			src.ChakraDrain(9000)
			sleep(15)
			if(src.knockedout)
				src.IronArmor=0
				src.overlays-='Icons/Jutsus/IronArmor.dmi'
		src.IronArmor=0
		src.Endurance=src.MEndurance
		src.overlays-='Icons/Jutsus/IronArmor.dmi'
		src<<"Your Iron Sand falls to your feet."

	IronSandfallWave()
		if(src.sphere||src.Kaiten||src.firing||src.knockedout)
			return
		src.ChakraDrain(40000)
		src.Handseals(35-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src.icon_state="beastman"
		sleep(12)
		var/obj/Jutsu/Sand/IronSandWave/IronL/K=new();K.name="[src]"
		var/obj/Jutsu/Sand/IronSandWave/IronM/G=new();G.name="[src]"
		var/obj/Jutsu/Sand/IronSandWave/IronR/B=new();B.name="[src]"
		if(src.dir==SOUTH)
			K.Owner=src;K.loc=locate(src.x-1,src.y-1,src.z);K.dir=src.dir;walk(K,src.dir);G.Owner=src;G.loc=locate(src.x,src.y-1,src.z);B.dir=src.dir;walk(G,src.dir);B.Owner=src;B.loc=locate(src.x+1,src.y-1,src.z);B.dir=src.dir;walk(B,src.dir)
		if(src.dir==NORTH)
			K.Owner=src;K.loc=locate(src.x-1,src.y+1,usr.z);K.dir=src.dir;walk(K,src.dir);G.Owner=src;G.loc = locate(src.x,src.y+1,src.z);G.dir=src.dir;walk(G,src.dir);B.Owner=src;B.loc=locate(src.x+1,src.y+1,src.z);B.dir=src.dir;walk(B,src.dir)
		if(src.dir==EAST)
			K.Owner=src;K.loc=locate(src.x+1,src.y+1,src.z);K.dir=src.dir;walk(K,src.dir);G.Owner=src;G.loc=locate(src.x+1,src.y,src.z);G.dir=src.dir;walk(G,src.dir);B.Owner=src;B.loc=locate(src.x+1,src.y-1,src.z);B.dir=src.dir;walk(B,src.dir)
		if(src.dir==WEST)
			K.Owner=src;K.loc=locate(src.x-1,src.y+1,src.z);K.dir=src.dir;walk(K,src.dir);G.Owner=src;G.loc=locate(src.x-1,src.y,src.z);G.dir=src.dir;walk(G,src.dir);B.Owner=src;B.loc=locate(src.x-1,src.y-1,src.z);B.dir=src.dir;walk(B,src.dir)
		src.Stun=999;
		src.firing=1
		spawn(50)
			src.Stun=0;
			src.firing=0;
			src.icon_state=""

	SandFist()
		src.ChakraDrain(18000)
		if(src.sphere||src.Kaiten||src.firing)
			return
		src.overlays+='Icons/Jutsus/IronSandFists.dmi'
		src.SandFist=1
		view()<<"[src] gathers their Iron Sand around their forearms."
		while(src.SandFist)
			src.chakra-=rand(10,60)
			sleep(10)
			src.RightHandSheath=0;src.LeftHandSheath=0
			if(src.chakra<=0)
				src.chakra=0;src.SandFist=0;src.overlays-='Icons/Jutsus/IronSandFists.dmi'
				src<<"Your lack of Chakra to hold up the Iron Sand causes it to fall at your feet.";return
			if(src.knockedout)
				src<<"As you fall unconcious your Iron Sand does as well.";src.overlays-='Icons/Jutsus/IronSandFists.dmi';src.SandFist=0;return
		src.SandFist=0
		src.overlays-='Icons/Jutsus/IronSandFists.dmi'
		src<<"Your Iron Sand dissipates.";return


	IronSandCreation()
		if(src.sphere||src.Kaiten||src.firing||src.knockedout)
			return
		src.ChakraDrain(50000)
		src.Handseals(5-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/obj/Jutsu/Sand/IronSandCreation/A=new();
		var/Z=rand(1,3)
		flick("[Z]Form",A);A.icon_state="[Z]"
		A.dir=src.dir;A.loc=src.loc;step(A,A.dir);A.Owner=src
		src.icon_state="throw";src.Frozen=1;src.firing=1
		spawn(7)
			src.icon_state="";src.Frozen=0;src.firing=0
//////////////////
atom
	var/obj/Shadow
proc
	Shadow_Chase(atom/movable/a)//Made to clean up the code a bit
		if(a.Shadow)
			a.Shadow.loc=a.loc
		/*	a.Shadow.step_x=a.step_x
			a.Shadow.step_y=a.step_y*/
			a.Shadow.dir=a.dir
			a.Shadow.icon_state=a.icon_state
		a.Shadow.invisibility=a.invisibility
	Create_Shadow(atom/movable/a,Pixel=0)
		if(a.Shadow)
			Shadow_Chase(a)
		else
			var/obj/Shadow/s=new
			a.Shadow=s
			s.pixel_z=-8
			s.icon=a.icon
			var/matrix/M=matrix()
			M.Scale(1,0.5)
			animate(s,transform=M)
			s.icon-=rgb(1000,1000,1000,200)
			//s.icon:Scale(s.icon:Width(),s.icon:Height()/2)
			a.Shadow.loc=a.loc

			a.Shadow.pixel_x=a.pixel_x
			a.Shadow.pixel_y=a.pixel_y

			a.Shadow.step_x=a.step_x
			a.Shadow.step_y=a.step_y
			a.Shadow.dir=a.dir
			a.Shadow.icon_state=a.icon_state
			s.invisibility=a.invisibility
obj/Shadow

proc
	RemoveShadow(mob/m)
		if(m.Shadow)
			del m.Shadow
	Flight(mob/m) //Handles Shadow Transformations and player flight 'bobbing'
		sleep(1)
		if(m.Suspension||m.OnBird)
			animate(m,pixel_z=30,time=5)
			var/matrix/State1=matrix()
			State1.Scale(0.85,0.425)
			animate(m.Shadow,alpha=190,transform=State1,time=5)
			spawn(5)
				var/matrix/State2=matrix()
				State2.Scale(0.95,0.475)
				animate(m,pixel_z=25,time=5)
				animate(m.Shadow,alpha=216,transform=State2,time=5)
				spawn(5)
					Flight(m)
		else
			animate(m,pixel_z=0,time=5)
			var/matrix/LandingState=matrix()
			LandingState.Scale(1,0.5)
			animate(m.Shadow,alpha=255,transform=LandingState,time=5)
			spawn(5)
				RemoveShadow(m)
