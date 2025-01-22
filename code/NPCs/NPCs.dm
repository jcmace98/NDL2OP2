mob/Banker//the new banker!
	name = "Banker"
	CNNPC = 1
	health = 9999999999999999999999999999999999999999999999
	icon='Map/Turfs/HakumeiGetsu.dmi'
	icon_state="Moon2"
	New()
		.=..()
		spawn()
			src.icon=null
			var/Base='Icons/New Base/Base.dmi'
			var/Hair='Icons/New Base/Hair/narutoH.dmi'
			Base+=rgb(235,145,52)
			Hair+=rgb(50,50,50)
			src.icon=Base
			src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays-='Icons/New Base/MaleEyes.dmi'
			src.overlays+='Icons/New Base/MaleEyes.dmi'
			src.overlays-='Icons/New Base/Eyes.dmi'
			src.overlays+='Icons/New Base/Eyes.dmi'
			src.overlays-='Icons/New Base/Clothing/kakashi mask.dmi'
			src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
			src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
			src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
			src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays-=Hair
			src.overlays+=Hair
	verb
		Deposit()
			set src in oview(3)
			set category = "Bank"
			var/heh = input(usr,"You have [usr.Yen] yen. How much do you wish to deposit?","Deposit") as num
			if (heh < 0)
				alert(usr,"Don't try cheating me!","Bank Keeper")
				return()
			if (heh > usr.Yen)
				alert(usr,"You don't have that much yen!", "Deposit")
				return()

			usr << "You deposit [heh] Yen."
			usr<<sound('SFX/Cash.wav')
			usr.Yen -= heh
			usr.goldinbank += heh
			return()

		Withdraw()
			set src in oview(3)
			set category = "Bank"
			var/heh = input(usr,"You have [usr.goldinbank] yen in the bank. How much do you wish to withdraw?","Withdraw") as num
			if (heh < 0)
				alert(usr,"You can't withdraw less then 1 yen!","Bank Keeper")
				return()
			if (heh > usr.goldinbank)
				alert(usr,"You don't have that much yen in the bank!", "Bank Keeper")
				return()

			usr << "You withdraw [heh] yen."
			usr.Yen += heh
			usr.goldinbank -= heh
			usr<<sound('SFX/Cash.wav')
			return()

		CheckBalance()
			set src in oview(3)
			set category = "Bank"
			set name = "Check Balance"
			usr << "You have [usr.goldinbank] yen in the bank."
mob/Vet
	name = "Vet"
	CNNPC = 1
	health = 9999999999999999999999999999999999999999999999
	icon='Map/Turfs/HakumeiGetsu.dmi'
	icon_state="Moon2"
	New()
		.=..()
		spawn()
			src.icon=null
			var/Base='Icons/New Base/Base.dmi'
			Base+=rgb(235,145,52)
			src.icon=Base
			src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays-='Icons/New Base/MaleEyes.dmi'
			src.overlays+='Icons/New Base/MaleEyes.dmi'
			src.overlays-='Icons/New Base/Eyes.dmi'
			src.overlays+='Icons/New Base/Eyes.dmi'
			src.overlays-='Icons/New Base/Clothing/kakashi mask.dmi'
			src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
			src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
			src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
			src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
	verb
		Heal()
			set src in oview(3)
			set category = "Dog"
			if(usr.Yen <= 200)
				usr<<"You need 200 Yen to heal your dog!"
			else
				if(usr.hasdog)
					usr.PetsHealth=usr.PetsMHealth
					usr.PetsStamina=usr.PetsMStamina
					usr.PetsChakra=usr.PetsMChakra
					usr.Yen-=200
					usr<<"All done"
					return
				else
					usr<<"You don't own a dog OR It needs to be picked up."
					return
		DogRanAway()
			set src in oview(3)
			set category = "Dog"
			for(var/mob/pet/P in world)
				if(P.Owner==usr)
					del(P)
			usr.hasdog=0
			usr<<"Go get a new pet."

mob
	var/tmp
		moving=0




proc/Name2Mob(var/mName as text)
	for(var/mob/i in world)
		if("[lowertext(i.name)]" == "[lowertext(mName)]")
			return i
mob
	tailor
		name = "Barber"
		icon = 'Haircuter.dmi'
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		verb
			Talk()
				set src in oview(2)
				set category ="Hair-cut"
				if(usr.Skill_Tree)
					usr<<sound('SFX/click2.wav',0)
					usr.client.perspective=MOB_PERSPECTIVE
					usr.client.eye=usr
					usr.Skill_Tree=0
				switch(input(usr,"Want me to fix that mop on your head you call hair?", text) in list ("Yes","No"))
					if("Yes")
						usr<<"Only your view has changed, Now select a hair style you like by clicking on it."
						usr<<"To Refresh the color, click on the color blocks and then click on your desired hair style to see a preview."
						usr<<sound('SFX/click1.wav',0)
						usr.Skill_Tree=1
						usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
						usr.client.eye=locate(172,29,20)
						var/d1 = locate(164,24,20)
						var/d2 = locate(166,24,20)
						var/d3 = locate(166,22,20)
						var/d4 = locate(164,22,20)
						usr.pic5()//new stuff
						var/icon/P = icon(usr.TIcon)
						usr.TIcon=null//end new stuff
						var/image/A = image(P,d1,"",103,NORTH)
						usr.pic()//new stuff
						var/icon/I = icon(usr.TIcon)
						usr.TIcon=null//end new stuff
						var/image/B = image(I,d2,"",103,SOUTH)
						usr.pic6()
						var/icon/X = icon(usr.TIcon)
						usr.TIcon=null
						var/image/C = image(X,d3,"",103,EAST)
						usr.pic7()
						var/icon/Y = icon(usr.TIcon)
						usr.TIcon=null
						var/image/D = image(Y,d4,"",103,WEST)
					//	var/image/A = image(usr.icon,d1,"",103,NORTH);var/image/B = image(I,d2,"",103,SOUTH);var/image/C = image(usr.icon,d3,"",103,EAST);var/image/D = image(usr.icon,d4,"",103,WEST)

						usr<<A;usr<<B;usr<<C;usr<<D
mob/owner/verb/Take_Out_An_Eye(mob/M in world)
	M.halfb = 1
	M.client.screen += new /obj/black2
	M << "[usr] rips your eyeball out .........HAHA! Your a cyclops!!"
	usr << "You see [M]'s eyeball roll around on the floor, teehee!"
mob
	nurse
		icon_state = ""
		density = 1
		CNNPC = 1
		health = 9999999999999999999999
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/InoH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(50,50,50)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-='gloves.dmi'
				src.overlays+='gloves.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb
			Talk()
				set src in oview(1)
				if(usr.health>=usr.maxhealth)
					usr << "Nurse : Hello, I am a fully qualified nurse, I can heal you if your hurt or half blinded. Just talk to me then."
					return
				if(usr.CBleeding)
					alert(usr,"Oh my dear god, your chest has been completely pushed in! Let me heal you!")
					usr.sight |= BLIND
					usr.CBleeding=0
					sleep(100)
					usr.sight &= ~BLIND
					usr<<"Nurse: There we go, all better. That was a serious wound!"
					return
				if(usr.health<usr.maxhealth)
					usr<<"You seem hurt! Allow me to assist you!!"
					if(usr.Yen>=500)
						usr.health = usr.maxhealth
						usr.chakra = usr.Mchakra
						usr << "Nurse : There, you're all better now, now I will take this from you  *takes a sack of 500 yen from you* "
						usr.Yen -= 500
					else
						usr << "Nurse : GET LOST YOU POOR HOBO, I WONT TOUCH YOUR FILTHY SKIN!"
						return
