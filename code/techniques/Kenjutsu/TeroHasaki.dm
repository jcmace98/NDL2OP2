mob/var/tmp/UsingSpinningSlash=0

mob
	proc
		DancingCrescentTechnique(Hand2)
			var/Distance=0
			var/obj/WEAPONS/CCA
			if(Hand2=="Right")
				CCA=src.WeaponInRightHand
			var/Damage=1
			if(CCA.SizeRating==1)
				Distance=5
				Damage=7
			if(CCA.SizeRating==2)
				Distance=3
				Damage=15
			if(CCA.SizeRating==3)
				Distance=1
				Damage=20
			if(src.firing||src.Frozen||src.knockedout)
				return
			src.icon_state="roundhouse-kick"
			sleep(5)
			src<<"You jump in the air with your blade!"
			flick("zan",src)
			var/Route = getline(src,get_steps(src,src.dir,Distance))-src.loc //Route between where you are, and your target!
			//get_steps() returns the spot thats [Distance] away from the user
			//And getline creates a path from one to the other. (-src.loc so it doesn't count the current tile)
			for(var/turf/T in Route)
				if(locate(/mob) in T || T.density) //If you encounter a wall, or a mob, break this loop.
					break
				else
					src.loc = T
			src.stamina-=(900/(src.Kenjutsu+1))
			for(var/mob/M in oview(1,src))
				if(M.Mogu||M.Dodging||M.Guarding||M.sphere)
					return
				spawn()
					M.Bloody()
					M.Bloody()
				Damage=(Damage*0.015)
				Damage=M.maxhealth*Damage
				M.DamageProc(Damage,"Health",src)
				viewers(10,M)<<sound('SFX/Slice.wav',0)
			sleep(9);src.icon_state=""

		AnarchistTechnique(Hand2,Uses)
			var/BonusChance=0
			var/BonusChance2=0
			var/AnarchistExpert=0
			var/obj/WEAPONS/CCA
			AnarchistExpert=(Uses/100)
			if(AnarchistExpert>15)
				AnarchistExpert=15
			BonusChance=((src.Kenjutsu/10)+1)
			if(Hand2=="Right")
				CCA=src.WeaponInRightHand
			if(CCA.SizeRating!=1)
				src<<"This weapon is too big to impale someone in the head with!"
				return
			if(src.target)
				BonusChance2=2
				src.dir=get_dir(src,src.dir)
		//	var/Damage=0.01
			var/X=rand(1,50)
			X+=BonusChance+BonusChance2+AnarchistExpert
			flick("Attack1",src)
			for(var/mob/M in get_step(src,src.dir))
				if(M.sphere)
					return
				src<<"You lunge your blade torward's [M]'s head!"
				if(X>=45)
					M<<"You were stabbed directly in the head!"
					M.Bloody();M.Bloody();M.Bloody()
					src<<"You managed to stab [M] directly in the head!"
					M.DamageProc(700,"Health",src)
				else if(X>=30)
					M<<"You were stabbed on the shoulder blade!"
					M.Bloody()
					src<<"You managed to stab [M] on the shoulder blade!"
					M.DamageProc(550,"Health",src)
				else if(X>=10)
					M<<"[src] completly missed with their weapon!"
			src.stamina-=(250/(src.Kenjutsu+1))

		DepartureInFlames(Hand2,Uses)
			var/Experience=(Uses/100)
			if(Experience>10)
				Experience=10
			var/BonusStruggle=0
			var/BonusStruggle2=0
			var/SurviveFlames=30
			var/obj/WEAPONS/CCA
			if(Hand2=="Right")
				CCA=src.WeaponInRightHand
			if(CCA.SizeRating==1)
				BonusStruggle=10
			if(src.Kenjutsu>=50)
				BonusStruggle2=5
			for(var/mob/M in get_step(src,src.dir))
				if(M.sphere)
					return
				if(M.dir==src.dir)
					src.icon_state="throw"
					src.firing=1;src.Frozen=1
					src<<"You grab [M] and quickly place your Blade underneath their neck getting ready to slice!"
					M.Frozen=1;M.firing=1
					if(M.Focus>250)
						M<<"You notice [src] grab you from behind and place their blade around your throat."
						M<<"Tap Spacebar and struggle out of their grab to stop their blade!"
					spawn(50)
						if(M.Struggle>(SurviveFlames+BonusStruggle+BonusStruggle2+Experience))
							M<<"You break out of [src]'s grab and stopped them from harming your throat!"
							src<<"[M] countered your grab!"
							M.firing=0;M.Frozen=0;src.Frozen=0;src.firing=0
						else
							M<<"Your Neck was sliced!";src<<"You sliced [M]'s neck!"
							M.firing=0;M.Frozen=0;src.Frozen=0;src.firing=0
							M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();
							spawn(30)
								if(prob(20+BonusStruggle+BonusStruggle2+Experience)||src.key=="")
									M<<"You lose too much blood from your slit throat!"
									M.Bloody();M.Bloody();M.Bloody();M.Bloody();M.Bloody();
									M.DamageProc(1500,"Health",src)
							M.DamageProc(350,"Health",src)
		KaitengiriTechnique(Hand2)
			var/SpinningLength=0
			var/SpinningExtra=0
			var/obj/WEAPONS/CCA
			if(Hand2=="Right")
				CCA=src.WeaponInRightHand
			if(CCA.SizeRating!=1)
				SpinningLength=10
			else
				SpinningLength=30
			src.UsingSpinningSlash=1
			SpinningExtra=((src.Kenjutsu/10)+1)
			SpinningLength+=SpinningExtra
			src<<"You begin to spin Slash repeatedly to all areas around you!"
			while(SpinningLength>0&&src.UsingSpinningSlash)
				src.icon_state="weaponslash"
				src.StaminaDrain(50)
				for(var/mob/M in oview(1,src))
					if(M.sphere)
						return
					if(M.KagDance=="Karamatsu")
						src.health-=10
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					spawn()
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(4,(src.dir-4))
							src.UsingSpinningSlash=0
						if(M.sphere||M.FrozenBind=="DoBind"||M.FrozenBind=="CBind")
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging)
								M.Dodge()
							else
								if(M.Guarding)
									viewers()<<sound('SFX/Guard.wav',0)
								else
									viewers()<<sound('SFX/HitMedium.wav',0)
						M.DamageProc(50,"Health",src)
						sleep(3)
				SpinningLength-=1
				sleep(5)
			src.UsingSpinningSlash=0

		AnzentaruEiketsuTechnique(Hand2)



			var/Damage=0
			Damage=(src.Kenjutsu/10)*5
			if(Damage>350)
				Damage=350
			var/mob/M
			for(var/mob/V in get_steps(src,src.dir,7))
				M = V
				break
			for(var/turf/T in getline(src,M))
				if(M in get_step(src,src.dir))
					if(M.KagDance=="Karamatsu")
						src.health-=350
						src<<output("You try to strike [M] but their bones stop you from attacking!","Attack");M<<output("You block out [src]'s attack","Attack")
						if(M.Deflection)
							src.DamageProc(src.maxhealth*0.03,"Health",M);spawn()Blood(src.x,src.y,src.z)
						return
					spawn()
						if(M.sphere)
							return
						if(M.Kaiten|M.ingat)
							spawn() src.HitBack(4,(src.dir-4))
							src.UsingSpinningSlash=0
						if(M.sphere||M.FrozenBind=="DoBind"||M.FrozenBind=="CBind")
							viewers()<<sound('SFX/Guard.wav',0)
						else
							src.DodgeCalculation(M)
							if(M.Dodging)
								M.Dodge()
							return
			///	if(T.density)
			//		return
				flick("zan",src)
				src.loc = T
				sleep(1)




		SanjuukenTechnique(Hand2)
			if(src.firing||src.knockedout)
				return
			if(src.target)
				src.dir=get_dir(src,src.target)
			src.Frozen=1
			for(var/mob/M in get_step(src,src.dir))
				if(M.Mogu||M.sphere)
					return
				var/X=3
				var/obj/WEAPONS/CCA
				var/Damage=1
		//		if(Hand=="Left")
		//			CCA=src.WeaponInLeftHand
		//		if(Hand=="Right")
		//			CCA=src.WeaponInRightHand
				if(Hand2=="Right")
					CCA=src.WeaponInRightHand
				Damage=CCA.PercentDamage
				var/SizeRating=CCA.SizeRating
				if(SizeRating==3&&src.Clan!="Kaguya")
					src<<"You can't do a set of rapid strikes with a sword like this.";return
				var/Type="Normal"
				if(CCA.ChakraDeplters)
					Type="Chakra"
				var/Power=10
				src.stamina-=(max(1000/(src.Kenjutsu+1),100))
				while(X>0&&M)
					flick("weaponslash",usr)
					src.DodgeCalculation(M,"Kenjutsu")
					if(M.Dodging)
						M.Dodge();X=0;return
					else
						spawn(1)
							if(CCA.name=="Tsubaki")
								src.TsubakiSlash(src.dir,0.036,0.045,src.reflexNew*10)
							else if(CCA.name=="Yanagi")
								src.Yanagi(M)
								src.Yanagi(M)
							else
								src.SliceHit(M,Damage,Type,Power,SizeRating)
						M.StunAdd(1)
						X--
					sleep(1)
			src.Frozen=0;return