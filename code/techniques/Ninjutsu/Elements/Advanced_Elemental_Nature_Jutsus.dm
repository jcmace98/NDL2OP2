mob/var/tmp




obj/Jutsu/Elemental/Yoton
	icon='Icons/Jutsus/YotonTechniques.dmi'
	Shakugaryugan
		L1
			icon_state="L1"
			density=0
			layer=MOB_LAYER+4

		L2
			icon_state="L2"
			density=0
			layer=MOB_LAYER+4

		L3
			icon_state="L3"
			density=1
			layer=MOB_LAYER+4
			var/nin=10
			New()
				..()
				spawn(100)
					del(src)
//			Move()
//				var/obj/Jutsu/Elemental/Youton/Lava/L=new()
//				L.loc=src.loc;L.Owner=src.Owner
				..()
			Bump(A)
				..()
				if(ismob(A))
					var/mob/M = A
					if(M.Kaiten||M.sphere)
						del(src)
					var/mob/O=src.Owner
					var/damage=round(rand(src.nin*0.23,src.nin*0.52))
					if(M.PaperStyleDance && !M.InHydro)
						M.PaperStyleDance=0
					M.DamageProc(damage*(1/3),"Health",O,"Shakugaryugan","red")
					if(M.PaperStyleDance && !M.InHydro)
						M.PaperStyleDance=0
					if(M.RaiArmor)
						M.overlays-='Icons/Jutsus/RaiArmor.dmi'
						M.RaiArmor=0
					spawn(1)
						M.dir=src.dir;
						M.HitBack(2,src.dir)
					del(src)
				if(istype(A,/turf/))
					var/turf/T = A
					if(T.density)
						del(src)
				if(istype(A,/obj/Jutsu/Elemental/))
					var/obj/Jutsu/Elemental/E=A
					var/mob/O=src.Owner
					var/damage=round(src.nin*pick(0.9,1))
					if(O.ElementalCapacity>1)
						damage=round(src.nin*pick(0.5,0.6))
					if(E.Element=="Mokuton"||E.Element=="Hyouton")
						damage*=2
					E.DamageProc((damage),"Stamina",O)
					del(src)
				else if(istype(A,/obj/))
					del(src)
			Del()
				for(var/turf/T in getcircle(src,3))
					var/obj/Jutsu/Elemental/Youton/Lava/K=new();K.loc=T;K.Owner=src.Owner
				..()
		L4
			icon_state="L4"
			density=1
			layer=MOB_LAYER+4
obj/Jutsu/Elemental/Ranton
	LaserCircus
		icon = 'Icons/Jutsus/Laser_Circus.dmi'
		icon_state="beam"
		density=1
		Move_Delay=-2
		pixel_step_size=16
		var/nin=10
		var/InitialDisplacement="None"
		Move()
			if(src.dir==WEST||src.dir==EAST)
				if(src.InitialDisplacement=="Positive")
					src.pixel_y+=rand(2,4)
					if(src.pixel_y>=16)
						src.pixel_y-=32
						src.loc=get_step(src,NORTH)
					else
						..()
				else if(src.InitialDisplacement=="Negative")
					src.pixel_y-=rand(2,4)
					if(src.pixel_y<=-16)
						src.pixel_y+=32
						src.loc=get_step(src,SOUTH)
					else
						..()
				else
					..()
			else if(src.dir==NORTH||src.dir==SOUTH)
				if(src.InitialDisplacement=="Positive")
					src.pixel_x+=rand(2,4)
					if(src.pixel_x>=16)
						src.pixel_x-=32
						src.loc=get_step(src,EAST)
					else
						..()
				else if(src.InitialDisplacement=="Negative")
					src.pixel_x-=rand(2,4)
					if(src.pixel_x<=-16)
						src.pixel_x+=32
						src.loc=get_step(src,WEST)
					else
						..()
				else
					..()
			else
				..()
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
				var/damage=round((O.nin*3.5)+5)
				if(M.InHydro)
					damage /= 15
					if(prob(40))
						src.loc=null
						return
				M.DamageProc((damage),"Health",O,"Laser","cyan")
				del(src)
			if(istype(A,/turf/))
				del(src)
			if(isobj(A))
				var/obj/O=A
				if(O.type!=src.type)
					del(src)
				else
					walk(src,0)
					src.loc=O.loc
					walk(src,src.dir)
					return
		Del()
//			for(var/turf/T in getcircle(src,2))
//				var/obj/Jutsu/Elemental/Raiton/Electrocute/E=new();E.loc=T;E.nin=src.nin*0.2;E.Owner=src.Owner;E.loc=src.loc
			..()
obj/Jutsu/Elemental/Shakuton
	IncineratngFlare
		icon='Icons/Jutsus/scorch release.dmi'
		icon_state="projectileorb"
		density=1
		var/nin=10
		New(Pwner)
			..()
//			var/mob/O=Pwner
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
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
				var/mob/O=src.Owner
				var/damage=round((O.nin*3.5)+20)
				M.DamageProc((damage*(3/5)),"Stamina",O,"incinerating orb","red")
				if(M&&!M.BoneMembrane)
					M.DamageProc((damage*(2/5)),"Health",O,"incinerating orb","red")
				else if(M)
					M.DamageProc((damage*(1/5)),"Health",O,"incinerating orb","red")
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				if(istype(A,/obj/WEAPONS/Kunai))
					var/obj/WEAPONS/Kunai/D=A
					src.loc=D
				else if(istype(A,/obj/WEAPONS/Shuriken))
					var/obj/WEAPONS/Shuriken/X=A
					src.loc=X
				else if(istype(A,/obj/WEAPONS/Senbon))
					var/obj/WEAPONS/Senbon/Q=A
					src.loc=Q
				else if(istype(A,/obj/Jutsu/Elemental/Katon/Houka))//Just added 6/19 and also added to Houka Object
					var/obj/Jutsu/Elemental/Katon/Houka/B=A
					src.loc=B
				else if(istype(A,/obj/Jutsu/Elemental/Katon/katonG))
					var/obj/Jutsu/Elemental/Katon/O=A
					if(O.Owner==src.Owner)
						return
					else
						del(O);del(src)
				else
					del(src)
		Del()
			if(src.icon=='Icons/Jutsus/BKatonTechniques.dmi') src.nin*=2.5
			var/obj/Jutsu/Elemental/Katon/Goukakyuu/K=new();K.loc=src.loc;K.nin=src.nin/2;K.Owner=src.Owner;..()
obj/Jutsu/Elemental/Ranton
	LaserSpawn
		icon = 'Icons/Jutsus/Laser_Circus.dmi'
		icon_state=""
		layer = MOB_LAYER+1
		New()
			..()
			spawn(25)
				del(src)

	CloudTail
		icon='Icons/Jutsus/black lightning.dmi'
		icon_state="StormCloudExhale"
		layer = MOB_LAYER+1
		New()
			..()
			spawn(34)
				del(src)
	StormCloud
		icon='Icons/Jutsus/black lightning.dmi'
		icon_state="StormCloud"
		layer=MOB_LAYER+2
		var/CloudL="Vit"
		New()
			var/randz=rand(1,4)
			if(randz==1) src.dir=NORTHEAST
			if(randz==2) src.dir=NORTHWEST
			if(randz==3) src.dir=SOUTHEAST
			if(randz==4) src.dir=SOUTHWEST
			..()
			spawn()
				spawn(2)//was spawn(1) 11/16/12
					src.pixel_x+=rand(-16,16)
					src.pixel_y+=rand(-16,16)
					while(src)
						for(var/mob/M in src.loc)
							if(M in OnlinePlayers)
								M.health-=pick(78.5,125.5)
						if(src.dir==NORTHEAST)
							src.pixel_x+=rand(-1,8)
							src.pixel_y+=rand(-1,8)
						if(src.dir==NORTHWEST)
							src.pixel_x+=rand(-8,1)
							src.pixel_y+=rand(-1,8)
						if(src.dir==SOUTHEAST)
							src.pixel_x+=rand(-1,8)
							src.pixel_y+=rand(-8,1)
						if(src.dir==SOUTHWEST)
							src.pixel_x+=rand(-8,1)
							src.pixel_y+=rand(-8,1)
						sleep(6)
						for(var/mob/M in oview(1,src))
					//		if((M.key==usr.key))
					//			return
							if(M.sphere)
								return
							if(M.Kaiten)
								del(src)

			spawn(50)
				del(src)
		Del()
			flick("CloudD",src)
			sleep(2)
			..()
obj/Jutsu/Elemental/Jinton
	BeamStart
		icon_state = "Start"
		layer = MOB_LAYER+1
		New()
			..()
			spawn(50)
				del(src)
	Dtrail
		icon_state = "Beam"
		layer=MOB_LAYER+1
		density = 0
		Move_Delay=0
		var
			nin=10;
		New()
			..()
			spawn()
				var/mob/O=src.Owner
				while(src)
					sleep(1)
					for(var/mob/M in oview(0,src))
						spawn()
							var/damage=src.nin;damage=round(damage*((O.FireChakra+O.EarthChakra+O.WindChakra)*0.2+0.8));var/Chakraz=M.ChakraArmor*0.01
							if((M.InHydro && prob(30)) || !M.InHydro)
								M.RestrictOwnMovement=1
								spawn(5)
									ReturnMovement(M)
							spawn()
								M.DamageProc((damage-(Chakraz*damage)),"Stamina",O,"dust","white")
							spawn()
								if(!M.BoneMembrane&&!M.knockedout)
									spawn()
										M.DamageProc((damage-(Chakraz*damage)/3),"Health",O,"dust","white")
							step(M,src.dir)
			spawn(50) del(src)


		Del()
			for(var/mob/M in src.loc)
				if(M in OnlinePlayers)
					if(M.RestrictOwnMovement)
						ReturnMovement(M)
			..()
	DetachmentPillar
		icon='Icons/Jutsus/Jinton_Techniques.dmi'
		icon_state="Head"
		density=0
		layer=OBJ_LAYER+3
		Move_Delay=0
		pixel_step_size=16
		var
			nin=10;firststep=0
		New(Pwner)
			..()
		//	var/mob/O=Pwner

		Move()
			var/obj/Jutsu/Elemental/Jinton/Dtrail/T=new();T.icon = src.icon;T.loc = src.loc;T.dir = src.dir;T.Owner = src.Owner
			..()

		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
			//	var/obj/Jutsu/Elemental/Katon/Goukakyuu/K=new();K.loc=src.loc;K.nin=src.nin;K.Owner=src.Owner;src.loc=M.loc
				var/damage=round(src.nin*5.5);damage=round(damage*((O.FireChakra+O.EarthChakra+O.WindChakra)*0.2+0.8));var/Chakraz=M.ChakraArmor*0.01
				M.DamageProc((damage-(Chakraz*damage)),"Stamina",O,"dust","white")
				if(!M.BoneMembrane&&!M.knockedout)
					M.DamageProc((damage-(Chakraz*damage)/3),"Health",O,"dust","white")
				M.Ghit=5;M.GHitDrain();M.Death(O)

				if(M.InHydro)
					src.loc=null
					return

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/Jutsu/Elemental/))
				var/obj/Jutsu/Elemental/E=A
				var/mob/O=src.Owner
				var/damage=round(src.nin*pick(0.9,1));damage=round(damage*(O.FireChakra*0.2+0.8))
				if(O.Trait=="Old Powerful") damage+=(O.NinSkill)
				if(E.Element=="Mokuton"||E.Element=="Hyouton")
					damage*=2
				E.DamageProc((damage),"Stamina",O)
				del(src)



obj/Jutsu/Elemental/Futton
	Mist
		icon='Icons/Jutsus/FuttonTechniques.dmi'
		icon_state="SmokeR"
		layer=MOB_LAYER+2
		var/CloudL="Vit"
		New()
			flick("SmokeA",src)
			var/randz=rand(1,4)
			if(randz==1) src.dir=NORTHEAST
			if(randz==2) src.dir=NORTHWEST
			if(randz==3) src.dir=SOUTHEAST
			if(randz==4) src.dir=SOUTHWEST
			..()
			spawn()
				spawn(2)//was spawn(1) 11/16/12
					src.pixel_x+=rand(-16,16)
					src.pixel_y+=rand(-16,16)
					while(src)
						for(var/mob/M in src.loc)
							if(M in OnlinePlayers)
								M.health-=pick(115.5,175.5)
						if(src.dir==NORTHEAST)
							src.pixel_x+=rand(-1,8)
							src.pixel_y+=rand(-1,8)
						if(src.dir==NORTHWEST)
							src.pixel_x+=rand(-8,1)
							src.pixel_y+=rand(-1,8)
						if(src.dir==SOUTHEAST)
							src.pixel_x+=rand(-1,8)
							src.pixel_y+=rand(-8,1)
						if(src.dir==SOUTHWEST)
							src.pixel_x+=rand(-8,1)
							src.pixel_y+=rand(-8,1)
						sleep(6)
						for(var/mob/M in oview(1,src))
					//		if((M.key==usr.key))
					//			return
							if(M.sphere)
								return
							if(M.Kaiten)
								del(src)

			spawn(100)
				del(src)
		Del()
			flick("SmokeD",src)
			sleep(2)
			..()
	MistTail
		icon='Icons/Jutsus/FuttonTechniques.dmi'
		icon_state="SteamExhale"
		layer = MOB_LAYER+1
		New()
			..()
			spawn(34)
				del(src)
////////////////////////
//Yoton
///////////////////////
mob/proc/Lavaball(Uses)
	src.ChakraDrain(20000)

	src.Handseals(38-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.Shibari) return
	src.icon_state="handseal"
	spawn(6)
		src.icon_state=""

	var/Check=Uses
	var/Amount=round(Check/300)+1
	if(Amount<1)
		Amount=1
	else if(Amount>4)
		Amount=4
	while(Amount>0)
		var/obj/Jutsu/Elemental/Yoton/Shakugaryugan/L3/G=new();
		G.Owner=src;
		G.nin=src.nin*50
		var/obj/Jutsu/Elemental/Yoton/Shakugaryugan/L1/G1=new();
		var/obj/Jutsu/Elemental/Yoton/Shakugaryugan/L2/G2=new();
		var/obj/Jutsu/Elemental/Yoton/Shakugaryugan/L4/G4=new();
		if(src.dir==SOUTH)
			G.pixel_x=-16;G4.pixel_x=32;G1.pixel_y=32;G2.pixel_x=32;G2.pixel_y=32
		if(src.dir==NORTH)
			G.pixel_x=-16;G4.pixel_x=32;G1.pixel_y=32;G2.pixel_x=32;G2.pixel_y=32
		if(src.dir==EAST||src.dir==NORTHEAST||src.dir==SOUTHEAST)
			G.pixel_x=-16;G.pixel_y=-16;G4.pixel_x=32
			G1.pixel_y=32;G2.pixel_x=32;G2.pixel_y=32
		if(src.dir==WEST||src.dir==NORTHWEST||src.dir==SOUTHWEST)
			G.pixel_x=-16;G.pixel_y=-16;G4.pixel_x=32
			G1.pixel_y=32;G2.pixel_x=32;G2.pixel_y=32
		G.overlays+=G1;G.overlays+=G2;G.overlays+=G4
		if(Amount==4||Amount==1) G.loc=usr.loc
		else if(Amount==3) G.loc=get_step(src,turn(src.dir,45))
		else if(Amount==2) G.loc=get_step(src,turn(src.dir,-45))
		G.dir=usr.dir;
		G.Move_Delay=0
		if(G.Move_Delay<=0)
			G.Move_Delay=0
		walk(G,G.dir);
		Amount--;
		sleep(2)
////////////////////////
//Ranton
////////////////////////
mob/proc/LaserCircus()
	src.ChakraDrain(35000)
	src.Handseals(35-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.Shibari) return
	var/obj/Jutsu/Elemental/Ranton/LaserSpawn/T=new();T.loc=usr.loc;T.dir=usr.dir
	src.icon_state="throw";src.Frozen=1
	var/random=rand(14,18)
	while(random>0)
		spawn()
			var/obj/Jutsu/Elemental/Ranton/LaserCircus/F=new(Pwner=src);F.loc=src.loc;F.nin=src.nin;F.Owner=src;F.dir=src.dir
			F.pixel_x=rand(-12,12);F.pixel_y=rand(-12,12)
			if(F.dir==WEST||F.dir==EAST)
				if(F.pixel_y>4){F.InitialDisplacement="Positive"}
				else if(F.pixel_y<-4){F.InitialDisplacement="Negative"}
			if(F.dir==NORTH||F.dir==SOUTH)
				if(F.pixel_x>4){F.InitialDisplacement="Positive"}
				else if(F.pixel_x<-4){F.InitialDisplacement="Negative"}
			walk(F,F.dir)
			F.JutsuLevel=((src.RaitonKnowledge)+(src.SuitonKnowledge)/2)
		random--
		sleep(1)
	src.Frozen=0
	src.icon_state=""

mob/proc/ThunderCloudWave()
	if(src.Frozen||src.firing)
		return
	var/X=src.x
	var/Y=src.y
	var/Z=src.z
	var/G=1
	var/H=0
	var/HC=0
	var/GC=6
	GC=8
	src.firing=1;
	src.Frozen=1
	if(src.dir==NORTH)
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Ranton/StormCloud/A=new();A.loc=locate(X+H,Y+G,Z);
				H++
			sleep(2)
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
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Ranton/StormCloud/A=new();A.loc=locate(X-H,Y-G,Z);
				H++
			sleep(2)
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
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Ranton/StormCloud/A=new();A.loc=locate(X-G,Y-H,Z);
				H++
			sleep(2)
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
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Ranton/StormCloud/A=new();A.loc=locate(X+G,Y+H,Z);
				H++
			sleep(2)
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
	src.firing=0;
	src.Frozen=0
/////////////////////////
//Futton
////////////////////////
mob/proc/SkilledMist()
	if(src.Frozen||src.firing||src.Shibari)
		return
	var/X=src.x
	var/Y=src.y
	var/Z=src.z
	var/G=1
	var/H=0
	var/HC=0
	var/GC=6//Max length of the poison gas
	GC=8
	src.firing=1;
	src.Frozen=1
	var/obj/Jutsu/Elemental/Futton/MistTail/Q=new();Q.layer=MOB_LAYER+1
	if(src.dir==SOUTH)
		Q.pixel_y = 16
	if(src.dir==NORTH)
		Q.pixel_y=-16;Q.layer=MOB_LAYER-1
	if(src.dir==WEST)
		Q.pixel_x=8
	if(src.dir==EAST)
		Q.pixel_x = -8
	Q.loc=src.loc;step(Q,src.dir)
	if(src.dir==NORTH)
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Futton/Mist/A=new();A.loc=locate(X+H,Y+G,Z);
				H++
			sleep(2)
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
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Futton/Mist/A=new();A.loc=locate(X-H,Y-G,Z);
				H++
			sleep(2)
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
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Futton/Mist/A=new();A.loc=locate(X-G,Y-H,Z);
				H++
			sleep(2)
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
		while(G<=GC)
			while(H<=HC)
				var/obj/Jutsu/Elemental/Futton/Mist/A=new();A.loc=locate(X+G,Y+H,Z);
				H++
			sleep(2)
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
	src.firing=0;
	src.Frozen=0
////////////////////////////
//Shakuton
///////////////////////////
mob/var/tmp
	IFlareShots=0
mob/proc/IncineratingFlare(Uses)
	src.ChakraDrain(10500)
	src.Handseals(30-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.Shibari) return
	var/i=1;var/DamageNumber=src.nin*4
	if(src.HousenkaExpert==1){i=2;DamageNumber*=1.1}
	if(src.HousenkaExpert==2){i=3;DamageNumber*=1.25}
	usr.IFlareShots=i
	usr<<"Press Z to shoot your fireballs. You have 10 seconds, and [src.IFlareShots] shots."
	spawn(100)
		if(usr.IFlareShots>0)
			usr<<"You ran out of time and lost your built up chakra for your fireball shots."
			usr.IFlareShots=0
			overlays-='Icons/Jutsus/scorch release.dmi'
mob/proc/FlareShoot()
	if(src.IFlareShots>0)
		overlays+='Icons/Jutsus/scorch release.dmi'
		src.IFlareShots--
		var/i=3;var/DamageNumber=src.nin
		if(src.HousenkaExpert==1){DamageNumber*=1.1}
		if(src.HousenkaExpert==2){DamageNumber*=1.25}
		while(i>0)
			var/obj/Jutsu/Elemental/Shakuton/IncineratngFlare/F=new(Pwner=src);F.loc=src.loc;F.Owner=src;F.dir=src.dir;F.nin=DamageNumber
			if(i==3&&F)
				F.loc=get_step(src,turn(src.dir,45))
			if(i==2&&F)
				F.loc=get_step(src,turn(src.dir,-45))
			walk(F,src.dir);F.JutsuLevel=src.KatonKnowledge;i--;sleep(1)
		overlays-='Icons/Jutsus/scorch release.dmi'
		sleep(6)
	else
		return
////////////////////////////
//Jinton
///////////////////////////
mob/proc/DustPillar()
	src.ChakraDrain(75000)
	src.Handseals(45-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.Shibari) return
	src.doingG=1;src.Frozen=1;src.firing=1;spawn(30)
		src.firing=0;src.doingG=0;src.Frozen=0
	var/obj/Jutsu/Elemental/Jinton/DetachmentPillar/A=new(Pwner=src);
	var/obj/Jutsu/Elemental/Jinton/BeamStart/J=new();
	if(src.dir==SOUTH)
		A.Owner=src;A.loc=locate(src.x,src.y-1,src.z);A.nin=src.nin*1.3;A.dir=src.dir;A.Move_Delay=0;walk(A,src.dir);J.loc=locate(src.x-1,src.y,src.z)
	if(src.dir==NORTH)
		A.Owner=src;A.loc=locate(src.x,src.y+1,usr.z);A.nin=src.nin*1.3;A.dir=src.dir;A.Move_Delay=0;walk(A,src.dir);J.loc=locate(src.x+1,src.y,usr.z)
	if(src.dir==EAST)
		A.Owner=src;A.loc=locate(src.x+1,src.y,src.z);A.nin=src.nin*1.3;A.dir=src.dir;A.Move_Delay=0;walk(A,src.dir);J.loc=locate(src.x,src.y+1,src.z)
	if(src.dir==WEST)
		A.Owner=src;A.loc=locate(src.x-1,src.y,src.z);A.nin=src.nin*1.3;A.dir=src.dir;A.Move_Delay=0;walk(A,src.dir);J.loc=locate(src.x,src.y-1,src.z)
