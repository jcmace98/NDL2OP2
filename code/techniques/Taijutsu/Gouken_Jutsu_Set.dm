


mob/proc
	Reppu()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
			return
		else
			var/damage=round(rand(src.tai*40,src.tai*55));var/A=4;src.StaminaDrain(45)
			var/damage2=(damage*0.15)/100
			while(A)
				src.dir=turn(src.dir,45)
				for(var/mob/M in oview(1,src))
					if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
						M<<"You grab [src]'s leg as they attempt to kick you and throw them!"
						src<<"[M] grabs your leg as you appear to kick them and they throw you!"
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						src.HitBack(10,M.dir)
						if(M.ReactionBelowCounter&&prob(25))
							M<<"You managed to break [src]'s legs while you throw them!"
							src<<"You can't feel your legs anymore!"
							src.BrokenLegs=1
							src.BrokenLegsTime=(M.tai*2)
						return
					if(M.KagDance=="Karamatsu")
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						src.health-=damage2
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					spawn()
						if(damage>=1500)
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(4,(src.dir-4))
							A=0
						if(M.sphere)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging || M.InHydro)
								M.Dodge()
							else
								if(M.Guarding||M.FrozenBind=="DoBind")
									viewers()<<sound('SFX/Guard.wav',0)
								else
									viewers()<<sound('SFX/HitMedium.wav',0)
								spawn()AttackEfx(M.x,M.y,M.z)
								flick("rasenganhit",M);damage=(damage/(M.Endurance/5))/(M.BaikaCharged+1);
								if(damage>1000)
									damage=1000
								view(M)<<output("<font color=green size=2>[M] has been hit by Reppu!([damage])</font>","Attack")
								M.DamageProc(damage,"Stamina",src)
								M.icon_state="knockedout";spawn(9)
									M.icon_state=""
								if(M.icon_state=="knockedout")
									spawn() M.HitBack(2,src.dir)
				A--
				sleep(1)
	Senpuu()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
			return
		else
			var/A=4;src.StaminaDrain(100)
			while(A)
				src.dir=turn(src.dir,90);flick("roundhouse-kick",src)
				var/damage=round(rand(src.tai*70,src.tai*85))
				var/damage2=(damage*0.15)/100
				if(damage>=1500)
					damage=1500

				for(var/mob/M in oview(1,src))
					if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
						M<<"You grab [src]'s leg as they attempt to kick you and throw them!"
						src<<"[M] grabs your leg as you appear to kick them and they throw you!"
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						src.HitBack(10,M.dir)
						A=0
						if(M.ReactionBelowCounter&&prob(25))
							M<<"You managed to break [src]'s legs while you throw them!"
							src<<"You can't feel your legs anymore!"
							src.BrokenLegs=1
							src.BrokenLegsTime=(M.tai*2)
						return
					if(M.KagDance=="Karamatsu")
						src.health-=damage2
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					spawn()
						if(damage>=1500)
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(4,turn(src.dir,90))
							A=0
						if(M.sphere)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging || M.InHydro)
								M.Dodge()
							else
								if(M.Guarding||M.FrozenBind=="DoBind")
									viewers()<<sound('SFX/Guard.wav',0)
								else
									viewers()<<sound('SFX/HitMedium.wav',0)
								spawn()AttackEfx(M.x,M.y,M.z)
								if(prob(45))
									M.Running=0
								flick("rasenganhit",M);damage=(damage/(M.Endurance/5))/(M.BaikaCharged+1);
								view(M)<<output("<font color=green size=2>[M] has been hit by Senpuu!([damage])</font>","Attack")
								M.DamageProc(damage,"Stamina",src)
								spawn() M.HitBack(5,src.dir)
								spawn(5) M.StunAdd(rand(1,7))
				A--
				sleep(1)
	KonohaShofuu()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
			return
		else
			if(src.target)
				var/mob/M=src.target;src.dir=get_dir(src,M)
			sleep(1);flick("crashingleg",src);src.StaminaDrain(250);var/damage=round(rand(src.tai*110,src.tai*120));
			if(damage>=2000)
				damage=2000
			var/damage2=damage*0.15
			for(var/mob/M in get_step(src,src.dir))
				if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
					M<<"You grab [src]'s leg before it comes down on you and throw them back!"
					src<<"[M] grabs your leg as you try and hit them and they throw you back!"
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
					src.stamina-=(M.tai*2)
					if(src.dir==NORTH) src.HitBack(10,EAST)
					if(src.dir==SOUTH) src.HitBack(10,WEST)
					if(src.dir==EAST) src.HitBack(10,NORTH)
					if(src.dir==WEST) src.HitBack(10,SOUTH)
					if(src.dir==NORTHEAST) src.HitBack(10,SOUTHEAST)
					if(src.dir==SOUTHEAST) src.HitBack(10,SOUTHWEST)
					if(src.dir==NORTHWEST) src.HitBack(10,EAST)
					if(src.dir==SOUTHWEST) src.HitBack(10,NORTH)
					flick("rasenganhit",src)
					if(M.ReactionBelowCounter&&prob(25))
						M<<"You managed to break [src]'s legs while you throw them!"
						src<<"You can't feel your legs anymore!"
						src.BrokenLegs=1
						src.BrokenLegsTime=(M.tai*2)
					return
				if(M.KagDance=="Karamatsu")
					src.health-=damage2
					src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					if(M.Deflection)
						src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
					return
				if(!M.Mogu)
					if(M.Kaiten|M.ingat)
						spawn() src.HitBack(4,(src.dir-4))
						return
					if(damage>=1500)
						for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
							del(P)
					if(M.sphere)
						viewers()<<sound('SFX/Guard.wav',0);return
					src.DodgeCalculation(M)
					if(M.Dodging || M.InHydro)
						M.Dodge()
					else
						if(M.Guarding||M.FrozenBind=="DoBind")
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
						spawn()AttackEfx(M.x,M.y,M.z)
						flick("rasenganhit",M);damage=(damage/(M.Endurance/5))/(M.BaikaCharged+1);
						if(damage>1500) damage=1500
						view(M)<<output("<font color=green size=2>[M] has been hit by KonohaShofuu!([damage])</font>","Attack")
						M.DamageProc(damage,"Stamina",src);M.HitBack(5,src.dir)
			/*			if((src.Focus>M.Focus&&prob(70))||(prob(40)))
							if(M.WeaponInLeftHand!="")
								M.WeaponInLeftHand=""
								M<<"The Weapon in your Left Hand has been Disarmed."
								src<<"You successfully disarmed [M]'s weapon in his left Hand!"
							if(M.WeaponInRightHand!="")
								M.WeaponInRightHand=""
								M<<"The Weapon in your Right Hand has been Disarmed."
			*///					src<<"You successfully disarmed [M]'s weapon in his Right Hand!"

	KonohaDaiSenkou()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenLegs)
			return
		else
			if(src.target&&src.Running)
				src.dir=get_dir(src,src.target)
			sleep(1);src.StaminaDrain(275)
			for(var/mob/M in get_step(src,src.dir))
				var/damage=round(rand(src.tai*200,src.tai*450))
				damage/=((M.Endurance/2)/(M.BaikaCharged+1))
				var/damage2=(damage*0.15)
				if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
					M<<"You grab [src]'s leg as they spin and punch them in the gut!"
					src<<"[M] grabs your leg as you spin and punches them and punches you in the gut!"
					flick("Attack2",M)
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
					src.HitBack(5,M.dir)
					src.stamina-=(M.tai*5)
					flick("rasenganhit",src)
					if(M.ReactionBelowCounter&&prob(25))
						M<<"You managed to punch [src] hard enough they cough up blood."
						src<<"You cough up blood in pain."
						src.Bloody();src.Bloody();src.Bloody();src.Bloody()
						src.DamageProc(150,"Health",M)
					return
				if(M.KagDance=="Karamatsu")
					src.health-=damage2
					src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					if(M.Deflection)
						src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
					return
				if(!M.Mogu)
					if(M.Kaiten|M.ingat)
						spawn() src.HitBack(4,(src.dir-4))
						return
					if(M.sphere||M.FrozenBind=="DoBind")
						viewers()<<sound('SFX/Guard.wav',0);return
					flick("roundhouse-kick",src)
					src.DodgeCalculation(M)
					if(M.Dodging || M.InHydro)
						M.Dodge();return
					else
						M.StunAdd(2);src.Stun=10
						view(M)<<output("<font color=green size=2>[M] has been hit by KonohaDaiSenkou!([damage])</font>","Attack")
						M.DamageProc(damage,"Stamina",src);
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
						sleep(1);flick("crashingleg",src);M.StunAdd(2)
						view(M)<<output("<font color=green size=2>[M] has been hit by KonohaDaiSenkou!([damage/2])</font>","Attack")
						M.DamageProc(damage/2,"Stamina",src);
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
						sleep(1);flick("highkick",src);M.StunAdd(2)
						view(M)<<output("<font color=green size=2>[M] has been hit by KonohaDaiSenkou!([damage*1.2])</font>","Attack")
						M.DamageProc(damage*1.2,"Stamina",src);
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
						sleep(1);M.Stun=0;src.Stun=0
						spawn() M.HitBack(5,src.dir)
	KonohaGenkurikiSenpuu()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
			return
		else
			src.StaminaDrain(300);flick("highkick",src);var/I=10;var/hits=0
			while(I>=1)
				flick("highkick",src);step(src,src.dir);var/damage=(round(rand(src.tai*4,src.tai*5)))/(hits+1);var/damage2=(damage*0.15)
				for(var/mob/M in get_step(src,src.dir))
					if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
						M<<"You grab [src]'s leg as they attempt to kick you and throw them!"
						src<<"[M] grabs your leg as you appear to kick them and they throw you!"
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						flick("rasenganhit",src)
						src.HitBack(10,M.dir)
						I=0
						if(M.ReactionBelowCounter&&prob(25))
							M<<"You managed to break [src]'s legs while you throw them!"
							src<<"You can't feel your legs anymore!"
							src.BrokenLegs=1
							src.BrokenLegsTime=(M.tai*2)
						return
					src.StaminaDrain(120)
					hits++
					I--
					if(M.KagDance=="Karamatsu")
						src.health-=damage2
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return

					if(!M.Mogu)
						if(damage>=1500)
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(4,(src.dir-4))
							return
						if(M.sphere||M.FrozenBind=="DoBind")
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging || M.InHydro)
								M.Dodge()
							else
								if(M.Guarding)
									viewers()<<sound('SFX/Guard.wav',0)
								else
									viewers()<<sound('SFX/HitStrong.wav',0)
								if(damage>1000)
									damage=1000
								view(M)<<output("<font color=green size=2>[M] has been hit by KonohaGenkurikiSenpuu!([damage])</font>","Attack")
								M.DamageProc(damage,"Stamina",src)
								spawn() M.HitBack(1,src.dir) //was originally 10
								spawn()AttackEfx(M.x,M.y,M.z)
				sleep(1)
				I--
	KonohaDaiSenpuu()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
			return
		else
			if(src.target)
				src.dir=get_dir(src,src.target)
			src.StaminaDrain(400);sleep(1);var/A=8
			while(A)
				src.dir=turn(src.dir,90);flick("roundhouse-kick",src)
				for(var/mob/M in oview(2,src))
					if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
						M<<"You grab [src]'s leg as they attempt to kick you and throw them!"
						src<<"[M] grabs your leg as you appear to kick them and they throw you!"
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						flick("rasenganhit",src)
						src.HitBack(10,M.dir)
						A=0
						if(M.ReactionBelowCounter&&prob(25))
							M<<"You managed to break [src]'s legs while you throw them!"
							src<<"You can't feel your legs anymore!"
							src.BrokenLegs=1
							src.BrokenLegsTime=(M.tai*2)
						return
					var/damage=round(rand(src.tai*40,src.tai*65))
					damage=(damage/(M.Endurance/5))/(M.BaikaCharged+1)
					if(damage>1000)
						damage=1000
					var/damage2=(damage*0.15)
					if(M.KagDance=="Karamatsu")
						src.health-=damage2
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					if(!M.Mogu)
						if(damage>=1500)
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(10,turn(src.dir,90))
							return
						if(M.sphere||M.FrozenBind=="DoBind")
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging || M.InHydro)
								M.Dodge()
							else
								if(M.Guarding)
									viewers()<<sound('SFX/Guard.wav',0)
								else
									viewers()<<sound('SFX/HitMedium.wav',0)
									flick("rasenganhit",M)
								spawn()AttackEfx(M.x,M.y,M.z)
								view(M)<<output("<font color=green size=2>[M] has been hit by KonohaDaiSenpuu!([damage])</font>","Attack")
								M.DamageProc(damage,"Stamina",src);M.dir=usr.dir
								M.HitBack(10,src.dir);M.StunAdd(rand(5,10))
				A--
				sleep(1)

	LotusProc()
		var/PDamage=(src.tai*3+(src.TaijutsuMastery*6))*0.5
		src.Target()
		if(src.ntarget) return;
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
			return
		if(src.GateIn!="Limit")
			src<<"You must be in the Fifth Gate to use this!";return
		var/mob/V=src.target
		src.icon_state="Beastman"
		V<<"[src.name] begins to dash towards you."
		src.Running=1
		sleep(10);
		src.loc=locate(V.x,V.y-1,V.z)
		src.icon_state="kickup"
		src.dir=NORTH;
		if(V.Dodging || V.InHydro)
			V.Dodge();src.icon_state="Running";return
		if(V.Guarding)
			viewers()<<sound('SFX/Guard.wav',0)
			src.icon_state="Running"
			src<< "[V.name] has blocked the attack"
			return;
		else
			viewers()<<sound('SFX/HitMedium.wav',0)
			V.DamageProc(75,"Stamina",src)
		V.firing=1;
		V.HitBack(3,src.dir)
		src.icon_state="zan"
		walk_towards(src,V)
		src<< "[src.name] says: first hit!!"
		flick("Attack1",src)
		flick("hit",V)
		V.HitBack(5,src.dir)
		view(V)<<output("<font color=green size=2>[V] has been hit!([PDamage])</font>","Attack")
		V.DamageProc(PDamage,"Stamina",src)
		src.icon_state="zan"
		walk_towards(src,V)
		sleep(3)

		src.loc=locate(V.x,V.y-1,V.z)
		src<< "[src.name] says: second hit!!"
		flick("Attack2",src)
		flick("hit",V)
		V.HitBack(5,src.dir)
		view(V)<<output("<font color=green size=2>[V] has been hit!([PDamage])</font>","Attack")
		V.DamageProc(PDamage,"Stamina",src)
		src.icon_state="zan"
		walk_towards(src,V)

		sleep(3)

		src.dir=EAST
		src.loc=locate(V.x,V.y-1,V.z)
		src<< "[src.name] says: third hit!!"
		flick("Attack1",src)
		flick("hit",V)
		V.HitBack(5,src.dir)
		view(V)<<output("<font color=green size=2>[V] has been hit!([PDamage])</font>","Attack")
		V.DamageProc(PDamage,"Stamina",src)
		src.icon_state="zan"
		walk_towards(src,V)

		sleep(3)

		src.loc=locate(V.x,V.y-1,V.z)
		flick("roundhouse-kick",src)
		V.HitBack(5,turn(src.dir,45))
		sleep(1)
		walk_towards(src,V)
		src<< "[src.name] says: Get back here!I'm not done yet!!"

		sleep(3)

		walk_towards(V,src)
		V<< "[src.name] pulls you in!"

		sleep(3)

		flick("Attack1",src)
		flick("hit",V)
		view(V)<<output("<font color=green size=2>[V] has been hit!([PDamage*3])</font>","Attack")
		V.DamageProc(PDamage*3,"Stamina",src)
		walk(V,0)
		walk(src,0)
		V.HitBack(10,src.dir)
		src<< "[src.name] says: HIDDEN LOTUS!!"
		return




	GateAssaultProc()
		var/PDamage=(src.tai+(src.TaijutsuMastery*2)*30)
		src.Target()
		if(src.ntarget) return;
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
			return
		if(!((src.GateIn=="Life")||(src.GateIn=="Wound")||(src.GateIn=="Limit")))
			src<<"You need to be in at least the Fourth Gate to use this jutsu!"
			return
		var/mob/V=src.target
		V<<"[src.name] begins to dash towards you!"
		src.Running=1
		src.deathcount+=rand(0.25,0.40)
		sleep(10);
		var/Times=10
		src.icon_state="zan"
		src.firing=1;
		while(Times>0)
			restart
			sleep(2)
			var/A=rand(1,4)
			var/turf/T
			if(A==1)
				T=locate(V.x-1,V.y,V.z)
				if(!T.density)
				//	src.loc=locate(V.x-1,V.y,V.z)
					src.loc=T
					src.dir=EAST;
				else
					A=rand(2,4)
					goto restart
			else if(A==2)
				T=locate(V.x+1,V.y,V.z)
				if(!T.density)
			//		src.loc=locate(V.x+1,V.y,V.z)
					src.loc=T
					src.dir=WEST;
				else
					A=pick(1,3,4)
					goto restart
			else if(A==3)
				T=locate(V.x,V.y+1,V.z)
			//	src.loc=locate(V.x,V.y+1,V.z)
				if(!T.density)
					src.loc=T
					src.dir=SOUTH;
				else
					A=pick(1,2,4)
					goto restart
			else
				T=locate(V.x,V.y-1,V.z)
			//	src.loc=locate(V.x,V.y-1,V.z)
				if(!T.density)
					src.loc=T
					src.dir=NORTH;
				else
					A=rand(1,3)
					goto restart

			if(V.Dodging || V.InHydro)
				V.Dodge();src.icon_state="Running";src.firing=0;return
			if(V.Guarding)
				viewers()<<sound('SFX/Guard.wav',0)
				src<< "[V.name] has blocked the attack!"
				V.DamageProc(PDamage/2,"Stamina",src)
				view(V)<<output("<font color=green size=2>[V] has been hit by a barrage of punches!([PDamage/2])</font>","Attack")
			else
				viewers()<<sound('SFX/HitMedium.wav',0)
				view(V)<<output("<font color=green size=2>[V] has been hit by a barrage of punches!([PDamage])</font>","Attack")
				V.DamageProc(PDamage,"Stamina",src)
				flick("Attack1",src)
				flick("hit",V)
		//	sleep(2)
			var/G=2
			while(G>0)
				var/RandY=rand(-3,3)
				var/RandX=rand(-3,3)
				var/turf/P
				P=locate(V.x+RandX,V.y+RandY,V.z)
				if(!P.density)
					src.loc=P
				sleep(2)
				G--
			sleep(2)
			Times--
		//	return
		src.firing=0




	OmoteRenge()
		var/PDamage=(src.tai*3+(src.TaijutsuMastery*6))
		var/Height=5
		src.Target()
		if(src.ntarget) return;
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
			return
		if(!((src.GateIn=="Initial")||(src.GateIn=="Life")||(src.GateIn=="Heal")))
			src<<"You must be in the first Gate to use this!";return
		var/mob/V=src.target
		src.icon_state="Beastman"
		V<<"[src.name] begins to dash towards you."
		src.Running=1
		sleep(5);
		src.loc=locate(V.x,V.y,V.z)
		src.icon_state="kickup"
		src.dir=NORTH;
		if(V.Dodging || V.InHydro)
			V.Dodge();src.icon_state="Running";return
		if(V.Guarding)
			viewers()<<sound('SFX/Guard.wav',0)
			src.icon_state="Running"
			src<< "[V.name] has blocked initial the attack"
			return;
		else
			viewers()<<sound('SFX/HitMedium.wav',0)
			V.DamageProc(75,"Stamina",src)
		V.Frozen=1;src.Frozen=1
		V.pixel_y+=80
		sleep(3)
		flick("zan",src)
		src.pixel_y+=80
		src.icon_state=""
		Height=0
		sleep(15)
		viewers()<<"[src] grabs [V] and begins to pile drive him downwards!"
		src.dir=NORTH;sleep(1);src.dir=EAST;sleep(1);src.dir=SOUTH;sleep(1);src.dir=WEST
		V.dir=NORTH;sleep(1);V.dir=EAST;sleep(1);V.dir=SOUTH;sleep(1);V.dir=WEST
//		usr.overlays+="Icons/Jutsus/Lotus.dmi" fix later

		if(Height==0)
			while(Height<5)
				src.pixel_y-=16
				V.pixel_y-=16
				Height++
				src.dir=NORTH;src.dir=EAST;src.dir=SOUTH;src.dir=WEST;
				sleep(1)
			src<< "<font size=2>[src.name] says:Primary Lotus!</font>"
			view(V)<<output("<font color=green size=2>[V] has been hit!([PDamage*2])</font>","Attack")
			V.DamageProc(PDamage*5,"Stamina",src)
			usr.CreateCrator()
			src.Frozen=0
			V.Frozen=0
		//	usr.overlays-="Icons/Jutsus/Lotus.dmi" fix later
			return
