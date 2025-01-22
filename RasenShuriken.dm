


obj/Jutsu/
	Rasenshuriken
		icon = 'New Icons(Con4)/Rasen-Shuriken(NEW).dmi'
		icon_state = "thrown"
		density=1
		Move_Delay=0
		var/nin
		var/Rhit=0
		Owner
		New()
			src.pixel_x = rand(-4,4);src.pixel_y = rand(-4,4)


			..()

		Bump(A)
			..()
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
				if(M.Kaiten)
					return
				var/damage=O.RasenganD
				if(damage>2000)
					damage=2000 //Don't want it doing a WTF amount of damage, but it should do a significant amount.
				spawn()
					M.Bloody();M.Bloody();M.Bloody();M.Bloody()
				M.DamageProc(damage,"Health",O)
				view(M) <<"<i><font color=blue size = 2>[M] took [damage] damage from the RasenShuriken!</font></i>"
			//	M.deathcount++
			//	M.deathcount++
				M.Death(O)
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
			var/obj/Jutsu/RSImpact/Z = new();Z.loc=src.loc;Z.Owner=src.Owner
			..()


// ================

mob/proc/ThrowRasenShuriken()
	if(src.AFK) return
	viewers()<<sound('SFX/Throw.wav',0,0,1,25)
	var/obj/Jutsu/Rasenshuriken/L=new();L.loc=src.loc;L.dir=src.dir;L.Move_Delay=0
	L.Owner=src;walk(L,src.dir,L.Move_Delay)
	L.icon='New Icons(Con4)/Rasen-Shuriken(NEW).dmi'


//==================

/*	WindTrail
		//icon='lava.dmi'
		icon_state="torrential"
		var/Life=10

		Ignitable=0;
		New()
			..()
			spawn()
				while(src)
					sleep(6)
					for(var/mob/M in src.loc)//oview(0,src))
						if(M.client&&M!=src.Owner&&!M.knockedout)
						//	spawn()
						//		M.DamageProc(rand(30,40),"Stamina",src.Owner)
							M.DamageProc(rand(45,60),"Stamina",src.Owner,"wind trail","grey")
					for(var/obj/Jutsu/Elemental/Raiton/Z in src.loc)
						if(Z.JutsuLevel>(src.JutsuLevel*3))
							BaseChance=8.33
						else if(Z.JutsuLevel>(src.JutsuLevel*2))
							BaseChance=18.33
						else if(Z.JutsuLevel>src.JutsuLevel)
							BaseChance=21.667
						if(prob(BaseChance))
							del(Z)
				//		else
				//			del(src)
			spawn(3)
				spawn(Life)
					del(src)*/

obj/Jutsu/
	RSImpact
		icon = 'Icons/Jutsus/HitImpact.dmi'
		icon_state="explode1,1"
		layer=MOB_LAYER+1
		density=0
		var/nin=10
		var/Life=10
		var/Ignitable=0;
		New()
			..()
			src.overlays+=/obj/Jutsu/RSImpact/Part1;src.overlays+=/obj/Jutsu/RSImpact/Part2;src.overlays+=/obj/Jutsu/RSImpact/Part3;src.overlays+=/obj/Jutsu/RSImpact/Part4;src.overlays+=/obj/Jutsu/RSImpact/Part5;
			src.overlays+=/obj/Jutsu/RSImpact/Part6;src.overlays+=/obj/Jutsu/RSImpact/Part7;src.overlays+=/obj/Jutsu/RSImpact/Part8;src.overlays+=/obj/Jutsu/RSImpact/Part9
			spawn()
				while(src)
					sleep(3)
					var/mob/O = src.Owner
					for(var/obj/Doors/D in oview(1,src))
						D.DamageProc(src.nin*2,"Health",O)
						sleep(1)
					for(var/mob/M in getcircle(src,2))
						if(M.Mogu)
							return
						var/damage=round(rand(src.nin/4,src.nin/1.5))*((O.WindChakra*0.6)+0.8)
						spawn()
							M.DamageProc(damage,"Health",O,"intense winds","grey")

			spawn(40)
			//	src.Owner=null;src.loc=null;
				del(src)//just added the del(src)


		Part1
			icon_state="explode0,0"
			pixel_x = -32
			pixel_y = -32
		Part2
			icon_state="explode1,0"
			pixel_y = -32
		Part3
			icon_state="explode2,0"
			pixel_x = 32
			pixel_y = -32
		Part4
			icon_state="explode0,1"
			pixel_x = -32
		Part5
			icon_state="explode1,1"
		Part6
			icon_state="explode2,1"
			pixel_x = 32
		Part7
			icon_state="explode0,2"
			pixel_x = -32
			pixel_y = 32
		Part8
			icon_state="explode1,2"
			pixel_y = 32
		Part9
			icon_state="explode2,2"
			pixel_x = 32
			pixel_y = 32



/*obj/Jutsu/
	RSImpact
		icon = 'Icons/Jutsus/HitImpact.dmi'
		icon_state="explode1,1"
		density=0
		var/nin
		Owner
		New()
			..()
			src.overlays+=/obj/Jutsu/RSImpact/Part1;src.overlays+=/obj/Jutsu/RSImpact/Part2;src.overlays+=/obj/Jutsu/RSImpact/Part3;src.overlays+=/obj/Jutsu/RSImpact/Part4;src.overlays+=/obj/Jutsu/RSImpact/Part5;
			src.overlays+=/obj/Jutsu/RSImpact/Part6;src.overlays+=/obj/Jutsu/RSImpact/Part7;src.overlays+=/obj/Jutsu/RSImpact/Part8;src.overlays+=/obj/Jutsu/RSImpact/Part9
			spawn(60)
				while(src)
					sleep(6)
					for(var/mob/M in src.loc)//oview(0,src))
						if(M.client&&M!=src.Owner&&!M.knockedout)
							M.DamageProc(rand(45,60),"Health",src.Owner,"intense winds","blue")

				del(src)*/
