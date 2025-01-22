//Hell, Place Auto Events, or anything you can think of that can add more fun things to the game, Quests, Idc lol.





var/list/TeamRedTDM = list()
var/list/TeamBlueTDM = list()
var/list/ParticipatorsInTDM = list()
var/list/TDMDLevel=list()
var/list/TDMCLevel=list()
var/list/TDMBLevel=list()
var/list/TDMALevel=list()
var/list/TDMSLevel=list()
var/list/OutCast()
var/TotalPlayersTDM=0
mob/var/tmp/JoinedTDM = 0
mob/var/tmp/WaitingtoTDM = 0
var/TDMHosted=0
var/CurrentEvent=""
mob/owner/verb/HostTDM()//Should Also make it an Auto World/proc so it can be automated ;o
	set name="Host Team Death Match"
	set category="Staff"
	if(CurrentEvent!="")
		usr<<"You need to wait for the current event [CurrentEvent] to finish up before you can use this!";return
	CurrentEvent="Team Death Match"
	for(var/mob/M in OnlinePlayers)
		M.verbs += new/mob/Events/verb/JoinTDM()
	world<<"<font color = blue size = 2> <TT>A Team DeathMatch is being hosted! Press the Join Team Death Match verb inside your Commands Tab to join!</TT></font>"
	spawn(600)
		for(var/mob/A in ParticipatorsInTDM)
			A.health=A.maxhealth;A.stamina=A.maxstamina;A.chakra=A.Mchakra;A.resting=0
			A<<"The Team Death Match will Start Soon."
	//	spawn(60)
		for(var/mob/C in OnlinePlayers)
			C.verbs -= new/mob/Events/verb/JoinTDM()
		world.SetTDM() //World Proc
mob/owner/verb/CheckTDMStuff()
	set name="Check Team Death Match Stuff"
	set category="Staff"
	usr<<"[ParticipatorsInTDM.len] are the amount of people in Team Death match."
	usr<<"[TDMDLevel.len] are D Rank."
	usr<<"[TDMCLevel.len] are C Rank."
	usr<<"[TDMBLevel.len] are B Rank."
	usr<<"[TDMALevel.len] are A Rank."
	usr<<"[TDMSLevel.len] are S Rank."
	usr<<"[TotalPlayersTDM] have been set into a proper Rank List"
	return
mob/Events/verb/JoinTDM()
	set name="Join Team Death match"
	set category="Commands"
	if(usr.Frozen||usr.firing||usr.Mogu||usr.Dead||usr.knockedout)
		return
	if(usr.resting)
		usr<<"Unrest.";return
	if(ParticipatorsInTDM.len>=20)
		usr<<"The Team Death Match is full.";usr.verbs-=new/mob/Events/verb/JoinTDM()
		return
	if(usr in ParticipatorsInTDM)
		usr<<"You're already in the Event!";usr.verbs-=new/mob/Events/verb/JoinTDM();return
	usr<<"The Team Death Match will begin shortly! Sit Tight!"
	world<<"<TT><font color=blue>[usr] has joined the Team Death Match!</font></TT>"
	ParticipatorsInTDM+=usr
world/proc/SetTDM()//Places the people who chose to join in Groups according to their ranks for balancing purposes
	for(var/mob/M in ParticipatorsInTDM)
		if(M.blevel=="D")
			TDMDLevel+=M;ParticipatorsInTDM-=M
		if(M.blevel=="C")
			TDMCLevel+=M;ParticipatorsInTDM-=M
		if(M.blevel=="B")
			TDMBLevel+=M;ParticipatorsInTDM-=M
		if(M.blevel=="A")
			TDMALevel+=M;ParticipatorsInTDM-=M
		if(M.blevel=="S")
			TDMSLevel+=M;ParticipatorsInTDM-=M
	world<<"Setting up Teams..."
	spawn(30)
		world.SetTDMTeams()
world/proc/SetTDMTeams()
	var/list/SettingUpTDM=list()
	var/list/OutCastD=list()
	var/list/OutCastC=list()
	var/list/OutCastB=list()
	var/list/OutCastA=list()
	var/list/OutCastS=list()
	var/Number

	var/mob/Out
	if(TDMDLevel%2==1)
		Out=pick(TDMDLevel)
		OutCastD+=Out
		TDMDLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for D Rank Ninja."
	if(TDMCLevel%2==1)
		Out=pick(TDMCLevel)
		OutCastC+=Out
		TDMCLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for C Rank Ninja."
	if(TDMBLevel%2==1)
		Out=pick(TDMBLevel)
		OutCastB+=Out
		TDMBLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for B Rank Ninja."
	if(TDMALevel%2==1)
		Out=pick(TDMALevel)
		OutCastA+=Out
		TDMALevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for A Rank Ninja."
	if(TDMSLevel%2==1)
		Out=pick(TDMSLevel)
		OutCastS+=Out
		TDMSLevel-=Out
		TotalPlayersTDM++
		world<<"For Balance Reasons, [Out] was placed into the Waiting Roster for S Rank Ninja."
	var/DPerTeam//=TDMDLevel.len/2
	var/CPerTeam//=TDMCLevel.len/2
	var/BPerTeam//=TDMBLevel.len/2
	var/APerTeam//=TDMALevel.len/2
	var/SPerTeam//=TDMSLevel.len/2
	DPerTeam=TDMDLevel.len/2
	CPerTeam=TDMCLevel.len/2
	BPerTeam=TDMBLevel.len/2
	APerTeam=TDMALevel.len/2
	SPerTeam=TDMSLevel.len/2
	for(var/mob/M in OnlinePlayers)
		if(M in TDMDLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMCLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMBLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMALevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
		if(M in TDMSLevel)
			TotalPlayersTDM++
			SettingUpTDM+=M
	world<<"[DPerTeam] D Ranked Ninjas per team."
	sleep(15)
	world<<"[CPerTeam] C Ranked Ninjas per team"
	sleep(15)
	world<<"[BPerTeam] B Ranked Ninjas per team"
	sleep(15)
	world<<"[APerTeam] A Ranked Ninjas per team"
	sleep(15)
	world<<"[SPerTeam] S Ranked Ninjas per team"
	world<<"Total Number of Players in this Team Death Match are [TotalPlayersTDM]"//[SettingUpTDM.len]."
//	if(OutCast.len!=null)
//	world<<"Current Value of those awaiting a team for balance purposes: [OutCast.len]."
	Number=(DPerTeam+CPerTeam+BPerTeam+APerTeam+SPerTeam)
	world<<"There will be [Number] Members per each side!"
	for(var/i=0;i<=(Number-1);i++)
		for(var/p=0;p<=DPerTeam;p++)
			var/mob/A
			A=pick(TDMDLevel)
			TDMDLevel-=A
			TeamRedTDM+=A
			p++
		for(var/q=0;q<=CPerTeam;q++)
			var/mob/B
			B=pick(TDMCLevel)
			TDMCLevel-=B
			TeamRedTDM+=B
			q++
		for(var/r=0;r<=BPerTeam;r++)
			var/mob/C
			C=pick(TDMBLevel)
			TDMBLevel-=C
			TeamRedTDM+=C
			r++
		for(var/s=0;s<=APerTeam;s++)
			var/mob/D
			D=pick(TDMALevel)
			TDMALevel-=D
			TeamRedTDM+=D
			s++
		for(var/t=0;t<=SPerTeam;t++)
			var/mob/E
			E=pick(TDMSLevel)
			TDMSLevel-=E
			TeamRedTDM+=E
			t++
		i++
	for(var/u=0;u<=(Number-1);u++)
		for(var/p=0;p<=DPerTeam;p++)
			var/mob/AA
			AA=pick(TDMDLevel)
			TDMDLevel-=AA
			TeamBlueTDM+=AA
			p++
		for(var/q=0;q<=CPerTeam;q++)
			var/mob/BB
			BB=pick(TDMCLevel)
			TDMCLevel-=BB
			TeamBlueTDM+=BB
			q++
		for(var/r=0;r<=BPerTeam;r++)
			var/mob/CC
			CC=pick(TDMBLevel)
			TDMBLevel-=CC
			TeamBlueTDM+=CC
			r++
		for(var/s=0;s<=APerTeam;s++)
			var/mob/DD
			DD=pick(TDMALevel)
			TDMALevel-=DD
			TeamBlueTDM+=DD
			s++
		for(var/t=0;t<=SPerTeam;t++)
			var/mob/EE
			EE=pick(TDMSLevel)
			TDMSLevel-=EE
			TeamBlueTDM+=EE
			t++
		u++
	world<<"Current amount of people on Red Team: [TeamRedTDM.len]."
	world<<"Current amount of people on Blue Team: [TeamBlueTDM.len]."

world/proc/StartFFA()
	if(global.AutoFreeForAllCount >= 1)
	//	usr<<"There is already a FFA in progress."
		return
	world<<"<b><font size=2 color=blue>A FFA is able to be joined!</font></b>"
	global.AutoFreeForAllCount = 1
	world<<"<b><font size=2 color=blue>Press the Join FFA verb located in the challenge tab to join the FFA!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The FFA will start in 2 minutes!</font></b>"
	sleep(600)
	world<<"<b><font size=2 color=blue>The FFA will start in another minute!</font></b>"
	sleep(600)
	world<<"<b><font size=3 color=red>The FFA has started!"
	global.AutoFreeForAllCount = 2
	world<<"<b><font size=2 color=blue>There are [length(AutoFreeForAll)] fighters in the FFA.</font></b>"
	global.AutoFreeForAllRewardBonus = 0
	global.AutoFreeForAllReward = 0
	global.AutoFreeForAllReward = length(AutoFreeForAll) * 7500
	world<<"<b><font size=2 color=green>The reward for this tournament is [global.AutoFreeForAllReward] ryo.</font></b>"
	if(length(AutoFreeForAll) > 10)
		world<<"<b><font size=2 color=red>An additional reward of 150000 Ryo will be awarded for this FFA due to the amount of participants!</font></b>"
		global.AutoFreeForAllRewardBonus = 1

	for(var/mob/A in AutoFreeForAll)
		A.loc = locate(rand(120,135),rand(170,171), 21)
		A.deathcount=0
		A.health=A.maxhealth
		A.chakra=A.Mchakra
		A.stamina=A.maxstamina
		A.ChakraPool=A.MaxChakraPool
		contestants+=A
	return
//////////////////////////////////////////////////////

//Assassin Mode :D!!

//////////////////////////////////

mob/owner/verb/HostAssassin()
	set name="Host Assasssin Event"
	set category="Commands"
	if(CurrentEvent!="")
		usr<<"Wait for the current event to end!";return
	for(var/mob/M in OnlinePlayers)
		M.verbs+=new/mob/Events/verb/JoinAssassin()
	world<<"<font size=2 color=blue> A Dangerous assassin has been located on the outskirts of a forest...Press the Hunt Down Assassin verb located in your commands tab to confront this Assassin!</font>"
	sleep(450)
	for(var/mob/C in OnlinePlayers)
		C.verbs-=new/mob/Events/verb/JoinAssassin()
	world.setAssassinEvent()

var/list/InAssassinEvent=list()

mob/Events/verb/JoinAssassin()
	set name="Hunt Down Assassin"
	set category="Commands"
	if(usr.Frozen||usr.firing||usr.Mogu||usr.Dead||usr.knockedout)
		return
	if(usr.resting)
		usr<<"Unrest.";return
	if(InAssassinEvent.len>=30)
		usr<<"The max amount of Ninja have already been dispatched to hunt down the assassin!";usr.verbs-=new/mob/Events/verb/JoinAssassin()
		return
	if(usr in InAssassinEvent)
		usr<<"You're already in the Event!";usr.verbs-=new/mob/Events/verb/JoinAssassin();return
	InAssassinEvent+=usr
	usr<<"The Dispatch will begin shortly! Sit Tight!"
	world<<"<font color=blue>[usr] will be dispatched to hunt down the Assassin!</font>"

mob/var/tmp/TheAssassin=0

world/proc/setAssassinEvent()
	for(var/mob/M in InAssassinEvent)
		M.health=M.maxhealth
		M.stamina=M.maxstamina
		M.chakra=M.Mchakra
		M.ChakraPool=M.MaxChakraPool
		M.resting=0
		M<<"<font color=green>Get ready to head to the forest..</font>"
	sleep(150)
	for(var/mob/L in InAssassinEvent)
		spawn()
			L.FadeScreen()
			L.loc=locate(rand(30,50),rand(30,90),37)
	world.startAssassinEvent()

var/list/Assassin = list()
mob/var/CantAlert=0
var/PrizeForAssassin
var/PrizeForNinja
world/proc/startAssassinEvent()
	var/mob/Assassin2=""
	for(var/mob/A in InAssassinEvent)
		Assassin2=pick(InAssassinEvent)
		Assassin+=Assassin2
		InAssassinEvent-=Assassin2
		break
	for(var/mob/L in Assassin)
		L<<"<font color=red> You are the Assassin..Your power has been Increased, along with your Willpower, and your increase in blood lust allows you to kill people within one knock out...Kill everyone in here!</font>"
		L.TheAssassin=1
		L.CantAlert=1
	for(var/mob/Q in InAssassinEvent)
		Q<<"All sources of information are shut off...If you encounter the assassin there will be no way to alert anyone to help you..Trust No One!"
		Q<<"<font color=red> Killing the assassin will result in a prize for you and a minor prize for the remaining survivors...</font>"
		Q.CantAlert=1
	if(InAssassinEvent.len>=29)
		PrizeForAssassin="2 Elemental Points"
		PrizeForNinja="500k Yen"
	if(InAssassinEvent.len>=19&&InAssassinEvent.len<9)
		PrizeForAssassin="1 Elemental Points"
		PrizeForNinja="750k Yen"
	if(InAssassinEvent.len<=9)
		PrizeForAssassin="1 Cooldown and EXP Scroll"
		PrizeForNinja="1 Million Yen"
	world.AssassinEvent()

world/proc/AssassinEvent()
	//Don't forget to make a check for if there is a chuunin exam currently
	CurrentEvent="Kill The Assassin"
	while(CurrentEvent=="Kill The Assassin")
		if(InAssassinEvent.len<=0)
			world<<"<font size=2 color=blue> The Assassin has killed all of the Ninja that tried to stop him...</font>"
			for(var/mob/O in Assassin)
				if(PrizeForAssassin=="2 Elemental Points")
					O.ElementalPoints+=2
					spawn()
						O.GotoVillageHospital()
				if(PrizeForAssassin=="1 Elemental Points")
					O.ElementalPoints+=1
					spawn()
						O.GotoVillageHospital()
			for(var/mob/A in world)
				if(A in OnlinePlayers)
					if(A.CantAlert)
						A.CantAlert=0
			CurrentEvent=""
			return
		if(Assassin.len<=0)
			world<<"<font size=2 color=blue> The Assassin has been killed...</font>"
			for(var/mob/I in InAssassinEvent)
				if(PrizeForNinja=="1 Million Yen")
					I.Yen+=1000000
					spawn()
						I.GotoVillageHospital()
				if(PrizeForNinja=="750k Yen")
					I.Yen+=750000
					spawn()
						I.GotoVillageHospital()
				if(PrizeForNinja=="500k Yen")
					I.Yen+=500000
					spawn()
						I.GotoVillageHospital()
			for(var/mob/F in world)
				if(F in OnlinePlayers)
					if(F.CantAlert)
						F.CantAlert=0
			CurrentEvent=""
			return
				//Don't Forget the Cooldown Scroll prize!
		sleep(30)

























