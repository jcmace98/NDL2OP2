var/list/VillageAttackers = list()//Adding this for a new mission
mob/var/tmp
	OnMission=0
	picked=0
	CompletedMission=0
mob/var
	tmp/ATarget=""
	tmp/HowManyMissingNeededToKill=0
	tmp/NumberOfSteps=0
	tmp/NumberOfWolvesKilled=0
	tmp/NumberOfWolvesNeededToKill=0
	tmp/NumberOfFlowersCollected=0
	tmp/NumberOfFlowersNeededToCollect=0
	tmp/NumberOfNinjaDefeated=0
	tmp/NumberOfNinjaNeededToDefeat=0
obj/MissingStuff
	Event_Mission_Complete
		icon = 'scrolls.dmi'
		icon_state="gay scroll"
		layer=MOB_LAYER+3
		Gauntlet//This doesn't work lololol......
			verb
				Get()
					set src in oview(1)
					if(usr.CurrentMission!="Gauntlet")
						usr.GotoVillageHospital();return
					usr<<"<font face=verdana>You picked up the [src]"
					usr.MissionComplete();usr.GotoVillageHospital()
	MissionHazard
		icon = 'scrolls.dmi'
		icon_state="gay scroll"
		invisibility=101
		dir=EAST
		var/Prey
		New()
			..()
			spawn()
				while(src)
					for(var/mob/M in OnlinePlayers)
						if(prob(30))
							M=Prey
							M<<"You feel as though something is watching you..."
						if(M in oview(10,src)&&src.Prey==M)
							var/obj/Jutsu/Elemental/Suiton/SuitonSuikoudan/K=new();
							K.name="[src]";
							K.loc=src.loc;
							K.nin=25
							K.Owner=src;
							K.JutsuLevel=50
							K.Move_Delay=0;
							K.dir=src.dir//turn(src.dir,45*SS)
							walk(K,K.dir);
					sleep(10)
	PeaceNote
		icon = 'scrolls.dmi'
		icon_state="gay scroll"
		var
			tmp
				WhoItBelongsTo=""
				WhichVillageGoingTo=""
				WhichVillageIsDelivering=""
		layer=MOB_LAYER+3
		verb
			Get()
				set src in oview(1)
				if(usr.CurrentMission!="Negotiating Peace With Rock"&&usr.CurrentMission!="Negotiating Peace With Leaf"&&usr.CurrentMission!="Negotiating Peace With Rain"&&usr.CurrentMission!="Negotiating Peace With Sound")
					usr<<"You pick up the Peace Note and rip it up, with disdain torwards [WhoItBelongsTo] and the [WhichVillageIsDelivering] Village..."
					var/mob/M=WhoItBelongsTo
					for(M in OnlinePlayers)
						if(M.CurrentMission=="Negotiating Peace With Rock"||M.CurrentMission=="Negotiating Peace With Leaf"||M.CurrentMission=="Negotiating Peace With Rain"||M.CurrentMission=="Negotiating Peace With Sound")
							M<<"You have lost the Peace Note that you were supposed to deliver to the [WhichVillageGoingTo] Village...."
							M<<"You have failed your Mission.."
							M.OnMission=0
							M.TimeLimit=10
					del(src)
				if(usr.CurrentMission=="Negotiating Peace With Rock"||usr.CurrentMission=="Negotiating Peace With Leaf"||usr.CurrentMission=="Negotiating Peace With Rain"||usr.CurrentMission=="Negotiating Peace With Sound")
					usr<<"You pick back up the Peace Note!"
					del(src)
			ReadNote()
				usr<<"You begin to read the Peace Note."
				sleep(15)
				if(usr.Village=="Leaf")
					usr<<"I, [Hokage], the Leader of the Hidden Leaf Village, would like to reduce the tension between the Hidden [WhichVillageGoingTo] Village, please bring this note back if you would like to discuss this any further.";return
				if(usr.Village=="Sound")
					usr<<"I, [Otokami], the Leader of the Hidden Sound Village, would like to reduce the tension between the Hidden [WhichVillageGoingTo] Village, please bring this note back if you would like to discuss this any further.";return
				if(usr.Village=="Rock")
					usr<<"I, [Tsuchikage], the Leader of the Hidden Rock Village, would like to reduce the tension between the Hidden [WhichVillageGoingTo] Village, please bring this note back if you would like to discuss this any further.";return
				if(usr.Village=="Rain")
					usr<<"I, [Amekoutei], the Leader of the Hidden Rain Village, would like to reduce the tension between the Hidden [WhichVillageGoingTo] Village, please bring this note back if you would like to discuss this any further.";return
		//	CheckDetails()
		//		usr<<"Whose this is: [WhoItBelongsTo]. Which Village to Deliver: [WhichVillageGoingTo]. Which Village is delivering this Peace Note: [WhichVillageIsDelivering]."

	Hidden_Scroll
		icon = 'scrolls.dmi'
		icon_state="gay scroll"
		layer=MOB_LAYER+3
		verb
			Get()
				set src in oview(1)
				if(usr.CurrentMission!="Find The Hidden Scroll")
					usr<<"You decide not to pick it up after noticing someone might've lost it.";return
				var/has=0
				for(var/obj/MissingStuff/Hidden_Scroll/A in src.contents)
					has=1
				if(has)
					usr<<"You already have one!";return
				usr<<"<font face=verdana>You picked up the [src]"
				usr.MissionComplete()
				del(src)
	Poster
		icon='Scenary.dmi'
		icon_state="Poster"
		layer=MOB_LAYER+3
		verb
			Get()
				set src in oview(1)
				if(usr.CurrentMission!="Poster Retrieve")
					usr<<"What a pretty poster!";return
				var/has=0
				for(var/obj/MissingStuff/Poster/A in src.contents)
					has=1
				if(has)
					usr<<"You already have one!";return
				usr<<"<font face=verdana>You picked up the [src]"
				usr.MissionComplete()
				del(src)
	Banana
		icon='Food.dmi'
		icon_state="26"
		layer=MOB_LAYER+3
		verb
			Get()
				set src in oview(1)
				if(usr.BananaMission==1)
					usr<<"That looks delicious";return
				var/has=0
				for(var/obj/MissingStuff/Banana/A in src.contents)
					has=1
				if(has)
					usr<<"You already have one!";return
				usr<<"<font face=verdana>You picked up the [src]"
				usr.BananaMission=1
				usr.MissionComplete()
				del(src)

mob/proc/MissionComplete()
	src.OnMission=0
	src<<"You've completed the mission!"
	if(src.CurrentMission=="Shin's Supplies")
		src.CurrentMission="Shin's Supplies Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Shin's Supplies")
							M.CurrentMission="Shin's Supplies Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Find Stray Dog")
		src.CurrentMission="Find Stray Dog Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Find Stray Dog")
							M.CurrentMission="Find Stray Dog Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Ryu's Package")
		src.CurrentMission="Ryu's Package Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Ryu's Package")
							M.CurrentMission="Ryu's Package Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Ryu's Informational")
		src.CurrentMission="Ryu's Informational Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Ryu's Informational")
							M.CurrentMission="Ryu's Informational Complete"
							M<<"The Mission is Completed by [src] as the information has been delivered to Ryu! Report back to the Mission Jounin!"
	if(src.CurrentMission=="Find Rain Climate")
		src.CurrentMission="Find Rain Climate Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Find Rain Climate")
							M.CurrentMission="Find Rain Climate Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Find Heavy Rain Climate")
		src.CurrentMission="Find Heavy Rain Climate Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Find Heavy Rain Climate")
							M.CurrentMission="Find Heavy Rain Climate Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Find The Hidden Scroll")
		src.CurrentMission="Find The Hidden Scroll Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Find The Hidden Scroll")
							M.CurrentMission="Find The Hidden Scroll Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Jog Walk")
		src.CurrentMission="Jog Walk Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Jog Walk")
							M.CurrentMission="Jog Walk Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Poster Retrieve")
		src.CurrentMission="Poster Retrieve Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Poster Retrieve")
							M.CurrentMission="Poster Retrieve Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Collect Flowers")
		src.CurrentMission="Collect Flowers Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Collect Flowers")
							M.CurrentMission="Collect Flowers Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Kill A Wolf")
		src.CurrentMission="Kill A Wolf Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Kill A Wolf")
							M.CurrentMission="Kill A Wolf Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Find Wolf Mane")
		src.CurrentMission="Find Wolf Mane Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Find Wolf")
							M.CurrentMission="Find Wolf Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Fierce Wolves")
		src.CurrentMission="Fierce Wolves Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Fierce Wolves Mane")
							M.CurrentMission="Fierce Wolves Mane Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Find Dark Wolf Mane")
		src.CurrentMission="Find Dark Wolf Mane Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Find Dark Wolf Mane Mane")
							M.CurrentMission="Find Dark Wolf Mane Mane Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Negotiating Peace With Rock"||src.CurrentMission=="Negotiating Peace With Leaf"||src.CurrentMission=="Negotiating Peace With Rain"||src.CurrentMission=="Negotiating Peace With Sound")
		if(src.CurrentMission=="Negotiating Peace With Rock")
			src.CurrentMission="Negotiating Peace With Rock Complete"
			if(src.guild_member)
				for(var/mob/M in world)
					if(M.guild_name==src.guild_name)
						src.ATarget=""
						if(M!=src)
							if(M.CurrentMission=="Negotiating Peace With Rock")
								M.CurrentMission="Negotiating Peace With Rock Complete"
								M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
		if(src.CurrentMission=="Negotiating Peace With Leaf")
			src.CurrentMission="Negotiating Peace With Leaf Complete"
			if(src.guild_member)
				for(var/mob/M in world)
					if(M.guild_name==src.guild_name)
						src.ATarget=""
						if(M!=src)
							if(M.CurrentMission=="Negotiating Peace With Leaf")
								M.CurrentMission="Negotiating Peace With Leaf Complete"
								M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
		if(src.CurrentMission=="Negotiating Peace With Rain")
			src.CurrentMission="Negotiating Peace With Rain Complete"
			if(src.guild_member)
				for(var/mob/M in world)
					if(M.guild_name==src.guild_name)
						src.ATarget=""
						if(M!=src)
							if(M.CurrentMission=="Negotiating Peace With Rain")
								M.CurrentMission="Negotiating Peace With Rain Complete"
		if(src.CurrentMission=="Negotiating Peace With Sound")
			src.CurrentMission="Negotiating Peace With Sound Complete"
			if(src.guild_member)
				for(var/mob/M in world)
					if(M.guild_name==src.guild_name)
						src.ATarget=""
						if(M!=src)
							if(M.CurrentMission=="Negotiating Peace With Sound")
								M.CurrentMission="Negotiating Peace With Sound Complete"
	if(src.CurrentMission=="Represent!")
		src.CurrentMission="Represent! Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Represent!")
							M.CurrentMission="Represent! Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Village Betrayal Enforcement")
		src.CurrentMission="Village Betrayal Enforcement Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Village Betrayal Enforcement")
							M.CurrentMission="Village Betrayal Enforcement Complete"
							M<<"The Mission is Completed by [src] as they have killed the Village Attacker. Report back to the Mission Jounin!"

	if(src.CurrentMission=="Assassination Mission")
		src.CurrentMission="Assassination Mission Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Assassination Mission")
							M.CurrentMission="Assassination Mission Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Track And Defeat")
		src.CurrentMission="Track And Defeat Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					src.ATarget=""
					if(M!=src)
						if(M.CurrentMission=="Track And Defeat")
							M.CurrentMission="Track And Defeat Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="High Class Level Assassination")
		src.CurrentMission="High Class Level Assassination Complete"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="High Class Level Assassination")
							M.CurrentMission="High Class Level Assassination Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"
	if(src.CurrentMission=="Gauntlet")
		src.CurrentMission="Gauntlet"
		if(src.guild_member)
			for(var/mob/M in world)
				if(M.guild_name==src.guild_name)
					if(M!=src)
						if(M.CurrentMission=="Gauntlet")
							M.CurrentMission="Gauntlet Complete"
							M<<"The Mission is Completed by [src] Report back to the Mission Jounin!"

mob/var/tmp/MissionJoinLaw=0
mob/proc/AlertSquadMatesofMission(mob/M)
	if(src.MissionJoinLaw)
		if(src.CurrentMission!="")
			return
		src<<"You are now on [M.CurrentMission] Mission, accepted by [M]!"
		src<<"Talk to [M] for any Mission Information,"
		src.CurrentMission=M.CurrentMission
		src.TimeLimit=M.TimeLimit
		src.ATarget=M.ATarget
		src.HowManyMissingNeededToKill=M.HowManyMissingNeededToKill

mob/proc/RewardMission()
	if(!findtext(src.CurrentMission,"Complete",1,0))
		src<<"You still haven't completed the Mission, huh?"
	else
		src<<"Congratulations! Here's your reward!"
		src.OnMission=0
		var/WhatMission
		var/MoneyGain=0
		var/MissionRankZ="D"
		if(src.CurrentMission=="Find Stray Dog Complete")
			WhatMission="Find Stray Dog"
			MoneyGain=6000
			MissionRankZ="D"
		if(src.CurrentMission=="Ryu's Package Complete")
			WhatMission="Ryu's Package"
			MoneyGain=3500
			MissionRankZ="D"
		if(src.CurrentMission=="Ryu's Informational Complete")
			WhatMission="Ryu's Informational"
			MoneyGain=3500
			MissionRankZ="D"
		if(src.CurrentMission=="Check On Uchiha Jack Complete")
			WhatMission="Check On Uchiha Jack"
			MoneyGain=6000
			MissionRankZ="D"
		if(src.CurrentMission=="Find Rain Climate Complete")
			WhatMission="Find Rain Climate"
			MoneyGain=20000
			MissionRankZ="D"
		if(src.CurrentMission=="Find Heavy Rain Climate Complete")
			WhatMission="Find Heavy Rain Climate"
			MoneyGain=20000
			MissionRankZ="D"
		if(src.CurrentMission=="Jog Walk Complete")
			WhatMission="Jog Walk"
			MoneyGain=7500
			MissionRankZ="D"
		if(src.CurrentMission=="Find The Hidden Scroll Complete")
			WhatMission="Find The Hidden Scroll"
			MoneyGain=8500
			MissionRankZ="D"
		if(src.CurrentMission=="Poster Retrieve Complete")
			WhatMission="Poster Retrieve"
			MoneyGain=8000
			MissionRankZ="D"
		if(src.CurrentMission=="Collect Flowers Complete")
			WhatMission="Collect Flowers"
			MoneyGain=2500*src.NumberOfFlowersNeededToCollect
			MissionRankZ="D"
		if(src.CurrentMission=="Kill A Wolf Complete")
			WhatMission="Kill A Wolf"
			MoneyGain=50000
			MissionRankZ="C"
		if(src.CurrentMission=="Find Wolf Mane Complete")
			WhatMission="Find Wolf Mane"
			MoneyGain=45000
			MissionRankZ="C"
		if(src.CurrentMission=="Fierce Wolves Complete")
			WhatMission="Fierce Wolves"
			MoneyGain=30000
			MissionRankZ="C"
		if(src.CurrentMission=="Find Dark Wolf Mane Complete")
			WhatMission="Find Dark Wolf Mane"
			MoneyGain=35000
			MissionRankZ="C"
		if(src.CurrentMission=="Represent! Complete")
			WhatMission="Represent!"
			MoneyGain=100000
			MissionRankZ="B"
		if(src.CurrentMission=="Village Betrayal Enforcement Complete")
			WhatMission="Village Betrayal Enforcement"
			MoneyGain=90000
			MissionRankZ="B"
		if(src.CurrentMission=="Negotiating Peace With Rock Complete")
			WhatMission="Negotiating Peace With Rock"
			MoneyGain=100000
			MissionRankZ="B"
		if(src.CurrentMission=="Negotiating Peace With Leaf Complete")
			WhatMission="Negotiating Peace With Leaf"
			MoneyGain=100000
			MissionRankZ="B"
		if(src.CurrentMission=="Negotiating Peace With Rain Complete")
			WhatMission="Negotiating Peace With Rain"
			MoneyGain=100000
			MissionRankZ="B"
		if(src.CurrentMission=="Negotiating Peace With Sound Complete")
			WhatMission="Negotiating Peace With Sound"
			MoneyGain=100000
			MissionRankZ="B"
		if(src.CurrentMission=="Assassination Mission Complete")
			WhatMission="Assassination Mission"
			MoneyGain=500000
			MissionRankZ="A"
		if(src.CurrentMission=="Track And Defeat Complete")
			WhatMission="Track And Defeat"
			MoneyGain=500000
			MissionRankZ="A"
		if(src.CurrentMission=="High Class Level Assassination Complete")
			WhatMission="High Class Level Assassination"
			MoneyGain=1000000
			MissionRankZ="S"
			var/mob/T
			for(var/mob/M in range(5,src))
				if(M.name=="[src.ATarget]'s corpse"){T=M}
			if(!T){src<<"You need to bring the body back with you! We need it to extract the information!!";return}
			else
				del(T)
		if(src.CurrentMission=="Gauntlet Complete")
			WhatMission="Gauntlet"
			MoneyGain=1000000
			MissionRankZ="S"
		MissionPayout(src,WhatMission,MissionRankZ,MoneyGain,src.Village)
mob/proc/GiveMission(MissionName,TimeLimit,Award,MissionDescription)
	src<<"<b><font face=verdana>[MissionDescription]"
	src<<"<b><font face=verdana>Award: [Award] Ryo."
	src.CurrentMission=MissionName;src.TimeLimit=TimeLimit
	if(src.guild_member)
		for(var/mob/M in world)
			if(M.guild_name==src.guild_name)
				if(M!=src)
					M.AlertSquadMatesofMission(src)
obj/proc/DeleteScroll(var/TimeLimit=600)
	sleep(TimeLimit)
	del(src)
mob/proc/RandomMissionGenerator(Rank,Village)
	var/MissionAward=0
	var/B = rand(1,4)
	src.OnMission=1
//	if(src.OnMission)
//		src<<"You're already doing a mission!";return
	if(Rank=="D")
		Randomizer
		var/PickMission=rand(1,9)
		if(PickMission==1)
			if(Village!="Leaf")
				goto Randomizer
			else
				src.GiveMission("Ryu's Package",300,3500,"I need you to deliver a package to Ryu.")
				return
		if(PickMission==9)
			if(Village!="Leaf")
				goto Randomizer
			else
				src.GiveMission("Ryu's Informational",350,3500,"I have some important news that you need to give to Ryu. Go and tell him this news as soon as possible, then report back to me after you've done so.")
		if(PickMission==2)
			src.NumberOfSteps=0
			src.GiveMission("Jog Walk",300,6500,"This is a simple mission! Don't worry! We need you to take a quick Jog, this'll help us with our rating system! Don't worry about the scamatics, we just need you to run at maximum speed for 1000 steps. That's not bad right?")
			return
		if(PickMission==3)

			var/obj/MissingStuff/Poster/A=new()
			if(Village=="Leaf")
				A.loc=locate(rand(42,47),54,11)
			if(Village=="Rain")
				if(B==1)
					A.loc=locate(71,119,6)
				else if(B==2)
					A.loc=locate(89,130,6)
				else if(B==3)
					A.loc=locate(51,135,6)
				else
					A.loc=locate(81,154,6)
			if(Village=="Rock")
				A.loc=locate(rand(53,56),33,14)
			if(Village=="Sound")
				A.loc=locate(rand(89,93),99,4)
			src.GiveMission("Poster Retrieve",300,5000,"Well hey! Can you do us a favor and take off that poster on the wall we put a couple of weeks ago? Thanks!")
			src<<"<b><font face=verdana>The Poster is located at [A.x],[A.y]!"
		if(PickMission==4)
			src.GiveMission("Find The Hidden Scroll",600,8000,"Woops, we seem to have lost a scroll somewhere within the village! Could you find it perhaps?")
			var/obj/MissingStuff/Hidden_Scroll/A=new()
			NewLoc
			var/X=rand(1,192)
			var/Y=rand(1,192)
			var/Z
			if(src.Village=="Leaf")
				var/i=rand(1,38)
				if(i==1) X=rand(14,42);Y=rand(35,39)
				if(i==2) X=rand(50,76);Y=rand(40,44)
				if(i==3) X=rand(21,75);Y=rand(46,53)
				if(i==4) X=rand(13,20);Y=rand(50,67)
				if(i==5) X=rand(15,20);Y=rand(68,82)
				if(i==6) X=rand(15,65);Y=rand(85,88)
				if(i==7) X=rand(15,29);Y=rand(89,103)
				if(i==8) X=rand(13,18);Y=rand(90,103)
				if(i==9) X=rand(13,18);Y=rand(108,123)
				if(i==10) X=13;Y=rand(108,140)
				if(i==11) X=rand(13,60);Y=rand(132,133)
				if(i==12) X=rand(13,29);Y=rand(129,140)
				if(i==13) X=rand(31,49);Y=rand(132,156)
				if(i==14) X=rand(23,50);Y=rand(149,151)
				if(i==15) X=rand(13,27);Y=rand(145,150)
				if(i==16) X=rand(13,17);Y=rand(145,156)
				if(i==17) X=rand(23,27);Y=rand(146,156)
				if(i==18) X=rand(51,62);Y=rand(145,150)
				if(i==19) X=rand(63,96);Y=rand(149,150)
				if(i==20) X=rand(72,96);Y=rand(145,156)
				if(i==21) X=rand(84,96);Y=rand(140,144)
				if(i==22) X=rand(86,96);Y=rand(138,139)
				if(i==23) X=rand(86,91);Y=rand(133,136)
				if(i==24) X=rand(59,62);Y=rand(39,111)
				if(i==25) X=rand(16,89);Y=rand(116,123)
				if(i==26) X=rand(64,91);Y=rand(130,132)
				if(i==27) X=rand(83,125);Y=rand(126,130)
				if(i==28) X=rand(96,143);Y=rand(157,159)
				if(i==29) X=rand(141,143);Y=rand(148,159)
				if(i==30) X=rand(116,143);Y=rand(148,151)
				if(i==31) X=rand(116,119);Y=rand(122,159)
				if(i==32) X=rand(96,101);Y=rand(116,134)
				if(i==33) X=rand(115,116);Y=rand(81,136)
				if(i==34) X=rand(70,148);Y=rand(91,98)
				if(i==35) X=rand(119,143);Y=rand(110,112)
				if(i==36) X=rand(74,141);Y=rand(82,95)
				if(i==37) X=rand(74,76);Y=rand(87,112)
				if(i==38) X=rand(60,76);X=rand(109,112)
				Z=11
			//	Z=rand(11,12)
			if(src.Village=="Rock")
				var/i=rand(1,10)
				if(i==1) X=rand(47,140);Y=rand(28,36)
				if(i==2) X=rand(132,140);Y=rand(28,56)
				if(i==3) X=rand(132,157);Y=rand(50,56)
				if(i==4) X=rand(101,153);Y=rand(7,9)
				if(i==5) X=rand(78,95);Y=rand(155,161)
				if(i==6) X=rand(122,141);Y=rand(62,65)
				if(i==7) X=rand(76,125);Y=rand(71,76)
				if(i==8) X=rand(76,84);Y=rand(71,101)
				if(i==9) X=rand(23,84);Y=rand(99,100)
				if(i==10) X=rand(44,60);Y=rand(87,97)
				Z=14
			if(src.Village=="Rain")
				Z=6
			if(src.Village=="Sound")
			//	Z=rand(4,5)
				var/i=rand(1,14)
				if(i==1) X=rand(61,65);Y=rand(31,73)
				if(i==2) X=rand(41,59);Y=rand(61,76)
				if(i==3) X=rand(41,45);Y=rand(61,85)
				if(i==4) X=rand(41,68);Y=rand(91,93)
				if(i==5) X=rand(41,45);Y=rand(91,111)
				if(i==6) X=rand(41,68);Y=rand(108,111)
				if(i==7) X=rand(67,68);Y=rand(91,111)
				if(i==8) X=rand(51,87);Y=rand(84,85)
				if(i==9) X=rand(89,106);Y=rand(89,96)
				if(i==10) X=rand(78,113);Y=rand(45,61)
				if(i==11) X=rand(95,157);Y=rand(72,74)
				if(i==12) X=rand(146,149);Y=rand(45,136)
				if(i==13) X=rand(87,113);Y=rand(110,127)
				if(i==14) X=rand(152,165);Y=rand(123,152)
				Z=4
			var/specificlocation=locate(X,Y,Z)
			for(var/turf/T in range(0,specificlocation))
				if(T.density)
					goto NewLoc
			A.loc=specificlocation
			spawn()
				A.DeleteScroll(1800)
			src<<"<b><font face=verdana>The scroll was last located at [A.x],[A.y],[A.z]. See if you can find it for us? Thank you!"
			return
		if(PickMission==5)
			if(Village=="Rock")//Rock has no flowers, does it? xD lololololol.
				goto Randomizer
			else//10 min?
				var/AX=rand(4,8)
				src.GiveMission("Collect Flowers",2000*AX,2500*AX,"The village is running low on medical supplies! We need you to go and recover [AX] flowers. We've found that they all have their uses..")
				src.NumberOfFlowersCollected=0;src.NumberOfFlowersNeededToCollect=AX
				return
		if(PickMission==6)
			goto Randomizer
		/*	var/WeatherChoice=rand(1,2)
			if(src.Village=="Rain")
				goto Randomizer
			if(WeatherChoice==1)
				src.GiveMission("Find Rain Climate",2500,20000,"We need you to find a nearby area that has a Climate that is currently Raining, because we need to test the pollution in the water.")
			if(WeatherChoice==2)
				src.GiveMission("Find Heavy Rain Climate",2500,20000,"We need you to find a nearby area that has a Climate that is currently experiencing Heavy Rain, because we need to let our fellow Villagers know if it's safe to leave the village or not with the current weather conditions.")*/
		if(PickMission==7)
			if(Village!="Leaf")
				goto Randomizer
			else
				src.GiveMission("Ryu's Informational",350,3500,"I have some important news that you need to give to Ryu. Go and tell him this news as soon as possible, then report back to me after you've done so.")
		if(PickMission==8)
			if(Village!="Sound")
				goto Randomizer
			else
				src.GiveMission("Check On Uchiha Jack",1500,5000,"I've been told several Uchihas have been bothering Uchiha Jack regarding the true powers of the Sharingan. Head to the Uchiha Clan house and check on Uchiha Jack, he's probably hiding behind a secret entrance in the Uchiha Clan's House Clan Library. Come back to me and deliver how he's doing after you've checked on him.")
	if(Rank=="C")
		var/PickMission=rand(1,4)
		if(PickMission==1)
			var/AX=rand(1,2)
			src.GiveMission("Kill A Wolf",3600,45000,"We've been getting complaints about the Wolves to the west of Tea Village. We need you to kill [AX] amount of wolves for us.")
			src.NumberOfWolvesKilled=0;src.NumberOfWolvesNeededToKill=AX
			return
		if(PickMission==2)
			src.GiveMission("Find Wolf Mane",3600,35000,"Wolf Mane is a very popular item. Do you think you could find it for us?")
			return
		if(PickMission==3)
			src.GiveMission("Fierce Wolves",3600,55000,"Fierce Wolves are said to be the leaders of the Wolf Pack. We think if you kill some of them off it'll make things easier to maintain.")
			return
		if(PickMission==4)
			src.GiveMission("Find Dark Wolf Mane",3600,45000,"Wolf Mane is expensive and popular but Dark Wolf Mane is 2x more popular. If you can find it, it'll be very helpful. Fierce Wolves drop them and you can find Fierce Wolves around the Tea Village.")
			return
	if(Rank=="B")
		Randomizer2
		var/PickMission=rand(1,3)
		if(PickMission==1)
			var/AX=rand(1,2)//sec
			src.GiveMission("Represent!",60000,150000,"We want you to defeat [AX] Ninja from Enemy Villages, their rank doesn't matter, to show the power of the [src.Village] Village!")
			src.NumberOfNinjaDefeated=0;src.NumberOfNinjaNeededToDefeat=AX
			return
		if(PickMission==2)
			var/list/WhichVillageAttacker = list()
			if(VillageAttackers.len>0)
				for(var/mob/P in OnlinePlayers)
					if(P.client&&P!=usr&&P.Village==usr.Village&&(P in VillageAttackers))
						WhichVillageAttacker.Add(P)
				var/mob/M = pick(WhichVillageAttacker)
				src.ATarget=M
				src.GiveMission("Village Betrayal Enforcement",6000,90000,"We want you to defeat [M] whom has been known to kill their own Villagers, we want you to put a stop to their village Killing by giving them a taste of their own medicine!")
			else
				goto Randomizer2
		if(PickMission==3)
			var/WhichVillage=rand(1,2)
			if(src.Village=="Leaf")//Negotiating Peace With Rock
				if(WhichVillage==1)
					src.GiveMission("Negotiating Peace With Rock",7500,100000,"We want you to deliver this Peace Note to the Rock Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
				//	for(var/obj/MissingStuff/PeaceNote/P)
				//		P.WhoItBelongsTo=src
				//		P.WhichVillageGoingTo="Rock"
				//		P.WhichVillageIsDelivering="Leaf"
				//		P.loc=src
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Rock"
					P.WhichVillageIsDelivering="Leaf"
					P.loc=src
				if(WhichVillage==2)
					src.GiveMission("Negotiating Peace With Rain",7500,100000,"We want you to deliver this Peace Note to the Rain Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Rain"
					P.WhichVillageIsDelivering="Leaf"
					P.loc=src
		//		if(WhichVillage==3)
			if(src.Village=="Rock")
				if(WhichVillage==1)
					src.GiveMission("Negotiating Peace With Leaf",7500,100000,"We want you to deliver this Peace Note to the Leaf Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Leaf"
					P.WhichVillageIsDelivering="Rock"
					P.loc=src
				if(WhichVillage==2)
					src.GiveMission("Negotiating Peace With Rain",7500,100000,"We want you to deliver this Peace Note to the Rain Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Rain"
					P.WhichVillageIsDelivering="Rock"
					P.loc=src
			if(src.Village=="Rain")
				if(WhichVillage==1)
					src.GiveMission("Negotiating Peace With Leaf",7500,100000,"We want you to deliver this Peace Note to the Leaf Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Leaf"
					P.WhichVillageIsDelivering="Rain"
					P.loc=src
				if(WhichVillage==2)
					src.GiveMission("Negotiating Peace With Sound",7500,100000,"We want you to deliver this Peace Note to the Sound Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Sound"
					P.WhichVillageIsDelivering="Rain"
					P.loc=src
			if(src.Village=="Sound")
				if(WhichVillage==1)
					src.GiveMission("Negotiating Peace With Rock",7500,100000,"We want you to deliver this Peace Note to the Rock Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Rock"
					P.WhichVillageIsDelivering="Sound"
					P.loc=src
				if(WhichVillage==2)
					src.GiveMission("Negotiating Peace With Leaf",7500,100000,"We want you to deliver this Peace Note to the Leaf Village as tension between the two villages are rising rapidly. Deliver this note to The Mission Jounin in the Village, and try to avoid fights, The Note is delicate and you don't want the enemy Ninja taking it!")
					var/obj/MissingStuff/PeaceNote/P=new()
					P.WhoItBelongsTo=src
					P.WhichVillageGoingTo="Leaf"
					P.WhichVillageIsDelivering="Sound"
					P.loc=src
	if(Rank=="A")
//		Randomizer3
		MissionAward=500000
		var/PickMission=rand(1,5)
		if(PickMission==1)//Low-Ranked Village Ninja Assassination
			var/list/L = list()
			for(var/mob/P in world)
				if(P.client&&P!=usr&&P.Village!=usr.Village&&(P.blevel=="C"||P.blevel=="B"))//P.blevel!="S"&&P.blevel!="A"&&P.blevel!="B")
					L.Add(P)
			if(L.len<=0)
				src<<"None are available.";return
			var/mob/M = pick(L)
			src<<"<b><font face=verdana>Find and Kill [M], a known [M.blevel]-ranked, [M.Village] Ninja."
			src<<"<b><font face=verdana>Award: [MissionAward] Ryo"
			src.ATarget = "[M.name]"
			src.CurrentMission="Assassination Mission";src.TimeLimit=7000
			if(src.guild_member)
				for(var/mob/X in world)
					if(X.guild_name==src.guild_name)
						if(X!=src)
							X.AlertSquadMatesofMission(src)
			return
		if(PickMission==2)//High-Ranked Missing Ninja Assassination
			MissionAward=500000
			var/list/L = list()
			for(var/mob/P in world)
				if(P.client&&P!=usr&&P.Village=="Missing"&&(P.blevel=="B"||P.blevel=="A"))//P.blevel!="D"&&P.blevel!="C"&&P.blevel!="E")
					L.Add(P)
			if(L.len<=0)
				src<<"None are available.";return
			var/mob/M = pick(L)
			src<<"<b><font face=verdana>Find and Kill [M], a known [M.blevel]-ranked, [M.Village] Ninja."
			src<<"<b><font face=verdana>Award: [MissionAward] Ryo"
			src.ATarget = "[M.name]"
			src.CurrentMission="Assassination Mission";src.TimeLimit=7000
			if(src.guild_member)
				for(var/mob/X in world)
					if(X.guild_name==src.guild_name)
						if(X!=src)
							X.AlertSquadMatesofMission(src)
			return
		if(PickMission==3)
			MissionAward=500000
			var/list/OnlineMissingNinja = list()
			var/X=rand(1,2)
			for(var/mob/P in world)
				if(P.client&&P!=usr&&P.Village=="Missing")//P.blevel!="D"&&P.blevel!="C"&&P.blevel!="E")
					OnlineMissingNinja.Add(P)
			if(OnlineMissingNinja.len<=0)
				src<<"There are none available.";return
			src<<"<b><font face=verdana>Missing Ninja normally have a bounty. Your goal is to track down [X] Missing Ninja and kill them before the time limit runs out."
			src<<"<b><font face=verdana>Award: [MissionAward] Ryo"
			src.CurrentMission="Track And Defeat";
			src.TimeLimit=7000;
			src.HowManyMissingNeededToKill=X

			if(src.guild_member)
				for(var/mob/Z in world)
					if(Z.guild_name==src.guild_name)
						if(Z!=src)
							Z.AlertSquadMatesofMission(src)
			return
		if(PickMission==4)//High-Ranked Village Ninja Assassination
			MissionAward=500000
			var/list/L = list()
			for(var/mob/P in world)
				if(P.client&&P!=usr&&P.Village!=usr.Village&&P.blevel!="D"&&P.blevel!="C"&&P.blevel!="E")
					L.Add(P)
			var/mob/M = pick(L)
			if(L.len<=0)
				src<<"There are none currently available.";return
			src<<"<b><font face=verdana>Find and Kill [M], a known [M.blevel]-ranked, [M.Village] Ninja."
			src<<"<b><font face=verdana>Award: [MissionAward] Ryo"
			src.ATarget = "[M.name]"
			src.CurrentMission="Assassination Mission";src.TimeLimit=7000
			if(src.guild_member)
				for(var/mob/X in world)
					if(X.guild_name==src.guild_name)
						if(X!=src)
							X.AlertSquadMatesofMission(src)
			return
		if(PickMission==5)//Low-Ranked Missing Ninja Assassination
			MissionAward=500000
			var/list/L = list()
			for(var/mob/P in world)
				if(P.client&&P!=usr&&P.Village=="Missing"&&P.blevel!="S"&&P.blevel!="A"&&P.blevel!="B")
					L.Add(P)
			if(L.len<=0)
				src<<"There are none available.";return
			var/mob/M = pick(L)
			src<<"<b><font face=verdana>Find and Kill [M], a known [M.blevel]-ranked, [M.Village] Ninja."
			src<<"<b><font face=verdana>Award: [MissionAward] Ryo"
			src.ATarget = "[M.name]"
			src.CurrentMission="Assassination Mission";src.TimeLimit=7200
			if(src.guild_member)
				for(var/mob/X in world)
					if(X.guild_name==src.guild_name)
						if(X!=src)
							X.AlertSquadMatesofMission(src)
			return
		//Blabla Put Rank A missions here.
	if(Rank=="S")
		//Blabla Put Rank S missions here.
		MissionAward=1000000
		var/list/L = list()
		for(var/mob/P in world)
			if(P.client&&P!=usr&&P.Village!=usr.Village&&P.blevel!="E"&&P.blevel!="D"&&P.blevel!="C"&&P.blevel!="B")
				L.Add(P)
		if(L.len<1)
			src<<"<b>Sorry there are no available S rank missions that this time.</b>"
			return
		var/mob/M = pick(L)
		src<<"<b><font face=verdana>Find and Kill [M], a known [M.blevel]-ranked, [M.Village] Ninja. Once you've done so, bring his corpse back to the village so we can extract information from it."
		src<<"<b><font face=verdana>Award: [MissionAward] Ryo";src.TimeLimit=8000
		src.ATarget = "[M.name]"
		src.CurrentMission="High Class Level Assassination"
		if(src.guild_member)
			for(var/mob/X in world)
				if(X.guild_name==src.guild_name)
					if(X!=src)
						X.AlertSquadMatesofMission(src)
		return

//////////////////
//D Rank Missions
//Weeds
obj/Weed
	icon='Map/Turfs/Landscapes.dmi'
	icon_state="weed"
mob/var/tmp/CurrentMission=""
mob/var/tmp/TimeLimit=0
////////////////////////////////////////////////////////////////
mob/var/MissionTarget=""
mob/NPC/RandomNPCs/LeafVillagers/LeafMissionJounin
	name="Leaf Mission Jounin(NPC)"
	Village="Leaf"
	health = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999
	New()
		..()
		spawn()
			src.icon=null
			var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52)
			var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
			Shirt+=rgb(61,100,60)
			src.icon=Base
			src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays+='Icons/New Base/MaleEyes.dmi';src.overlays+='Icons/New Base/Eyes.dmi'
			src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi';src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays+=Shirt;src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
	verb
		Talk()
			set src in oview(3)
			set category ="Mission"
			var/MissionCheck1=0
			if(usr.OnMission)
				usr<<"You're already doing a mission!";return
			if(usr.Village!=src.Village&&usr.CurrentMission=="Negotiating Peace With Leaf")
			//	world<<"This has been recognized."
				for(var/obj/MissingStuff/PeaceNote/P in usr.contents)
					if(P.WhichVillageGoingTo=="Leaf"&&P.WhichVillageIsDelivering!="Leaf")
						MissionCheck1=1
						del(P)
			if(MissionCheck1==1)
				usr<<"Thank You......I'll give this to [Hokage] when they arrive....I suggest you leave now.."
				usr.MissionComplete()
				usr.RewardMission()
				return

			if(usr.Village!=src.Village)
				usr<<"...You're not in this village.";return
			if(usr.rank=="Student")
				usr<<"You must be atleast a genin to do a any missions.";return
			if(usr.CurrentMission!="")
				usr.RewardMission()
			else
				if(usr.OnMission==0)
					usr.OnMission=1
					switch(input(usr,"Which Level Mission are you certified for?", text) in list ("D","C","B","A","S"))
						if("D")
							if(usr.rank=="Student")
								usr<<"You aren't certified to perform a mission yet.";return
							usr.RandomMissionGenerator("D","Leaf")
						if("C")
							if(usr.rank=="Student")
								usr<<"You aren't certified to perform a mission yet.";return
							if(usr.blevel=="E"|usr.blevel=="D")
								usr<<"Your rank is too low to perform this mission.";return
							usr.RandomMissionGenerator("C","Leaf")
						if("B")
							if(usr.rank=="Student")
								usr<<"You aren't certified to perform a mission yet.";return
							if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C")
								usr<<"Your rank is too low to perform this mission.";return
							usr.RandomMissionGenerator("B","Leaf")
						if("A")
							if(usr.rank=="Student")
								usr<<"You aren't certified to perform a mission yet.";return
							if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
								usr<<"Your rank is too low to perform this mission.";return
							usr.RandomMissionGenerator("A","Leaf")
						if("S")
							if(usr.rank=="Student")
								usr<<"You aren't certified to perform a mission yet.";return
							if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
								usr<<"Your rank is too low to perform this mission.";return
							usr.RandomMissionGenerator("S","Leaf")
///////////////////////////////////////////////
mob/NPC/RandomNPCs/SoundVillage/SoundMissionJounin
	name="Sound Mission Jounin(NPC)"
	icon='Map/Turfs/HakumeiGetsu.dmi'
	Village="Sound"
	health = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999
	New()
		..()
		spawn()
			src.icon=null
			var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52)
			var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi';Shirt+=rgb(0,0,0)
			src.icon=Base
			src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays+='Icons/New Base/MaleEyes.dmi';src.overlays+='Icons/New Base/Eyes.dmi'
			src.overlays+='Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi';src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays+=Shirt;src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
	verb
		Talk()
			var/MissionCheck1=0
			set src in oview(3)
			set category ="Mission"
			if(usr.OnMission)
				usr<<"You're already doing a mission!";return
			if(usr.Village!=src.Village&&usr.CurrentMission=="Negotiating Peace With Sound")
		//		world<<"This has been recognized."
				for(var/obj/MissingStuff/PeaceNote/P in usr.contents)
					if(P.WhichVillageGoingTo=="Sound"&&P.WhichVillageIsDelivering!="Sound")
						MissionCheck1=1
					//	usr<<"Thank You......I'll give this to [Otokami] when they arrive....I suggest you leave now.."
						del(P)
					//	usr.RewardMission()
					//	return
			if(MissionCheck1==1)
				usr<<"Thank You......I'll give this to [Otokami] when they arrive....I suggest you leave now.."
				usr.MissionComplete()
				usr.RewardMission()
				return
			if(usr.Village!=src.Village)
				usr<<"...You're not in this village.";return
			if(usr.rank=="Student")
				usr<<"You must be atleast a genin to do a any missions.";return
			if(usr.CurrentMission!="")
				usr.RewardMission()
			else
				switch(input(usr,"Which Level Mission are you certified for?", text) in list ("D","C","B","A","S"))
					if("D")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						usr.RandomMissionGenerator("D","Sound")
					if("C")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("C","Sound")
					if("B")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("B","Sound")
					if("A")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("A","Sound")
					if("S")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("S","Sound")
///////////////////////////////////////////////
mob/NPC/RandomNPCs/RainVillage/RainMissionJounin
	name="Rain Mission Jounin(NPC)"
	icon='Map/Turfs/HakumeiGetsu.dmi'
	Village="Rain"
	health = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999
	New()
		..()
		spawn()
			src.icon=null
			var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52)
			var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi';Shirt+=rgb(0,0,150)
			src.icon=Base
			src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays+='Icons/New Base/MaleEyes.dmi';src.overlays+='Icons/New Base/Eyes.dmi'
			src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi';src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays+=Shirt;src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
	verb
		Talk()
			set src in oview(3)
			set category ="Mission"
			var/MissionCheck1=0
			if(usr.OnMission)
				usr<<"You're already doing a mission!";return
			if(usr.Village!=src.Village&&usr.CurrentMission=="Negotiating Peace With Rain")
			//	world<<"This has been recognized."
				for(var/obj/MissingStuff/PeaceNote/P in usr.contents)
					if(P.WhichVillageGoingTo=="Rain"&&P.WhichVillageIsDelivering!="Rain")
						MissionCheck1=1
					//	usr<<"Thank You......I'll give this to [Amekoutei] when they arrive....I suggest you leave now.."
						del(P)
					//	usr.RewardMission()
					//	return
			if(MissionCheck1==1)
				usr<<"Thank You......I'll give this to [Amekoutei] when they arrive....I suggest you leave now.."
				usr.MissionComplete()
				usr.RewardMission()
				return
			if(usr.Village!=src.Village)
				usr<<"...You're not in this village.";return
			if(usr.rank=="Student")
				usr<<"You must be atleast a genin to do a any missions.";return
			if(usr.CurrentMission!="")
				usr.RewardMission()
			else
				switch(input(usr,"Which Level Mission are you certified for?", text) in list ("D","C","B","A","S"))
					if("D")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						usr.RandomMissionGenerator("D","Rain")
					if("C")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("C","Rain")
					if("B")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("B","Rain")
					if("A")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("A","Rain")
					if("S")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("S","Rain")
///////////////////////////////////////////////
mob/NPC/RandomNPCs/RockVillage/RockMissionJounin
	name="Rock Mission Jounin(NPC)"
	icon='Map/Turfs/HakumeiGetsu.dmi'
	Village="Rock"
	health = 99999999999999999999999999999999999999999999999999999999999999999999999999999999999
	New()
		..()
		spawn()
			src.icon=null
			var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52)
			var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi';Shirt+=rgb(128,064,0)
			src.icon=Base
			src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
			src.overlays+='Icons/New Base/MaleEyes.dmi';src.overlays+='Icons/New Base/Eyes.dmi'
			src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi';src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
			src.overlays+=Shirt;src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
	verb
		Talk()
			set src in oview(3)
			set category ="Mission"
			var/MissionCheck1=0
			if(usr.OnMission)
				usr<<"You're already doing a mission!";return
			if(usr.Village!=src.Village&&usr.CurrentMission=="Negotiating Peace With Rock")
		//		world<<"This has been recognized."
				for(var/obj/MissingStuff/PeaceNote/P in usr.contents)
					if(P.WhichVillageGoingTo=="Rock"&&P.WhichVillageIsDelivering!="Rock")
						MissionCheck1=1
					//	usr<<"Thank You......I'll give this to [Tsuchikage] when they arrive....I suggest you leave now.."
						del(P)
					//	usr.RewardMission()
					//	return
			if(MissionCheck1==1)
				usr<<"Thank You......I'll give this to [Tsuchikage] when they arrive....I suggest you leave now.."
				usr.MissionComplete()
				usr.RewardMission()
				return
			if(usr.Village!=src.Village)
				usr<<"...You're not in this village.";return
			if(usr.rank=="Student")
				usr<<"You must be atleast a genin to do a any missions.";return
			if(usr.CurrentMission!="")
				usr.RewardMission()
			else
				switch(input(usr,"Which Level Mission are you certified for?", text) in list ("D","C","B","A","S"))
					if("D")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						usr.RandomMissionGenerator("D","Rock")
					if("C")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("C","Rock")
					if("B")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("B","Rock")
					if("A")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("A","Rock")
					if("S")
						if(usr.rank=="Student")
							usr<<"You aren't certified to perform a mission yet.";return
						if(usr.blevel=="E"|usr.blevel=="D"|usr.blevel=="C"|usr.blevel=="B")
							usr<<"Your rank is too low to perform this mission.";return
						usr.RandomMissionGenerator("S","Rock")
proc
	MissionPayout(mob/P in world,Mission,MissionRank,Money,Village)
		var/Tax=0
		if(Village=="Leaf")
			Tax=Money*(LeafMTax*0.01)
			LeafVillagePool+=Tax
		if(Village=="Rock")
			Tax=Money*(RockMTax*0.01)
			RockVillagePool+=Tax
		if(Village=="Rain")
			Tax=Money*(RainMTax*0.01)
			RainVillagePool+=Tax
		if(Village=="Sound")
			Tax=Money*(SoundMTax*0.01)
			SoundVillagePool+=Tax
		if(usr.key=="")
			usr<<"The Current Tax of your mission is [Tax]."
			usr<<"The Current Mission Tax is [RainMTax]."
		if(Tax<0)
			world<<"Error, Error! [Village]'s tax is set to an incorrect number!"
			Tax=0
		var/FinalMoney=0
		FinalMoney=(Money-Tax)
		if(Village=="Leaf"&&LeafVillageMissionFree==1)
			P<<"Your money goes torwards the Village Fund.";LeafVillagePool+=FinalMoney;return
		if(Village=="Rain"&&RainVillageMissionFree==1)
			P<<"Your money goes torwards the Village Fund.";RainVillagePool+=FinalMoney;return
		if(Village=="Rock"&&RockVillageMissionFree==1)
			P<<"Your money goes torwards the Village Fund.";RockVillagePool+=FinalMoney;return
		if(Village=="Sound"&&SoundVillageMissionFree==1)
			P<<"Your money goes torwards the Village Fund.";SoundVillagePool+=FinalMoney;return
		P<<"Here's your award of [Money] Yen! ([FinalMoney] After Taxes!)"
		Money=(Money-Tax) //Money=Money-Tax
		SaveVillageStuff()
		if(P.guild_member)
			P<<"Your yen is split evenly through out your members, but the Leader gets the most."
			var/count=0
			if(MissionRank=="S")
				P.smission+=1;P.VMorale+=10;P<<"Your Village Morale went up by 10!"
			if(MissionRank=="A")
				P.amission+=1;P.VMorale+=5;P<<"Your Village Morale went up by 5!"
			if(MissionRank=="B")
				P.bmission+=1;P.VMorale+=2;P<<"Your Village Morale went up by 2!"
			if(MissionRank=="C")
				P.cmission+=1;P.VMorale+=1.5;P<<"Your Village Morale went up by 1.5!"
			if(MissionRank=="D")
				P.dmission+=1;P.VMorale+=1;P<<"Your Village Morale went up by 1!"
			P.CurrentMission=""
			for(var/mob/M in world)
				if(M.CurrentMission==P.CurrentMission)
					if(M.guild_name==P.guild_name)
						count+=1
			for(var/mob/M in world)
				if(M.CurrentMission==P.CurrentMission)
					if(M.guild_name==P.guild_name)
						if(M.guild_leader)
							M<<"You gain the award of [Money/count]+100 yen!"
							M.Yen+=(Money/count)+100
						if(M.guild_member)
							M<<"You gain the award of [Money/count] yen!"
							M.Yen+=Money/count
						if(MissionRank=="S")
							M.smission+=1;M.VMorale+=10;M<<"Your Village Morale went up by 10!"
						if(MissionRank=="A")
							M.amission+=1;M.VMorale+=5;M<<"Your Village Morale went up by 5!"
						if(MissionRank=="B")
							M.bmission+=1;M.VMorale+=2;M<<"Your Village Morale went up by 2!"
						if(MissionRank=="C")
							M.cmission+=1;M.VMorale+=1.5;M<<"Your Village Morale went up by 1.5!"
						if(MissionRank=="D")
							M.dmission+=1;M.VMorale+=1;M<<"Your Village Morale went up by 1!"
						M.CurrentMission=""
			if(count>=1)
				P.Yen+=Money/count
			else
				P.Yen+=Money
		else
			P.Yen+=Money
			if(MissionRank=="S")
				P.smission+=1;P.VMorale+=10;P.JutsuDelay-=2000;if(P.Subscriber) P.JutsuDelay-=1000;if(P.JutsuDelay<0) P.JutsuDelay=0;P<<"Your Village Morale went up by 10!"
			if(MissionRank=="A")
				P.amission+=1;P.VMorale+=5;P.JutsuDelay-=1500;if(P.Subscriber) P.JutsuDelay-=800;if(P.JutsuDelay<0) P.JutsuDelay=0;P<<"Your Village Morale went up by 5!"
			if(MissionRank=="B")
				P.bmission+=1;P.VMorale+=2;P.JutsuDelay-=900;if(P.Subscriber) P.JutsuDelay-=400;if(P.JutsuDelay<0) P.JutsuDelay=0;P<<"Your Village Morale went up by 2!"
			if(MissionRank=="C")
				P.cmission+=1;P.VMorale+=1.5;P.JutsuDelay-=500;if(P.Subscriber) P.JutsuDelay-=200;if(P.JutsuDelay<0) P.JutsuDelay=0;P<<"Your Village Morale went up by 1.5!"
			if(MissionRank=="D")
				P.dmission+=1;P.VMorale+=1;P.JutsuDelay-=200;if(P.Subscriber) P.JutsuDelay-=100;if(P.JutsuDelay<0) P.JutsuDelay=0;P<<"Your Village Morale went up by 1!"
			P.picked=0
			P.CurrentMission=""