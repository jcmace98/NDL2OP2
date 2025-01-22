mob/verb
	CheckEventLog()
		set hidden=1
		usr.Events()
	CheckRulesLog()
		set hidden=1
	//	return
		usr.RuleGuide()
	//	usr.CurrentRules()
	CheckRPLog()
		set hidden=1
		usr.RPGuidelines()
	UpdateLogs()
		set hidden=1
		usr.UpdateLog()
	CheckWorldMap()
		set hidden=1
		usr.CheckMap()

mob/owner/verb
	Test()
		var/Test= {"
			<html>
				<head>
					<title>Name Goes Here</title>
					<style type="text/css">
						body {
							color: silver;
							background-color: black;
							font-family: Arial, Times, Tahoma, sans-serif
						}
						th {
							font-weight: bold;
							font-size: 13pt
						}
						tr {
							font-size: 12pt;
							padding: 2px. 10px, 2,px, 10px
						}
					</style>
				</head>
				<body>
					<tr align="left">
							<th>Description
							<th>They suck!
		"}
		usr << output("[Test]", "window1.browser2")


mob/proc/Events()
	if(!src.client)
		return
	var/updates = {"
		<html>
		<head>
		<title>Events</title>
		</head>
		<body bgcolor=#FFFFFF text=black>
		</br></font>
		</body>
		</html>
		"}
	usr << browse("[updates]","size=576x576,window=Events")

mob/proc/UpdateLog()
	if(!src.client)
		return
	var/updates = {"
		<html>
		<head>
		<title>Update Log</title>
		</head>
		<body bgcolor=#0000 text=red>

		<center><h2>June 1, 2018</h2></center>
		<br> New Clan

		<center><h2>May 10, 2018</h2></center>
		<br>Profiles now work. (Shoutout to my boy Nick)
		<br>Sand Manipulation changed to mouse control opposed to the regular directional button.
		<br>RasenShuriken throwing.. *Wink*

		<center><h2>May 7, 2018</h2></center>
		<br>Medics should now be able to 'see' how much wounds a person has.
		<br>Shushin uses now affect the respective passives. Go nuts.
		<br>Speedy severely nerfed..

		<center><h2>May 5, 2018</h2></center>
		<br> Added back NPCs... Let's hope I don't regret this.

		<center><h2>September 10, 2017</h2></center>
		<br>Planet Earth

		<center><h2>July 25, 2017</h2></center>
		<br>Fixes


		<center><h2>July 20, 2017</h2></center>
		<br>End game stuff.


		<center><h2>April 30, 2017</h2></center>
		<br>Change how Rasengan works
		<br>Fixed Corpses?
		<br>Changed Hidden Ninja Scroll
		<br>Buffed some fire Jutsus.
		<br>Gates Mastery.
		<br>New Mangekyou (Shin)


		<center><h2>March 10, 2017</h2></center>
		<br>Changed games FPS
		<br> few stuffs I forgot about


		<center><h2>February 18, 2017</h2></center>
		<br>Rollback


		<center><h2>July 25, 2016</h2></center>
		<br>Stuff
		<br>Jinchurikis are no longer able to go pass the first tail without *complete* control.
		<br>Eye and DNA Extract completed?
		<br>More Stuff.

		<center><h2>April 30, 2016</h2></center>
		<br>Added DNA Extraction Jutsu. (May need testing though) - Implanting DNA has a chance of wiping so don't qq if you get wiped.

		<center><h2>April 29, 2016</h2></center>

		<br>Added more Mokuton jutsus for what it's worth.
		<br>Added Sub-clans.

		<center><h2>April 27, 2016</h2></center>

		<br>Yotsuki Taijutsu stuff added cause wynaut?
		<br>Black Lightning Jutsus added.
		<br>Other stuff implemented that I forgot about.
		<br>Bug fixes that I forgot about.
		<br>New Mokuton Jutsus I guess.


		<center><h2>April 17, 2016</h2></center>

		<br>Re-enabled Nano Mites cause wynaut?
		<br>Added Omote Renge(Primary Lotus for those English Dub fans)

		<center><h2>April 13, 2016</h2></center>

		<br>Elemental Last names (Should) work.
		<br>When you get over 1000 Cursed Seal Mastery, you'll unlock Stage 2, although there will be an alternate way to get it.
		<br>Otokami has the power to grant someone the Mind Awakening pill, but at the cost of some vitals.
		<br>Anbu Captain thingy. (Aka Anbu Root) Can make other Anbus, I think..



		<center><h2>April 12, 2016</h2></center>

		<br>Separated Cursed Seal from Curse Mark and added Cursed Seal Skillcard (Stage 2 for Curse Mark)
		<br>You no longer wake up with 100% health. (I swear if someone qqs about this again.)
		<br>Nerfed Curse Mark, because it was legitimately too strong.

		<center><h2>April 8, 2016</h2></center>

		<br>Hyuuga Clan branches secret techniques added. (Lion Palms, Eight Trigrams Secret art: Style 361 palms)
		<br>Kyuubi Chakra Mode for Kyuubi Jinchuuriki added
		<br>Re-Added coordination. (Please, no more baby qqing)

		<center><h2>April 7, 2016</h2></center>

		<br>Hyuuga Clan Branchs: You'll know when your character turns 15 years old in game, your stats will tell you what Branch you're apart of.
		<br>Jinchuuriki Formes and all Tails Finished (Not Full Bijuu transformation)
		<br>Divine Air Palm added.
		<br>Made it take longer to age (Not sure if people will mind this or not.)


		<center><h2>March 3, 2016</h2></center>

		<br> Changed a lot of icons for things.
		<br> Wonder and Death Gates are in game. (Admin given)
		<br> Buffed Chidori damage and charge speed as well as nerfed Rasengan damage.
		<br> Fixed Lion Sage not activating at all.
		<br> Added Dragon and Senju Sage Modes and buffed the other Sage Modes.
		<br> Fixed a few small bugs in and around the game.
		<br> New Login screen.


		center><h2>October 17- October 23th </h2></center>
		</br><b>UPDATES!!</b>

		<br> Added a new Waiting Screen(Koin)
		<br> New Login Screen(Koin)
		<br> New Clan Select icons(Koin)
		<br> Add Mangekyo with a new req(Koin)
		<br> Added a new Last name, check last names list and you will see it(Koin)
		<br> Maxed Handseal Agility the passive that make you run using handseals(Koin)
		<br> New Skin(Koin)


		<center><h2>October 17 - October 19th</h2></center>

		</br>
		<br> Added New Last Names
		<br> Buffed Alot Of Last Names
		<br> Added a few new last names
		<br> Rasenshurikan in the making
		<br> Soon Buffing Sage Rasengan
		<br> Chidori Been Changed
		<br> Bestiales has been buffed in drain


		<center><h2>Last Name List</h2></center>
		</br><b>The Following Last Names Are Considered Important</b>
		<br>Uzumaki : Uzumaki naturally possess incredibly strong life forces, granting them very long lifespans. They also possess greater Chakra pools than the average Shinobi
		<br>Hatake : Hatake is an average Clan, that posses a hidden ability; White Light Saber, that makes their Tanto weapon stream a white light when used.
		<br>Sarutobi : Sarutobi's have higher than average Physical Stamina.
		<br>Haruno : Haruno clan, known to have slightly higher Chakra Control than the average person.
		<br>Namikaze : Namikaze's have natural higher movement speed and above average Ninjutsu.
		<br>Momochi : Momochi's are ruthless ninjas that possess a stronger phyisical body that most people.
		<br>Renden : Mutated Shinobi's, having strong phyisical bodies aswell as higher chakra amounts than normal people.
		<br>Naga : Naga, over the years, sacrifices all of their Chakra building up and amounts to pour all of it into their Stamina.
		<br>Naiobatsu : Naiobatsu is a clan of experimental Ninja, that found a way to let the body regenerate faster than it's usual, and come close to immortality.
		<br>Bayamo : Bayamo is a Clan that specializes in Fuuton ninjutsu.
		<br>Crimson : Crimson is a Clan that specializes in Katon ninjutsu.
		<br>Hozuki : Hozuki is a Clan that specializes in Suiton ninjutsu.
		<br>Bachi : Bachi is a Clan that specializes in Doton ninjutsu.
		<br>Ryouken : Ryouken is a Clan that specializes in Raiton ninjutsu.
		<br>Shimura : This is a clan of Genjutsu masters, focusing all of their training and time into understanding and overcoming Genjutsus.
		<br>Shiranui : Shiranui is a clan that has the ability to use their Chakra to armor through damage.
		<br>Namiashi : Namiashi is a clan that uses their knowledge of projectile weapons to battle.
		<br>Terumi : Terumi is known to be Elemental prodigies.
		<br>Kurosuki : Kurosuki is a clan focusing their main type of battling into using close ranged weapons, such as Katanas and Ninjatos.
		<br>Munashi : Unfinished.
		<br>Loren : Loren's are people that sacrifices their chakra for pure Taijutsu.
		<br>Jashin : Unfinished.
		<br>Kasuke : A descendant of Naiobatsu, that specialize in recovering their body's at an exponential rate.
		<br>Irkashi : Meh.
		<br>Enton : Enton clan is a bunch of Ninjutsu masters.
		<br>Saru : Saru is a clan based around 'Apes', making them have slightly higher phyisical stamina and endurance.
		<br>Atsuzawa : Atsuzawa is a clan, balancing all of their abilities and skills, prodigous in all of them.
		<br>Suikazan : Suikazan is a clan which sacrifices their Vitals for make room for exponential Chakra amounts.
		<br>Matsuro : OP.
		<br>Cobra : A clan, based around the snake - Cobra - Specializing in Poison and Poison attacks.





		</br>
		</br></font>
		</body>
		</html>
		"}
	usr << browse("[updates]","size=600x600,window=Update Log")//576x576
mob/proc/CheckMap()
	if(!src.client)
		return//
	var/Link="http://z1.ifrm.com/1509/77/0/p1026776/worldmap.png"
	usr << browse({"<html><head><style type="text/css">table, td, th{border:1px solid white;border-collapse:collapse;}th{background-color:white;color:black;}</style></head><img src=[Link]></body></html>"},"window=NFF World Map")
mob/proc/CurrentRules()
	if(!src.client)
		return//
	var/Link="http://s8.zetaboards.com/NarutoFinalFight/topic/8347957/1/"
	usr << browse({"<html><head><style type="text/css">table, td, th{border:1px solid white;border-collapse:collapse;}th{background-color:white;color:black;}</style></head><img src=[Link]></body></html>"},"window=NFF Rules")




mob/var/tmp/target // the var to tell you your target

mob/proc/DeleteTarget()
	src.target=null
	if(!src.client)
		return
	for(var/image/x in src.client.images)
		if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
			del(x)

mob
	proc
		Target()
			if(!src.target)
				src << "You need to target first"
				src.ntarget = 1
			else
				src.ntarget = 0

mob/var/tmp
	ntarget = 0




var/list/Winners
var/list/MatchUpList
var/list/CurrentFighters
var/Limit=0
mob
mob/owner/verb/ResetLists()
	Winners=null
	MatchUpList=null
	CurrentFighters=null
	contestants=list()
	SecondPartDeath=list()
mob/owner/verb/TestAutomaticTournament()
	world<<"<font size=3><b>Automatic Tournament Test Hosting Commencing now. Join using the tournament tab."
	Limit=0
	for(var/mob/M in world)
		M.verbs+=new /mob/Tournament/verb/Join
		spawn(300)
			M.verbs-=/mob/Tournament/verb/Join
	sleep(350)
	world<<"Test Tournament Commencing."
	AutomaticTournament()
mob/Tournament/verb/Join()
	set category="Tournament"
	if(Limit<24)
		src<<"This is a testing tournament and it may be a bit buggy but bear with us and please be patient. You are Frozen until your match starts."
		world<<"[src] joined the tournament."
		src.loc=locate(12,53,30)
		Limit+=1
		contestants+=src
		src.FrozenBind="WaitingForTournament"
		src.verbs-=/mob/Tournament/verb/Join
	else
		src<<"Sorry, because this is a testing tournament the limit is preset at 24 participants. You cannot join."
		src.verbs-=/mob/Tournament/verb/Join
		return


proc/AutomaticTournament()
	if(Limit<4)
		world<<"<font size=3><TT>Not enough participants in the Tournament. Tournament cancelled.</TT></font>"
		contestants=list();return
	if(!Winners)
		world<<"<font size=3><TT>Preparing Tournament set-up. Matching up players randomly.</TT></font>"
		var/list/L=list()
		Winners=list()
		for(var/mob/C in contestants)
			L.Add(C);
		for(var/mob/M in L)
			if(!M.Opponent)
				if(L.len>1)
					L.Remove(M);
					var/mob/PickedOpponent=pick(L)
					PickedOpponent.Opponent=M.ckey
					M.Opponent=PickedOpponent.ckey
					L.Remove(PickedOpponent);
					world<<"<font size=1><TT>[M] vs [PickedOpponent]</TT></font>"
				else
					Winners.Add(M);
					contestants.Remove(M);
					world<<"<font size=1><TT>[M] has no opponent and will move on to the next round.</TT></font>"
			sleep(1)
		world<<"<font size=3><TT>Tournament Set-Up complete.</TT></font>"
		AutomaticMatches()
		return
	else if(Winners.len>=1)
		world<<"Mark5";
		if(Winners.len<=1)
			var/mob/Winner=pick(Winners)
			world<<"<font size=3><TT>Tournament Completed. Congratulations to the winner, [Winner]. Prize: Ninja Cash.</TT></font>"
		else
			contestants=null
			contestants=list()
			world<<"<font size=3><TT>Viewable Contestants Refreshed. Beginning Next Round.</TT></font>"
			MatchUpList=list();
			world<<"Mark6";
			for(var/mob/W in Winners)
				contestants+=W;
				Winners.Remove(W);
				MatchUpList.Add(W);
			var/list/K=list()
			for(var/mob/C in contestants)
				K.Add(C);
			for(var/mob/M in MatchUpList)
				if(MatchUpList.len>=1)
					var/mob/PickedOpponent=pick(K)
					PickedOpponent.Opponent=M.ckey
					M.Opponent=PickedOpponent.ckey
					MatchUpList.Remove(M);
					MatchUpList.Remove(PickedOpponent);
					world<<"<font size=1><TT>[M] vs [PickedOpponent]</TT></font>"
				/*else
					MatchUpList=null;MatchUpList=list();
					Winners=null;Winners=list();
					contestants=null;contestants=list()
					world<<"<font size=1><TT>[M] has no opponent and will move on to the next round.</TT></font>"
					sleep(11)
					world<<"<font size=3><TT>Tournament Completed. Congratulations to the winner, [M]. Prize: 25,000 Ryo.</TT></font>"
					M.Yen+=25000
					return*/
			if(contestants.len>1)
				world<<"<font size=3><TT>Preparing for the next round.</TT></font>"
				AutomaticMatches()
				return



proc/AutomaticMatches()
	world<<"<font size=3><TT>Randomly selecting next match.</TT></font>"
	if(contestants.len==0||!contestants.len)
		if(Winners.len>=1)
			AutomaticTournament()
			return
	if(!contestants.len)
		world<<"<font size=3><TT>All contestants have vanished magically. The tournament is cancelled.</TT></font>"
		return
	world<<"Mark1";
	var/mob/M=pick(contestants)
	var/mob/O
	for(var/mob/Opponent in contestants)
		if(Opponent.Opponent==M.ckey)
			O=Opponent
	world<<"Mark2";
	M.FrozenBind=""
	O.FrozenBind=""
	CurrentFighters=list();
	CurrentFighters.Add(M);CurrentFighters.Add(O);
	sleep(11)
	world<<"Mark3";
	world<<"<font size=3><TT>Match Selected. [M] vs [O]</TT></font>"
	sleep(25)
	world<<"<font size=3><TT>Randomly selecting Arena.</TT></font>"
	sleep(11)
	world<<"Mark4";
	if(prob(50))
		M.loc=locate(115,67,32)
		O.loc=locate(115,46,32)
	else
		M.loc=locate(141,67,32)
		O.loc=locate(141,46,32)
	world<<"<font size=3><TT>Arena Selected. Participants in place. Begin!</TT></font>"
	while(CurrentFighters.len>=2)
		sleep(300)
	if(CurrentFighters.len<=1)
		var/mob/Winner=pick(CurrentFighters)
		world<<"<font size=3><TT>[Winner] wins the match.</TT></font>"
		Winners.Add(Winner)
		if(Winner in contestants)
			contestants.Remove(Winner);
		CurrentFighters=null
		Winner.loc = locate(154,85,32)
		world<<"<font size=3><TT>Moving onto next match.</TT></font>"
		AutomaticMatches()
		return

//HONESTLY...I have no idea why this doesn't work.
//It will not go onto the next match even if someone wins when it should.
//I really don't get it. This constant loop in AutomaticMatches() proc should take care of everything
//regardless if someone loses/logs out/DCs/ or whatever. It doesn't though so I can't say for sure.
//
//You COULD always try calling Automatic Matches after someone wins in the Death Proc with a spawn() infront of it.
//But idk if that would work.


mob/GauntletJoin/verb
	JoinGauntlet()
		set category="Mission Alert"
		set name="Join"
		if(usr.rank=="Genin"||usr.rank=="Student")
			usr.verbs-=new/mob/ChuuninJoin/verb/JoinChuunin()
		else
			usr.verbs-=new/mob/ChuuninJoin/verb/JoinChuunin()
			usr<<"You embark to the hidden base!"
//			usr.loc=locate(0,0,0)
			sleep(50)
			usr<<"After a long journey you've found yourself in the deep underground of Sand! It's your time to shine, now."
			sleep(50)
			usr<<"Go north! But be careful, the ninja have created clever traps. Look out for the lava. The scroll is somewhere north!"
			usr.loc=locate(72,22,32)
			usr.CurrentMission="Gauntlet";usr.TimeLimit=45
proc/Gauntlet()
	var/Xo=pick("Leaf","Rain","Sound","Rock")
	for(var/mob/M in world)
		if(M.client&&M.Village==Xo)
			M<<"<font size=2><font color=red>Mission Alert: A masked ninja has proven resourceful and have stolen another Hidden Ninja Scroll from the Daimyo!? This is an S Rank Mission, we need you to obtain this jewel back! This requires the quickest of movements!!! We need Chuunins and up! Do you join this mission?"
			if(M.rank!="Genin"||M.rank!="Student")
				M.verbs+=new/mob/GauntletJoin/verb/JoinGauntlet()
				spawn(600)
					M.verbs-=new/mob/GauntletJoin/verb/JoinGauntlet()