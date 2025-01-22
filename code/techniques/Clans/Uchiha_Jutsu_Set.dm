mob/var/tmp/SharinganNotice=0
mob/var/tmp/UchihaAuraOn=0
mob/var/tmp/GhostParasite=0
obj/Mshar
	icon='Code/Techniques/shading.dmi'
	icon_state="weak"
	screen_loc="1,1 to 19,19"
	layer=MOB_LAYER+10
	mouse_opacity=0
obj/Jutsu/Uchiha
	AmatFireStuff
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="AmatFire"
		layer=80
		density = 0
		New()
			..()
			spawn()
				var/mob/O=src.Owner
				while(src)
			//		src.SoundEngine('SFX/FireSFX.wav',4)
					for(var/mob/M in src.loc)//range(1,src))
						if(M&&M!=O)
							if(!M.knockedout)
								var/damage=round(O.nin*rand(0.5,0.6))
								M.DamageProc(damage,"Health",O)
					//		sleep(7)
					sleep(11)
			spawn(600)
				del(src)
	AmatFireStuff2
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="AmatFire"
		layer=80
		density = 0
		New()
			..()
			spawn()
				var/mob/O=src.Owner
				while(src)
				//	src.SoundEngine('SFX/FireSFX.wav',4)
					for(var/mob/M in oview(1,src))
						if(M&&M!=O)
							if(!M.knockedout)
								var/damage=round(O.nin*rand(0.5,0.6))
								M.DamageProc(damage,"Health",O)
					sleep(11)
	//		spawn(600)
	//			del(src)
	AMAExplosion
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state="AmatExplode"
		layer=6
		density = 0
		New()
			..()
			spawn()
				while(src)
					for(var/mob/M in src.loc)
						var/mob/O=src.Owner
						if(M&&M!=O)
							var/damage=round(O.nin*rand(1.2,1.5))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O);M.DamageProc(damage*1.5,"Stamina",O)
					sleep(11)
			spawn(15)
				del(src)
		Del()
			var/obj/Jutsu/Uchiha/AMAProjectile/D=new();D.loc=src.loc;D.name="[src]";D.dir=NORTH;D.Owner=src.Owner;walk(D,D.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/C=new();C.loc=src.loc;C.name="[src]";C.dir=SOUTH;C.Owner=src.Owner;walk(C,C.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/B=new();B.loc=src.loc;B.name="[src]";B.dir=EAST;B.Owner=src.Owner;walk(B,B.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/A=new();A.loc=src.loc;A.name="[src]";A.dir=WEST;A.Owner=src.Owner;walk(A,A.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/F=new();F.loc=src.loc;F.name="[src]";F.dir=NORTHEAST;F.Owner=src.Owner;walk(F,F.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/G=new();G.loc=src.loc;G.name="[src]";G.dir=SOUTHWEST;G.Owner=src.Owner;walk(G,G.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/Y=new();Y.loc=src.loc;Y.name="[src]";Y.dir=SOUTHEAST;Y.Owner=src.Owner;walk(Y,Y.dir)
			var/obj/Jutsu/Uchiha/AMAProjectile/T=new();T.loc=src.loc;T.name="[src]";T.dir=NORTHWEST;T.Owner=src.Owner;walk(T,T.dir)
			..()
	AMA
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state = "Amaterasu"
		layer=MOB_LAYER+2
		density = 0
		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine2('SFX/FireSFX.wav',volume=50)
					for(var/mob/M in oview(1,src))
						var/mob/O=src.Owner
						if(M&&!M.knockedout&&M!=O)
							var/damage=round(O.nin*rand(1.45,1.6))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O)
								M.DamageProc(damage*3,"Stamina",O)
					sleep(11)

			spawn(600)
				del(src)
		Move()
			var/obj/Jutsu/Uchiha/AMATrail/Z=new();Z.loc=src.loc;Z.dir=src.dir;Z.Owner=src.Owner
			var/obj/Jutsu/Uchiha/AMATrail/ZZ=new();ZZ.loc=src.loc;ZZ.dir=src.dir;ZZ.Owner=src.Owner
			..()
	AMATrail
		icon='Icons/Jutsus/KatonTechsBlack.dmi'
		icon_state = "Amaterasu"
		layer=MOB_LAYER+2
		density = 0
		New()
			..()
			spawn()
				pixel_x=rand(-8,8)
				pixel_y=rand(-8,8)
				while(src)
				//	src.SoundEngine2('SFX/FireSFX.wav',volume=50)
					for(var/mob/M in range(1,src))
						var/mob/O=src.Owner
						if(M&&M!=O)
							var/damage=round(O.nin*rand(0.7,0.75))
							if(M.RaiArmor==2)
								damage/=2
							if(!M.knockedout)
								M.DamageProc(damage,"Health",O);M.DamageProc(damage*1.5,"Stamina",O)
					sleep(14)

			spawn(300)
				del(src)
	LightAMATrail
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state = "LightAmaterasu"
		layer=MOB_LAYER+2
		density = 0
		New()
			..()
			spawn()
				while(src)
			//		src.SoundEngine('SFX/FireSFX.wav',100)
					for(var/mob/M in range(1,src))
						var/mob/O=src.Owner
						if(M!=O)
							var/damage=round(O.nin*rand(0.7,0.75))
							if(M.RaiArmor==2)
								damage/=10
							M.DamageProc(damage,"Health",O);M.DamageProc(damage,"Stamina",O)
					sleep(11)

			spawn(300)
				del(src)
	AMAProjectile
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state = "AmaterasuProjectile"
		layer=MOB_LAYER+2
		density = 1
		var/nin=10
		New()
			..()
			spawn()
				while(src)
					sleep(11)
				//	src.SoundEngine('SFX/FireSFX.wav',100)
			spawn(100)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner

				var/damage=round(O.nin*rand(25,50));M.DamageProc(damage,"Health",O);M.DamageProc(damage,"Stamina",O)

				src.loc=M.loc;del(src)
			if(istype(A,/obj/))
				return 0
		Move()
			src.AmaterasuFire()
			..()
		Del()
			src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire()
			..()
	WhiteAMAProjectile
		icon='Icons/Jutsus/KatonTechniques.dmi'
		icon_state="WhiteAmaProjectile"
		layer=MOB_LAYER+2
		density = 1
		var/nin=10
		New()
			..()
			spawn()
				while(src)
					sleep(11)
		//			src.SoundEngine('SFX/FireSFX.wav',100)

			spawn(600)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner

				var/damage=round(src.nin*rand(50,100))
				M.DamageProc(damage,"Health",O)
				M.DamageProc(damage,"Stamina",O)

				src.loc=M.loc;del(src)
			if(istype(A,/obj/))
				return 0
			if(istype(A,/turf/))
				del(src)
		Move()
			src.AmaterasuFire()
			..()
		Del()
			src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire();src.AmaterasuFire()
			..()
	UchihaAura
		icon='Icons/Jutsus/Uchiha Aura.dmi'
		icon_state="0,0"
		layer=MOB_LAYER+1
		Part1
			icon_state="0,0"
			pixel_x=-16
		Part2
			icon_state="1,0"
			pixel_x=16
		Part3
			icon_state="0,1"
			pixel_x=-16
			pixel_y=32
		Part4
			icon_state="1,1"
			pixel_x=16
			pixel_y=32
	Susanoo
		icon='New Icons(Con4)/Susanoo Ribcage.dmi'
		density=1
		layer=MOB_LAYER+1
		var/Type="Itachi"
		var/AmatShieldOn=0
		var/EntonDefenceBoost=0
		Bump(A)
			if(ismob(A))
				var/mob/M = A
				if(src.Owner==M)
					src.loc=M.loc
		New()
			if(src.Type=="Sasuke")
				src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
				;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part03;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part04;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part01;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part02
			spawn()
				if(src.Type=="Sasuke")
					src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part03;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part04;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part01;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part02
			if(src.Type=="Itachi")
				src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
				;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part3;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part4;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part1;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part2
			spawn()
				if(src.Type=="Itachi")
					src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part3;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part4;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part1;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part2
			if(src.Type=="Shisui")
				src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
				;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part013;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part014;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part011;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part012
			spawn()
				if(src.Type=="Shisui")
					src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part013;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part014;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part011;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part012
			if(src.Type=="Madara")
				src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
				;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part023;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part024;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part021;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part022
			spawn()
				if(src.Type=="Madara")
					src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part023;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part024;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part021;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part022
			if(src.Type=="Obito")
				src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
				;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part033;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part034;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part031;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part032
			spawn()
				if(src.Type=="Obito")
					src.overlays+=icon=='New Icons(Con4)/Susanoo Ribcage.dmi'
					src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part033;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part034;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part031;src.overlays+=/obj/Jutsu/Uchiha/Susanoo/Part032
				while(src)
					for(var/obj/Jutsu/A in oview(1,src))
						if(A.Owner!=src.Owner)
							del(A)
					for(var/obj/Jutsu/A in src.loc)
						if(A.Owner!=src.Owner)
							del(A)
					if(src.Type=="Itachi"||src.Type=="Sasuke"||src.Type=="Shisui"||src.Type=="Madara"||src.Type=="Obito")
						for(var/mob/A in oview(1,src))
							if(A!=src.Owner)
								var/damage=rand(1,200)
								if(src.Type=="Sasuke")
									damage/=2.5
									if(src.EntonDefenceBoost==1)
										damage*=2.5
									if(src.EntonDefenceBoost==2)
										damage*=2.65
									if(src.EntonDefenceBoost==3)
										damage*=3
								A.DamageProc(damage*rand(1,2.5),"Health",src.Owner)
								A.DamageProc(damage*rand(1,2.5),"Stamina",src.Owner)
					sleep(11)
		proc/AmatDefenceProc(LevelOfDefence,PixelY,PixelX,Yvar,Xvar,Number1=1,Number2=3)
			var/mob/P=src.Owner
			if(src.AmatShieldOn==1)
				src.AmatShieldOn=0
				for(var/obj/Jutsu/Uchiha/AmatFireStuff2/A in src)
					del(A)
				for(var/obj/SkillCards/SusanooAmatDefence/A in P.LearnedJutsus)
					A.DelayIt(400,P,"Clan")
				P<<"You release the Enton shielding you....."
				return
			if(LevelOfDefence=="Light")
				src.AmatShieldOn=1
				src.EntonDefenceBoost=1
				var/a=rand(Number1,Number2)
				while(a>0)
					sleep(1)
					var/obj/Jutsu/Uchiha/AmatFireStuff2/F=new()
					F.Owner=src.Owner
					F.pixel_y=rand(PixelY,PixelY+((Yvar*2)-6))
					F.pixel_x=rand(PixelX,PixelX+((Xvar*2)-1))
		//			F.dir=Dir
					src.overlays+=F
					a--
			if(LevelOfDefence=="Medium")
				src.AmatShieldOn=1
				src.EntonDefenceBoost=2
				var/a=rand(Number1,Number2)
				while(a>0)
					sleep(1)
					var/obj/Jutsu/Uchiha/AmatFireStuff2/F=new()
					F.Owner=src.Owner
					F.pixel_y=rand(PixelY,PixelY+((Yvar*2)-5))
					F.pixel_x=rand(PixelX,PixelX+((Xvar*2)-1))
		//			F.dir=Dir
					src.overlays+=F
					a--
			if(LevelOfDefence=="Heavy")
				src.AmatShieldOn=1
				src.EntonDefenceBoost=3
				var/a=rand(Number1,Number2)
				while(a>0)
					sleep(1)
					var/obj/Jutsu/Uchiha/AmatFireStuff2/F=new()
					F.Owner=src.Owner
					F.pixel_y=rand(PixelY,PixelY+((Yvar*2)-4))
					F.pixel_x=rand(PixelX,PixelX+((Xvar*2)-1))
		//			F.dir=Dir
					src.overlays+=F
					a--


///////Sasuke's////////

		Part03
			icon_state="03"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part04
			icon_state="04"
			pixel_x=14//32
			pixel_y=24//32
		Part01
			icon_state="01"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part02
			icon_state="02"
			pixel_x=14//32
			pixel_y=-8//-16//-32
//////Itachi's///////

		Part3
			icon_state="3"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part4
			icon_state="4"
			pixel_x=14//32
			pixel_y=24//32
		Part1
			icon_state="1"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part2
			icon_state="2"
			pixel_x=14//32
			pixel_y=-8//-16//-32
///////Shisui's////////

		Part013
			icon_state="013"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part014
			icon_state="014"
			pixel_x=14//32
			pixel_y=24//32
		Part011
			icon_state="011"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part012
			icon_state="012"
			pixel_x=14//32
			pixel_y=-8//-16//-32
////////Madara's//////

		Part023
			icon_state="023"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part024
			icon_state="024"
			pixel_x=14//32
			pixel_y=24//32
		Part021
			icon_state="021"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part022
			icon_state="022"
			pixel_x=14//32
			pixel_y=-8//-16//-32
/////////Obito's///////

		Part033
			icon_state="033"
			pixel_x=-18//-32
			pixel_y=24//16//32
		Part034
			icon_state="034"
			pixel_x=14//32
			pixel_y=24//32
		Part031
			icon_state="031"
			pixel_x=-18//-32
			pixel_y=-8//-16//-32
		Part032
			icon_state="032"
			pixel_x=14//32
			pixel_y=-8//-16//-32
mob/owner/verb/TestUchihaAura()
	var/obj/Jutsu/Uchiha/UchihaAura/Part1/A=new();var/obj/Jutsu/Uchiha/UchihaAura/Part2/B=new()
	var/obj/Jutsu/Uchiha/UchihaAura/Part3/C=new();var/obj/Jutsu/Uchiha/UchihaAura/Part4/D=new();
	usr.overlays+=A;usr.overlays+=B;usr.overlays+=C;usr.overlays+=D
mob/owner/verb/TestUchihaAuraRemoval()
	var/obj/Jutsu/Uchiha/UchihaAura/Part1/A=new();var/obj/Jutsu/Uchiha/UchihaAura/Part2/B=new()
	var/obj/Jutsu/Uchiha/UchihaAura/Part3/C=new();var/obj/Jutsu/Uchiha/UchihaAura/Part4/D=new();
	usr.overlays-=A;usr.overlays-=B;usr.overlays-=C;usr.overlays-=D
mob/proc/SasukeAmatDefence(HowStrong)
	var/AmatStrength=HowStrong
	src.MUses++
	view()<<"[src] encoats themself in a Black Flame..."
	for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
		if(A.Owner==src)
			if(HowStrong=="Light")
			//	A.AmatDefenceProc(AmatStrength,PixelY,PixelX,Yvar,Xvar,Dir=SOUTH,Number1=1,Number2=3)
				A.AmatDefenceProc(AmatStrength,-8,-18,26,32,8,15)
			if(HowStrong=="Medium")
				A.AmatDefenceProc(AmatStrength,-8,-18,26,32,15,24)
			if(HowStrong=="Heavy")
				A.AmatDefenceProc(AmatStrength,-8,-18,26,32,24,30)
mob/proc/TimeCollaboration()
	src.MUses++
	view()<<"[src] decreases the speed of time around them!"
	src.health-=25
	if(prob(30))
		src.Bloody()
	src.chakra-=250
	for(var/obj/Jutsu/B in oview(4,src))
		if(B.Owner!=src.Owner)
			walk(B,0)
	for(var/obj/Jutsu/C in src.loc)
		if(istype(C,/obj/Jutsu/Uchiha/Susanoo))
			break
		if(C.Owner!=src.Owner)
			del(C)
	for(var/mob/M in oview(4,src))
		if(M in OnlinePlayers && !M.knockedout)
			M<<"Time is slown down around you!"
			M.Running=0
			M.StunAdd(20)

obj/proc/AmaterasuFire()
	var/obj/Jutsu/Uchiha/AmatFireStuff/A=new()
	A.loc=src.loc;A.pixel_x+=rand(1,8)
	A.pixel_y+=rand(1,8)
	A.icon='Icons/Jutsus/KatonTechniques.dmi'
	A.icon_state="AmatFire"
	if(src.icon_state=="WhiteAmaProjectile"||src.icon_state=="WhiteAmatSmall")
		A.icon_state="WhiteAmatFire"
	A.Owner=src
mob/proc
	Illuminate()
		src.see_invisible=99
		if(src.mangekyou)
			src.see_invisible=100
	IlluminateOff()
		src.see_invisible=1

mob/var
	DoujutsuTechs=0
	tmp/shari=0
	tmp/mangekyou=0
	tmp/SharCounter=0
	tmp/CopyMode=0
	tmp/GenjutsuCounterMode=0
	tmp/SusanooIn=0
	tmp/UsingAmaterasu=0
	tmp/Phasing=0
	tmp/Kamui=0
obj/WarpEffect3
	icon='Icons/Jutsus/Kamui_New.dmi'
	icon_state=""
	layer=5
	pixel_x=-16
	pixel_y=-16
	New()
		..()
		spawn(12)
			del(src)
mob/var/tmp
	MindGenjutsuReady=0
	MindGenjutsuWho="Missing Ninja"
	MindGenjutsuRank="Genin"
	MindGenjutsuWhat="Message"
	MindGenjutsuMode="Say"
	MindGenjutsuTarget
mob/proc
	Mind_Genjutsu()
		usr.Target()
		if(usr.ntarget)
			return
		else if(usr.MindGenjutsuReady)
			usr<<"You already prepared a Mind Genjutsu, to cancel the previous one, Shift+Click yourself. To execute it, Shift+Click on the person to say it, or Shift+Click on anything else to make the name you typed say it with no speech bubble."
			return
		else
			var/mob/M=usr.target
			var/Mode=input(usr,"Village Say or Say?","Mode",usr.MindGenjutsuMode) in list("Say","Village Say","Cancel")
			if(Mode=="Cancel") return
			var/A=input(usr,"What do you want to make [M] think that they are hearing?","Message") as text
			var/B=input(usr,"Who is going to say it? You can leave this blank and simply click on the person you want them to think is saying it. If you do not click on a mob though, the name will appear as <i>Missing Ninja</i> and no speech bubble will appear.","Name",usr.MindGenjutsuWho) as text
			usr<<"Now Shift + Click the person you want [M] to think is talking. To cancel, Shift+Click yourself. For no speech bubble and the default name, click a turf or object."
			if(B==null)
				B="Missing Ninja"
			usr.MindGenjutsuWho=B;usr.MindGenjutsuWhat=A;usr.MindGenjutsuMode=Mode;usr.MindGenjutsuTarget=M
			usr.MindGenjutsuReady=1
	Invisibility()
		if(src.invisibility==100)
			src.invisibility=1;src.AttackDelay=0
			src<<"You release the invisibility genjutsu.."
		else
			src.icon_state="handseal"
			src.MUses++
			src<<"You begin to cast a genjutsu of invisibility around yourself.."
			spawn(30)
				if(src.icon_state=="handseal")
					src.invisibility=100;src.AttackDelay=1
					src<<"Success! You're completely invisible to all but those with the keenest eyes. In this mode you're incapable of attacking."
				else
					src<<"The genjutsu failed."
					for(var/obj/SkillCards/Invisibility/A in src.LearnedJutsus)
						A.DelayIt(600,src,"Clan")

	False_Bunshin(atom/movable/A in world)
		var/mob/Clones/Clone/M = new()
		src.MUses++
		M.CloneType="GenjutsuClone"
		M.name=A.name;M.icon=A.icon;M.overlays=A.overlays;M.Owner=src;M.health=100000;M.density=1
		M.x=src.x-1;M.y=src.y;M.z=src.z

	Bunshin_MindFuck()
		if(src.controlled)
			var/mob/K=src.controlled
			for(var/mob/W in world)
				if(W.client&&W.client.eye==K)
					if(W!=src)
						W.client.eye=src
					else
						src.client.eye=src;src.client.perspective=MOB_PERSPECTIVE
						src.controlled=null
				sleep(25)
				del(K)
			return
		if(!src.target)
			src<<"You need a target.";return
		var/mob/M=usr.target
		var/mob/Clones/Clone/K=new()
		K.loc=locate(src.x,src.y,src.z)
		src.controlled=K;src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;src.client.eye=K
		for(var/mob/P in range(15,src))
			if(src==P.target)
				M.target=K
				for(var/image/x in M.client.images)
					if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
						del(x)
				var/image/I = image('Icons/target1.dmi',K)
				M<<I
		for(var/mob/W in world)
			if(W.client&&W.client.eye==src)
				W.client.eye=K
		if(K)
			for(var/V in src.vars)
				var/list/BAD = list("locs","cansave","key","ckey","client","type","parent_type","verbs","vars","group","x","y","z","loc","contents","controlled","alterV","alterC","alterR","OriginalVillage","Orank","OClan","ImmuneToDeath")
				if(!BAD.Find(V))
					K.vars[V] = src.vars[V]
			K.CloneType="GenjutsuClone"
			K.RunningSpeed=5;K.Running=1;K.density=1
			K.icon=src.icon;K.overlays+=src.overlays
			K.name="[src.name]";K.Owner=src
			K.tai=K.tai;K.nin=K.nin;K.gen=K.gen
			K.Running=1;K.RunningSpeed=5;src.KBunshinOn=1
			K.icon_state="running";K.Clone=1;K.cansave=0
		while(K&&src.chakra>0&&src.mangekyou)
			src.invisibility=100
			src.sight |= SEE_SELF
			src.density=0
			src.ImmuneToDeath=1
			sleep(20)
		if(K)
			for(var/mob/W in world)
				if(W.client&&W.client.eye==K)
					if(W!=src)
						W.client.eye=src
			sleep(25)
			del(K)
		src.client.eye=src;src.client.perspective=MOB_PERSPECTIVE
		src.controlled=null
		src.invisibility=1
		src.sight &= ~SEE_SELF
		src.density=1
		src.ImmuneToDeath=0




mob/var/tmp/UsingAmaterasuExplosion=0
mob/var/EternalMangekyoSharingan=0 //0 = None or Regular. 1 = Eternal MS. 2 = Extended Life MS.



mob/proc
	Sharingan()
//		if(src.Clan!="Uchiha")
//			return
		if(src.mangekyou)
			return
		if(src.shari)
			src<<"You release your sharingan.";usr.ChangeEyeStyle(usr.EyeStyle,usr.reye,usr.geye,usr.beye);src.shari=0;src.IlluminateOff();src.GenjutsuCounterMode=0;src.SharCounter=0;src.CopyMode=0;src.ChakraSight(0);
			for(var/obj/SkillCards/SharinganIlluminate/Z in usr.LearnedJutsus)
				del(Z)
			for(var/obj/SkillCards/SharinganFocus/Z in usr.LearnedJutsus)
				del(Z)
			src.UpdateInv()
			return
		else
			if(!src.shari)
				src.icon_state="1";usr.ChangeEyeStyle(usr.EyeStyle,200,0,0)
				var/image/I = new('Icons/Jutsus/sharinganthing.dmi');I.pixel_y=32;I.layer=6
		//		if(src.SharinganMastery==0)
			//		src.AwardMedal("Sharingan!")
				if(src.SharinganMastery<75)
					view()<<"[src]'s eyes shine brightly red, revealing 1 tomoe!";I.icon_state="1 tomoe"
				if(src.SharinganMastery>=75&&!src.TomoeThree)
					view()<<"[src]'s eyes shine brightly red, revealing 2 tomoes!";I.icon_state="2 tomoe"
				if(src.TomoeThree>=1&&src.SharinganMastery>75)
					view()<<"[src]'s eyes shine brightly red, revealing 3 tomoes!";I.icon_state="3 tomoe"
				if(src.SharinganMastery>300&&src.TomoeThree)
					view()<<"[src]'s eyes shine brightly red, revealing a very mature Sharingan!"
					src.LearnedJutsus+=new/obj/SkillCards/SharinganFocus
				if(src.SharinganMastery>=61)
					src<<"You can see through taijutsu techniques a lot better now!";usr.SharCounter=1
				if(src.SharinganMastery>=100)
					src.LearnedJutsus+=new/obj/SkillCards/SharinganIlluminate
					src<<"You can see through taijutsu techniques on a high level!";src.SharCounter=2
				src.UpdateInv()
				src.overlays+=I
				spawn(30)
					src.overlays-=I
					del(I)
				src.shari=1;src.Illuminate();sleep(30);src.ChakraSight(1)
				while(src.shari)
					var/A=src.SharinganMastery
					if(A<1) A=1
					var/ChakraDrain=(src.Mchakra/(A*15))
					if(ChakraDrain>65)
						ChakraDrain=65
					if(ChakraDrain<5)
						ChakraDrain=5
					src.chakra-=ChakraDrain
					if(prob(1))
						src.SharinganMastery+=pick(0.1,0.2,0.3,0.4)
					if(src.Charging&&prob(3))
						src.SharinganMastery+=pick(0.1,0.2,0.3,0.4,0.5,0.6)
					sleep(25)
	Sharingancopy()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			src<<"The next attack done by any ninja will be copied by you!";src.CopyMode=1
	SharinganFocus()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			if(src.SharinganNotice)
				src<<"You stop focusing on their handseals"
				src.SharinganNotice=0
				return
			else
				src<<"You begin to focus on the Opponents Handseals."
				src.SharinganNotice=1
	SharinganIlluminate()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			src<<"You focus your Sharingan to see chakra."
			src.IlluminateOff()
			src.ChakraSight(0)
			src.Illuminate()
			src.ChakraSight(1)
	GenjutsuCounter()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		else
			var/TimeLimit=100+(usr.SharinganMastery/10);src<<"You have the ability to counter genjutsu for [TimeLimit/10] seconds.";src.GenjutsuCounterMode=1
			spawn(TimeLimit)
				src.GenjutsuCounterMode=0
	Konsui()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		if(src.firing||src.Frozen)
			return
		src.chakra-=500
		for(var/mob/M in get_step(src,src.dir))
			if(M.dir==(get_dir(M,src))&&usr.dir==(get_dir(src,M)))
				if(M.knockedout)
					src<<"They're currently knocked out!";return
				if(M.Majest)
					src<<"You look deeply into [M]'s eyes!"
					spawn(15)
						src<<"Their Golden Majestic Eyes saw through your hypnosis, and prevented your genjutsu from working!"
				if(M.FrozenBind=="Sharingan")
					src<<"You've already captured them in a genjutsu, you can't cast the Hypnosis spell when they're in this much pain!";return
				M<<"[src] looks deeply into your eyes, their eyes spinning rapidly!";src<<"You look deeply into [M]'s eyes!";var/SleepingCount=30
				while(SleepingCount>0)
					if(SleepingCount>10&&M.gencounter)
						view()<<"[M] uses Genjutsu Release to prevent [src]'s attack from working!";M.gencounter=0;SleepingCount=0;return
					if(SleepingCount==20)
						M<<"You feel rather tired."
					if(SleepingCount==10)
						M<<"You feel like you're going to collapse."
					if(SleepingCount<=10)
						M.Running=0
					if(SleepingCount==1)
						M<<"You are way too tired, you are collapsing."
						M.Status="Asleep";M.icon_state="dead"
						M.StatusEffected=min(rand(src.SharinganMastery/25,src.SharinganMastery/15),20)
					SleepingCount-=1
					if(M.knockedout||M.ImmuneToDeath||M.Dead)
						src<<"The genjutsu failed."
						SleepingCount=0
						return
					sleep(11)
			else
				usr<<"You need to make eye contact!";return
	Kasegui()
		if(!src.shari)
			src<<"You need Sharingan on!";return
		if(src.firing)
			return
		if(src.Frozen)
			return
		var/Damage=(src.SharinganMastery+src.GenjutsuKnowledge)
		var/mob/ST   //Specified Target     I defined these variables so that the mob or turf is not lost in runtime
											//By movement or other things
		var/Distance=round(src.SharinganMastery/100)
		if(Distance<1) Distance=1
		if(Distance>10) Distance=10
		var/turf/DM = get_steps(src,src.dir,Distance)  //Distance Marker
		var/a=0
		while(a<Distance&&!ST)
			a++
			DM = get_steps(src,src.dir,a)
			for(var/mob/M in DM)
				if(M!=src&&M.dir==(get_dir(M,src))&&src.dir==(get_dir(src,M))&&M.FrozenBind==""&&!M.knockedout)
					ST=M   //Catch the first mob in the line. If he makes eyecontact then he's caught
					//If not, then the jutsu ends because anyone behind him wouldn't make eyecontact period.
					break
		if(!ST)
			src<<"You couldn't make eye contact with anyone.";return
		if(ST.ImmuneToDeath)
			return
		ST.FrozenBind="Sharingan"
		var/b=(ST.GenjutsuSight+(ST.GenjutsuKnowledge/100))///10))
		if(b<1) b=1
		Damage=(Damage/b)+src.Mgen
		var/StartHealth=ST.health
		var/image/A=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);A.icon_state="1";var/image/B=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);B.icon_state="2"
		var/image/C=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);C.icon_state="3";var/image/D=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);D.icon_state="4"
		var/image/E=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);E.icon_state="5";var/image/F=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);F.icon_state="6"
		var/image/G=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);G.icon_state="7";var/image/H=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);H.icon_state="8";var/image/I=image('Icons/Jutsus/GenjutsuTechniques.dmi',ST);I.icon_state="9"
		src<<A;src<<B;src<<C;src<<D;src<<F;src<<G;src<<H;src<<I
		if(ST.client) ST<<A;ST<<B;ST<<C;ST<<D;ST<<F;ST<<G;ST<<H;ST<<I
		sleep(18)
		ST.stamina-=Damage
		src<<output("[ST] was hurt by the genjutsu!([Damage])","Attack")
		while(ST&&src&&ST.FrozenBind=="Sharingan"&&!src.firing&&ST.Status!="Asleep")
			if(ST.health>(StartHealth-100)&&src.shari&&src.dir==(get_dir(src,ST)))
				var/ChakraDrain=100;src.chakra-=ChakraDrain;ST.FrozenBind="Sharingan";src<<E;ST<<E;ST.firing=1;src.UnableToChargeChakra=1;sleep(11)
				if(prob(10))
					ST.stamina-=Damage/10;src<<output("[ST] was hurt by the genjutsu!([Damage/10])","Attack")
				if(src.chakra<ChakraDrain)
					src<<"The bind on [ST] breaks!"
					ST.FrozenBind="";src.UnableToChargeChakra=0;step(src,ST.dir)
					for(var/image/x in src.client.images)
						if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
							del(x)
					if(ST.client)
						for(var/image/c in ST.client.images)
							if(c.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
								del(c)
			else
				src<<"You break the bind!";ST.firing=0;src.UnableToChargeChakra=0;ST.FrozenBind=""
				for(var/image/x in src.client.images)
					if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
						del(x)
				if(ST.client)
					for(ST in src.view)
						for(var/image/x in ST.client.images)
							if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
								del(x)
		ST<<"The binds breaks!"
		ST.firing=0;src.UnableToChargeChakra=0;ST.FrozenBind=""
		for(var/image/x in src.client.images)
			if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
				del(x)
		if(ST.client)
			for(var/image/x in ST.client.images)
				if(x.icon=='Icons/Jutsus/GenjutsuTechniques.dmi')
					del(x)



	MangekyouPrep()
		if(src.firing)
			return
		if(src.EternalMangekyoSharingan)
			EMS()
			return
		if(src.mangekyou)
			src.mangekyou=0
			if(!src.shari)
				src.ChangeEyeStyle(src.EyeStyle,src.reye,src.geye,src.beye);src.IlluminateOff()
			else
				src<<"You release the mangekyou sharingan, and your eyes return to their 3 tomoe state.."
				src.RemoveUchihaAura()
				src.UpdateInv()
			if(src.SusanooIn)
				for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
					if(A.Owner==src)
						del(A)
				src.SusanooIn=0
			var/list/Techniques=list("AmateratsuExplosion","MindGenjutsu","Invisibility","FalseBunshin","GenjutsuBunshin","Kamui","KTele","KTele2","TimeCollaboration","Phase","Amateratsu","AmateratsuProjectile","WhiteAmaterasuProjectile","Susanoo","Tsukiyomi","WhiteAmaterasu360","SusanooAmatDefence","SusanooAmatDefence2","SusanooAmatDefence3","ZeroVoidBarrier","ChakraRob","BladedWeapons","MSpaceTimeFreezeTimeSelect","MSpaceTimeFreeze")
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
			src<<"You release your Mangekyou Sharingan.";src.ChakraSight(0);src.Phasing=0;src.mangekyou=0
			for(var/obj/Mshar/MM in src.client.screen)
				del(MM)
			if(src.MUses>250)
				var/obj/Mshar/MM=new()
				MM.screen_loc = "1,1 to 19,19"
				src.client.screen+=MM
				if(src.MUses>250&&usr.MUses<350)
					MM.icon_state="weak"
				if(src.MUses>=350&&usr.MUses<500)
					MM.icon_state="strong"
				if(src.MUses>=500)
					MM.icon_state="blind"
				if(src.MUses>=600)
					MM.icon_state="blinder"
				if(src.SusanooIn)
					for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
						if(A.Owner==src)
							del(A)
					src.SusanooIn=0
				src.RemoveUchihaAura()
				src.UpdateInv()
		else
			if(!src.shari)
				src<<"Turn on your regular sharingan first."
				return
			if(src.EternalMangekyoSharingan)
				EMS()
				return
				//src.ChangeEyeStyle(src.EyeStyle,src.reye,src.geye,src.beye);src.shari=0;src.IlluminateOff();src.GenjutsuCounterMode=0;src.SharCounter=0;src.CopyMode=0;src.ChakraSight(0);return
			src.mangekyou=1;src.ChakraSight(1);src.ChangeEyeStyle(src.EyeStyle,200,0,0)
			view(9,src)<<"[src]'s pupils spin and transform into the Legendary Mangekyou Sharingan!";usr.Illuminate()
/*		var/image/A = new('Icons/Jutsus/sharinganthing.dmi');
			A.pixel_y=32;A.layer=6 //Begin Added stuff
			if(!src.EternalMangekyoSharingan)
				A.icon_state="[src.mangekyouC]"
			else if(src.EternalMangekyoSharingan==2)
				A.icon_state="ELMS"
			src.overlays+=A
			spawn(30)
				src.overlays-=A
				del(A)End Added stuff*/
			if(src.mangekyouC=="6 point")
				src.mangekyouC="bladed"
			for(var/obj/Mshar/MM in src.client.screen)
				del(MM)
			if(src.MUses>350)
				var/obj/Mshar/MM=new()
				MM.screen_loc = "1,1 to 19,19"
				src.client.screen+=MM
				MM.icon_state="weak"
				var/obj/I=new()
				var/obj/I2=new()
				I.icon='Icons/Jutsus/sharinganthing.dmi';I2.icon=I.icon
				I.pixel_y=16;I2.pixel_y=16
				I.pixel_x=-20;I2.pixel_x=20
				if(src.MUses>=500)
					MM.icon_state="strong"
					I.icon_state="blind 1";I2.icon_state=I.icon_state
				if(src.MUses>=600)
					MM.icon_state="blind"
					I.icon_state="blind 2";I2.icon_state=I.icon_state
				if(src.MUses>=700)
					MM.icon_state="blinder"
					I.icon_state="blind 3";I2.icon_state=I.icon_state
				src.overlays+=I;src.overlays+=I2
				spawn(20)
					src.overlays-=I;src.overlays-=I2
					del(I)
			else
				var/obj/I=new();var/obj/I2=new()
				I.icon='Icons/Jutsus/sharinganthing.dmi';I2.icon=I.icon
				I.icon_state="[src.mangekyouC]";I2.icon_state=I.icon_state
				I.pixel_y=16;I2.pixel_y=16
				I.pixel_x=-20;I2.pixel_x=20
				src.overlays+=I;src.overlays+=I2
				spawn(20)
					src.overlays-=I;src.overlays-=I2
					del(I)
			if(findtext(usr.mangekyouC,"obito",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
				src.LearnedJutsus+=new/obj/SkillCards/KTele
				src.LearnedJutsus+=new/obj/SkillCards/KTele2
			if(findtext(usr.mangekyouC,"shin",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/BladedWeapons
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreezeTimeSelect
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreeze
			if(findtext(usr.mangekyouC,"shuriken",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"madara",1,0)||findtext(usr.mangekyouC,"star",1,0)||findtext(usr.mangekyouC,"gridlock",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"bladed",1,0)||findtext(usr.mangekyouC,"shuriken",1,0)||findtext(usr.mangekyouC,"niro",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			if(findtext(usr.mangekyouC,"sasuke",1,0)||findtext(usr.mangekyouC,"bladed",1,0)||findtext(usr.mangekyouC,"star",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			if(findtext(usr.mangekyouC,"gridlock",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			if(findtext(usr.mangekyouC,"star",1,0,)||findtext(usr.mangekyouC,"madara",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/ChakraRob
				src.LearnedJutsus+=new/obj/SkillCards/ZeroVoidBarrier
			if(findtext(usr.mangekyouC,"obito",1,0)||findtext(usr.mangekyouC,"bladed",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Kamui
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"sasuke",1,0)||findtext(usr.mangekyouC,"niro",1,0)||findtext(usr.mangekyouC,"shisui",1,0)||findtext(usr.mangekyouC,"madara",1,0)||findtext(usr.mangekyouC,"obito",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.mangekyouC,"sasuke",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
				src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence
				for(var/obj/SkillCards/Susanoo/P in usr.LearnedJutsus)
					if(P.Uses>=10)
						usr<<"You feel as though you're able to use the Enton more effectively...!"
						if(!(locate(/obj/SkillCards/SusanooAmatDefence2) in usr.LearnedJutsus))
							src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence2
				for(var/obj/SkillCards/SusanooAmatDefence2/X in usr.LearnedJutsus)
					if(X.Uses>=15)
						usr<<"You feel as though you've mastered your use of Enton..,,,"
						if(!(locate(/obj/SkillCards/SusanooAmatDefence3) in usr.LearnedJutsus))
							src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence3
			if(findtext(usr.mangekyouC,"shisui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/MindGenjutsu
				src.LearnedJutsus+=new/obj/SkillCards/Invisibility
				src.LearnedJutsus+=new/obj/SkillCards/FalseBunshin
				src.LearnedJutsus+=new/obj/SkillCards/GenjutsuBunshin
			if(findtext(usr.MMove1,"AmateratsuP",1,0)||findtext(usr.MMove2,"AmateratsuP",1,0)||findtext(usr.MMove3,"AmateratsuP",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			if(findtext(usr.MMove1,"Amateratsu",1,0)||findtext(usr.MMove2,"Amateratsu",1,0)||findtext(usr.MMove3,"Amateratsu",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			if(findtext(usr.MMove1,"Tsukiyomi",1,0)||findtext(usr.MMove2,"Tsukiyomi",1,0)||findtext(usr.MMove3,"Tsukiyomi",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			if(findtext(usr.MMove1,"Susanoo",1,0)||findtext(usr.MMove2,"Susanoo",1,0)||findtext(usr.MMove3,"Susanoo",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.MMove1,"Phase",1,0)||findtext(usr.MMove2,"Phase",1,0)||findtext(usr.MMove3,"Phase",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
			if(findtext(usr.MMove1,"Kamui",1,0)||findtext(usr.MMove2,"Kamui",1,0)||findtext(usr.MMove3,"Kamui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Kamui
			if(findtext(usr.MMove1,"WAmaterasuP",1,0)||findtext(usr.MMove2,"WAmaterasuP",1,0)||findtext(usr.MMove3,"WAmaterasuP",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
			if(findtext(usr.MMove1,"TimeCollaboration",1,0)||findtext(usr.MMove2,"TimeCollaboration",1,0)||findtext(usr.MMove3,"TimeCollaboration",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
			if(findtext(usr.MMove1,"WSpreadShot",1,0)||findtext(usr.MMove2,"WSpreadShot",1,0)||findtext(usr.MMove3,"WSpreadShot",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			if(findtext(usr.MMove1,"BAmaterasuExplode",1,0)||findtext(usr.MMove2,"BAmaterasuExplode",1,0)||findtext(usr.MMove3,"BAmaterasuExplode",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
			if(findtext(usr.MMove1,"Void",1,0)||findtext(usr.MMove2,"Void",1,0)||findtext(usr.MMove3,"Void",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/ZeroVoidBarrier
			if(findtext(usr.MMove1,"ChakraSteal",1,0)||findtext(usr.MMove2,"ChakraSteal",1,0)||findtext(usr.MMove3,"ChakraSteal",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/ChakraRob
			if(findtext(usr.MMove1,"Blades",1,0)||findtext(usr.MMove2,"Blades",1,0)||findtext(usr.MMove3,"Blades",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/BladedWeapons
			if(findtext(usr.MMove1,"SpaceTime",1,0)||findtext(usr.MMove2,"SpaceTime",1,0)||findtext(usr.MMove3,"SpaceTime",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreezeTimeSelect
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreeze
			src.UpdateInv()
			while(src.shari&&src.mangekyou&&src.chakra>0)
				sleep(120)
				if(prob(20))
					src.stamina-=(src.maxstamina/100)
				src.chakra-=rand(75,90)
				if(prob(10))
					if(src.invisibility<=1)
						src.Bloody()
					src.health-=70
			if(!src.shari&&src.mangekyou)
				src.MangekyouPrep()
				return
			else if(src.chakra<=10&&src.mangekyou)
				src<<"You're unable to sustain the Mangekyo with your current chakra levels so it deactivates.."
				src.MangekyouPrep()
				return
		src.UpdateInv()

	Amateratsu()
		src.MUses+=10;
		src.chakra-=1500;
		src.stamina-=rand(200,350);
		src.health-=rand(150,250)
		if(src.MUses<=0)
			src.health-=150
	//	src.Handseals(50-src.HandsealSpeed)
	//	if(src.HandsSlipped) return
		src.SaveK()
		src.UsingAmaterasu=1;var/obj/Jutsu/Uchiha/AMA/K=new();K.loc=src.loc;K.dir=src.dir;K.name="[src]";K.Owner=src
		while(src.UsingAmaterasu)
			src.chakra-=80;
			src.health-=45;
			src.stamina-=35;
			sleep(pick(60,70))
		src.client.perspective=MOB_PERSPECTIVE;src.client.eye=src;del(K)
	AmaterasuExplosion()
		src<<"You begin to concentrate on a location very hard and begin to form a manifestation of Enton!"
		src<<"Double Click on an area to spawn an Enton particle that will release into Amaterasu in time!"
		src.MUses+=5;src.chakra-=850;src.stamina-=rand(100,250);src.health-=rand(50,150)
	//	src.HandSeals(50-src.HandsealSpeed)
		src.UsingAmaterasuExplosion=1
		src.SaveK()
		while(src.UsingAmaterasuExplosion)
			src.chakra-=25;src.health-=25;src.stamina-=25;sleep(10)
	AmaterasuFire()
		var/obj/Jutsu/Uchiha/AmatFireStuff/A=new();A.loc=src.loc;A.pixel_x+=rand(1,8);A.pixel_y+=rand(1,8);A.icon='Icons/Jutsus/KatonTechniques.dmi';A.icon_state="AmatFire";A.Owner=src
		if(src.icon_state=="WhiteAmaProjectile")
			A.icon_state="WhiteAmatFire"
	ProjectileAmaterasu()
	//	if(!src.InSusano)
		src.chakra-=500;src.stamina-=rand(150,300);src.MUses+=3
		src.SaveK()
	//	src.Handseals(50-src.HandsealSpeed)
	//	if(src.HandsSlipped) return
		var/obj/Jutsu/Uchiha/AMAProjectile/K=new();K.loc=src.loc;K.nin=src.nin/5;K.dir=src.dir;K.name="[src]";K.Owner=src;walk(K,src.dir)
	WhiteProjectileAmaterasu()
		src.chakra-=450;src.stamina-=rand(150,300);src.MUses+=5
		src.SaveK()
	//	src.Handseals(31-src.HandsealSpeed)
	//	if(src.HandsSlipped) return
		var/obj/Jutsu/Uchiha/WhiteAMAProjectile/K=new();K.loc=src.loc;K.nin=src.nin/5;K.dir=src.dir;K.name="[src]";K.Owner=src;walk(K,src.dir)
	WhiteFireShot()
		set name = "White Amaterasu: 360 Degrees"
		src.chakra-=1000;src.stamina-=rand(250,400);src.MUses+=10
		src.SaveK()
		var/num=8
		var/loldir=src.dir
		while(num>0)
			var/obj/Jutsu/Uchiha/WhiteAMAProjectile/K=new();K.icon_state="WhiteAmatSmall";K.loc=src.loc;K.nin=src.nin/10;K.dir=loldir;K.name="[src]";K.Owner=src;walk(K,K.dir)
			loldir=turn(loldir,45)
			num--

	Tsukiyomi()
		src.Target()
		if(src.ntarget)
			return
		var/mob/M   //Specified Target     I defined these variables so that the mob or turf is not lost in runtime
											//By movement or other things
		var/Distance=round(src.SharinganMastery/100)
		if(Distance<1) Distance=1
		if(Distance>10) Distance=10
		var/turf/DM = get_steps(src,src.dir,Distance)  //Distance Marker
		var/a=0
		while(a<Distance&&!M)
			a++
			DM = get_steps(src,src.dir,a)
			for(var/mob/P in DM)
				if(P!=src&&P.dir==(get_dir(P,src))&&src.dir==(get_dir(src,P))&&P.FrozenBind==""&&!P.knockedout)
					M=P   //Catch the first mob in the line. If he makes eyecontact then he's caught
					//If not, then the jutsu ends because anyone behind him wouldn't make eyecontact period.
					break
		src.MUses+=5
		src.SaveK()
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(M.FrozenBind!="")
			src<<"They're already binded right now.";return
		if(M.knockedout)
			src<<"Not now.";return
		if(M in oview(4))
			src.Struggle=0;M.Struggle=0
			src<<"Quickly, press the space bar repeatedly to do damage to [M]'s willpower!"
			M<<"You're suddenly caught in a Genjutsu! Press the space bar repeatedly to escape!";M.FrozenBind="Tsukiyomi"
			spawn(1)
				var/i=rand(40,60)
				while(i>0)
					sleep(1);M<<output("[src] slashes you!","Attack");M<<sound('SFX/Slice.wav',0);i--
			M.sight |= (SEE_SELF|BLIND);var/obj/A=new();A.icon='Icons/Jutsus/sharinganthing.dmi';A.icon_state="[usr.mangekyouC]";A.screen_loc="10,10";A.layer=MOB_LAYER+1;M.client.screen+=A
			spawn(60)
				if(M.Struggle<src.Struggle+25)
					M.deathcount+=((src.Struggle/10)-(M.Struggle/10))
				else
					src<<"[M] over came the Tsukiyomi!"
					M<<"You over came the Tsukiyomi!"
				M.FrozenBind="";M.sight &= ~(SEE_SELF|BLIND)
				for(var/obj/C in M.client.screen)
					if(C.icon=='Icons/Jutsus/sharinganthing.dmi')
						del(C)
	Phase()
		if(src.Phasing)
			src<<"You begin to come back and phase back into reality."
			src.Phasing=0
			src.density=1
			return
		src.Phasing=1;src<<"You begin to phase out of reality, nothing can harm you but you're unable to attack."

		while(src.Phasing)
			src.density=0;src.chakra-=100;sleep(20)
		src.density=1
	Kamui()
		if(src.knockedout||src.Dead||!src.mangekyou)
			src.firing=0
			return
		src.MUses+=10;
		src.health-=rand(150,250);src<<"Your eyes feel strained."
		src.Kamui=1
		src.SaveK()
		src<<"You ready your Kamui technique. Click on a target to warp it away. Be precise to do the most damage possible."
		while(src.Kamui)
			src.chakra-=(src.Mchakra/100)
			src.stamina-=(src.maxstamina/25)
			sleep(7)
	WarpHole(atom/movable/M,iconX,iconY)
		var/obj/WarpEffect3/W=new()
		W.pixel_x+=iconX;W.pixel_y+=iconY;W.loc=M.loc
		if(ismob(M))
			if(!M.density)
				src<<"For some reason, they're not affected!?";src.Kamui=0;return
			else if(iconX>=14&&iconX<=18&&iconY>=23&&iconY<=26)
				src.Kamui=0
				spawn()
					Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z)
				spawn()
					Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z)
				src<<"You use your Mangekyo to create a worm hole at [M]'s head, killing them instantly!"
				M:Stun=10
				M<<"[src] blows your head through a worm hole with their Mangekyo!"
				M:health=0;M:stamina=0;M:Death(src)
				spawn(2)
					M:DeathStruggle(src,1)
			else if(iconX>=13&&iconX<=19&&iconY>=10&&iconY<=17)
				src.Kamui=0
				spawn()
					Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z);Blood(M.x,M.y,M.z)
				src<<"You use your Mangekyo to create a worm hole in [M]'s torso, dealing massive damage!"
				M:Stun=10
				M<<"[src] blows a hole through your torso with their Mangekyo!"
				M.DamageProc(500,"Health",src)
				M:CBleeding=1
			else
				src.Kamui=0
				spawn()
					Blood(M.x,M.y,M.z)
				src<<"You use your Mangekyo to create a worm hole on [M], but you only knick them with it!"
				M:Stun=5
				M<<"[src] creates a worm hole near you with their Mangekyo!"
				M:DamageProc(100,"Health",src)
		else if(isobj(M))
			if(istype(M,/obj/Jutsu/Uchiha/Susanoo))
				var/obj/Jutsu/Uchiha/Susanoo/A=M
				var/mob/P = A.Owner
				if(!A.Owner||!P)
					return
				P<<"Your Susano has been warped away?!"
				P.SusanooIn=0
				src.Kamui=0
				src<<"You successfully warped away [P]'s Susano'o!"
				del(M)
			if(istype(M,/obj/VillageScrollPost))
				src<<"Nah."
				src.Kamui=0
				src.DamageProc(2000,"Health")
				return
			if(istype(M,/obj/Hidden_Ninja_Scroll))
				src<<"Nah."
				src.Kamui=0
				src.DamageProc(2000,"Health")
				return
			src.Kamui=0
			viewers(src)<<"[src] uses their Mangekyo to create a worm hole on the [M], warping it away!"
			del(M)
	Susanoo(Uses)
		if(Uses<100)
			src.chakra-=2000;
			src.stamina-=rand(500,1200)
		if(src.MUses<=0)
			src.health-=100
		src.MUses+=20;
		src.Handseals(1-src.HandsealSpeed)
		src.SaveK()
		if(src.HandsSlipped) return
		var/obj/Jutsu/Uchiha/Susanoo/K=new();K.name="[src]";K.Owner=src;src.SusanooIn=1;K.loc=src.loc;walk_towards(K,src)
		if(src.mangekyouC=="itachi") K.Type="Itachi"
		if(src.mangekyouC=="sasuke") K.Type="Sasuke"
		if(src.mangekyouC=="obito") K.Type="Obito"
		if(src.mangekyouC=="madara") K.Type="Madara"
		if(src.mangekyouC=="shisui") K.Type="Shisui"
		while(src.SusanooIn)
			src.chakra-=pick(75,100,120);
			src.stamina-=pick(50,65,70,80);
			src.Running=0
			if(src.MUses<=0)
				if(prob(30))
					src.health-=80
			if(prob(15))
				src.Bloody();
				src.health-=250;
				src.MUses+=1
			sleep(60)



	EMS()
		if(src.firing)
			return
		if(src.mangekyou)
			src.mangekyou=0;src.MUses=-5000;src.ChangeEyeStyle(src.EyeStyle,src.reye,src.geye,src.beye);src.IlluminateOff()
			for(var/obj/SkillCards/MindGenjutsu/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Invisibility/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/FalseBunshin/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Kamui/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/TimeCollaboration/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Phase/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Amateratsu/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/AmateratsuProjectile/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/WhiteAmateratsuProjectile/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Susanoo/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Tsukiyomi/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/Kamui/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/WhiteAmaterasu360/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/AmateratsuExplosion/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/SusanooAmatDefence/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/SusanooAmatDefence2/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/SusanooAmatDefence3/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/UchihaAura/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/UchihaAuraOff/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/ChakraRob/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/ZeroVoidBarrier/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/BladedWeapons/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/MSpaceTimeFreezeTimeSelect/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/MSpaceTimeFreeze/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/KTele/A in src.LearnedJutsus)
				del(A)
			for(var/obj/SkillCards/KTele2/A in src.LearnedJutsus)
				del(A)
			src<<"You release your Mangekyou Sharingan.";
			src.RemoveUchihaAura()
			src.UpdateInv()
			src.ChakraSight(0);
			src.Phasing=0;
			src.mangekyou=0
			if(src.SusanooIn)
				for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
					if(A.Owner==src)
						del(A)
				src.SusanooIn=0
		else
			if(!src.shari)
				src<<"Activate your regular sharingan first.";return
			src.mangekyou=1;src.ChakraSight(1);src.ChangeEyeStyle(src.EyeStyle,200,0,0)
			view(9,src)<<"[src]'s pupils spin and transform into an Eternal Mangekyou Sharingan!";usr.Illuminate()
	//		for(var/obj/Mshar/MM in src.client.screen)
	//			del(MM)
			var/obj/I=new();var/obj/I2=new()
			I.icon='Icons/Jutsus/sharinganthing.dmi';I2.icon=I.icon
			I.icon_state="";I2.icon_state=I.icon_state
			I.pixel_y=16;I2.pixel_y=16
			I.pixel_x=-20;I2.pixel_x=20
			src.overlays+=I;src.overlays+=I2
			spawn(20)
				src.overlays-=I;src.overlays-=I2
				del(I)
			src.CreateUchihaAura()
			spawn(30)
				src.RemoveUchihaAura()
			if(src.mangekyouC=="6 point")
				src.mangekyouC="bladed"
			if(findtext(usr.mangekyouC,"obito",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
				src.LearnedJutsus+=new/obj/SkillCards/KTele
				src.LearnedJutsus+=new/obj/SkillCards/KTele2
			if(findtext(usr.mangekyouC,"shin",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/BladedWeapons
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreezeTimeSelect
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreeze
			if(findtext(usr.mangekyouC,"shuriken",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"madara",1,0)||findtext(usr.mangekyouC,"star",1,0)||findtext(usr.mangekyouC,"gridlock",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"bladed",1,0)||findtext(usr.mangekyouC,"shuriken",1,0)||findtext(usr.mangekyouC,"niro",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			if(findtext(usr.mangekyouC,"sasuke",1,0)||findtext(usr.mangekyouC,"bladed",1,0)||findtext(usr.mangekyouC,"star",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			if(findtext(usr.mangekyouC,"gridlock",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			if(findtext(usr.mangekyouC,"star",1,0,)||findtext(usr.mangekyouC,"madara",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/ChakraRob
				src.LearnedJutsus+=new/obj/SkillCards/ZeroVoidBarrier
			if(findtext(usr.mangekyouC,"obito",1,0)||findtext(usr.mangekyouC,"bladed",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Kamui
			if(findtext(usr.mangekyouC,"itachi",1,0)||findtext(usr.mangekyouC,"sasuke",1,0)||findtext(usr.mangekyouC,"niro",1,0)||findtext(usr.mangekyouC,"shisui",1,0)||findtext(usr.mangekyouC,"madara",1,0)||findtext(usr.mangekyouC,"obito",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.mangekyouC,"sasuke",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
				src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence
				for(var/obj/SkillCards/Susanoo/P in usr.LearnedJutsus)
					if(P.Uses>=10)
						usr<<"You feel as though you're able to use the Enton more effectively...!"
						if(!(locate(/obj/SkillCards/SusanooAmatDefence2) in usr.LearnedJutsus))
							src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence2
				for(var/obj/SkillCards/SusanooAmatDefence2/X in usr.LearnedJutsus)
					if(X.Uses>=15)
						usr<<"You feel as though you've mastered your use of Enton..,,,"
						if(!(locate(/obj/SkillCards/SusanooAmatDefence3) in usr.LearnedJutsus))
							src.LearnedJutsus+=new/obj/SkillCards/SusanooAmatDefence3
			if(findtext(usr.mangekyouC,"shisui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/MindGenjutsu
				src.LearnedJutsus+=new/obj/SkillCards/Invisibility
				src.LearnedJutsus+=new/obj/SkillCards/FalseBunshin
				src.LearnedJutsus+=new/obj/SkillCards/GenjutsuBunshin
			if(findtext(usr.MMove1,"AmaterasuP",1,0)||findtext(usr.MMove2,"AmaterasuP",1,0)||findtext(usr.MMove3,"AmaterasuP",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuProjectile
			if(findtext(usr.MMove1,"Amateratsu",1,0)||findtext(usr.MMove2,"Amateratsu",1,0)||findtext(usr.MMove3,"Amateratsu",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Amateratsu
			if(findtext(usr.MMove1,"Tsukiyomi",1,0)||findtext(usr.MMove2,"Tsukiyomi",1,0)||findtext(usr.MMove3,"Tsukiyomi",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Tsukiyomi
			if(findtext(usr.MMove1,"Susanoo",1,0)||findtext(usr.MMove2,"Susanoo",1,0)||findtext(usr.MMove3,"Susanoo",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Susanoo
			if(findtext(usr.MMove1,"Phase",1,0)||findtext(usr.MMove2,"Phase",1,0)||findtext(usr.MMove3,"Phase",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Phase
			if(findtext(usr.MMove1,"Kamui",1,0)||findtext(usr.MMove2,"Kamui",1,0)||findtext(usr.MMove3,"Kamui",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/Kamui
			if(findtext(usr.MMove1,"WAmaterasuP",1,0)||findtext(usr.MMove2,"WAmaterasuP",1,0)||findtext(usr.MMove3,"WAmaterasuP",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmateratsuProjectile
			if(findtext(usr.MMove1,"TimeCollaboration",1,0)||findtext(usr.MMove2,"TimeCollaboration",1,0)||findtext(usr.MMove3,"TimeCollaboration",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
			if(findtext(usr.MMove1,"TimeCollaboration",1,0)||findtext(usr.MMove2,"TimeCollaboration",1,0)||findtext(usr.MMove3,"TimeCollaboration",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/TimeCollaboration
			if(findtext(usr.MMove1,"WSpreadShot",1,0)||findtext(usr.MMove2,"WSpreadShot",1,0)||findtext(usr.MMove3,"WSpreadShot",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/WhiteAmaterasu360
			if(findtext(usr.MMove1,"BAmaterasuExplode",1,0)||findtext(usr.MMove2,"BAmaterasuExplode",1,0)||findtext(usr.MMove3,"BAmaterasuExplode",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/AmateratsuExplosion
			if(findtext(usr.MMove1,"Void",1,0)||findtext(usr.MMove2,"Void",1,0)||findtext(usr.MMove3,"Void",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/ZeroVoidBarrier
			if(findtext(usr.MMove1,"ChakraSteal",1,0)||findtext(usr.MMove2,"ChakraSteal",1,0)||findtext(usr.MMove3,"ChakraSteal",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/ChakraRob
			if(findtext(usr.MMove1,"Blades",1,0)||findtext(usr.MMove2,"Blades",1,0)||findtext(usr.MMove3,"Blades",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/BladedWeapons
			if(findtext(usr.MMove1,"SpaceTime",1,0)||findtext(usr.MMove2,"SpaceTime",1,0)||findtext(usr.MMove3,"SpaceTime",1,0))
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreezeTimeSelect
				src.LearnedJutsus+=new/obj/SkillCards/MSpaceTimeFreeze
			src.UpdateInv()
			src.LearnedJutsus+=new/obj/SkillCards/UchihaAura
			src.LearnedJutsus+=new/obj/SkillCards/UchihaAuraOff
			src.UpdateInv()
			while(src.mangekyou)
				sleep(100);src.chakra-=(rand(50,75))
			if(src.chakra<=10&&src.mangekyou)
				src<<"You're unable to sustain your Eternal Mangekyo with your current chakra levels so it deactivates.."
				src.EMS()
				return
mob/proc/Izanagi()
	if(src.SelfHeal)
		src.SelfHeal=0
		src<<"You stop the regeneration."
	src<<"You restore yourself to have a longer life!"
	src.SelfHeal=1
	sleep(1)
	var/Location
	Location=src.loc
	while(src.loc==Location&&src.SelfHeal&&!src.knockedout)
		var/HealthHeal=(5*(src.NinSkill*2))
		var/StaminaHeal=(5*(src.NinSkill*2))
		src.health+=HealthHeal
		src.stamina+=StaminaHeal
		if(src.stamina>src.maxstamina)
			src.stamina=src.maxstamina
		src.ChakraDrain(35000)
		var/SleepWait=(1/(src.GenerationMastery+1))
	//	sleep(300/(src.GenerationMastery+1))
		sleep(SleepWait)
		if(src.chakra<0)
			src.SelfHeal=0
			src<<"You're unable to continue healing yourself because you've run out of chakra!"
mob/proc
	MSFreezeTimeSelect()
		switch(input(usr,"Which Variation of Space Time Ninjutsu: Freeze would you like to use","Space Time Ninjutsu: Freeze") in list("Target","Screenwide","Cancel"))
			if("Target")
				src.FreezeTime="Target"
			if("Screenwide")
				src.FreezeTime="Screenwide"
			if("Cancel")
				return
	MSFreezeTime(WhichFreezeTime)
		var/FreezeTimeEffect=WhichFreezeTime
		if(FreezeTimeEffect=="")
			src<<"You need to use Freeze Time Select and select which type of Freeze Space Time you would like to use first!";return
		if(FreezeTimeEffect=="Target")
			var/TimeFrozen=200
			var/mob/A=src.target
			if(src.ntarget)
				src<<"You need a target!";return
			src.MUses+=3
			src.health-=25
			src.stamina-=50
			src.dir=A.dir
			view()<<"[src] faces your direction and the world begins to seem...disoriented...?"
			sleep(15)
			view()<<"[A] is frozen by the space time continuum!"
			A<<"Tap Spacebar to resist the change from Space!"
			A.FrozenBind="SpaceTimeFrozen"
			while((TimeFrozen-A.Struggle)>0)
				A.FrozenBind="SpaceTimeFrozen"
				TimeFrozen-=5
				sleep(10)
			A<<"The space time continuum goes back to it's normal state and you're able to move again!"
			src<<"You're forced to stop altering the space time continuum!"
			A.FrozenBind=""
			return
		if(FreezeTimeEffect=="Screenwide")
			var/mob/A
	//		var/tmp/list/Effected = list()
	//		var/TimeFrozen=125
			for(var/mob/M in oview(19,src))
	//			spawn()
	//				if(M in OnlinePlayers)
	//					Effected+=M
			view(A)<<"[src] places their hands in front of them and the world around them begins to seem...disoriented..?"
			src.MUses+=6
			src.health-=75;src.Bloody();src.Bloody()
			src.stamina-=150
			sleep(7)
			for(var/mob/M in oview(19,src))
				if(M.FrozenBind!="SpaceTimeFrozen")
					M.Running=0;M.FrozenBind="SpaceTimeFrozen";M<<"You've been stopped as if time around you has been frozen."
					spawn()
						M.TimeStop()
/*			view()<<"[A] is frozen by a large unknown force!"
			A<<"Tap Spacebar to resist the change from Space!"
			while((TimeFrozen-A.Struggle)>0)
				A.FrozenBind="SpaceTimeFrozen"
				TimeFrozen-=5
				sleep(6)
			A<<"The space time continuum goes back to it's normal state and you're able to move again!"
			src<<"You're forced to stop altering the space time continuum!"
			src.Frozen=0
			A.FrozenBind=""*/
			return
mob/proc/TimeStop()
	var/TimeFrozen=130
	if(src.FrozenBind=="SpaceTimeFrozen")
		src<<"Tap Spacebar to resist the change from Space!"
		while(src&&src.FrozenBind=="SpaceTimeFrozen"&&(TimeFrozen-src.Struggle)>0)
			src.FrozenBind="SpaceTimeFrozen"
			TimeFrozen-=5
			sleep(6)
	src<<"You broke through the stoppage of time!";src.Struggle=0;src.FrozenBind="";src.Frozen=0
	if(!src.knockedout)
		src.Struggle=0
mob/proc/ChakraA()
	src.MUses++
	src.health-=25
	if(prob(30))
		src.Bloody()
	src.chakra-=250
	src.icon_state="throw";src.firing=1
	for(var/mob/M in oview(6))
		var/loal=rand(1200,2000)
		if(M.name=="Kikaichu"&&!M.client)
			loal=rand(10,20)
			del(M)
			M.chakra-=loal
		if(src.chakra<src.Mchakra*1.5)
			src.chakra+=loal
		if(M.Clone&&!M.client)
			var/obj/SmokeCloud/S=new()
			S.loc = locate(M.x,M.y,M.z)
			M.loc=null
			spawn(100)
				del(M)
		if(M.Kaiten)
			M<<"The chakra for the rotation has been drained?"
			M.Kaiten=0
			M.chakra-=500
	src.firing=0
mob/proc/MSWeapon()
	src.ChakraDrain(25000)
	src.MUses+=3
	src.icon_state="throw"
	src.firing=1;
	var/rounds=15+(round(MUses/200));//Number of rounds fired this number can be changed to smaller if to oped.
	if(rounds>30)
		rounds=30;
	while(rounds>0&&src.icon_state=="throw")
		var/s=3
		while(s>0)
			var/obj/MSKunai/K=new();K.loc=src.loc;K.Owner=src;K.dir=src.dir;K.nin=src.nin;K.Move_Delay=0;
			if(s==3&&K)
				K.icon_state = "Shinweapon";K.loc=get_step(src,turn(src.dir,45))
			if(s==2&&K)
				K.icon_state = "Shinweapon2";K.loc=get_step(src,turn(src.dir,-45))
			walk(K,src.dir);s--;sleep(1)
		rounds--;
		sleep(1);//delay btw rounds //Was originally 3

	src.Frozen=0;src.firing=0;
	src.icon_state="";
obj/MSKunai
	icon='Weapons.dmi'
	icon_state = "Shinweapon"
	density=1
	Move_Delay=0
	var/StunChance=0;
	var/nin=10
	var/Owner
	New()
		..()
		spawn(30)
			del(src)
	Bump(A)
		if(ismob(A))
			var/mob/M = A
			var/mob/O=src.Owner
			var/damage=(rand(30,55)+(src.nin*1.15))//If the user goes pure cap the move will do 100damage.
									   //The +28 insures the move does min of 28 damage.
			if(damage>600)//Caps the damage in case they use a nin buff transformation so move doesn't become oped.
				damage=600;
			var/random=(rand(6,8)/6)//Number changed if want to buff or nerf the damage.
									//The random is to give it that feel of not always hitting the same.
			damage*=random;//Damage multi is done this way because rand can only generate integers so random btw .6 and .8 cant be done.
						  //So rand(6,8)/10 is done instead then multiplied to damage.
			if(M.icon_state=="Block"&&prob(5*M.DeflectionZ))//Chance to block the incoming senbon
				view(M)<<output("<font>You deflect the senbon!</font>","output")
				M.HitBack(1,src.dir)//Push back even though you blocked its still traveling fast enough
				del(src);
				return;
			if(M.Kaiten)
				view(M)<<output("<font>You deflect the weapon!</font>","output")
				del(src);
				return;
			if(src.StunChance==1&&prob(45))
				M.Stun=10;
			M.DamageProc(damage,"Health",O)
			view(M)<<output("<font>[M] was by weapon for ([damage]) damage!</font>","Attack")
			viewers()<<sound('HitStrong.wav',0,0,1)
			M.Bloody();M.Bloody();M.Bloody()
			del(src)
		if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				del(src)
mob/proc/KTele()
	var/blah=input("Options")in list("Person","Cordinates","Cancel")
	switch(blah)
		if("Person")
			var/list/people=new
			for(var/mob/M in world)
				people.Add(M)
			var/mob/whoto=input("Teleport to who?")in people
			usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full")
			sleep(20)
			usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full")
			if(whoto)
				usr.loc=whoto.loc
				usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full2")
				sleep(7)
				usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full2")
				sleep(20)
				src.MUses+=5
		if("Cordinates")
			var/blahx=input("x")as num
			var/blahy=input("y")as num
			var/blahz=input("z")as num
			usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full")
			sleep(20)
			usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full")
			usr.loc=locate(blahx,blahy,blahz)
			usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full2")
			sleep(7)
			usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full2")
			sleep(20)
			src.MUses+=2

mob/proc/KTele2()
//	var/PreviousLoc=src.loc
	if(!src.knockedout&&src.PrevX==null)
		usr.PrevX=usr.x
		usr.PrevY=usr.y
		usr.PrevZ=usr.z
		usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full")
		sleep(20)
		usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full")
	//	W.loc=usr.loc
		src.loc = locate(52, 117, 29)
		usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full2")
		sleep(7)
		usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full2")
		src.MUses+=2
		return
	else
		usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full")
		sleep(20)
		usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full")
		src.x=src.PrevX;src.y=src.PrevY;src.z=src.PrevZ
		usr.overlays+=image('Icons/Jutsus/Kamui_New.dmi',"full2")
		sleep(7)
		usr.overlays-=image('Icons/Jutsus/Kamui_New.dmi',"full2")
		src.PrevX=null;src.PrevY=null;src.PrevZ=null
		return
/*
	var/mob/M
			var/tmp/list/Effected = list()
			var/TimeFrozen=125
			for(var/mob/M in oview(19,src))
				spawn()
					if(M in OnlinePlayers)
						Effected+=M
			view(Effected)<<"[src] places their hands in front of them and the world around them begins to seem...disoriented..?"
			src.MUses+=5
			src.health-=75;src.Bloody();src.Bloody()
			src.stamina-=150
			sleep(15)
			for(var/mob/M in Effected)
				spawn()
					M.FrozenBind="SpaceTimeFrozen"
			view()<<"[M] is frozen by a large unknown force!"
			M<<"Tap Spacebar to resist the change from Space!"
			while((TimeFrozen-M.Struggle)>0)
				M.FrozenBind="SpaceTimeFrozen"
				TimeFrozen-=5
				sleep(6)
			M<<"The space time continuum goes back to it's normal state and you're able to move again!"
			src<<"You're forced to stop altering the space time continuum!"
			M.FrozenBind=""
			return
	if(src.z==29)
		if(src.x>=40&&src.x<=65&&src.y>=120&&src.y<=100)*/