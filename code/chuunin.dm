var/list/BSs=list("","","","","","","","","")
var/TestingChuunin=0
var/list/ChuuninTesters=list()
mob/owner/verb/Test_Chuunin_Map()
	set name="Test Chuunin Stuff"
	set category="Commands"
	TestingChuunin=1
	world<<"[usr] is testing a new map for something important. If you would like to join use the Help Test verb in the commands tab!"
	for(var/mob/M in OnlinePlayers)
		M.verbs+=new/mob/ChuuninJoin/verb/TestChuuninStuff()
	spawn(300)
		for(var/mob/C in OnlinePlayers)
			C.verbs-=new/mob/ChuuninJoin/verb/TestChuuninStuff()
		for(var/mob/A in ChuuninTesters)
			ChuuninTesters-=A
			A.loc=locate(rand(5,12),rand(8,11),38)
			A.BoulderStrike=0
			A.TakingPartInChuunins=1
			A<<"This is a Beta Map for a new soon to be Chuunin 1st Stage Map. Reach the end without getting hit by the bolders. A bolder will immediatly knock you out, however blocking a boulder will only push you back. Make it to the end!"

mob/ChuuninJoin/verb/TestChuuninStuff()
	set name="Help Test"
	set category="Commands"
	if(TestingChuunin==0)
		usr<<"Nope.";return
	if(ChuuninTesters.len>=20)
		usr<<"Sorry. There is already enough people testing.";usr.verbs-=new/mob/ChuuninJoin/verb/TestChuuninStuff();return
		TestingChuunin=0
	usr<<"You will be warped to the location shortly."
	world<<"[usr] has chosen to help test."
	ChuuninTesters+=usr
	return




mob/var/tmp/BoulderStrike=0
var
	WaitingRoom
	Chuunintime
	Chuunintime2
	Chuunintime1
	Chuuninexam
	list/Spectators = list()


obj
	TeaForestSound//Inb4MassLag
		icon='Icons/Jutsus/DotonTechniques.dmi'
		icon_state=""
		invisibility=100
		dir=SOUTH
		var/list/Inside = list()
		var/list/Listening = list()
		New()
			..()
			spawn()
				while(src)
					for(var/mob/C in oview(30,src))
						if(!(C in Inside))
							Inside+=C
					for(var/mob/M in Inside)
						if(!(locate(M in oview(30,src))))
							Inside-=M
							Listening-=M
						if(M.client)
							if(!(locate(M in Listening)))
								Listening+=M
								M<<sound('ForestOfTreant.mid',channel=7,volume=60)
					sleep(70)
	AutoBoulder
		icon='Icons/Jutsus/DotonTechniques.dmi'
		icon_state=""
		invisibility=100
		dir=SOUTH
		var/tai=1000
		var/EarthChakra=10
		var/BoulderCD=0
		New()
			..()
			spawn()
				while(src)
					sleep(150)
					BoulderCD=0
			//		world<<"15 Seconds has passed for the Auto Boulder Obj."
					if(prob(50)&&BoulderCD==0)
						BoulderCD=1
					//	world<<"A Dango has been set off!"
						var/obj/Jutsu/Elemental/Doton/BigDoton/K=new();
						K.ChuuninBoulder=1
						K.name="Boulder";K.dir=src.dir;
						K.Owner=src;K.Move_Delay=pick(0.3,0.5,1)
						K.JutsuLevel=1500000
						K.health=100000
						K.loc=src.loc;sleep(2);
						K.tai=src.tai;
						spawn(3)
							walk(K,src.dir)
			//	sleep(300)
			spawn(300)
				del(src)
	AutoBoulderSide
		icon='Icons/Jutsus/DotonTechniques.dmi'
		icon_state=""
		invisibility=100
		dir=WEST
		var/tai=1000
		var/EarthChakra=10
		New()
			..()
			spawn()
				while(src)
					sleep(125)
				//	world<<"15 Seconds has passed for the Auto Boulder Obj."
					if(prob(40))
					//	world<<"A Dango has been set off!"
						var/obj/Jutsu/Elemental/Doton/BigDoton/K=new();
						K.ChuuninBoulder=1
						K.name="Boulder";K.dir=src.dir;
						K.Owner=src;K.Move_Delay=pick(0.3,0.5,1)
						K.JutsuLevel=1500000
						K.health=100000
						K.loc=src.loc;sleep(2);
						K.tai=src.tai;
						spawn(3)
							walk(K,src.dir)
			//	sleep(300)
			spawn(300)
				del(src)


mob/var
	tmp/TakingPartInChuunins=0
mob/ChuuninJoin/verb/JoinChuunin()
	set category="Chuunin"
	set name="Join"
	if(usr.rank!="Genin")
		usr<<"You're not a Genin!"
		usr.verbs-=new/mob/ChuuninJoin/verb/JoinChuunin()
	else
		usr.verbs-=new/mob/ChuuninJoin/verb/JoinChuunin()
		usr<<"You embark to the Iron Country!"
		usr.TakingPartInChuunins=1
//		usr.loc=locate(0,0,0)
		sleep(50)
		usr.loc=locate(12,53,30)
		usr<<"Welcome to Outer Haven's Chuunin Exam Conference Room. Wait Patiently for the test to start to begin the Exam."
		usr<<"<font color=red><font size=2>The Chuunin Exam is a lot different now, but it is still simple. For the first test you will need to get through the opstical. For the second test, you would still go through the forest of death and have to get the scroll. After getting both scrolls you will be teleported to Outer Haven's Chuunin Arena for the 3rd part. It shouldn't be too hard."
		usr<<"<B>Do not log out during Chuunin! You will automatically be out of it, unless you log out while the Joining is still commencing, which you'd have to rejoin! Take notice of this!"
		usr<<"Do not use any Jutsu of any sorts while in the Waiting Room or undergoing Part 1 of the Chuunin Exam. You have been warned."
mob/ChuuninJoin/verb/SpectateChuunin()
	set category="Chuunin"
	set name="Spectate Chuunin Exam"
	if(!(locate(usr in Spectators)))
		if(Spectators.len<=10)
			Spectators+=usr
			usr<<"You have chosen to spectate this Chuunin Exam! You will be summoned to the Seats when the third part starts!"
			return
		else
			usr<<"All the spectators seats have already been taken.";return
	else
		usr<<"You're already going to Spectate!";return

mob/Kage
	verb
		Chuuninexam()
			var/WhichType=0
			set category = "Kage"
			set name = "Chuunin Examination"
			if(Chuunintime||Chuunintime2)
				usr<<"A chuunin is already occuring.";return
			if(usr.z==1)
				if(usr.x>=150&&usr.x<=185&&usr.y>=103&&usr.y<=118)
					usr<<"You're not able to host one while locked away in prison!"
					return
			var/count=0
			for(var/mob/M in OnlinePlayers)
				if(M.client&&M.rank=="Genin")
					count++
			if(count<20)
				usr<<"You need to have at least 20 Genin on to start a chuunin!";return
			var/LeafVillageCount=0
			var/RockVillageCount=0
			var/SoundVillageCount=0
			var/RainVillageCount=0
			for(var/mob/M in OnlinePlayers)
				if(M.client&&M.rank=="Genin"&&M.Village=="Leaf")
					LeafVillageCount++
			for(var/mob/M in OnlinePlayers)
				if(M.client&&M.rank=="Genin"&&M.Village=="Rock")
					RockVillageCount++
			for(var/mob/M in OnlinePlayers)
				if(M.client&&M.rank=="Genin"&&M.Village=="Rain")
					RainVillageCount++
			for(var/mob/M in OnlinePlayers)
				if(M.client&&M.rank=="Genin"&&M.Village=="Sound")
					SoundVillageCount++
			WaitingRoom=1
			if(LeafVillageCount<3||RockVillageCount<3||SoundVillageCount<3||RainVillageCount<3)
				usr<<"You need at least 3 Genin in each village to start a chuunin!";return
			if(!Chuunintime&&!Chuunintime2)
				usr.loc=locate(15,42,30)
				world<<"<font size=3><font color=red>A Chuunin Exam is being hosted at the Iron Country's Outer Haven! If you want to join all Genin should have a tab to join it. You have 10 minutes!"
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin")
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
//				world<<"<b>If you wish to watch Chuunin exams go to the Exam room and talk to the ticket guy!"
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 9 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 8 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 7 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 6 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 5 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 4 minutes."
				sleep(230)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 3 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 2 minutes."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 1 minute."
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					if(M.client&&M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
					if(M.client&&(M.rank=="Chuunin"||M.rank=="S.Jounin"||M.rank=="Jounin"))
						M.verbs+=new/mob/ChuuninJoin/verb/SpectateChuunin()
				sleep(250)
				for(var/mob/M in OnlinePlayers)
					M.verbs-=new/mob/ChuuninJoin/verb/JoinChuunin()
					M.verbs-=new/mob/ChuuninJoin/verb/SpectateChuunin()
				world<<"<font size=3><font color=red>Chuunin exam has now started! The contestants are going through part 1 currently!"
			//	WhichType=pick(1,2)
				WhichType=1
				Chuunintime=1
				usr<<"They're now taking part 1"
				WaitingRoom=0
				for(var/mob/M in OnlinePlayers)
					if(M.TakingPartInChuunins==1)
						M.loc=locate(1,187,32)
						M<<"<b><font color=red>Welcome to Part 1! This part is severly easy and a test of agility and endurance for Ninja. The point of this test is to make it across the opsticals to the other region. Head downwards, but of course there is a path. As a ninja you must be able to get through opsticals and find your way in a moderate time limit. You have 3 minutes!"
				sleep(1100)
				world<<"Chuunin Exam Part one is over!"
				for(var/mob/M in OnlinePlayers)
					if(M.TakingPartInChuunins==1)
						M<<"You've failed part one."
						spawn() M.GotoVillageHospital()
						M.TakingPartInChuunins=0
				Chuunintime=0



				//This Is the Classic Get the Scrolls Second Part of the Chuunin Exam


				sleep(30)
				if(WhichType==1)
					var/heavenorearth=0
					spawn() for(var/mob/M in OnlinePlayers)
						if(M.TakingPartInChuunins==2)
							if(heavenorearth==0)
								var/obj/heavenscroll/H=new();H.loc=M;M.loc=locate(97,187,37)//M.loc=locate(88,192,31)
								heavenorearth=1
							else
								var/obj/earthscroll/E=new();E.loc=M;M.loc=locate(82,8,37)//M.loc=locate(94,1,31)
								heavenorearth=0
							M<<"You have passed the first part of the Chuunin Exam!"
							sleep(2)
					world << "<b><font color = red>Chuunin exam part 2 has begun!  The contestants have 10 minutes to obtain both scrolls!"
					usr.loc=locate(154,85,32)
					usr<<"Note:: The arena is right below you. Use Set Chuunin Contestants when the fighting starts."
					for(var/mob/M in OnlinePlayers)
						if(M.z==30)
							M<<"<b><font color=red>Note: Whenever someone is knocked out, they will immediately drop the scroll they're holding which you can grab and take a run for. You don't have to kill. Also, EVERYONE on your side has the same scroll as you, so try not to fight each other."
					Chuunintime2=1
					sleep(3000)
					for(var/mob/M in OnlinePlayers)
						//if(M.z==31)
						if(M.z==37)
							M<<"<b><font color=red>5 Minutes Left!"
					sleep(2400)
					for(var/mob/M in OnlinePlayers)
					//	if(M.z==31)
						if(M.z==37)
							M<<"<b><font color=red>1 Minute Left!"
					sleep(600)
					world << "<b> Chuunin Part 2 is now over! The matches will begin."
					spawn() for(var/mob/P in OnlinePlayers)
						if(P.client&&P.z==37)//P.z==31)
							P<<"You've failed to obtain both scrolls, and so you've failed part 2."
							spawn() P.GotoVillageHospital()
							P.TakingPartInChuunins=0

				//This is a new part I want to test; Forest Of Death, literally.

				if(WhichType==2)
			//		var/list/SecondPartDeath
					SecondPartDeath = list()
					var/SecondPartInitialAmount=0
					spawn()
						for(var/mob/M in OnlinePlayers)
							if(M.TakingPartInChuunins==2)
								SecondPartDeath.Add(M)
								M.loc=locate(88,192,31)
								M<<"You have passed the First Part of the Chuunin Exam!"
						//		sleep(2)
					SecondPartInitialAmount=round(SecondPartDeath.len/2)
					world << "<b><font color = red>Chuunin exam part 2 has begun!  The contestants have 10 minutes to fight until at most [SecondPartInitialAmount] Ninja Remain!"
					usr.loc=locate(154,85,32)
					usr<<"Note:: The arena is right below you. Use Set Chuunin Contestants when the fighting starts."
					for(var/mob/O in SecondPartDeath)
						O<<"<b><font color=red>Note: The last [SecondPartInitialAmount] standing alive are victorious and can continue to kill each other, or wait until time runs out and go to part 3."
					Chuunintime2=1
					sleep(3000)
					for(var/mob/P in SecondPartDeath)
						P<<"<b><font color=red>5 Minutes Left!"
					sleep(2400)
					for(var/mob/Q in SecondPartDeath)
						Q<<"<b><font color=red>1 Minute Left!"
					sleep(600)
					world << "[SecondPartDeath.len] remain alive in the Forest Of Death!"
	//				sleep(20)
					if(SecondPartDeath.len>SecondPartInitialAmount)
						for(var/mob/P in SecondPartDeath)
							if(P.client&&P.z==31)
								world<<"There were more than [SecondPartInitialAmount] left Alive. All of the Chuunin Contestants Fail!"
								P<<"There was more than [SecondPartInitialAmount] People left standing. All of you Fail!"
								P.GotoVillageHospital()
								P.TakingPartInChuunins=0
					else
						for(var/mob/Survivors in SecondPartDeath)
							Survivors.loc = locate(154,85,32)
							SecondPartDeath.Remove(Survivors)
							Survivors << "Prepare for the matches! There's a concesesion stand to the bottom right with beverages and weapons to restock."
							world << "[Survivors] has passed chuunin exam part 2!"
				Chuunintime2=0
				usr<<"<b><font size = 2>Use the SetChuuninContestant verb in your Staff tab to choose two people to fight. The world will be informed when one wins, just summon the winner back to you."
				usr<<"DO NOT LOG OUT, otherwise you won't be able to continue the Chuunin without a GM's help."
				usr.verbs+=new/mob/Admin/verb/SetChuuninContestant()
				usr.verbs+=new/mob/Admin/verb/MakeChuunin()





mob/owner
	verb
		Chuuninexam()
			set category = "Staff"
			set name = "Chuunin Examination"
			if(!Chuunintime&&!Chuunintime2)
				usr.loc=locate(15,42,30)
				world<<"<font size=3><font color=red>A Chuunin Exam is being hosted at the Iron Country's Outer Haven! If you want to join all Genin should have a tab to join it. You have 10 minutes!"
				for(var/mob/M in world)
					if(M.rank=="Genin")
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
//				world<<"<b>If you wish to watch Chuunin exams go to the Exam room and talk to the ticket guy!"
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 9 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 8 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 7 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 6 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 5 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 4 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 3 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 2 minutes."
				sleep(500)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				world<<"<font size=3><font color=red>There will be a Chuunin exam in 1 minute."
				sleep(250)
				for(var/mob/M in world)
					if(M.rank=="Genin"&&M.TakingPartInChuunins==0)
						M.verbs+=new/mob/ChuuninJoin/verb/JoinChuunin()
						M<<"You can still join the Chuunin!"
				sleep(250)
				for(var/mob/M in world)
					M.verbs-=new/mob/ChuuninJoin/verb/JoinChuunin()
				world<<"<font size=3><font color=red>Chuunin exam has now started! The contestants are going through part 1 currently!"
				Chuunintime=1
				usr<<"They're now taking part 1"
				for(var/mob/M in world)
					if(M.TakingPartInChuunins==1)
						M.loc=locate(1,187,32)
						M<<"<b><font color=red>Welcome to Part 1! This part is severly easy and a test of agility and endurance for Ninja. The point of this test is to make it across the opsticals to the other region. Head downwards, but of course there is a path. As a ninja you must be able to get through opsticals and find your way in a moderate time limit. You have 2 minutes!"
				sleep(1100)
				world<<"Chuunin Exam Part one is over!"
				for(var/mob/M in world)
					spawn()
						if(M.TakingPartInChuunins==1)
							M<<"You've failed part one."
							spawn() M.GotoVillageHospital()
							M.TakingPartInChuunins=0
				Chuunintime=0
				sleep(30)
				var/heavenorearth=0
				spawn() for(var/mob/M in world)
					if(M.TakingPartInChuunins==2)
						if(heavenorearth==0)
							var/obj/heavenscroll/H=new();H.loc=M;M.loc=locate(rand(70,111),rand(170,191),37)
							heavenorearth=1
						else
							var/obj/earthscroll/E=new();E.loc=M;M.loc=locate(rand(130,173),rand(2,26),37)
							heavenorearth=0
						M<<"You have passed the first part of the Chuunin Exam!"
						sleep(2)
				world << "<b><font color = red>Chuunin exam part 2 has begun!  The contestants have 10 minutes to obtain both scrolls!"
				usr.loc=locate(154,85,32)
				for(var/mob/C in Spectators)
				//	spawn()
					C.loc=locate(116,36,32)
					C<<"Jutsu usage is not allowed while watching these matches. Attempting to abuse into the Arena Fights will result in Punishment"
					C.FrozenBind="Spectating Chuunin"
					Spectators-=C
				usr<<"Note:: The arena is right below you. Use Set Chuunin Contestants when the fighting starts."
				for(var/mob/M in world)
					if(M.z==37)
						M<<"<b><font color=red>Note: Whenever someone is knocked out, they will immediately drop the scroll they're holding which you can grab and take a run for. You don't have to kill. Also, EVERYONE on your side has the same scroll as you, so try not to fight each other."
				Chuunintime2=1
				sleep(3000)
				for(var/mob/M in world)
					if(M.z==37)
						M<<"<b><font color=red>5 Minutes Left!"
				sleep(2400)
				for(var/mob/M in world)
					if(M.z==37)
						M<<"<b><font color=red>1 Minute Left!"
				sleep(600)
				world << "<b> Chuunin Part 2 is now over! The matches will begin."
				spawn()
					for(var/mob/P in world)
						spawn()
							if(P.client&&P.z==31)
								P<<"You've failed to obtain both scrolls, and so you've failed part 2."
								spawn() P.GotoVillageHospital()
								P.TakingPartInChuunins=0
				Chuunintime2=0
				usr<<"<b><font size = 2>Use the SetChuuninContestantverbs in your Staff tab to choose people to fight. The world will be informed when one wins."
turf/chuunin22
	density=0
	Enter(A)
		if(CurrentEvent=="Kill The Assassin")
			return
		else if(ismob(A))
			var/mob/M=A
			if(M.client)
				if(M.rank!="Genin")
					M<<"What are you doing, you're not in Chuunins!"
					M.GotoVillageHospital()
					M.TakingPartInChuunins=0
				if(M.TakingPartInChuunins==1)
					M.loc=locate(15,42,30)
					M<<"You've passed Part One Of The Chuunin!"
					M<<"Wait patiently here for Part Two to begin."
					M.TakingPartInChuunins=2


turf
	chuunin2
		density = 0
		Enter(A)
			if(ismob(A))
				var/mob/M = A
				if(M.client)
					var/Z=0;var/ZX=0
					for(var/obj/heavenscroll/H in M.contents)
						Z=1
					for(var/obj/earthscroll/E in M.contents)
						ZX=1
					if(Z&&ZX&&Chuunintime2)
						M.loc = locate(154,85,32)
						for(var/obj/earthscroll/E in M.contents)
							del(E)
						for(var/obj/heavenscroll/H in M.contents)
							del(H)
						world << "[M] has passed chuunin exam part 2!"
						M << "Prepare for the matches! There's a concesesion stand to the bottom right with beverages and weapons to restock."

					else if(Chuunintime2)
						alert(M,"You need to find the other scroll.")
					else
						M << "The matches have already started."
						for(var/obj/earthscroll/E in M.contents)
							del(E)
						for(var/obj/heavenscroll/H in M.contents)
							del(H)
						M.GotoVillageHospital()
						return
			if(istype(A,/obj/)) del(A)



obj
	earthscroll
		name = "Scroll Of Earth"
		icon = 'scrolls.dmi'
		icon_state = "6"
		verb
			Get()
				set src in oview(1)
				var/AX=0
				var/MobCheck=0
				if(CurrentEvent!="")
					usr<<"You can't pick this up right now.";return
				for(var/mob/M in view(3,src))
					if(M!=usr&&!M.knockedout&&!M.Dead&&M.client)
						MobCheck=1
				if(MobCheck)
					usr<<"You can't pick this up right now with people around watching!";return
				for(var/obj/earthscroll/A in usr.contents)
					AX=1
				if(AX)
					usr<<"You already have a Earth scroll!";return
				else
					src.loc = usr
					usr<<"You picked up a [src]"

			Drop()
				src.loc=locate(usr.x,usr.y-1,usr.z)
			Destroy()
			 set hidden = 1
			 del(src)
obj
	heavenscroll
		name = "Scroll Of Heaven"
		icon = 'scrolls.dmi'
		icon_state = "7"

		verb
			Get()
				set src in oview(1)
				var/AX=0
				var/MobCheck=0
				for(var/mob/M in view(3,src))
					if(M!=usr&&!M.knockedout&&!M.Dead&&M.client)
						MobCheck=1
				if(MobCheck)
					usr<<"You can't pick this up right now with people around watching!";return
				if(CurrentEvent!="")
					usr<<"You can't pick this up right now.";return
				for(var/obj/heavenscroll/A in usr.contents)
					AX=1
				if(AX)
					usr<<"You already have a Heaven scroll!";return
				else
					src.loc = usr
					usr<<"You picked up a [src]"

			Drop()
				src.loc=locate(usr.x,usr.y-1,usr.z)
			Destroy()
			 set hidden = 1
			 del(src)