//Palm Thrust = High Pushback and Moderate Stamina Damage. No Tenketsu collapsed or Chakra Damage.

mob
	proc
		PalmThrust()
			if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
				return
			else if(!src.bya)
				src<<"You need to activate Byakugan to use this!";return
			else
				if(src.target)
					var/mob/M=src.target;src.dir=get_dir(src,M)
				sleep(1);flick("Attack1",src);src.StaminaDrain(50);var/damage=round(rand(src.tai*275,src.tai*310));var/damage2=damage*0.15
				damage+=src.StanceMastery*round(src.GenSkill/10)
				for(var/mob/M in get_step(src,src.dir))
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
						if(M.sphere)
							viewers()<<sound('SFX/Guard.wav',0);return
						src.DodgeCalculation(M)
						if(M.Dodging)
							M.Dodge()
						else
							if(M.Guarding||M.FrozenBind=="DoBind")
								viewers()<<sound('SFX/Guard.wav',0)
							else
								viewers()<<sound('SFX/HitMedium.wav',0)
							spawn()AttackEfx(M.x,M.y,M.z)
							src<<"You thrust your palm forward onto [M]'s body, pushing him back!"
							M<<"[src] thrusts his palm on your body, pushing you back!"
							flick("rasenganhit",M);damage=(damage/(M.Endurance))/(M.BaikaCharged+1);M.DamageProc(damage,"Stamina",src);M.HitBack(8,src.dir)
		TenketsuStrike()
			if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
				return
			else if(!src.bya)
				src<<"You need to activate Byakugan to use this!";return
			else
				if(src.target)
					var/mob/M=src.target;src.dir=get_dir(src,M)
				sleep(1);flick("Attack1",src);src.StaminaDrain(150)
				for(var/mob/M in get_step(src,src.dir))
					if(M.KagDance=="Karamatsu")
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					if(!M.Mogu)
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(4,(src.dir-4))
							return
						if(M.sphere)
							viewers()<<sound('SFX/Guard.wav',0);return
						src.DodgeCalculation(M)
						if(M.Dodging)
							M.Dodge()
						else
							if(M.Guarding||M.FrozenBind=="DoBind")
								viewers()<<sound('SFX/Guard.wav',0)
							else
								viewers()<<sound('SFX/HitMedium.wav',0)
							spawn()AttackEfx(M.x,M.y,M.z)
							src<<"You aim directly for [M]'s Tenketsu!"
							src.Frozen=1
							M.Frozen=1
							M<<"[src] strikes a direct poke onto your body!"
							var/WhatHappened=rand(1,2)
							sleep(30)
							if(src.ByakuganMastery>1000&&src.TenketsuAccuracy>14)
								WhatHappened=rand(1,3)
							if(src.ByakuganMastery>3000&&src.TenketsuAccuracy>=20)
								WhatHappened=rand(3,5)
							if(WhatHappened==1)
								M<<"You feel a small amount of chakra leave your body!"
								src<<"You missed [M]'s Tenketsu by just a bit."
								M.chakra-=rand(150,500)
								M.Frozen=0;src.Frozen=0
							if(WhatHappened==2)
								M<<"You feel sick as a portion of your chakra is gone!"
								src<<"You were close to hitting [M]'s Tenketsu!"
								M.chakra-=rand(250,800)
								M.Frozen=0;src.Frozen=0
							if(WhatHappened==3)
								M<<"You feel your body get weak as your chakra lowers!"
								src<<"You hit [M]'s Tenketsu but only by a little!"
								M.chakra-=(M.chakra/4)
								M.Frozen=0;src.Frozen=0
								M.Bloody()
							if(WhatHappened==4)
								M<<"You feel your body get extremly tired, as [src] almost hit your Tenketsu perfectly!"
								src<<"You hit [M]'s Tenketsu near perfectly!"
								M.chakra-=(M.chakra/3)
								M.Bloody();M.Bloody();M.Bloody();
								M.Frozen=0;src.Frozen=0
							if(WhatHappened==5)
								M<<"You get Dizzy and fall to the floor, as [src] hit your Tenketsu with deadly precision!"
								src<<"You hit [M]'s Tenketsu perfectly!"
								M.chakra=(M.Mchakra*0.05)
								M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody()
								M.Status="Asleep"
								M.StatusEffected=7
								M.Frozen=0;src.Frozen=0




//Tenketsu Burst = Momentary Expulsion of Chakra from Every Tenketsu to Blow Back Objects or Binds as a quick defense as moderate chakra cost. Does no damage.