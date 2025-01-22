mob/proc
	LightningStraight()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenArms)
			return
		else
			src.Target()
			if(src.ntarget)
				return
			var/mob/m=src.target
			src.StaminaDrain(150)
			src.firing=1
			if(m.hyoushou)
				return
			else
				src.StaminaDrain(300)
				if(m.z!=src.z)
					spawn(10) src.firing=0
					return
				if(get_dist(src,m)>2)
					src<<"Your target is too far to use this attack!"
					src.firing=0
					return
				var/turf/T
				if(m.dir==NORTH) T=locate(m.x,m.y-1,m.z)
				if(m.dir==SOUTH) T=locate(m.x,m.y+1,m.z)
				if(m.dir==EAST) T=locate(m.x-1,m.y,m.z)
				if(m.dir==WEST) T=locate(m.x+1,m.y,m.z)
				if(m.dir==NORTHEAST) T=locate(m.x-1,m.y-1,m.z)
				if(m.dir==SOUTHEAST) T=locate(m.x-1,m.y+1,m.z)
				if(m.dir==NORTHWEST) T=locate(m.x+1,m.y-1,m.z)
				if(m.dir==SOUTHWEST) T=locate(m.x+1,m.y+1,m.z)
				if(T&&!T.density)
					src.loc=T
				flick("zan",src);src.dir=get_dir(src,m)
				if(prob(50))
					flick("Attack1",src)
				else
					flick("Attack2",src)
				src.buyou=1
				src.firing=1
				spawn(15)
					src.firing=0
					src.buyou=0
				for(var/mob/M in get_step(src,src.dir))
					if((M.ReactionAbove&&prob(55)&&M.tai<src.tai)||(M.ReactionAbove&&prob(70)&&M.tai>=src.tai))
						M<<"You grab [src]'s arm as they appear behind you and flip them over your head!"
						src<<"[M] grabs your arm as you appear behind them and they flip you over their head!"
						if(M.dir==NORTH) T=locate(M.x,M.y+1,M.z)
						if(M.dir==SOUTH) T=locate(M.x,M.y-1,M.z)
						if(M.dir==EAST) T=locate(M.x+1,M.y,M.z)
						if(M.dir==WEST) T=locate(M.x-1,M.y,M.z)
						if(M.dir==NORTHEAST) T=locate(M.x+1,M.y+1,M.z)
						if(M.dir==SOUTHEAST) T=locate(M.x+1,M.y-1,M.z)
						if(M.dir==NORTHWEST) T=locate(M.x-1,M.y+1,M.z)
						if(M.dir==SOUTHWEST) T=locate(M.x-1,M.y-1,M.z)
						if(T&&!T.density)
							src.loc=T
						if(M.tai<src.tai)
							M.StaminaDrain(100)
						else
							M.StaminaDrain(50)
						src.Status="Asleep"
						src.StatusEffected=(M.tai*1.5)
						src.stamina-=(M.tai*2)
						src.Bloody();src.Bloody();src.Bloody()
						src.DamageProc(M.tai*2,"Health",M)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"You managed to break [src]'s arms while you threw him down to the ground!"
							src<<"You can't feel your arms anymore!"
							src.BrokenArms=1
							src.BrokenArmsTime=(M.tai*2)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"Your face first impact managed to give [src] slight head trauma!"
							src<<"You feel a bit dizzy."
							src.DizzyProc(50)
							src.firing=0
						return
					if(!M.Mogu && !M.InHydro)
						src.DodgeCalculation(M)
						if(M.Dodging)
							M.Dodge();return
						if(M.Kaiten|M.ingat|M.intank)
							spawn() src.HitBack(4,(src.dir-4))
							return
						if(M.intank|M.sphere||M.Mogu)
							viewers()<<sound('SFX/Guard.wav',0);return
						else
							spawn()AttackEfx(M.x,M.y,M.z)
							var/damage=round(rand(usr.tai*50,usr.tai*70));var/Damage=(damage/(M.Endurance/12))/(M.BaikaCharged+1)
							if(Damage>1500)
								Damage=1500
							if(Damage>=1500)
								for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
									del(P)
							if(src.Trait=="Powerful")
								Damage*=1.25
							if(M.Guarding)
								viewers()<<sound('SFX/Guard.wav',0)
							else
								viewers()<<sound('SFX/HitMedium.wav',0)
								flick("hit",M)
						//	view(M)<<output("<font color=green size=2>[M] has been hit by Lion Punch!([Damage])</font>","Attack")
							M.DamageProc(Damage,"Stamina",src);src.ExpGain(M,damage)
							spawn() M.HitBack(1,src.dir)
							flick("Attack2",src)
							step(src,src.dir)
							view(M)<<output("<font color=blue size=2>[M] has been hit by Lightning Straight!([Damage])</font>","Attack")
							M.DamageProc(Damage,"Stamina",src)
							spawn() M.HitBack(rand(3,6),src.dir)
							if(M.RaiArmor)
								src.DamageProc(100,"Health",M);src.HitBack(1,(turn(src.dir,180)))
	Oppression()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenArms)
			return
		else
			var/Z=rand(1,2)
			if(Z==1)
				flick("Attack1",src)
			if(Z==2)
				flick("Attack2",src)
			if(src.target)
				src.dir=get_dir(src,src.target)
			src.StaminaDrain(100)
			for(var/mob/M in get_step(src,src.dir))
				if((M.ReactionAbove&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionAbove&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
					M<<"You grab [src]'s Arm as they attempt to chop you and you punch them in the face!"
					src<<"[M] grabs your arm as you try and chop them and they punch you in the face!"
					flick("Attack1",M)
					flick("rasenganhit",src)
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						src.HitBack(10,M.dir)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"You managed to break [src]'s arms while you grabbed them!"
							src<<"You can't feel your arms anymore!"
							src.BrokenArms=1
							src.BrokenArmsTime=(M.tai*2)
						return
				if(M.KagDance=="Karamatsu")
					src.health-=rand(150,300)
					src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					if(M.Deflection)
						src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
					return
				if(!M.Mogu)//&&M.FrozenBind!="DoBind")
					src.DodgeCalculation(M)
					if(M.Dodging || M.InHydro)
						M.Dodge();return
					if(M.Kaiten|M.ingat)
						spawn() src.HitBack(4,(src.dir-4))
						return
					if(M.intank|M.sphere||M.Mogu)
						viewers()<<sound('SFX/Guard.wav',0);return
					else
						spawn()AttackEfx(M.x,M.y,M.z)
						var/damage=round(rand(usr.tai*1000,usr.tai*1200));var/Damage=(damage/(M.Endurance))/(M.BaikaCharged+1)
						if(src.Trait=="Powerful")
							damage*=1.25
						if(Damage>700)//Raised Asshous cap
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
							Damage=700
						else
							if(src.RaiArmor==2)
								Damage=300
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
							flick("hit",M)
						M.DamageProc(Damage,"Stamina",src,"Oppression Horizantal","yellow");src.ExpGain(M,damage)
						if(src.RaiArmor==2)
							M.DamageProc(Damage,"Health",src,"Oppression Horizantal","blue");src.ExpGain(M,damage)
						spawn() M.HitBack(5,src.dir)
	OppressionH()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenArms)
			return
		else
			var/Z=rand(1,2)
			if(Z==1)
				flick("Attack1",src)
			if(Z==2)
				flick("Attack2",src)
			if(src.target)
				src.dir=get_dir(src,src.target)
			src.StaminaDrain(100)
			for(var/mob/M in get_step(src,src.dir))
				if((M.ReactionAbove&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionAbove&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
					M<<"You grab [src]'s Arm as they attempt to chop you and you punch them in the face!"
					src<<"[M] grabs your arm as you try and chop them and they punch you in the face!"
					flick("Attack1",M)
					flick("rasenganhit",src)
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
						src.stamina-=(M.tai*2)
						src.HitBack(10,M.dir)
						if(M.ReactionAboveCounter&&prob(25))
							M<<"You managed to break [src]'s arms while you grabbed them!"
							src<<"You can't feel your arms anymore!"
							src.BrokenArms=1
							src.BrokenArmsTime=(M.tai*2)
						return
				if(M.KagDance=="Karamatsu")
					src.health-=rand(150,300)
					src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					if(M.Deflection)
						src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
					return
				if(!M.Mogu)//&&M.FrozenBind!="DoBind")
					src.DodgeCalculation(M)
					if(M.Dodging || M.InHydro)
						M.Dodge();return
					if(M.Kaiten|M.ingat)
						spawn() src.HitBack(4,(src.dir-4))
						return
					if(M.intank|M.sphere||M.Mogu)
						viewers()<<sound('SFX/Guard.wav',0);return
					else
						spawn()AttackEfx(M.x,M.y,M.z)
						var/damage=round(rand(usr.tai*1200,usr.tai*1500));var/Damage=(damage/(M.Endurance))/(M.BaikaCharged+1)
						if(src.Trait=="Powerful")
							damage*=1.25
						if(Damage>1000)//Raised Asshous cap
							for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
								del(P)
							Damage=1000
						else
							if(src.RaiArmor==2)
								Damage=500
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitMedium.wav',0)
							flick("hit",M)
						M.DamageProc(Damage,"Stamina",src,"Oppression Horizantal Chop","yellow");src.ExpGain(M,damage)
						if(src.RaiArmor==2)
							M.DamageProc(Damage,"Health",src,"Oppression Horizantal Chop","blue");src.ExpGain(M,damage)
						spawn() M.HitBack(7,src.dir)

	GuillotineD()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!="")
			return
		else
			if(src.target)
				src.dir=get_dir(src,src.target)
			viewers()<<sound('SFX/AttackSwish2.wav',0)
			flick("crashingleg",src)
			src.StaminaDrain(145)
			var/damage=round(rand(src.tai*750,src.tai*1250))
			var/damage2=(damage*0.15)/100
			var/damage3=(rand(src.tai*15,src.tai*25))
			for(var/mob/M in get_step(src,src.dir))
				if(damage>=1300)
					for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
						del(P)
				else
					if(damage3>700)
						damage=700
				if((M.ReactionBelow&&prob(55+(M.HanshaDefence*10))&&M.tai<src.tai)||(M.ReactionBelow&&prob(70+(M.HanshaDefence*10))&&M.tai>=src.tai))
					M<<"You dodge [src]'s kick as they try and hit you and you kick them!"
					src<<"[M] swiftly dodges your attack and then repeats your movements!"
					flick("crashingleg",M)
					flick("rasenganhit",src)
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
					src.stamina-=damage
					src.HitBack(10,M.dir)
					if(M.ReactionBelowCounter&&prob(25))
						M<<"You managed to cause Head trauma to [src] when you kicked them!"
						src<<"You feel dizzy!"
						src.DizzyProc(50)
					return
				if(M.KagDance=="Karamatsu")
					src.health-=damage2
					src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
					if(M.Deflection)
						src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
					return
				if(!M.Mogu&&M.FrozenBind!="DoBind")
					if(M.Kaiten|M.ingat)
						spawn() src.HitBack(4,(src.dir-4))
						return
					src.DodgeCalculation(M)
					if(M.Dodging || M.InHydro)
						M.Dodge();return
					if(M.Guarding)
						viewers()<<sound('SFX/Guard.wav',0)
					else
						viewers()<<sound('SFX/HitStrong.wav',0)
					spawn()AttackEfx(M.x,M.y,M.z)
					M.DamageProc(((damage/(M.Endurance/1.5))/(M.BaikaCharged+1)),"Stamina",src,"Guillotine Drop","yellow")
					if(src.RaiArmor==2)
						M.DamageProc(damage3,"Health",src,"Guillotine Drop","blue");src.ExpGain(M,damage)
					if(!M.Guarding)
						M.dir=src.dir;step(M,M.dir);sleep(1);step(M,M.dir);sleep(1);step(M,M.dir);M.StunAdd(2)

	Lariat()
		if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.BrokenLegs)
			return
		else
			src.StaminaDrain(200);var/I=10
			while(I>=1)
				flick("zan",src);step(src,src.dir)
				if(prob(50)) step(src,src.dir)
				for(var/mob/M in get_step(src,src.dir))
					I=0
				sleep(1)
				I--
			for(var/mob/M in get_step(src,src.dir))
				if((M.ReactionAbove&&prob(55)&&M.tai<src.tai)||(M.ReactionAbove&&prob(70)&&M.tai>=src.tai))
					M<<"You grab [src]'s arm as he flies at you and slam him into the ground!"
					src<<"[M] grabs your arm as you make contact with him and he slams you into the ground!"
					if(M.tai<src.tai)
						M.StaminaDrain(100)
					else
						M.StaminaDrain(50)
					src.stamina-=(M.tai*2)
					src.Bloody();src.Bloody();src.Bloody()
					src.DamageProc(M.tai*2,"Health",M)
					if(M.ReactionAboveCounter&&prob(25))
						M<<"You managed to break [src]'s arms while you grabbed them!"
						src<<"You can't feel your arms anymore!"
						src.BrokenArms=1
						src.BrokenArmsTime=(M.tai*2)
					if(M.ReactionAboveCounter&&prob(25))
						M<<"Your impact managed to give [src] slight head trauma!"
						src<<"You feel a bit dizzy."
						src.DizzyProc(50)
					return
				src.pixel_x=8
				flick("Attack1",src);var/damage=round(rand(src.tai*100,src.tai*135))
				src.pixel_x=0
				if(src.Trait=="Powerful")
					damage*=1.25
				damage/=(M.Endurance/15)
				if(damage>1800)
					damage=1800
				if(!M.Mogu && !M.InHydro)
					if(damage>=1500)
						for(var/obj/Jutsu/Elemental/Doton/EarthB/P in M.loc)
							del(P)
					else
						if(src.RaiArmor==2)
							damage=1000
					if(M.Kaiten|M.ingat|M.intank)
						spawn() src.HitBack(4,turn(src.dir,180))
						return
					if(M.sphere)
						viewers()<<sound('SFX/Guard.wav',0)
					else
						if(M.Guarding)
							viewers()<<sound('SFX/Guard.wav',0)
						else
							viewers()<<sound('SFX/HitStrong.wav',0)
						view(M)<<output("<font color=yellow size=2>[M] has been hit by Lariat!([damage])</font>","Attack")
						M.DamageProc(damage,"Stamina",src)
						if(src.RaiArmor==2)
							M.DamageProc(damage,"Health",src)
						spawn() M.HitBack(rand(5,10),src.dir)
						spawn()AttackEfx(M.x,M.y,M.z)


mob/proc/LigerBomb()
	if(src.Stun>=1|src.DoingHandseals|src.doingG|src.inso|src.Kaiten|src.resting|src.meditating|src.sphere|src.ingat|src.firing|src.FrozenBind!=""|src.doingG)
		return
	if(src.RaiArmor<2)
		usr<<"You need to be in Lightning Release Chakra Mode";return
	for(var/mob/M in get_step(src,src.dir))
		if(M.Kaiten||M.InHydro)
			return
		if(M.KagDance=="Karamatsu")
			src.health-=rand(150,300)
			src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
			if(M.Deflection)
				src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
			return
		spawn(30)
			usr.firing=0;usr.Frozen=0;
			M.Frozen=0;M.firing=0
		usr.icon_state = "throw"
		view(M) << "[usr] picks [M] up and raises him above his head"
		M.pixel_y+=16
		M.loc=locate(src.x,src.y,src.z)
		M.Frozen=1;M.firing=1
		usr.firing=1;usr.Frozen=1
		var/damage=round(src.tai*25)/(M.BaikaCharged+1)
		var/Range=5
		sleep(30)
		if(!M)
			return
		else
			view(M) << "[usr]: LIGER BOMB!!"
			M.health-=damage
			M.pixel_y-=16
			view(M) << "[usr] slams [M] into the ground head first"
			M.CreateCrator()
			for(var/turf/T in oview(Range,src))
				spawn()
					if(prob(17))
						T.CreateSmoke("Light")
//			for(var/mob/M in oview(Range,src))
//				spawn()
//					Quake_Effect(M,10,2)
//					AttackEfx2(M.x,M.y,M.z)
			src.icon_state = ""
			M.icon_state="dead"
			M.DamageProc(damage,"Health",src)
			damage+=src.TaijutsuMastery*5
			M.DamageProc(damage*2,"Stamina",src)
			M.Running=0;usr.firing=0;usr.Frozen=0;
			M.Frozen=0;
			spawn(10)
				M.Frozen=0;
				M.icon_state=""
			M.Death(src)