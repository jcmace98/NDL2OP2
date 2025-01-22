mob/Staff/verb
// Copy the code under and post it in the "Admin" file under mob/Staff/verb
	Timeskip()
		set category="Staff"
		var/varPeople = list()
		var/Selected = list()
		for(var/mob/M)
			if(M.client)
				varPeople +=M

		select1
		var/N = input(usr,"Select the people to timeskip!") in varPeople + list("Done","Cancel")
		if(N =="Cancel")
			return
		if(N!="Done")
			Selected+=N
			varPeople-=N
			goto select1

		select2
		var/addyear = input(usr,"How many years would you like them to age by?") as num
		var/addyearlog=addyear // For GM Logs
		var/addsp = input(usr,"How many starting points would you like to give?") as num
		var/confirm1 = input(usr,"Are you fine with these terms? Parameters :  AgeSkip: [addyear]  SP: [addsp]") in list("Yes","No","Cancel")
		if(confirm1=="Cancel")
			return
		if(confirm1=="No")
			goto select2

		for(var/mob/M in Selected)
			var/confirm2 = input(M,"An admin is giving you the choice to have a time skip, do you accept? 	Parameters:	 Age Skip: [addyear]   SP: [addsp]") in list("Yes","No")
			if (confirm2 == "Yes")
				M<<"You'll age by [addyear] year(s) and get [addsp] starting point(s), wait patiently!"
				while(addyear)
					M.AgeEXP = 999999
					if(M.Age == 17)
						M<<"If you didn't get a prompt for your second trait, wait till this is over and save and relog."
					sleep(10)
					addyear--
				M.StartingPoints += addsp
				M.AutoSave()
				M<<"You're good to go! Timeskip's over."
				text2file("[time2text(world.timeofday/600)]: [M] ([M.key]) had a timeskip from [usr]([usr.key]) with the parameters: AgeSkip:[addyearlog] SP:[addsp]<BR>","GMlog.html")
				return
			else
				return

			if(src.WeaponInLeftHand=="ChakraRod")
				var/Damage2=95
				var/Delay2=8
				var/WhatDoesItDo="Slash"
				if(WhatDoesItDo=="Slash")
					flick("weaponslash",src)
					src.LeftHandDelay=1
					src.Deflection=1;spawn(2+src.DeflectionZ)
						src.Deflection=0
					spawn(Delay2-src.SpeedDice)
						src.LeftHandDelay=0
						if(src.Clan!="Yotsuki")
							if(prob(2))
								if(src.SpeedDice<5)
									var/image/I = new('Icons/Jutsus/Skillcards.dmi');I.pixel_y=32;I.layer=6;I.icon_state="SwiftYes"
									src.overlays+=I
									spawn(15)
										src.overlays-=I
									src.SpeedDice+=0.5;if(src.SpeedDice>5) src.SpeedDice=5
							else
								if(prob(5))
									if(src.SpeedDice<5)
										var/image/I = new('Icons/Jutsus/Skillcards.dmi');I.pixel_y=32;I.layer=6;I.icon_state="SwiftYes"
										src.overlays+=I
										spawn(15)
											src.overlays-=I
										src.SpeedDice+=0.5;if(src.SpeedDice>5) src.SpeedDice=5
					for(var/mob/M in get_step(src,src.dir))
						if(M.Mogu)
							return
						src.DodgeCalculation(M,"Kenjutsu")
						if(M.Dodging)
							M.Dodge();return
						if(M.Clan=="Yotsuki"&&prob((M.DeflectionZ+M.Buffet+M.Teamwork+M.SpeedDice)*3)&&M.RightHandSheath||M.Deflection||M.WeaponMaster>6&&M.LeftHandSheath||M.WeaponMaster>6&&M.RightHandSheath)
							M<<output("Your weapons deflect each other!","Attack");src<<output("Your weapons deflect each other!","Attack");viewers()<<sound('SFX/SwordClash.wav',0,volume=40);M.Deflection=0;src.Deflection=0
							spawn() AttackEfx4(M.x,M.y,M.z,M.dir);AttackEfx4(src.x,src.y,src.z,src.dir)
							if(prob(1))
								M.DeflectionZ+=pick(0.1,0.3);if(M.DeflectionZ>5) M.DeflectionZ=5
							return
						else
							var/Type="Chakra"
							src.SliceHit(M,Damage2,Type,Power)
							if(prob(src.DoubleStrike*3))
								src.SliceHit(M,Damage2,Type,Power)
							if(prob(M.DeflectionZ*15))
								M.Deflection=1;spawn(2+src.DeflectionZ)
									M.Deflection=0

	ChakraReceiver()
		var/PreviousWeaponInHand=""
		if(src.sphere||src.Kaiten||src.firing)
			return
		PreviousWeaponInHand=src.WeaponInLeftHand
		src.underlays+='Icons/New Base/Weapons/ChakraReceiverU.dmi'
		src.overlays+='Icons/New Base/Weapons/ChakraReceiverO.dmi'
		src.ChakraReceiver=1
		view()<<"[src] generates a black rod, propelling out from their left palm."
		var/obj/WEAPONS/ChakraRod/T=new();src.WeaponInLeftHand=T;src.LeftHandSheath=1
		while(src.ChakraReceiver)
			src.WeaponInLeftHand=T;src.LeftHandSheath=1
			src.ChakraReceiver=1
			src.WeaponInLeftHand="ChakraRod"
			if(src.knockedout)
				src<<"As you fall unconcious your chakra receiver recedes back into your body."
				src.underlays-='Icons/New Base/Weapons/ChakraReceiverU.dmi'
				src.overlays-='Icons/New Base/Weapons/ChakraReceiverO.dmi'
				src.ChakraReceiver=0
				src.WeaponInLeftHand=PreviousWeaponInHand
				return
			sleep(1)
	ChakraReceiver()
		if(src.firing)
			return
		if(src.ChakraReceiver)
			src<<"The rod recedes.";src.WeaponInLeftHand="";src.LeftHandSheath=0
		else
			src.ChakraReceiver=1
			var/obj/WEAPONS/ChakraRod/T=new();src.WeaponInLeftHand=T;src.LeftHandSheath=1
			while(src.ChakraReceiver)
				src.WeaponInLeftHand=T;src.LeftHandSheath=1
				src.ChakraReceiver=1
				if(src.knockedout)
					src<<"As you fall unconcious your chakra receiver recedes back into your body."
					src.ChakraReceiver=0
					src.WeaponInLeftHand=""
					src.LeftHandSheath=0
				sleep(4)
//		else
//			src<<"The rod recedes.";src.WeaponInLeftHand="";src.LeftHandSheath=0
//			ChakraReceiver=0
	ChakraRod
		name="Black Receiver"
		icon_state="Receiver"
		Activate(mob/M)
			if(M.ChakraReceiver)
				M.underlays-='Icons/New Base/Weapons/ChakraReceiverU.dmi'
				M.overlays-='Icons/New Base/Weapons/ChakraReceiverO.dmi'
				M.ChakraReceiver=0
				src.DelayIt(600,M)
			src.Uses+=1
			M.ChakraReceiver(src.Uses)