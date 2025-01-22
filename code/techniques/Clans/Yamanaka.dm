//NEW CLAN!!!

mob/var/tmp/CastingMindControl=0
mob/proc/MindControlStruggle(mob/M)
	if(usr.controlled)
		usr<<"You're control of [usr.controlled] slips away.."
		usr.MindControlJutsu()
		return
	if(M.knockedout||M.Dead)
		src<<"You gain control of their body rather easily."
		M.knockedout=0
		M.Dead=0
		src.MindControlJutsu(M)
		sleep(50)
		while(src.controlled==M)
			if(M.Struggle>src.chakra||src.chakra<10||src.knockedout)
				src.MindControlJutsu(M)
				src<<"You lose your control over [M]!"
				M<<"Your mind is free from outside control!"
			src.chakra-=rand(75,150)
			sleep(50)
	else
		M<<"You feel your mind fading away, quickly tap SPACE to resist!"
		src<<"You begin to push for control over [M]'s mind, tap the SPACE struggle for it!"
		M.Struggle=0;src.Struggle=0
		spawn(100)
			if(M.Bijuu!="")
				M.Struggle*=2
			if(M.Struggle>src.Struggle+30)
				M<<"You resisted whatever was causing your mind to lose consciousness..."
				src<<"[M] resisted your attempt to control them.."
				M.Struggle=0;src.Struggle=0
				return
			else
				src<<"Success, you've taken control of [M]'s mind!"
				src.MindControlJutsu(M)
				sleep(50)
				while(src.controlled==M)
					if(M.Struggle>src.chakra||src.chakra<10||src.knockedout)
						src.MindControlJutsu(M)
						src<<"You lose your control over [M]!"
						M<<"Your mind is free from outside control!"
					src.chakra-=rand(75,150)
					sleep(50)



mob/proc/MindBodyDisturbanceTechnique(mob/M)
	usr=src
	if(!usr.controlled&&M)
		usr.controlled=M
		usr.client.eye=M
		usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
		usr.KBunshinOn=1
		M.RestrictOwnMovement=1
		M.icon_state="running"
		var/X=0
		for(var/obj/SkillCards/O in M.LearnedJutsus)//Loop through all the items in the players contents
			winset(usr, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
			usr << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
		winset(usr,"Jutsu.Jutsus", "cells=[X]")
		usr<<"Alt + Click on anything to release the Mind Control Jutsu."
		usr.UpdateInv()//3/13/2013
	else
		var/mob/O=usr.controlled
		if(O)
			O.RestrictOwnMovement=0
			O<<"Your mind has been freed from outside control!"
		usr.KBunshinOn=0
		usr.controlled=null
		usr.client.eye=usr
		usr.client.perspective=MOB_PERSPECTIVE
		usr.UpdateInv()

///Mind Disturbtion
mob/var/tmp/CastingMindBodyDisturbanceTechnique=0
mob/proc/MindBodyDisturbanceTechniqueStruggle(mob/M)
	if(usr.controlled)
		usr<<"You're control of [usr.controlled] slips away.."
		usr.MindControlJutsu()
		return
	if(M.knockedout||M.Dead)
		src<<"You gain control of their body rather easily."
		M.knockedout=0
		M.Dead=0
		src.MindBodyDisturbanceTechnique(M)
		sleep(50)
		while(src.controlled==M)
			if(M.Struggle>src.chakra||src.chakra<10||src.knockedout)
				src.MindBodyDisturbanceTechnique(M)
				src<<"You lose your control over [M]!"
				M<<"Your mind is free from outside control!"
			src.chakra-=rand(75,150)
			sleep(50)
	else
		M<<"You feel your mind fading away, quickly tap SPACE to resist!"
		src<<"You begin to push for control over [M]'s mind, tap the SPACE struggle for it!"
		M.Struggle=0;src.Struggle=0
		spawn(100)
			if(M.Bijuu!="")
				M.Struggle*=2
			if(M.Struggle>src.Struggle+30)
				M<<"You resisted whatever was causing your mind to lose consciousness..."
				src<<"[M] resisted your attempt to control them.."
				M.Struggle=0;src.Struggle=0
				return
			else
				src<<"Success, you've taken control of [M]'s mind!"
				src.MindBodyDisturbanceTechnique(M)
				sleep(50)
				while(src.controlled==M)
					if(M.Struggle>src.chakra||src.chakra<10||src.knockedout)
						src.MindBodyDisturbanceTechnique(M)
						src<<"You lose your control over [M]!"
						M<<"Your mind is free from outside control!"
					src.chakra-=rand(75,150)
					sleep(50)






mob/proc/MindControlJutsu(mob/M)
	usr=src
	if(!usr.controlled&&M)
		usr.controlled=M
		usr.client.eye=M
		usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
		usr.KBunshinOn=1
		M.RestrictOwnMovement=1
		M.icon_state="running"
		M.MentalDamage+=0.1;if(M.MentalDamage>10) M.MentalDamage=10
		var/X=0
		for(var/obj/SkillCards/O in M.LearnedJutsus)//Loop through all the items in the players contents
			winset(usr, "Jutsu.Jutsus", "current-cell=1,[++X]")	//Add multiple cells horizontally for each obj
			usr << output(O, "Jutsu.Jutsus")//Send the obj's in src.contents to the Grid
		winset(usr,"Jutsu.Jutsus", "cells=[X]")
		usr<<"Alt + Click on anything to release the Mind Control Jutsu."
		usr.UpdateInv()//3/13/2013
	else
		var/mob/O=usr.controlled
		if(O)
			O.RestrictOwnMovement=0
			O<<"Your mind has been freed from outside control!"
		usr.KBunshinOn=0
		usr.controlled=null
		usr.client.eye=usr
		usr.client.perspective=MOB_PERSPECTIVE
		usr.UpdateInv()
////////////////////
mob/proc/Yamanaka_Chakra_Sense()
	if(src.knockedout)
		src.ChakraSense=0
		return
	if(src.ChakraSense)
		src.ChakraSense=0
		return
	src.ChakraDrain(0)
	sleep(10)
	src.ChakraSense=1
	src<<"You're now able to sense chakra! Press Z + C to see if there is any noticable Chakra around you!"
	while(src.ChakraSense)
		src.ChakraDrain(0)
		sleep(15)


mob/proc/Telepathy()
	var/players[0]
	for(var/mob/M in world)
	var/mob/M = input("Who would you like to emote to?","Whisper") as null|anything in players
	if(!M) return
	var/msg = input("What would you like to emote to [M]?","Message") as text|null
	if(!msg) return
	usr<<"You say to [M]: [html_encode(copytext(msg,1,50000000))]"
	M<<"You hear something in your mind: [html_encode(copytext(msg,1,50000000))]"