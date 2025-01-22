mob/proc/DoIHavePaper()
	var/HavePaper=0
	for(var/obj/RandomEquipment/Paper/A in src.contents)
		HavePaper=1;A.Ammount-=1;A.ReCheckAmount()
	if(!HavePaper)
		src<<"You've ran out of paper."
		src.PaperStyleDance=0


mob/var/tmp/PaperStyleDance=0
obj/Jutsu/Paper
	icon='Icons/Jutsus/PaperObjects.dmi'
	JutsuLevel=1
	density=1

	Butterfly_Dance
		density=0
		layer=MOB_LAYER+1
		icon_state="butterflydance"
	Butterflies
		density=0
		layer=MOB_LAYER+1
		icon_state="butterfly"
		var/FirstSpawned
		New()
			..()
			spawn()
				while(src)
					if(src.FirstSpawned)
						step_rand(src)
						sleep(rand(2,4))
					else
						step_rand(src)
						for(var/mob/M in view(3,src))
							if(M.client)
								M<<"There is a [M.Village] ninja at [M.x],[M.y]."
						sleep(100)
			spawn(200)
				del(src)
	Person_Explosive
		density=0
		layer=MOB_LAYER+1
		icon_state="Person1"
		New()
			if(prob(50))
				icon_state="Person2"
			..()
			spawn()
				if(prob(40))
					icon_state="Person2"
			spawn(rand(200,350))
				del(src)
		DblClick()
			if(src.Owner==usr&&usr.Charging&&usr.PaperStyleDance)
				usr.chakra-=115
				src.Explode()
		proc
			Explode()
				var/obj/Jutsu/Explosion/K=new()
				K.loc=src.loc
				K.Owner=src.Owner
				for(var/obj/Jutsu/Paper/Person_Explosive/P in oview(1,src))
					if(prob(25))
						P.Explode()
				del(src)


	OffenciveButterflies
		density=0
		layer=MOB_LAYER+1
		icon_state="butterfly"
		var/FirstSpawned
		New()
			..()
			spawn()
				while(src)
					for(var/mob/A in view(2,src))
						if(A.client&&A!=src.Owner)
							A.DamageProc(5,"Health",src.Owner)
					if(src.FirstSpawned)
						step_rand(src)
						sleep(rand(3,4))
					else
						step_rand(src)
						for(var/mob/M in view(3,src))
							if(M.client&&M!=src.Owner)
								M.DamageProc(10,"Health",src.Owner)
						sleep(15)
			spawn(200)
				del(src)
	Shuriken
		icon_state="shuriken"
		var/Rating=1
		New()
			..()
			spawn(25)
				del(src)
		Bump(A)
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					del(src)
				Rating=round(Rating/5)
				if(Rating<1) Rating=1
				if(Rating>3) Rating=3
				Rating=Rating*0.1
				var/damage=round(M.maxhealth*Rating/2)
				M.DamageProc(damage,"Health",O)
				if(damage>0)
					spawn() M.Bloody();M.Bloody();M.Bloody()
					view(M)<<output("<font color=#BB0000 size=2>[M] was penetrated by the paper attack!([damage])</font>","Attack")
				del(src)
	Spear
		icon_state="Spearthrow"
		New()
			..()
			flick("Spearthrowform",src)
			spawn(5)
				walk(src,src.dir)
		Bump(A)
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					del(src)
				var/damage=round(M.maxhealth*0.2,M.maxhealth*0.25)
				M.DamageProc(damage,"Health",O)
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

mob/proc/PaperStyleDance(Uses)
	if(src.PaperStyleDance!=0)
		src<<"You exit the stance."
		src.PaperStyleDance=0
		for(var/obj/SkillCards/Paper_Mode/P in src.LearnedJutsus)
			if(!P.Delay)
				P.DelayIt(300,usr)
		return
	var/A=round(Uses/100)
	if(A<1)
		A=1
	src<<"You enter the Paper Controlling Stance!"
	src<<"Guarding how now become a paper fading tactic."
	src.PaperStyleDance=A
	if(A>5)
		src<<"You have progressed so far in controlling Paper that you don't even have to guard, it'll just take paper from you and you'll avoid any hit."
	while(src.PaperStyleDance)
		src.chakra-=30
		src.DoIHavePaper()
		if(src.knockedout)
			src.PaperStyleDance=0
		sleep(100)
	src<<"You exit the stance."
/*Paper Shuriken:
Projectile Shuriken, increases in damage and quantity with use.
*/
mob/proc/Paper_Shuriken(Uses)
	if(!src.PaperStyleDance)
		src<<"You need to be in Paper Style Dance!";return
	src.ChakraDrain(10000)
	src.Handseals(5-src.HandsealSpeed)
	if(src.HandsSlipped) return
	var/obj/Jutsu/Paper/Shuriken/C=new()
	spawn(2)
		C.loc=src.loc;C.dir=src.dir;C.Owner=src;walk(C,C.dir);C.Rating=Uses
		if(Uses>100)
			var/obj/Jutsu/Paper/Shuriken/A=new();A.loc=src.loc;A.dir=src.dir;A.Owner=src;A.Rating=Uses;A.dir=turn(A.dir,45);step(A,A.dir);A.dir=src.dir;walk(A,A.dir);var/obj/Jutsu/Paper/Shuriken/B=new();B.loc=src.loc;B.dir=src.dir;B.Owner=src;B.Rating=Uses;B.dir=turn(B.dir,45);step(B,B.dir);B.dir=src.dir;walk(B,B.dir)
			if(Uses>500)
				var/obj/Jutsu/Paper/Shuriken/D=new();D.loc=src.loc;D.dir=src.dir;D.Owner=src;D.Rating=Uses;D.dir=turn(D.dir,45);step(D,D.dir);walk(D,D.dir);var/obj/Jutsu/Paper/Shuriken/E=new();E.loc=src.loc;E.dir=src.dir;E.Owner=src;E.Rating=Uses;E.dir=turn(E.dir,45);step(E,E.dir);walk(E,E.dir)
	flick("Attack1",src)

/*Paper Butterflies:
Releases Butterflies that reveal the locations of outside people.
*/
mob/proc/Paper_Butterflies(Uses)
	if(!src.PaperStyleDance)
		src<<"You need to be in Paper Style Dance!";return
	src.ChakraDrain(10000)
	src.Handseals(5-src.HandsealSpeed)
	if(src.HandsSlipped) return
	src.icon_state="handseal"
	src<<"Stop the handseal to withdraw the butterflies!"
//	spawn()
	var/AmountOfPaperButterflies=(Uses/10+1)
	if(Uses<1)
		Uses=1
	if(AmountOfPaperButterflies>50)
		AmountOfPaperButterflies=50
	while(AmountOfPaperButterflies>0)
		sleep(1)
		if(src.icon_state!="handseal"||!src.PaperStyleDance)
			AmountOfPaperButterflies=0
	//	var/obj/Jutsu/Paper/Butterflies/C=new();
		var/obj/Jutsu/Paper/OffenciveButterflies/C=new();
		C.Owner=src
		C.loc=src.loc //I indented one over from here
		C.FirstSpawned=1;
		spawn(15)//was 15
			C.FirstSpawned=0
		AmountOfPaperButterflies-=1
	while(src.icon_state=="handseal")
		src.ChakraDrain(3500)
		sleep(10)
	spawn(30)
		for(var/obj/Jutsu/Paper/Butterflies/A in world)
			if(A.Owner==src)
				del(A) //to here
		for(var/obj/Jutsu/Paper/Butterflies/A in world)
			if(A.Owner==src)
				del(A) //to here
/*Butterfly Dance:
A butterfly circles an opponent making it so that they're always targetted.
*/
mob/var/tmp/ButterflyDance=0
mob/proc/Butterfly_Dance()
	src.Target()
	if(src.ntarget)
		return
	src.ChakraDrain(10000)
	src.Handseals(5-src.HandsealSpeed)
	if(src.HandsSlipped) return
	var/mob/M=src.target
	src<<"Butterflies gather around [M]!";M<<"Butterflies forms around you!"
	M.overlays-='Icons/Jutsus/PaperObjects2.dmi';M.overlays+='Icons/Jutsus/PaperObjects2.dmi';M.ButterflyDance=1
	spawn(600)
		if(M)
			src<<"The Butterfly fades.";M<<"The Butterfly fades."
			M.overlays-='Icons/Jutsus/PaperObjects2.dmi';M.ButterflyDance=0
/*Butterfly Destruction:
Creates a mass torrent of butterflies that the user can double click to destroy.
*/
mob/proc/Person_Explosion(Uses)

	var/BonusSize=(Uses/200)
	if(BonusSize>=5)
		BonusSize=5
	src.ChakraDrain(30000)
	src.Handseals(40-src.HandsealSpeed)
	if(src.HandsSlipped) return
	for(var/turf/T in view(5+BonusSize))//was Originally 30
		if(prob(45))
			var/obj/Jutsu/Paper/Person_Explosive/S=new()
			S.Owner=src
			S.loc=T

	view()<<"[src] creates a torrent of paper high in the sky!"
	src<<"Hold down Z and Double Click on a sheet of paper to Explode it!"
/*Divine Spear:
Shhots a hella powerful spear forward that will...destroy the enemy, kay lol.
*/
mob/proc/Divine_Spear()
	if(!src.PaperStyleDance)
		src<<"You must be in Paper Style Dance!";return
	src.ChakraDrain(50000)
	src.Handseals(5-src.HandsealSpeed)
	if(src.HandsSlipped) return
	var/obj/Jutsu/Paper/Spear/A=new();A.dir=src.dir;A.loc=src.loc;step(A,A.dir);A.Owner=src
	src.icon_state="handseal";src.Frozen=1;src.firing=1
	spawn(5)
		src.icon_state="";src.Frozen=0;src.firing=0