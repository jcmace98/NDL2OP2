obj/Jutsu/Elemental/BroilingWater
	//Element="Youton"
	icon='Icons/Jutsus/Broiling water.dmi'
obj/Jutsu/Elemental/BroilingWater/WaterVapor
	icon_state=""
	density=0
	layer=TURF_LAYER
	var/nin1=0
	New()
		..()
		spawn()
			while(src)
				src.SoundEngine2('SFX/LavaFlow.wav',7,80)
				for(var/mob/M in src.loc)
					var/mob/O=src.Owner
					if(M==O)
						return
					if(M.knockedout)
						return
					if(M.Status!="Burn" && !M.InHydro)
						M.Status="Burn"
						M.StatusEffected=(O.Broil*2)+5
						if(M.StatusEffected>20)
							M.StatusEffected=20
					M.DamageProc(rand(100,120),"Health",O)
					M.DamageProc(rand(50,0),"Stamina",O)
					M.Running=0
				for(var/obj/Jutsu/Elemental/Suiton/A in src.loc)
					src.CreateSmoke("Light")
					del(src)
				sleep(11)
		spawn(300)
			del(src)

mob/proc/BroilinWat(Uses)
	var/ChakraLoss=1750;ChakraLoss-=src.GenSkill*2
	src.chakra-=ChakraLoss
	src.Handseals(70-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(src.Shibari) return
	src.icon_state="handseal";src.Frozen=1
	for(var/turf/T in oview(1))
		var/obj/Jutsu/Elemental/BroilingWater/WaterVapor/A=new()
		A.Owner=src;A.JutsuLevel=src.SuitonKnowledge/5+src.KatonKnowledge/5;A.loc=T
	sleep(1)
	var/AZ=2
	var/HowFarItGoes=rand(5,10)
	if(HowFarItGoes>10)
		AZ=10
	else
		AZ=HowFarItGoes
	if(Uses>200)
		AZ+=1
	var/Z=1
	while(Z<AZ)
		for(var/turf/T in oview(Z,src))
			if(!(T in oview(Z-1)))
				var/obj/Jutsu/Elemental/BroilingWater/WaterVapor/A=new();A.Owner=src;A.JutsuLevel=src.SuitonKnowledge/5+src.KatonKnowledge/5;A.loc=T
		Z++
		sleep(1)
	if(Z<AZ)
		src.icon_state="";src.Frozen=0