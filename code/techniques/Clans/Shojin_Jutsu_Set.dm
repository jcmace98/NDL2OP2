mob/var/tmp
	CrystalBindedBy=""
	cwheel=0
	UsingCDome=0
	CMirror=0
	CArmorOn=0
	Labyrinth=0

obj/Jutsu/Elemental/Shoton
	icon = 'Icons/Jutsus/Crystal Techniques.dmi'
	Element="Shoton"
	health=250

	Cwall
		icon_state="Cwall"
		density=1
		opacity=1
		layer=MOB_LAYER+1
		New()
			.=..()
			spawn()
				flick("CwallF",src);sleep(1)
			spawn(500)
				del(src)
	CrsytalCrimsonFruit
		icon_state=""
		layer=MOB_LAYER+1
		density=1
		var/StruggleOutBind=60
		New()
			..()
			spawn()
				flick("CrystalBind",src)
				while(src)
					sleep(5)
					if(src.icon_state=="CrimsonFruit")
						for(var/mob/M in src.loc)
							var/mob/O=src.Owner
							if(M==O||M.Mogu)
								return
							if(M.ImmuneToDeath)
								del(src)
							if(M.SusanooIn)
								M<<"Your Susanoo causes the Crystals to shatter around you."
								del(src)
							if(M.sphere|M.intsu|M.cwheel|M.ingat|M.Kaiten|M.knockedout|M.intank)
								del(src)
							if(M.FrozenBind=="")
								M<<"You've been binded by crystals! Tap Spacebar to break out!";M.FrozenBind="CBind";M.CrystalBindedBy="[O]"
							if(M.InHydro)
								M<< "You slip out of the Crystals!"
								M.FrozenBind="";M.CrystalBindedBy=""
								return
							sleep(11)
							M.loc=src.loc
							if(M.Struggle>src.StruggleOutBind)
								M<<"You've forcefully break the crystals surrounding you!"
								M.FrozenBind=""
								M.CrystalBindedBy=""
								del(src)
					sleep(11)
			spawn(300)
				del(src)
		Del()
			for(var/mob/M in world)
				var/mob/O=src.Owner
				if(M.CrystalBindedBy=="[O]")
					M<<"You've been freed!";M.FrozenBind="";M.CrystalBindedBy=""
			sleep(2)
			..()
	CrystalBarrier
		icon = 'Icons/Jutsus/Cdome.dmi'
		density=1
		layer=MOB_LAYER+1
		New()
			spawn()
				while(src)
					sleep(45)
					for(var/obj/Jutsu/Elemental/Suiton/A in oview(1))
						if(A.JutsuLevel>(src.JutsuLevel*3))
							BaseChance=25
						else if(A.JutsuLevel>(src.JutsuLevel*2))
							BaseChance=55
						else if(A.JutsuLevel>src.JutsuLevel)
							BaseChance=65
						if(prob(BaseChance))
							del(A)

		Del()
			src.CreateSmoke("Medium")
			for(var/mob/M in src.loc)
				M.sight &= ~BLIND
			..()
		A
			icon_state="1"
		B
			icon_state="2"
		C
			icon_state="3"
		D
			icon_state="4"
		E
			icon_state="5"
		F
			icon_state="6"
		G
			icon_state="7"
		H
			icon_state="8"
		I
			icon_state="9"
			..()
	CrystalNeedles
		icon_state = "Cneedles"
		density = 1
		JutsuLevel=1
		layer=MOB_LAYER+1
		var/nin=10
		var/InitialDisplacement="None"
		New()
			src.pixel_x+=rand(8,16)
			src.pixel_y+=rand(2,6)
			..()
			spawn()
				while(src)
					sleep(8)
					for(var/obj/Doors/D in oview(1,src))
						D.DamageProc(src.nin/10,"Health")
						sleep(1)


			spawn(50)
				del(src)
		Bump(A)
			..()
			if(istype(A,/mob/Kibaku/))
				var/mob/Kibaku/M=A;M.Defused=1
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				var/damage=src.nin-20//Was - 2
				damage=round((damage)*((O.CrystalChakra*0.02)+0.4));var/Chakraz=M.ChakraArmor*0.01;damage=damage-(Chakraz*damage)
				if(damage<10) damage=10
				if(damage>50) damage=50
				M.DamageProc(damage,"Health",O,"Crystal needles","cyan")
				spawn() M.Bloody()
				M.SoundEngine('SFX/Slice.wav',10)

				M.StunAdd(round((damage/100)*2))
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				var/obj/ZZ=A
				if(istype(A,/obj/Doors/))
					var/obj/O=A
					O.DamageProc(src.nin/2)
					del(src)
				if(istype(ZZ,/obj/Jutsu/Elemental/Doton/))
					var/obj/Jutsu/Elemental/Doton/ZAC=ZZ
					if((ZAC.JutsuLevel/2)>=src.JutsuLevel)
						del(src)
					else
						del(ZAC)
	CrystalShuriken
		icon_state = "Cshuriken"
		density = 1
		JutsuLevel=1
		layer=MOB_LAYER+1
		var/nin=10
		var/InitialDisplacement="None"
		New()
			src.pixel_x+=rand(10,18)
			src.pixel_y+=rand(2,6)
			..()
			spawn()
				while(src)
					sleep(8)
					for(var/obj/Doors/D in oview(1,src))
						D.DamageProc(src.nin/10,"Health")
						sleep(1)


			spawn(50)
				del(src)
		Bump(A)
			..()
			if(istype(A,/mob/Kibaku/))
				var/mob/Kibaku/M=A;M.Defused=1
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				var/damage=src.nin-20//Was - 2
				damage=round((damage)*((O.CrystalChakra*0.04)+0.3));var/Chakraz=M.ChakraArmor*0.01;damage=damage-(Chakraz*damage)
				if(damage<25) damage=25
				if(damage>75) damage=75
				M.DamageProc(damage,"Health",O,"Crystal shuriken","cyan")
				spawn() M.Bloody()
				M.SoundEngine('SFX/Slice.wav',10)
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				var/obj/ZZ=A
				if(istype(A,/obj/Doors/))
					var/obj/O=A
					O.DamageProc(src.nin/2)
					del(src)
				if(istype(ZZ,/obj/Jutsu/Elemental/Doton/))
					var/obj/Jutsu/Elemental/Doton/ZAC=ZZ
					if((ZAC.JutsuLevel/2)>=src.JutsuLevel)
						del(src)
					else
						del(ZAC)
	SpikeUnderground
		icon_state="SpikeUnderground"
		layer = TURF_LAYER
		density=0
		health=500
		mouse_opacity = 0
		New()
			..()
			spawn(450)
				del(src)
	CSawarabi
		icon_state="Spike8"
		layer = MOB_LAYER+1
		density=1
		health=2000
		New()
			..()
			spawn()
				var/mob/O=src.Owner
				for(var/mob/M in src.loc)
					if(M==O)
						return
					var/damage=M.maxhealth*0.18
					damage=round(damage*(usr.CrystalChakra*0.08))
					view()<<"[M] has taken [damage] damage from [O]'s Crystal Thorns!"
					M.SoundEngine('SFX/Slice.wav',3);M.DamageProc(damage,"Health",O)
					spawn()
						M.Bloody();M.Bloody();M.Bloody()
			spawn(450)
				del(src)
	HashoKoryu
		icon_state = "CdragonHead"
		density = 1
		layer = MOB_LAYER+1
		Move_Delay=0
		var
			nin=10
			prestep=0
			laststep=0
		New()
			..()
			spawn(180)
				del(src)
		Move()
			src.prestep = src.loc
			..()
			var/obj/Jutsu/Elemental/Shoton/HashoKoryuTrail/L=new();L.loc = src.prestep;L.dir = src.dir;L.Owner = src.Owner
			..()
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				if(M.Kaiten||M.sphere)
					del(src)
					return
				if(M.RaiArmor)
					del(src)
					return
				if(M.InHydro)
					del(src)
					return
				var/damage=round(src.nin*(100))
				var/mob/O=src.Owner
				damage=round((damage)*((O.CrystalChakra*0.2)+0.7));damage=damage/(M.Endurance)
			//	var/AddOn=(O.ShotonMastery*0.150)*damage
			//	damage+=AddOn
				if(damage>600)
					damage=600
				M.DamageProc(damage,"Health",O,"Crystal Dragon","cyan")

				for(var/obj/Jutsu/Elemental/Shoton/HashoKoryuTrail/S in world)
					if(S.Owner == src.Owner)
						del(S)
				del(src)
			if(istype(A,/obj/Jutsu/Elemental/Suiton/SuiryedanTrail/))
				var/obj/Jutsu/Elemental/Suiton/SuiryedanTrail/B = A
				src.loc=B.loc
			if(istype(A,/turf/))
				del(src)
			if(istype(A,/obj/))
				if(istype(A,/obj/Doors/))
					var/obj/O=A
					O.DamageProc(src.nin)
					del(src)
				del(src)
		Del()
			var/mob/O=src.Owner
			O.TatsumakiOn=0;O.firing=0
			O.client.perspective=MOB_PERSPECTIVE;O.client.eye=O;O.controlled=null
			for(var/obj/Jutsu/Elemental/Shoton/HashoKoryuTrail/A in world)
				if(A.Owner==src.Owner)
					del(A)
			if(O.Shibari)
				for(var/obj/Nara/Shibari/K in world)
					if(K.Owner==O)
						O.controlled=K
						O.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
						O.client.eye=K
			..()
	HashoKoryuTrail
		icon_state = "Cdragon Trail"
		Element="Shoton"
		density=1
		layer = MOB_LAYER+1
		New()
			..()

			spawn()
				while(src)
					sleep(1)


			spawn(180)
				del(src)
		Del()
			..()

	GiantHexagonalShuriken
		icon_state="Giant Hexigon Shuriken"
		density = 1
		layer = MOB_LAYER+1
		var
			nin=10
			prestep=0
			laststep=0
		New()
			..()

			spawn(40)
				del(src)

		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				if(M.Kaiten||M.sphere)
					del(src)
					return
				if(M.RaiArmor)
					del(src)
					return
				var/damage=src.nin*rand(120)
				var/damage2=src.nin*rand(60,100)
				var/mob/O = src.Owner
				damage2=round((damage)*((O.CrystalChakra*4)+2))
				damage2=damage/(M.Endurance/1.5)
				if(damage2>450)
					damage2=450
				M.DamageProc(damage2,"Health",O,"Giant Crystal shuriken","cyan")
				M.Bloody()
				M.Bloody()
				M.Bloody()
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				if(istype(A,/obj/Jutsu/Paper/))
					del(A)
				if(istype(A,/obj/Jutsu/Elemental/Suiton/SuitonSuikoudan))
					del(A)
				if(istype(A,/obj/Jutsu/Elemental/Hyouton))
					var/obj/D=A
					D.DamageProc(src.nin)
					del(src)
				else
					if(istype(A,/obj/Doors/))
						var/obj/O=A
						O.DamageProc(src.nin)
						del(src)
					del(src)
		Del()
			..()
	CrystalLabyrinth
		icon = 'Icons/Jutsus/Crystal Techniques.dmi'
		icon_state="CrystalMirrors"
		density=0
		opacity = 0
		layer=MOB_LAYER+1
		New()
			..()
			spawn()
				src.density=0
				src.opacity=0
				flick("Cmirrorform",src)
				src.icon_state="CrystalMirrors"
				src.density=1
				src.opacity=1

mob/Jutsu/Elemental/Shoton
	CrystalMirror
		icon = 'Icons/Jutsus/Crystal Techniques.dmi'
		name="Crystal Mirror"
		icon_state="Crystalmirror"
		health=1000000000000000000000000000000000000000000000
		var/StunChance=0
		density=1
		Frozen=1
		MoveDelay=4
		layer=MOB_LAYER+1
		New()
			..()
			spawn()
			while(src)
				sleep(11);src.Running=0
				if(src.Stun>0)
					if(prob(90))
						src.Stun--

			spawn(10000)
				viewers(src)<<"The mirror shatters.";del(src)

////Originally planned to make it spawm clones like SunaBunshin/Clones with actual health.
	/*	Bump(A)
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M==O)
					src.loc=O.loc;return
				var/DamagePlus=rand(O.ShotonKnowledge*rand(1.1,1.5));var/damage=((src.nin+DamagePlus)/(M.Endurance/10))
				if(!src.firing)
					if(M.Kaiten)
						viewers(src)<<"The sand falls back into dust.";del(src)
					spawn()AttackEfx(M.x,M.y,M.z);view(M)<<output("[M] was hit by the sand!([damage])","Attack")
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
				return 0*/
/////////////////////////////////////////////
mob/var/tmp/list/CrystalMirrors=list()
mob/proc
	CrystalCrimsonFruit()
		src.Target()
		if(src.ntarget)
			return
		var/mob/M=src.target
		src.ChakraDrain(22000)
		if(M in oview(8))
			src.Handseals(37-src.HandsealSpeed)
			if(src.HandsSlipped) return
			var/obj/Jutsu/Elemental/Shoton/CrsytalCrimsonFruit/A=new();A.loc = locate(M.x,M.y,M.z);A.Owner=src;A.health=100;A.JutsuLevel=1
			src<<"The crystal forms around [M]!";src.icon_state="CrystalBind";sleep(5);A.icon_state = "CrimsonFruit"
			sleep(310);M.FrozenBind="";M.CrystalBindedBy=""

	CrystalEncampment()
		src.ChakraDrain(10000)
		var/number=5
		while(number>0)
			var/BonusHealth=(src.ShotonMastery*20)
			var/obj/Jutsu/Elemental/Shoton/Cwall/D=new()
			D.health=(((src.ShotonKnowledge+src.DotonKnowledge)*3)+BonusHealth)
			D.Owner=src;
			D.loc=get_step(src,src.dir)
			if(number==4)
				var/d=turn(src.dir,45);D.loc=get_step(src,d)
			if(number==3)
				var/d=turn(src.dir,-45);D.loc=get_step(src,d)
			if(number==2)
				var/d=turn(src.dir,90);D.loc=get_step(src,d)
			if(number==1)
				var/d=turn(src.dir,-90);D.loc=get_step(src,d)
			number--
		sleep(1)
		spawn(5) src.icon_state=""

	CrystalNeedles()
		if(src.firing)
			return
		else
			src.ChakraDrain(11000)
			src.Handseals(5)
			if(src.HandsSlipped) return
			flick("Attack2",src);var/I=(src.ShotonMastery*1.5)+rand(1,2)
			if(I>8)
				I=8
			while(I>0)
				var/obj/Jutsu/Elemental/Shoton/CrystalNeedles/A=new();A.Owner=src;A.JutsuLevel=src.ShotonKnowledge;A.nin=src.nin
				A.loc=src.loc
				if(prob(65))
					if(prob(50))
						var/d=turn(src.dir,45);A.loc=get_step(src,d)
					else
						var/d=turn(src.dir,-45);A.loc=get_step(src,d)
				A.dir=src.dir;A.Move_Delay=0
				A.Owner=src;walk(A,src.dir,A.Move_Delay)
				A.pixel_x=rand(-2,16);A.pixel_y=rand(1,2)
				spawn(60)
					del(A)
				I--
	CrystalShurikens()
		if(src.firing)
			return
		else
			src.ChakraDrain(12500)
			src.Handseals(10)
			if(src.HandsSlipped) return
			flick("Attack2",src);var/I=(src.ShotonMastery*1.6)+rand(1,2)
			if(I>12)
				I=12
			while(I>0)
				var/obj/Jutsu/Elemental/Shoton/CrystalShuriken/A=new();A.Owner=src;A.JutsuLevel=src.ShotonKnowledge;A.nin=src.nin
				A.loc=src.loc
				if(prob(45))
					if(prob(50))
						var/d=turn(src.dir,45);A.loc=get_step(src,d)
					else
						var/d=turn(src.dir,-45);A.loc=get_step(src,d)
				A.dir=src.dir;A.Move_Delay=0
				A.Owner=src;walk(A,src.dir,A.Move_Delay)
				A.pixel_x=rand(-6,28);A.pixel_y=rand(4,24)
				spawn(60)
					del(A)
				I--
	CrystalLance()
		src.ChakraDrain(18000)
		if(src.cwheel||src.sphere||src.Kaiten||src.firing)
			return
		src.overlays+='Icons/Jutsus/CrystalLance.dmi'
		src.CrystalSpear=1
		view()<<"[src] manipulates their chakra and forms a Crystal Spear around their arm!"
		var/Time=75
		while(src.CrystalSpear&&Time>0)
			sleep(10)
			src.RightHandSheath=0;src.LeftHandSheath=0
			if(src.chakra<=0)
				src.chakra=0;src.CrystalSpear=0;src.overlays-='Icons/Jutsus/CrystalLance.dmi'
				src<<"Your lack of Chakra turns your Arm back to normal.";return
			if(src.knockedout)
				src<<"As you fall unconcious your arm turns back to normal.";src.overlays-='Icons/Jutsus/CrystalLance.dmi';src.CrystalSpear=0;return
			Time--
		src.CrystalSpear=0
		src.overlays-='Icons/Jutsus/CrystalLance.dmi'
		src<<"Your arm goes back to normal.";return

	GiantCrystalShuriken(Uses)
		src.ChakraDrain(18000)
		src.Handseals(30-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/obj/Jutsu/Elemental/Shoton/GiantHexagonalShuriken/A=new();A.loc=src.loc;A.nin=src.nin*2.5;A.name="[src]";A.Owner=src;A.Move_Delay=0;A.JutsuLevel=src.ShotonKnowledge*4;A.dir=src.dir;
		walk(A,A.dir)

	CrystalMirror()
		usr=src
		src.ChakraDrain(1000)
		if(src.CMirror)
			src.CMirror=0
			for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/B in src.CrystalMirrors)
				del(B)
			return
		else
			src.CMirror=1
			var/mob/Jutsu/Elemental/Shoton/CrystalMirror/A=new();A.loc=src.loc;A.nin=src.nin;A.Owner=src;A.MoveDelay=5
			src.CrystalMirrors.Add(A)
			while(A)
				if(prob(1))
					src.ShotonMastery+=pick(0.01,0.1);if(src.ShotonMastery>10) src.ShotonMastery=10
				var/ChakraLoss=60-(src.ShotonMastery/3);src.ChakraDrain(ChakraLoss*1.3)
				sleep(11)
			src.CMirror=0
	CLabyrinth()
		src.Handseals(35-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/X=10
		if(src.ShotonKnowledge>75)
			if(prob(25))
				X=9
			else
				X=8
		if(src.ShotonKnowledge>99)
			if(src.Charging)
				X=9
			else
				X=9
		if(src.ShotonKnowledge>99)
			if(src.Charging)
				X=10
			else
				X=7
		src.icon_state="handseal"
		spawn(8)
			src.icon_state=""
		var/obj/Center=new /obj/
		Center.loc=src.loc;Center.density=0
		for(var/turf/T in oview(X,src))
			if(!(T in oview(X-1)))
				var/obj/Jutsu/Elemental/Shoton/CrystalLabyrinth/A=new();A.health=2000+(src.ShotonKnowledge*10);A.loc=locate(T.x,T.y,T.z);A.Owner=src;
				src.JutsuList+=A
		src.Labyrinth=1;
		while(src.Labyrinth&&!src.knockedout&&distance(src,Center)<20)
			var/ChakraLoss=(3000**(((distance(src,Center))/7)))
			if(ChakraLoss>3500) ChakraLoss=3500
			if(src.chakra>=0)
				src.ChakraDrain(ChakraLoss)
			else
				for(var/obj/Jutsu/Elemental/Shoton/CrystalLabyrinth/S in src.JutsuList)
					del(S)
				src.Labyrinth=0
			sleep(11)
		src.Labyrinth=0
		for(var/obj/Jutsu/Elemental/Shoton/CrystalLabyrinth/O in src.JutsuList)
			del(O)
	ShotonNoBunshin()
		src.Handseals(25-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/GoodToGo=0
		var/list/BAD = list("locs","KagDance","cansave","icon_state","RasenganD","ChidoriD","Rasenganon","Chidorion","WeaponInRightHand","WeaponInLeftHand","LeftHandSheath","RightHandSheath","GateIn","InDeathGate","key","ckey","client","type","parent_type","verbs","vars","group","x","y","z","loc","contents","alterV","alterC","alterR","OriginalVillage","Orank","OClan","ImmuneToDeath","Owner","CopyMode","ChargedChakraForPunch")
		for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/A in world)
			if(A.Owner==src)
				GoodToGo=1
		if(GoodToGo)
			for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/A in src.CrystalMirrors)
				var/mob/Clones/Clone/K=new();K.loc=A;K.Owner=src;K.CloneType="ShotonBunshin"
				src.ChakraDrain(15000)
				for(var/V in src.vars)
					if(!BAD.Find(V))
						K.vars[V] = src.vars[V]
				if(K)
					K.MoveDelay=2;K.health=1000;K.stamina=4000;K.icon='Icons/New Base/Base.dmi';K.icon+=rgb(238,135,238)
					K.overlays+=usr.overlays;K.name="[usr.name]";K.tai=K.tai/70;K.nin=K.nin/70;K.gen=K.gen/70
					K.Clone=1;K.Running=1;K.CloneType="ShotonBunshin";K.icon_state="running"
			//	A.icon='Icons/New Base/Base.dmi';A.overlays+=src.overlays;A.icon+=rgb(238,135,238)
			//	A.tai=src.tai*2;A.nin=src.nin*2;A.gen=src.gen*2;A.health=3000;A.Frozen=0;A.StunChance=1

		else
			src<<"A Crystal Mirror must be out!";return
	Crystalwheel()
		if(usr.cwheel||usr.Kaiten||usr.firing)
			return
		else
			if(src.target)
				src.dir=get_dir(src,src.target)
			usr.cwheel=1
			usr.ChakraDrain(12000)
			usr.overlays-='Icons/Jutsus/CrystalWheel.dmi'
			usr.overlays+='Icons/Jutsus/CrystalWheel.dmi'
			usr.firing=1
			sleep(150)
			usr.cwheel=0
			usr.overlays-='Icons/Jutsus/CrystalWheel.dmi'
			usr.firing=0
			return
	CrystalDome()
		if(src.UsingCDome)
			for(var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/Objects in view(1,src))
				if(Objects.Owner==src)
					del(Objects)
			src<<"You stop using Crystal Barrier."
			src.UsingCDome=0
			return
		src.ChakraDrain(15000)
		src.Handseals(40-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(!src.UsingCDome)
			src.UsingCDome=1
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/A/A=new()
			A.Owner=src;A.loc=locate(src.x-1,src.y+1,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/B/B=new()
			B.Owner=src;B.loc=locate(src.x,src.y+1,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/C/C=new()
			C.Owner=src;C.loc=locate(src.x+1,src.y+1,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/D/D=new()
			D.Owner=src;D.loc=locate(src.x-1,src.y,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/E/E=new()
			E.Owner=src;E.loc=locate(src.x,src.y,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/F/F=new()
			F.Owner=src;F.loc=locate(src.x+1,src.y,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/G/G=new()
			G.Owner=src;G.loc=locate(src.x-1,src.y-1,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/H/H=new()
			H.Owner=src;H.loc=locate(src.x,src.y-1,src.z)
			var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/I/I=new()
			I.Owner=src;I.loc=locate(src.x+1,src.y-1,src.z)
			while(src.UsingCDome)
				src.icon_state="handseal"
				src.chakra-=90
				sleep(11)
				if(usr.chakra<1)
					for(var/obj/Jutsu/Elemental/Shoton/CrystalBarrier/Objects in view(1,src))
						if(Objects.Owner==src)
							del(Objects)
					src<<"You stop using Crystal Barrier.";src.icon_state=""
					src.UsingCDome=0
					return
	CrystalDragon()
		var/Multiplier=1
		if(src.target)
			src.ChakraDrain(15000)
			src.Handseals(50-src.HandsealSpeed)
			if(src.HandsSlipped) return
			src.icon_state="handseal"
			spawn(1)
				src.icon_state=""
			var/obj/Jutsu/Elemental/Shoton/HashoKoryu/K=new();
			K.loc=src.loc;
			K.nin=src.nin*1.1;
			K.Owner=src;
			K.JutsuLevel=src.ShotonKnowledge;
			K.name="[src]";
			K.Move_Delay=1
			if(src.ShotonMastery>=5)
				K.Move_Delay=1
			if(src.ShotonKnowledge>99)
				K.Move_Delay=1
			if(src.ShotonMastery>=8)
				K.nin*=1.25
			src.controlled=K;src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;src.client.eye=K
			var/mob/M=src.target
			while(M&&K)
				step_towards(K,M)
				sleep(rand(K.Move_Delay,K.Move_Delay+1))
		else if(!src.target)
			src.ChakraDrain(23000)
			src.Handseals(55-src.HandsealSpeed)
			if(src.HandsSlipped) return
			src.icon_state="handseal"
			spawn(1)
				src.icon_state=""
			var/obj/Jutsu/Elemental/Shoton/HashoKoryu/K=new();K.loc=src.loc;K.nin=src.nin*Multiplier;K.Owner=src;K.JutsuLevel=src.SuitonKnowledge;K.name="[src]";K.Move_Delay=1
			if(src.ShotonMastery>=8)
				K.nin*=1.25
			if(src.ShotonMastery>=8)
				K.Move_Delay=2
			src.controlled=K;src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;src.client.eye=K

	CSawarabi(Uses)
		if(src.firing||src.knockedout)
			return
		else
			src.ChakraDrain(25000)
			var/B=Uses*0.1
			if(B<5)
				B=5
			if(B>10&&!src.Charging)
				B=10
			var/HowFarItGoes=1
			if(Uses>200)
				HowFarItGoes=2

			for(var/turf/T in oview(HowFarItGoes,src))
				var/obj/Jutsu/Elemental/Shoton/SpikeUnderground/AB=new/obj/Jutsu/Elemental/Shoton/SpikeUnderground(locate(T.x,T.y,T.z))
				spawn(15)
					var/obj/Jutsu/Elemental/Shoton/CSawarabi/A=new/obj/Jutsu/Elemental/Shoton/CSawarabi(locate(AB.x,AB.y,AB.z))
					A.Owner=src;flick("c.rise",A);A.icon_state="c.Spike8"
			sleep(1)
			var/num=1
			StartSpikes
			sleep(1)
			for(var/atom/T in oview(B,src))
				if(!(ismob(T)))
					if(prob(70))
						var/obj/Jutsu/Elemental/Shoton/SpikeUnderground/AB=new/obj/Jutsu/Elemental/Shoton/SpikeUnderground(locate(T.x,T.y,T.z))
						AB.layer=T.layer
						spawn(10)
							var/obj/Jutsu/Elemental/Shoton/CSawarabi/A=new/obj/Jutsu/Elemental/Shoton/CSawarabi(locate(AB.x,AB.y,AB.z))
							var/Z=rand(1,7)
							A.Owner=src;flick("c.rise[Z]",A);
							A.icon_state="c.Spike[Z]";
							A.density=rand(0,1);
					if(locate(/obj/Jutsu/Elemental/Doton/Yomicenter))
						var/obj/Jutsu/Elemental/Shoton/SpikeUnderground/AC=new/obj/Jutsu/Elemental/Shoton/SpikeUnderground
						spawn(10)
							var/Y=rand(1,7)
							var/obj/Jutsu/Elemental/Shoton/CSawarabi/C=new/obj/Jutsu/Elemental/Shoton/CSawarabi(locate(AC.x,AC.y,AC.z))
							C.Owner=src;flick("c.rise[Y]",C);C.icon_state="c.Spike[Y]";C.density=rand(0,1);

				num++
				if(num<7)
					goto StartSpikes


	KesshoNoYoroi()
		if(src.firing||src.Kaiten)
			return
		else
			src.CArmorOn=1;var/I='Icons/New Base/Base.dmi';I += rgb(238,135,238);src.Oicon=src.icon;src.icon=I;src.overlays+='Icons/New Base/EyesClosed.dmi';src.ChakraDrain(20000)
			spawn(((100+src.ShotonMastery)*(CrystalChakra/4)+1))
				src.CArmorOn=0;src<<"The armor wears off!";src.icon=usr.Oicon;src.overlays-='Icons/New Base/EyesClosed.dmi'
				for(var/obj/SkillCards/KesshoNoYoroi/A in src.LearnedJutsus)
					A.DelayIt(350,src,"Clan")
