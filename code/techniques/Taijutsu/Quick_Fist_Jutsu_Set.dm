mob/var/tmp
	QuickFeet=0
	SoundSpinningKick=0
mob/proc
	SoundSpinningKick()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenArms)
			return
		else
			src.SoundSpinningKick=1
			src.icon_state="roundhouse-kick"
			while(src.SoundSpinningKick)
				var/damage=20000
				var/damage2=150
				src.StaminaDrain(50)
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
						src.SoundSpinningKick=0
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
							spawn() src.HitBack(4,(src.dir-4))
							src.SoundSpinningKick=0
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
								view(M)<<output("<font color=green size=2>[M] has been hit by SoundSpinningKick!([(damage/(M.Endurance))/(M.BaikaCharged+1)])</font>","Attack")
								M.DamageProc((damage/(M.Endurance))/(M.BaikaCharged+1),"Stamina",src)
				damage-=100
				sleep(5)
	SoundWhirlwindKick()
		var/damage=round(rand(src.tai*20,src.tai*25))
		damage=(damage/4)
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
			return
		else
			src.firing=1
			src.StaminaDrain(300);flick("highkick",src);var/I=5;var/mob/MX=src.target
			if(get_dist(src,MX)>=3)
				src<<"You need to be closer.";src.firing=0;return
			while(I>=1)
				flick("highkick",src);step_towards(src,MX)
				for(var/mob/M in get_step(src,src.dir))
					if(M.KagDance=="Karamatsu")
						src.health-=rand(100,175)
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					if(!M.Mogu)
						if(damage>=1500)
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
						if(M.Kaiten|M.ingat)
							src.firing=0
							spawn() src.HitBack(4,(src.dir-4))
							I=0
						if(M.sphere||M.FrozenBind=="DoBind")
							src.firing=0
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging || M.InHydro)
								src.firing=0
								M.Dodge()
							else
								if(M.Guarding)
									viewers()<<sound('SFX/Guard.wav',0)
								else
									viewers()<<sound('SFX/HitStrong.wav',0);M.StunAdd(10)
									spawn()AttackEfx(M.x,M.y,M.z)
						I=0
				sleep(1)
				I--
			src.firing=0
			for(var/mob/M in get_step(src,src.dir))
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
							src.firing=0
						return

				if(src.Trait=="Old Powerful")
					damage*=1.25
				if(!M.Mogu)
					if(M.Kaiten|M.ingat)
						spawn() src.HitBack(4,(src.dir-4))
				//		spawn(10)
				//			src.firing=0
						src.firing=0
						return
					if(M.sphere||M.FrozenBind=="DoBind")
						viewers()<<sound('SFX/Guard.wav',0)
					//	spawn(10)
						src.firing=0
					else
						src.DodgeCalculation(M)
						if(M.Dodging || M.InHydro)
							M.Dodge()
						else
							if(M.Guarding)
								viewers()<<sound('SFX/Guard.wav',0)
							else
								viewers()<<sound('SFX/HitStrong.wav',0)
							//view(M)<<output("<font color=green size=2>[M] has been hit by SoundWhirlwindKick!([(damage)])</font>","Attack")
							M.DamageProc(damage,"Stamina",src);M.Stun=0;Quake_Effect(M,10,1)
							spawn() M.HitBack(1,src.dir)
							spawn()AttackEfx(M.x,M.y,M.z)
							spawn(10)
								src.firing=0


mob
	proc
		RapidPunchProc() //One of Sound Styles actual jutsu
			if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenArms)
				return
			var/A=8
			while(A)
				var/damage=round(rand(src.tai*150,src.tai*180))
				if(src.Trait=="Old Powerful")
					damage*=1.25
				var/damage2=(damage*0.15)/100
				src.StaminaDrain(50)
				if(A==8)
					flick("Attack1",src)
				if(A==7)
					flick("Attack1",src)
				if(A==6)
					flick("Attack1",src)
				if(A==5)
					flick("Attack2",src)
				if(A==4)
					flick("Attack1",src)
				if(A==3)
					flick("Attack2",src)
				if(A==2)
					flick("Attack1",src)
				if(A==1)
					flick("Attack2",src)
				for(var/mob/M in get_step(src,src.dir))
					if((M.ReactionAbove&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionAbove&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
						M<<"You grab [src]'s arms as they attempt to combo you with a barrage of punches and you sweep kick them!"
						src<<"[M] grabs your arms as you try and punch them and they sweep kick you onto the ground!"
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						src.HitBack(10,M.dir)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"You managed to break [src]'s arms while you sweep kicked them!"
							src<<"You can't feel your arms anymore!"
							src.BrokenArms=1
							src.BrokenArmsTime=(M.tai*2)
						return
					if(damage>=1500)
						for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
							del(P)
					if(M.KagDance=="Karamatsu")
						src.health-=damage2
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					if(M.Kaiten)
						return
					src.DodgeCalculation(M)
					if(M.Dodging||M.InHydro)
						M.Dodge();return
					flick("rasenganhit",M)
					M.DamageProc(damage/(M.Endurance),"Stamina",src)
					view(M)<<output("<font color=green size=2>[M] has been hit by RapidPunch!([(damage/(M.Endurance))])</font>","Attack")
					M.Death(usr)
				A--
				sleep(1)

		LeapingSoundSpinKickProc()
			if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG|src.BrokenLegs)
				return
			var/damage=round(rand(src.tai*400,src.tai*450))
			var/damage2=(damage*0.15)
			src.icon_state="roundhouse-kick"
			src.StaminaDrain(60)
			var/A=8
			while(A)
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
					if(damage>=1500)
						for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
							del(P)
					if(M.Kaiten||M.sphere)
						return
					src.DodgeCalculation(M)
					if(M.Dodging || M.InHydro)
						M.Dodge()
					else
						flick("hit",M)
						M.DamageProc(damage/(M.Endurance),"Stamina",src)
						view(M)<<output("<font color=green size=2>[M] has been hit by LeapingSoundSpinKick!([(damage/(M.Endurance))])</font>","Attack")
				step(src,src.dir)
				A--
				sleep(1)
			src.icon_state="Running"
