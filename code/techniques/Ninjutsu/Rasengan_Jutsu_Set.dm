mob/var/tmp
	Rasenganon=0
	RasenganCharge=0
	RasenganD=0
	RasenganType=0
	DRasenganon=0
	DRasenganCounter=0
/*Rasengan:
Chargeable move designed to destroy an opponent from spiraling damage.
*/


mob/proc/SpirallingSpheres()
	if(src.Rasenganon==1)
		src.ChakraDrain(40000)
		src<<"You utilize your Sage Mode Chakra and place some of it into your Rasengan, strengthening it!"
		src.SageModeTime-=pick(20,25,35)
		src.RasenganD*=(pick(1.5,2,2.5))
	else
		src<<"You Need Rasengan on in order to use this!"
mob/proc/Rasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Rasengan!";src.RasenganCharge=1;src.Rasenganon=1;src.RasenganType=0
		var/A='Icons/Jutsus/Rasengan2.dmi';src.overlays-=A;src.overlays+=A;flick("Power",A)
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',5,50)
			if(!src.RasenganCharge)
			//	src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
					if(src.DRasenganCounter>0)
						src.DRasenganCounter=0;src.overlays-='Icons/Jutsus/Rasengan4.dmi'
					src.overlays-='Icons/Jutsus/Rasengan2.dmi';src<<"Your Rasengan ran out of energy!";src.Rasenganon=0
			sleep(8)
mob/proc/DoubleRasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing)
		return
	else
		if(src.Rasenganon&&!src.RasenganCharge)
			var/A='Icons/Jutsus/KatonRasengan.dmi'
			var/D='Icons/Jutsus/FuutonRasengan.dmi'
			src.overlays-='Icons/Jutsus/Rasengan5.dmi'
			src.overlays-='Icons/Jutsus/Rasengan6.dmi'
			var/B='Icons/Jutsus/Rasengan2.dmi'
			var/C='Icons/Jutsus/OdamaRasengan.dmi'
			var/E='Icons/Jutsus/Rasengan4.dmi'
			src.overlays-=B
			src.overlays+=B
			src.overlays-=A
			src.overlays-=D
			src.overlays-=C
			src.overlays+=E
			src<<"You add another Rasengan to your other hand!"
			src.DRasenganCounter=2
			src.SoundEngine('SFX/RasCharge.wav',7,75)
			src.RasenganType=50
			src.RasenganD=(src.RasenganD/1.25)//src.RasenganD*2
/*Giant Rasengan:
Increases the size of the current Rasengan causing it to do massive damage.
*/
mob/proc/Giant_Rasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing)
		return
	else
		if(src.Rasenganon&&!src.RasenganCharge)
			src.ChakraDrain(75000)
			var/A='Icons/Jutsus/KatonRasengan.dmi'
			var/D='Icons/Jutsus/FuutonRasengan.dmi'
			src.overlays-='Icons/Jutsus/Rasengan5.dmi'
			var/B='Icons/Jutsus/Rasengan2.dmi'
			var/C='Icons/Jutsus/OdamaRasengan.dmi'
			var/E='Icons/Jutsus/Rasengan4.dmi'
			src.overlays-=B
			src.overlays-=A
			src.overlays-=D
			src.overlays-=E
			src.overlays+=C
			src<<"The size of your Rasengan doubles in size!"
			src.SoundEngine('SFX/RasCharge.wav',7,75)
			src.RasenganType+=0.5
			src.RasenganD=src.RasenganD*2

/*Planetary Rasengan:
KCM based version.(Giant Rasengan Variant)
*/
mob/proc/Planetary_Rasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Planetary Rasengan!";src.RasenganCharge=1;src.RasenganType=400;src.Rasenganon=1;
		src.overlays+='New Icons(Con4)/PlanetaryRasengan(NEW).dmi'
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',100)
			if(!src.RasenganCharge)
//				src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
					src.overlays-='New Icons(Con4)/PlanetaryRasengan(NEW).dmi';
					src<<"Your Planetary Rasengan ran out of energy!";
					src.Rasenganon=0
			sleep(8)
/*	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Planetary Rasengan!";src.RasenganCharge=1;src.Rasenganon=1;src.RasenganType=400
		var/A='New Icons(Con4)/PlanetaryRasengan(NEW).dmi';src.overlays-=A;src.overlays+=A;flick("Power",A)
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',5,50)
			if(!src.RasenganCharge)
			//	src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
					if(src.DRasenganCounter>0)
						src.DRasenganCounter=0;src.overlays-='Icons/Jutsus/Rasengan4.dmi'
					src.overlays-='New Icons(Con4)/PlanetaryRasengan(NEW).dmi';src<<"Your Rasengan ran out of energy!";src.Rasenganon=0
			sleep(8)
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing)
		return
	else
		if(src.Rasenganon&&!src.RasenganCharge)
			src.ChakraDrain(75000)
			var/A='Icons/Jutsus/KatonRasengan.dmi'
			var/D='Icons/Jutsus/FuutonRasengan.dmi'
			src.overlays-='Icons/Jutsus/Rasengan5.dmi'
			var/B='Icons/Jutsus/Rasengan2.dmi'
			var/F='Icons/Jutsus/OdamaRasengan.dmi'
			var/C='New Icons(Con4)/PlanetaryRasengan(NEW).dmi'
			var/E='Icons/Jutsus/Rasengan4.dmi'
			src.overlays-=B
			src.overlays-=A
			src.overlays-=D
			src.overlays-=F
			src.overlays-=E
			src.overlays+=C
			src<<"Your Rasengan's size grows and creates it's own gravitational pull"
			src<<"You add smaller Rasengans spinning invertly to the gravitational pull of your original"
			src.SoundEngine('SFX/RasCharge.wav',7,75)
			src.RasenganType+=400
			src.RasenganD=src.RasenganD*3.6*/


/*Rasenshuriken:
Shuriken based version.
*/
mob/proc/Rasenshuriken()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing)
		return
	else
		if(src.Rasenganon&&!src.RasenganCharge)
			src.ChakraDrain(5000)
			var/A='Icons/Jutsus/KatonRasengan.dmi'
			var/D='Icons/Jutsus/FuutonRasengan.dmi'
			src.overlays-='Icons/Jutsus/Rasengan5.dmi'
			var/B='Icons/Jutsus/Rasengan2.dmi'
			var/C='New Icons(Con4)/Rasen-Shuriken(NEW).dmi'
			var/E='Icons/Jutsus/Rasengan4.dmi'
			src.overlays-=B
			src.overlays-=A
			src.overlays-=D
			src.overlays-=E
			src.overlays+=C
			src<<"You add your wind Chakra Nature and begin forming your Rasengan into a Shuriken"
			src.SoundEngine('SFX/RasCharge.wav',7,75)
			src.RasenganType+=300
			src.RasenganD=src.RasenganD*4

/*Fire Rasengan:
Fire based version.
*/
mob/proc/KRasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Rasengan!";src.RasenganCharge=1;src.RasenganType=100;src.Rasenganon=1;
	//	var/A='Icons/Jutsus/KatonRasengan.dmi';
	//	src.overlays-=A;
	//	src.overlays+=A;
	//	flick("Power",A)
		src.overlays-='Icons/Jutsus/Rasengan6.dmi'
		src.overlays+='Icons/Jutsus/Rasengan6.dmi'
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',100)
			if(!src.RasenganCharge)
//				src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
					src.overlays-='Icons/Jutsus/KatonRasengan.dmi';
					src.overlays-='Icons/Jutsus/Rasengan6.dmi'
					src<<"Your Rasengan ran out of energy!";
					src.Rasenganon=0
			sleep(8)
/*
/*Wind Rasengan:
Wind based version.
*/
*/
mob/proc/WRasengan()
	if(src.intank|src.Kaiten|src.sphere|src.inso|src.firing|src.Rasenganon)
		return
	else
		src<<"Hold down Z to charge your Rasengan!";src.RasenganCharge=1;src.RasenganType=200;src.Rasenganon=1;var/A='Icons/Jutsus/Rasengan5.dmi';src.overlays-=A;src.overlays+=A;flick("Power",A)
		while(src.Rasenganon)
			src.SoundEngine('SFX/RasCharge.wav',50)
			if(!src.RasenganCharge)
			//	src.RasenganD-=10
				src.RasenganD-=20
				for(var/obj/Jutsu/Kiriame/S2 in src.loc)
					src.RasenganD=0
				if(src.RasenganD<=0)
				//	src.overlays-='Icons/Jutsus/FuutonRasengan.dmi';
					src.overlays-='Icons/Jutsus/Rasengan5.dmi'
					src<<"Your Rasengan ran out of energy!";
					src.Rasenganon=0
			sleep(8)
