///////////////////////////////////////////////////////
////Black Lightning//Advance form of raiton that is based on pure damage fasted pace high cost raiton with no effects like stuns or skewed.
////////////////////////////

obj/Jutsu/Elemental/Raiton/BlackLightning
	icon = 'Icons/Jutsus/black lightning.dmi'
	Element="Raiton"
	icon_state="RaitonTile"//Should be a recolored black nagashi
	BElectrocute
		icon = 'Icons/Jutsus/BlackElectrocute.dmi'
		icon_state=""
		layer=MOB_LAYER+1
		density=0
		var/nin=10
		New()
			..()
			spawn()
				while(src)
					sleep(3)
					var/mob/O = src.Owner
		//			spawn(1)
		//				for(var/obj/Jutsu/Elemental/Doton/ZZ in src.loc)
		//					if((ZZ.JutsuLevel/2)>=src.JutsuLevel)
		//						src.Owner=null;src.loc=null
		//					else
		//						src.Owner=null;src.loc=null
		//				for(var/obj/Jutsu/Elemental/Suiton/ZZ in src.loc)
		//					if(!ZZ.Electrocuted)
		//						ZZ.Electrocuted=1
		//						var/obj/Jutsu/Elemental/Raiton/Electrocute/AA=new();AA.loc=locate(src.x,src.y,src.z);AA.nin=src.nin/2;AA.Owner=src.Owner//;K.Owner=src.Owner;B.Owner=src.Owner;C.Owner=src.Owner;D.Owner=src.Owner
			//		for(var/mob/Kibaku/M in src.loc)
			//			M.Defused=1
					for(var/obj/Doors/D in oview(1,src))
						D.DamageProc(src.nin/8,"Health",O)
						sleep(1)
					for(var/mob/M in src.loc)
					//	spawn()
						if(M.Mogu)
							return
						if(!M.client)
							return
						var/damage=round(rand(src.nin/4,src.nin/5))*((O.LightningChakra*0.1)+0.9)
				//		var/Chakraz=M.ChakraArmor*0.01
						if(M.InHydro)
							damage *=3
						M.StunAdd(O.Static);
						if(O.SecondName=="Ryouken")
							damage *=1.3
						//M.health-=(damage-(Chakraz*damage));M.Death(O)
						spawn()
							M.DamageProc(damage,"Health",O,"electric shock","yellow")
						if(M.Stun>30)
							M.Stun=30
						if(O.Electromagnetivity>0&&prob(10*O.Electromagnetivity*(M.InHydro?3:1)))
							if(!M.ImmuneToDeath)
								M.Status="Screwed"
								M.StatusEffected=O.Electromagnetivity
						if(O.ShockTreatment>0&&prob(10*O.ShockTreatment*(M.InHydro?3:1))&&M.Shocked!=1)
							M.Shocked=1
							M.ShockTreatmentWearOff(rand(20,50))
			spawn(25)
			//	src.Owner=null;src.loc=null;
				del(src)
///////////////////////////////////
//Kuro Panther
//////////////////////////////////
obj/Jutsu/Elemental/Raiton/BlackLightning
	BlackPanther
		icon_state="blackpanther"
		layer = MOB_LAYER+1
		Move_Delay=0
		pixel_step_size=8
		density=1
		JutsuLevel=1
		var/nin=0
		var/Hit=0
		New()
			..()
			spawn()
				while(src)
					sleep(1)
					src.SoundEngine('SFX/LightningSFX.wav',5,45)
					for(var/obj/Jutsu/Elemental/Doton/Z in src.loc)
						if(prob(20))
							del(Z)
					for(var/obj/Doors/D in oview(1,src))
						D.DamageProc(src.nin/10,"Health")
						sleep(1)
					for(var/obj/Jutsu/Elemental/Suiton/Z in src.loc)
						if(!Z.Electrocuted)
							if(prob(20))
								Z.Electrocuted=1
								var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/AA=new();AA.loc=locate(src.x+1,src.y,src.z);AA.Owner=src.Owner

			spawn(50)
				del(src)
		Bump(A)
	//		..()

			if(istype(A,/mob/Kibaku/))
				var/mob/Kibaku/M=A;M.Defused=1
			if(ismob(A))
				if(Hit==1)
					return
				Hit=1
				var/mob/M=A
				var/mob/O=src.Owner
				var/LightningChakra=LightningDamage(O)
				var/damage=src.nin;damage=round((damage)*((LightningChakra*0.2)+1));var/Chakraz=M.ChakraArmor*0.07;damage=damage-(Chakraz*damage)
				if(M.RaiArmor)
					if((M.RaitonKnowledge-O.RaitonKnowledge)>damage)
						view(M)<<"[M]'s armor absorbed the shock!";del(src)
					else
						var/resistance=(M.RaitonKnowledge-O.RaitonKnowledge);if(resistance<50) resistance=50
						if((damage-resistance)<0) resistance=(damage-1)
						damage-=resistance
				if(O.Trait=="Old Powerful"||O.SecondName=="Ryouken")
					damage+=(O.NinSkill*3)
				if(M.Clan=="Hoshigaki"||M.Clan2=="Hoshigaki")
					damage*=1.2
				M.DamageProc(damage,"Health",O,"Black Panther","grey")
				if(prob(75))
					M.StunAdd(20)
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				var/obj/ZZ=A
				if(istype(A,/obj/Doors/))
					var/obj/O=A
					O.DamageProc(src.nin)
					del(src)
				if(istype(ZZ,/obj/Jutsu/Elemental/Doton/))
					var/obj/Jutsu/Elemental/Doton/ZAC=ZZ
					if((ZAC.JutsuLevel/2)>=src.JutsuLevel)
						del(src)
					else
						del(ZAC)
				if(istype(ZZ,/obj/Jutsu/Elemental/Suiton/))
					var/obj/Jutsu/Elemental/Suiton/ZAC=ZZ
					if(!ZAC.Electrocuted)
						ZAC.Electrocuted=1
						var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/AA=new();var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/K=new();var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/B=new();var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/C=new();var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/D=new()
						AA.loc=locate(src.x+1,src.y,src.z);K.loc=src.loc;B.loc=locate(src.x-1,src.y,src.z);C.loc=locate(src.x,src.y+1,src.z);D.loc=locate(src.x,src.y-1,src.z)
						AA.nin=src.nin/2;K.nin=src.nin/2;B.nin=src.nin/2;C.nin=src.nin/2;D.nin=src.nin/2
						AA.Owner=src.Owner;K.Owner=src.Owner;B.Owner=src.Owner;C.Owner=src.Owner;D.Owner=src.Owner

		Del()
			for(var/turf/T in oview(1,src))
				var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/AA=new();AA.loc=T;AA.Owner=src.Owner;AA.nin=src.nin
			..()
	BlackPulse
		icon_state = "Lightning Cutter"
		density=1
		var/Hit=0
		Move_Delay=0
		pixel_step_size=16
		var/nin=10
		New()
			..()
			spawn(30)
				del(src)
		Move()
			..()
			var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/A=new();A.loc=src.loc;A.Owner=src.Owner;A.nin=src.nin/2
		Bump(A)
			..()
			if(istype(A,/mob/Kibaku/))
				var/mob/Kibaku/M=A;M.Defused=1
			if(ismob(A))
				if(Hit==1)
					return
				Hit=1
				var/mob/M = A
				if(M.Chidorion||M.Raikirion)
					var/ZZ=rand(1,3)
					if(ZZ==1) view(M)<<sound('SFX/AttackSwish1.wav',0)
					if(ZZ==2) view(M)<<sound('SFX/AttackSwish2.wav',0)
					if(ZZ==3) view(M)<<sound('SFX/AttackSwish3.wav',0)
					flick("Attack1",M)
					view(M)<<output("[M] cancels out the Raiton technique with Chidori!","Attack")
					M.ChidoriD=0;M.Chidorion=0;M.overlays-='Icons/Jutsus/Chidori.dmi'
					src.CreateSmoke("Light");del(src);return
				if(M.Kaiten)
					src.CreateSmoke("Light");del(src);return
				if(M.DotonArmor)
					M.DotonArmor=0
					M.overlays-='Earth Armor.dmi'
				var/damage = round(src.nin*2)
				var/mob/O = src.Owner
				var/LightningChakra=LightningDamage(O)
				damage=round((damage)*((LightningChakra*0.07)+0.9)*(M.InHydro?3:1))
				var/Chakraz=M.ChakraArmor*0.01
				if(M.RaiArmor)
					if((M.RaitonKnowledge-O.RaitonKnowledge)>damage)
						view(M)<<"[M]'s armor absorbed the shock!";del(src)
					else
						var/resistance=(M.RaitonKnowledge-O.RaitonKnowledge);if(resistance<50) resistance=50
						if((damage-resistance)<0) resistance=(damage-1)
						damage-=resistance
				if(M.Clan=="Hoshigaki"||M.Clan2=="Hoshigaki")
					damage*=1.2
				damage=(damage-(Chakraz*damage))
				if(O.Trait=="Old Powerful"||O.SecondName=="Ryouken") damage+=(O.NinSkill)
				M.DamageProc(damage,"Health",O,"Black Pulse","grey")
				if(O.Electromagnetivity>0&&prob(30*O.Electromagnetivity*(M.InHydro?3:1)))
					if(!M.ImmuneToDeath)
						M.Status="Screwed"
						M.StatusEffected=O.Electromagnetivity
				if(O.ShockTreatment>0&&prob(10*O.ShockTreatment*(M.InHydro?3:1))&&M.Shocked!=1)
					M.Shocked=1
					M.ShockTreatmentWearOff(rand(20,50))

				M.Death(O)
				if(prob(90))
					M.StunAdd(O.Static*2)
				src.loc=M.loc
				Hit=0
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				var/obj/ZZ=A
				if(istype(ZZ,/obj/Jutsu/Elemental/Doton/))
					var/obj/Jutsu/Elemental/Doton/ZAC=ZZ
					if((ZAC.JutsuLevel/2)>=src.JutsuLevel)
						del(src)
					else
						del(ZAC)
				if(istype(ZZ,/obj/Jutsu/Elemental/Suiton/))
					var/obj/Jutsu/Elemental/Suiton/ZAC=ZZ
					if(!ZAC.Electrocuted)
						ZAC.Electrocuted=1
						var/obj/Jutsu/Elemental/Raiton/Electrocute/AA=new();var/obj/Jutsu/Elemental/Raiton/Electrocute/K=new();var/obj/Jutsu/Elemental/Raiton/Electrocute/B=new();var/obj/Jutsu/Elemental/Raiton/Electrocute/C=new();var/obj/Jutsu/Elemental/Raiton/Electrocute/D=new()
						AA.loc=locate(src.x+1,src.y,src.z);K.loc=src.loc;B.loc=locate(src.x-1,src.y,src.z);C.loc=locate(src.x,src.y+1,src.z);D.loc=locate(src.x,src.y-1,src.z)
						AA.nin=src.nin/2;K.nin=src.nin/2;B.nin=src.nin/2;C.nin=src.nin/2;D.nin=src.nin/2
						AA.Owner=src.Owner;K.Owner=src.Owner;B.Owner=src.Owner;C.Owner=src.Owner;D.Owner=src.Owner
	BoltStrike
		icon_state = "BlackLightningstrike"
		density=1
		layer=MOB_LAYER+1
		var
			nin=10
			prestep=0
			turf/laststep
			Hit=0
		New()
			..()
			spawn(50) del(src)
		Move()
			var/turf/old_loc=src.loc
			..()
			var/obj/Jutsu/Elemental/Raiton/BlackLightning/BoltTrail/L=new();L.loc=old_loc;L.dir=src.dir;L.Owner=src.Owner
			var/obj/Jutsu/Elemental/Raiton/BlackLightning/BElectrocute/A=new();A.loc=old_loc
		Bump(A)
			..()
			if(istype(A,/mob/Kibaku/))
				var/mob/Kibaku/M=A;M.Defused=1
			if(ismob(A))
				if(Hit==1)
					return
				Hit=1
				var/mob/M = A
				if(M.Chidorion||M.Raikirion)
					var/ZZ=rand(1,3)
					if(ZZ==1) view(M)<<sound('SFX/AttackSwish1.wav',0)
					if(ZZ==2) view(M)<<sound('SFX/AttackSwish2.wav',0)
					if(ZZ==3) view(M)<<sound('SFX/AttackSwish3.wav',0)
					flick("Attack1",M)
					view(M)<<output("[M] cancels out the Raiton technique with Chidori!","Attack")
					M.ChidoriD=0;M.Chidorion=0;M.overlays-='Icons/Jutsus/Chidori.dmi'
					src.CreateSmoke("Light");del(src);return
				if(M.Kaiten)
					src.CreateSmoke("Light");del(src);return
				if(M.DotonArmor)
					M.DotonArmor=0
					M.overlays-='Earth Armor.dmi'
				var/damage = round(src.nin)
				var/mob/O = src.Owner
				var/LightningChakra=LightningDamage(O)
				damage=round((damage)*((LightningChakra*0.1)+0.8)*(M.InHydro?3:1))
				var/Chakraz=M.ChakraArmor*0.01
				if(M.RaiArmor)
					if((M.RaitonKnowledge-O.RaitonKnowledge)>damage)
						view(M)<<"[M]'s armor absorbed the shock!";del(src)
					else
						var/resistance=(M.RaitonKnowledge-O.RaitonKnowledge);if(resistance<50) resistance=50
						if((damage-resistance)<0) resistance=(damage-1)
						damage-=resistance
				damage=(damage-(Chakraz*damage))
				if(O.Trait=="Old Powerful"||O.SecondName=="Ryouken") damage+=(O.NinSkill)
				M.DamageProc(damage,"Health",O,"lightning","grey")
				if(O.Electromagnetivity>0&&prob(30*O.Electromagnetivity*(M.InHydro?3:1)))
					if(!M.ImmuneToDeath)
						M.Status="Screwed"
						M.StatusEffected=O.Electromagnetivity
				if(O.ShockTreatment>0&&prob(10*O.ShockTreatment*(M.InHydro?3:1))&&M.Shocked!=1)
					M.Shocked=1
					M.ShockTreatmentWearOff(rand(20,50))

				M.Death(O)
				if(prob(90))
					M.StunAdd(O.Static*2)
				src.loc=M.loc
				Hit=0
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				if(istype(A,/obj/Doors/))
					var/obj/O=A
					O.DamageProc(src.nin)
					del(src)
				del(src)
		Del()
			for(var/obj/Jutsu/Elemental/Raiton/BlackLightning/BoltTrail/A in world)
				if(A.Owner==src.Owner)
					del(A)
//			spawn()
//				src.CreateBubbles("Light")
			..()
	BoltTrail
		icon_state = "trail"
		density=0
		layer=MOB_LAYER+1
		New()
			..()
			spawn(50) del(src)
		Del()
//			spawn()
//				src.CreateBubbles("Light")
			..()

///////////////////
//Jutsu Procs
////////////////////
mob/proc
	BlackPanther(Uses)
		src.ChakraDrain(50000)
		src.Handseals(45-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(src.Shibari) return
		src.overlays-='Icons/Jutsus/Chidori.dmi';flick("Attack2",src)
		if(Uses>650&&src.HoldingR)
			var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPanther/G=new();G.loc=src.loc;G.Owner=src;G.dir=src.dir;G.nin=src.nin*2;sleep(5)
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPanther/A=new();A.loc=src.loc;A.Owner=src;A.dir=src.dir;A.nin=src.nin*2;sleep(1)
		if(src.target)
			var/mob/M=src.target;var/turf/T=M.loc;walk_towards(A,T)
		else
			walk(A,src.dir)
	BlackPulse()
		if(src.Clan=="Yotsuki"||src.Clan2=="Yotsuki")
			src.ChakraDrain(9500)
		else
			src.ChakraDrain(11000)
		src.Handseals(36-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(src.Shibari) return
		src.icon_state="beastman";src.firing=1;src.Frozen=1
		src.overlays+='Icons/Jutsus/BlackRaiArmor.dmi'
		sleep(15)
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/A=new();A.loc=src.loc;A.nin=src.nin;A.name="[src]";A.Owner=src;A.Move_Delay=0;walk(A,EAST,0);A.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/B=new();B.loc=src.loc;B.nin=src.nin;B.name="[src]";B.Owner=src;B.Move_Delay=0;walk(B,WEST,0);B.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/C=new();C.loc=src.loc;C.nin=src.nin;C.name="[src]";C.Owner=src;C.Move_Delay=0;walk(C,NORTH,0);C.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/D=new();D.loc=src.loc;D.nin=src.nin;D.name="[src]";D.Owner=src;D.Move_Delay=0;walk(D,SOUTH,0);D.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/E=new();E.loc=src.loc;E.nin=src.nin;E.name="[src]";E.Owner=src;E.Move_Delay=0;walk(E,NORTHEAST,0);E.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/F=new();F.loc=src.loc;F.nin=src.nin;F.name="[src]";F.Owner=src;F.Move_Delay=0;walk(F,NORTHWEST,0);F.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/G=new();G.loc=src.loc;G.nin=src.nin;G.name="[src]";G.Owner=src;G.Move_Delay=0;walk(G,SOUTHEAST,0);G.JutsuLevel=src.RaitonKnowledge
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BlackPulse/H=new();H.loc=src.loc;H.nin=src.nin;H.name="[src]";H.Owner=src;H.Move_Delay=0;walk(H,SOUTHWEST,0);H.JutsuLevel=src.RaitonKnowledge
		src.icon_state="";src.Frozen=0;src.firing=0
		src.overlays-='Icons/Jutsus/BlackRaiArmor.dmi'
	BlackStrike()
		src.ChakraDrain(10000)
		src.Handseals(15-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(src.Shibari) return
		src.icon_state="throw";src.Frozen=1;src.firing=1
		spawn(5)
			src.icon_state="";src.Frozen=0;src.firing=0
		var/obj/Jutsu/Elemental/Raiton/BlackLightning/BoltStrike/K=new()
		if(src.dir==EAST)
			K.pixel_x=16
		if(src.dir==WEST)
			K.pixel_x=-16
		K.loc=src.loc;K.nin=src.nin*1.2;K.dir=src.dir;K.name="[src]";K.Move_Delay=(2-(src.WaterChakra/10));K.Owner=src;K.JutsuLevel=src.SuitonKnowledge;walk(K,src.dir)