mob/var/tmp/ItemWeight=0
mob/var/tmp/SavedLayer=4
mob/var/AgeCounter=0
mob/var/tmp/ChoosingTrait=0
mob/var/FaceChange=0
mob/var/ImplantWait=0
mob/var/FirstArenaWin=0
mob/var/OneTimeFirstTraitChange=0
mob/var/TwentyFifthArenaWinMark=0
mob/var/FiftythArenaWinMark=0
mob/var/HundrethArenaWinMark=0
mob/var/TwoHundredFiftythArenaWinMark=0
mob/var/NPCHunter=0
mob/var/itemowned=0
mob/var/itemowned2=0
mob/var/tmp/VersatileCount=0
mob/var/tmp/StealthCount=0
mob/var/tmp/FuuinOn=""
var/TextCheck1="Youarenot"
mob/proc/FirstTraitChoose()
	set background=1
	if(src.ChoosingTrait==0&&src.Trait=="")
		src.ChoosingTrait=1
		switch(input("You've hit the age of 13 and your body begins to hit adolesence, which of the characteristics do you see yourself as?") in list("Hardworking","Quick","Tough","Powerful","Intellectual"))
			if("Hardworking")
				src.Trait="Hard-Worker"
				src.AutoSave()
			if("Intellectual")
				src.Trait="Genius"
				src.StartingPoints+=5
				src.ElementalPoints+=8
				src.AutoSave()
			if("Powerful")
				src.Trait="Powerful"
				src.AutoSave()
			if("Quick")
				src.Trait="Speedy"
				src.AutoSave()
			if("Tough")
				src.Trait="Tough"
				src.StaminaRegen+=rand(10,20)
				src.HealthRegen+=rand(10,20)
				src.AutoSave()
mob/proc/SecondTraitChooseSuper()
	set background=1
	if(src.Age>=17&&src.Trait2=="")
		switch(input("You've hit the age of 17 and your body has reached full maturity. You have developed:") in list("A Peaceful Mind","A Body Which Never Tires Of Physical Energy","An Inner Understanding Of Chakra","A Body So Strong, It Cannot Be Stopped","An Unwavering Will","Inhuman Endurance","Inhuman Regeneration","Inhuman Speed"))
			if("A Peaceful Mind")
				src.Trait2="Sound Mind"
				src.AutoSave()
			if("A Body Which Never Tires Of Physical Energy")
				src.Trait2="Hyperactivity"
				src.StaminaRegen+=rand(35,50)
				src.AutoSave()
			if("An Inner Understanding Of Chakra")
				src.Trait2="Pure Body"
				if(src.SecondName!="Karsumu")
					src.DeclineAge+=20
				src.AutoSave()
			if("A Body So Strong, It Cannot Be Stopped")
				src.Trait2="Adamant"
				src.MEndurance+=15
				src.AutoSave()
			if("An Unwavering Will")
				src.Trait2="Iron Will"
				src.AutoSave()
			if("Inhuman Endurance")
				src.Trait3="Super Human Endurance"
				src.MEndurance+=250;
				src.Endurance=src.MEndurance
				src.AutoSave()
			if("Inhuman Regeneration")
				src.Trait3="Super Human Regeneration"
				src.HealthRegen+=rand(15,20)
				src.StaminaRegen+=rand(20,35)
				src.AutoSave()
			if("Inhuman Speed")
				src.Trait3="Super Human Speed"
				src.AutoSave()
mob/proc/FirstTraitChange()
	set background=1
	return
	if(src.Age>=13&&src.Trait!=""&&src.OneTimeFirstTraitChange==0)
		src.OneTimeFirstTraitChange=1
		switch(input("(THIS IS A ONE TIME CHANCE IF YOU'VE ALREADY CHOSEN YOUR TRAIT) You've hit the age of 13 and your body begins to hit adolesence, which of the characteristics do you see yourself developing?") in list("Hardworking","Quick","Tough","Powerful","Intellectual"))
			if("Hardworking")
				src.Trait="Hard-Worker"
				src.AutoSave()
			if("Intellectual")
				if(src.Trait!="Genius")
					src.StartingPoints+=5
					src.ElementalPoints+=8
				if(src.Trait=="Hard-Worker"&&src.Age>=25)
					src.maxstamina-=rand(2500,3000)
					src.Mchakra-=rand(3000,4000)
				src.Trait="Genius"
				src.AutoSave()
			if("Powerful")
				if(src.Trait=="Hard-Worker"&&src.Age>=25)
					src.maxstamina-=rand(2500,3000)
					src.Mchakra-=rand(3000,4000)
				src.Trait="Powerful"
				src.AutoSave()
			if("Quick")
				if(src.Trait=="Hard-Worker"&&src.Age>=25)
					src.maxstamina-=rand(2500,3000)
					src.Mchakra-=rand(3000,4000)
				src.Trait="Speedy"
				src.AutoSave()
			if("Tough")
				if(src.Trait=="Hard-Worker"&&src.Age>=25)
					src.maxstamina-=rand(2500,3000)
					src.Mchakra-=rand(3000,4000)
				if(src.Trait!="Tough")
					src.StaminaRegen+=rand(10,20)
					src.HealthRegen+=rand(10,20)
				src.Trait="Tough"
				src.AutoSave()
mob/proc/FirstTraitFix()
	set background=1
	if(src.Age>=13&&src.ChoosingTrait==0&&src.Trait=="")
		src.ChoosingTrait=1
		src.OneTimeFirstTraitChange=1
		switch(input("You've hit the age of 13 and your body begins to hit adolesence, which of the characteristics do you see yourself developing?") in list("Hardworking","Quick","Tough","Powerful","Intellectual"))
			if("Hardworking")
				src.Trait="Hard-Worker"
				src.AutoSave()
			if("Intellectual")
				src.Trait="Genius"
				src.StartingPoints+=5
				src.ElementalPoints+=8
				src.AutoSave()
			if("Powerful")
				src.Trait="Powerful"
				src.AutoSave()
			if("Quick")
				src.Trait="Speedy"
				src.AutoSave()
			if("Tough")
				src.Trait="Tough"
				src.StaminaRegen+=rand(10,20)
				src.HealthRegen+=rand(10,20)
				src.AutoSave()
mob/proc/TraitFix()
	set background=1
	if(src.Age>=17&&src.Trait2=="")
		switch(input("You've hit the age of 17 and your body has reached full maturity. You have developed:") in list("A Peaceful Mind","A Body Which Never Tires Of Physical Energy","An Inner Understanding Of Chakra","A Body So Strong, It Cannot Be Stopped","An Unwavering Will"))
			if("A Peaceful Mind")
				src.Trait2="Sound Mind"
				src.AutoSave()
			if("A Body Which Never Tires Of Physical Energy")
				src.Trait2="Hyperactivity"
				src.StaminaRegen+=rand(35,50)
				src.AutoSave()
			if("An Inner Understanding Of Chakra")
				src.Trait2="Pure Body"
				if(src.SecondName!="Karsumu")
					src.DeclineAge+=20
				src.AutoSave()
			if("A Body So Strong, It Cannot Be Stopped")
				src.Trait2="Adamant"
				src.MEndurance+=15
				src.AutoSave()
			if("An Unwavering Will")
				src.Trait2="Iron Will"
				src.AutoSave()
mob/proc/BanCheck()
	set background=1
	if(src.client&&src)
		if(Bans.Find(src.key)||src.client.IsComputerBanned())
			del(src)
		sleep(6000)
		src.BanCheck()
mob/proc/CHECK()//Cleaned out Check Proc
	if(!src.client||!src.key)//If they're not a player they don't need this.
		return
	if(src.key in Dev)
		src.Dev=1
	if(src.Age>=17&&src.Trait2=="")
		src.TraitFix()
//	if(src.Age>=13&&src.Trait!=""&&src.OneTimeFirstTraitChange==0)
//		src.FirstTraitChange()
	if(src.Age>=13&&src.Trait=="")
		src.FirstTraitFix()
	if(usr.CantAlert&&!(usr in InAssassinEvent))
		usr.CantAlert=0
	var/calcLag = abs(world.cpu - 100)
	if(calcLag<=10)
		src<<"The server happens to be at a very low performance right now. It is suggested that you do not save or log off at this time."
	if(src.Rasenganon==0&&src.DRasenganCounter>0)
		src.DRasenganCounter=0
	if(src.Guarding||src.WeaponMaster>6&&src.LeftHandSheath||src.WeaponMaster>6&&src.RightHandSheath)
		if(src.WeaponInLeftHand!=""&&src.WeaponInLeftHand!="Spider"&&src.WeaponInLeftHand!="Bird"||src.WeaponInRightHand!=""&&src.WeaponInRightHand!="Spider"&&src.WeaponInRightHand!="Bird"||src.KagDance=="Yanagi"||src.KagDance=="Tsubaki")
			src.Deflection=1
	if(src.Overthought!=1&&src.GenjutsuKnowledge>550&&src.Age>35)
		src.Overthought=1
	if(src.CurrentMission=="Find Stray Dog")
		src.verbs+= new /mob/Mission/verb/Capture
	src.invisibility=1
	src.see_invisible=1
	src.desc=""
	/*
		mob/var/challengeWins = 0
		mob/var/challengeLosses = 0
	*///Huge Section designed just for rewards that come with the challenge system!
/*
	if(src.FirstArenaWin==0&&src.challengeWins>0)
		src<<"Congratulations on your first arena win! You have been given 3 Elemental Points!"
		src.FirstArenaWin=1
//		src.NinjaCash+=15
		src.ElementalPoints+=3
		src.AutoSave()
//		src.SaveK()
	if(src.TwentyFifthArenaWinMark==0&&src.challengeWins>=25)
		src<<"You're getting better in combat! You have been given 5 Elemental Points!"
		src.TwentyFifthArenaWinMark=1
	//	src.NinjaCash+=10
		src.ElementalPoints+=5
		src.AutoSave()
	//	src.SaveK()
	if(src.FiftythArenaWinMark==0&&src.challengeWins>=50)
		src<<"You're becoming a really strong Fighter! You have been given 1 Starter Point, and 5 Elemental Points!"
		src.FiftythArenaWinMark=1
	//	src.NinjaCash+=75
		src.StartingPoints+=1
		src.ElementalPoints+=5
		src.AutoSave()
	//	src.SaveK()
	if(src.HundrethArenaWinMark==0&&src.challengeWins>=100)
		src<<"You've become a legend....You have been given 1 Starter Point, and 5 Elemental Points..."
		src.HundrethArenaWinMark=1
	//	src.NinjaCash+=90
		src.StartingPoints+=1
		src.ElementalPoints+=5
		src.AutoSave()
	//	src.SaveK()
	if(src.TwoHundredFiftythArenaWinMark==0&&src.challengeWins>=250)
		src<<"You're a God...."
		src.Mchakra+=250
		src.maxstamina+=250
		src.TwoHundredFiftythArenaWinMark=1
		src.AutoSave()
	//	src.SaveK()
*/

	if(LeafVillagePool>=20000000) LeafVillagePool=20000000
	if(SoundVillagePool>=20000000) SoundVillagePool=20000000
	if(RockVillagePool>=20000000) RockVillagePool=20000000
	if(RainVillagePool>=20000000) RainVillagePool=20000000
	if(global.AutoFreeForAllCount == 2)
		FFAAutoRun()
	if(src.FrozenBind!="")
		if(src.FrozenBind!="Death")
			src.FrozenBind=""
	if(src.Focus>750) //Adding this for now until I fix the Cursed Seal Bug
		src.Focus=750
	if(src.Kenjutsu>125&&src.Clan=="Yotsuki"||src.Kenjutsu>125&&usr.Clan2=="Yotsuki")
		src.Kenjutsu=125
	src.underlays -= 'Icons/Jutsus/Kujaku.dmi';src.underlays -= 'Icons/Jutsus/Kujaku.dmi'
//Fixing Henge Glitch Below
	if(src.SavedLayer!=null)
		if(src.SavedLayer!=4)
			src.SavedLayer=4
		src.layer=src.SavedLayer
	if(src.Oicon)
		src.icon=src.Oicon
	src.overlays-='Icons/Jutsus/BEyes.dmi'
	if(src.InHenge)
		src.overlays=null
		src.icon=src.Oicon
		src.overlays+=src.hair
		src.overlays+=usr.Overlays
		src.firing=0
		src.name=src.savedname
		src.InHenge=0
	if(src.SavedHengeVillage&&src.Village!=src.SavedHengeVillage)
		src.Village=src.SavedHengeVillage
//////////////////////////////////
	src.HasHiddenScroll=0//Makes sure they never have the Hidden Ninja Scroll Ever
	for(var/obj/Hidden_Ninja_Scroll/H in src.contents)
		del(H)
//Makes sure nothing under here glitches.
	if(src.maxhealth>=1500)
		src.maxhealth=1500;src.health=src.maxhealth
	if(src.NinSkill>40)
		src.NinSkill=40
	if(src.GenSkill>40)
		src.GenSkill=40
	if(src.TaiSkill>40)
		src.TaiSkill=40
	spawn()//So it doesn't delay the loading process.
//		if(locate(var/obj/SkillCards/KujakuMyouhou/A in src.LearnedJutsus))
		for(var/obj/SkillCards/KujakuMyouhou/A in src.LearnedJutsus)
			src.maxhealth=1250
			if(src.SecondName=="Suikazan")
				src.maxhealth=750
			src.ChakraColorR=255;src.ChakraColorG=26;src.ChakraColorB=198
	if(src.TaijutsuStyle=="")
		src.TaijutsuStyle="Basic"
	if(src.Clan=="Hyuuga"&&src.TaijutsuStyle!="Jyuken")
		src.TaijutsuStyle="Jyuken"
	if(src.Buffet>=10)
		src.AdvancedWielding=1
//////////////////////////////////
//Skillcard Delay fix.
	spawn()
		var/list/QQ = src.LearnedJutsus
		for(var/obj/SkillCards/S in QQ)
			S.Delay=0
			S.overlays-='Icons/Jutsus/Skillcards2.dmi';S.overlays-='Icons/Jutsus/Skillcards2.dmi'
			S.overlays-='Icons/Jutsus/Skillcards2.dmi';S.overlays-='Icons/Jutsus/Skillcards2.dmi'
	spawn()
		src.DeleteMultipleCopySkillCards()//Multiple Skillcard thing.
/////////////////////////////////////////
//Hospital Time Waiter Fixer
	if(src.FrozenBind=="Dead")
		src.GotoVillageHospital()

//Let me auto learn my sh-- under here.
	src.LearnJutsuZ()
//Legendary Sword Skills
	if(src.KirinCheck1==1&&src.KirinCheck2==1)
		src.LearnedJutsus+=new/obj/SkillCards/KirinWeak
	if(locate(/obj/WEAPONS/DarkBlade) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/BlackShot
		src.LearnedJutsus+=new/obj/SkillCards/BlackGouryuuka
	if(locate(/obj/WEAPONS/OriginalKubikiriHoucho) in src.contents)
		if(!(locate(/obj/SkillCards/BloodLust) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/BloodLust
	if(locate(/obj/WEAPONS/RoseBladeSword) in src.contents)
		if(!(locate(/obj/SkillCards/RosePetal) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/RosePetal
	if(locate(/obj/WEAPONS/Shibuki) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/ShibukiDash
	if(locate(/obj/WEAPONS/LightBlade) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/LightShot
		src.LearnedJutsus+=new/obj/SkillCards/LightGouryuuka
	if(locate(/obj/WEAPONS/NagaBladeSword) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/VoidOpen1
		src.LearnedJutsus+=new/obj/SkillCards/VoidOpen2
		src.LearnedJutsus+=new/obj/SkillCards/VoidOpen3
	if(locate(/obj/WEAPONS/InvisibleKaito) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/KaitoReach
		src.LearnedJutsus+=new/obj/SkillCards/KaitoInvisibleCuts
	if(locate(/obj/WEAPONS/Evanesence) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/EvanesenceBlastJutsu
 //Xiveres Skills
	if(locate(/obj/Clothes/XiveresMask) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen1
	if(locate(/obj/Clothes/XiveresLeaderMask) in src.contents)
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen1
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen2
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen3
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulR
		src.LearnedJutsus+=new/obj/SkillCards/XiveresHealing
//Akatsuki And Xiveres
	if(src.SevenSkiesMember||src.SevenSkiesLeader)
		src.LearnedJutsus+=new/obj/SkillCards/SkiesTeleport
	if(src.IndigoMember||src.IndigoLeader)
		src.LearnedJutsus+=new/obj/SkillCards/IndigoTeleport
		src.LearnedJutsus+=new/obj/SkillCards/IndigoEyes
		src.LearnedJutsus+=new/obj/SkillCards/IndigoIlluminate

	if(src.XiveresMember==1)
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulAbsorb
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulCytoplasm
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulEmpowerment
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulAssault
		if(src.SoulKnowledge>=50&&src.SoulKnowledge<=100)
			src.LearnedJutsus+=new/obj/SkillCards/XiveresHealing
			src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulR
			src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen1
			src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen2
	 src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulAbsorb
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulCytoplasm
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulEmpowerment
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulAssault
		src.LearnedJutsus+=new/obj/SkillCards/XiveresHealing
		src.LearnedJutsus+=new/obj/SkillCards/XiveresLeaderSummon
		src.LearnedJutsus+=new/obj/SkillCards/XiveresLeaderSuicideHeal
		src.LearnedJutsus+=new/obj/SkillCards/XiveresPunishment
		src.LearnedJutsus+=new/obj/SkillCards/XiveresBodySoulRemoval
		src.LearnedJutsus+=new/obj/SkillCards/XiveresSoulR
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen1
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen2
		src.LearnedJutsus+=new/obj/SkillCards/XiveresOpen3
	if(src.akatsukileader==1)
		src.verbs+=new/mob/Warp/verb/BaseTeleport()
		src.verbs+=new/mob/Warp/verb/Warp()
		//src.verbs+=new/mob/Warp/verb/Warp2()
		src.verbs+=new/mob/Warp/verb/Warp3()
	//	src.verbs+=new/mob/Warp/verb/Warp4()
	if(src.akatsukimember==1)
		src.verbs+=new/mob/Warp/verb/BaseTeleport()
	if(src.sevenswordsmenleader==1)
		src.verbs += typesof(/mob/sevenswordsmen/verb)
		src.verbs += typesof(/mob/sevenswordsmenmember/verb)
	if(src.sevenswordsmenmember==1)
		src.verbs += typesof(/mob/sevenswordsmenmember/verb)

//Medals

//Ban Check Starter
	spawn()
		src.BanCheck()
	if(PermDeath)
		src<<"Perm death mode was activated for the sake of a possible RP or even just a small wipe! If you die during this you have a chance at getting wiped!"
	if(Halfexpday)
		src<<"HalfEXP has been activated. Anything that gives Jutsu EXP is x0.5."
	if(DBLexpday)
		src<<"DoubleEXP has been activated. Anything that gives Jutsu EXP is x2. and Jutsu Delay is almost tripled."
	if(TRPLexpday)
		src<<"TipleEXP has been activated. Anything that gives Jutsu EXP is x3. and Jutsu Delay is almost tripled."
	if(!(src.name in src.namesknown))
		src.namesknown+=src.name
//////////////////////////////////////
//////////////////////////////////

//Verbs
//////////////////////////////////
	if(src.rank=="Hokage"||src.rank=="Amekoutei"||src.rank=="Otokami"||src.rank=="Tsuchikage")
		src.verbs+=typesof(/mob/Kage/verb)
		src.verbs+=typesof(/mob/ANBU/verb)
		src.verbs+=/mob/VC/verb/ImpeachKage
	if(src.Anbu)
		if(src.TaijutsuKnowledge+src.NinjutsuKnowledge+src.GenjutsuKnowledge>=500)
			src.verbs += typesof(/mob/ANBU/verb)
		else
			for(var/mob/X in world)
				if(X.Village==src.Village)
					X << "<font color = #BB0EDA>Village Information:</font> [src] did not meet the requirements to be an ANBU and has lost their rank."
			src.Anbu=0
			for(var/obj/Clothes/C in src.contents)
				if(C.icon=='Icons/New Base/Clothing/Official Clothing/Ganbu.dmi'||C.icon=='Icons/New Base/Clothing/Official Clothing/Ranbu.dmi'||C.icon=='Icons/New Base/Clothing/Official Clothing/Banbu.dmi')
					del(C)
//	if(src.rank=="Jounin"||src.rank=="Sannin")
//		src.verbs+=typesof(/mob/Jonin/verb)


//Leaf Village
	if(src.rank=="Hokage")
		if(Hokage!=src.key)
			src.rank="Jounin"
			src<<"You have been demoted from Hokage because the game does not recognize you as Hokage."
			for(var/obj/Clothes/HokageSuit/A in src.contents)
				del(A)
			for(var/obj/Kage_Ring/B in src.contents)
				del(B)
	if(src.rank=="Leaf Village Official")
		if(LeafVillageOfficial!=src.key)
			src.rank="Genin"
			src<<"You have lost the rank of Village Official because the game does not recongize you as the Village Official."
	if(src.rank=="Leaf Village Official")
		src.verbs+=typesof(/mob/VillageOfficial/verb)
	if(src.rank=="Hokage")
		src.verbs+=/mob/Kage/verb/VillageLeaderSay
		src.verbs+=typesof(/mob/Hokage/verb)
		src.verbs+=typesof(/mob/KonohaMilitaryPoliceForceMember/verb)
		spawn()
			var/Accept=0
			for(var/obj/Clothes/HokageSuit/A in src.contents)
				Accept=1
			for(var/obj/Kage_Ring/A in src.contents)
				Accept=2
			if(!Accept)
				var/obj/Clothes/HokageSuit/B=new();B.loc=src
				var/obj/Kage_Ring/C=new();C.loc=src
	if(src.KonohaMilitaryPoliceForceMember)
		src.verbs += typesof(/mob/KonohaMilitaryPoliceForceMember/verb)
//Rain Village
	if(src.rank=="Amekoutei")
		if(Amekoutei!=src.key)
			src.rank="Jounin"
			src<<"You have been demoted from Amekoutei because the game does not recognize you as Amekoutei."
			for(var/obj/Clothes/AmekouteiSuit/A in src.contents)
				del(A)
			for(var/obj/Kage_Ring/B in src.contents)
				del(B)
	if(src.rank=="Rain Village Official")
		src.verbs+=typesof(/mob/VillageOfficial/verb)
		if(RainVillageOfficial!=src.key)
			src.rank="Genin"
			src<<"You have lost the rank of Village Official because the game does not recongize you as the Village Official."
	if(src.rank=="Amekoutei")
		src.verbs+=/mob/Kage/verb/VillageLeaderSay
		src.verbs+=typesof(/mob/Amekoutei/verb)
		src.verbs+=typesof(/mob/HunterNin/verb)
		spawn()
			var/Accept=0
			for(var/obj/Clothes/AmekouteiSuit/A in src.contents)
				Accept=1
			for(var/obj/Kage_Ring/A in src.contents)
				Accept=2
			if(!Accept)
				var/obj/Clothes/AmekouteiSuit/B=new();B.loc=src
				var/obj/Kage_Ring/C=new();C.loc=src
	if(src.HunterNinMember)
		src.verbs+=typesof(/mob/HunterNin/verb)
//Sound Village
	if(src.rank=="Otokami")
		if(Otokami!=src.key)
			src.rank="Jounin"
			src<<"You have been demoted from Otokami because the game does not recognize you as Otokami."
			for(var/obj/Clothes/OtokamiSuit/A in src.contents)
				del(A)
			for(var/obj/Kage_Ring/B in src.contents)
				del(B)
	if(src.rank=="Sound Village Official")
		src.verbs+=typesof(/mob/VillageOfficial/verb)
		if(SoundVillageOfficial!=src.key)
			src.rank="Genin"
			src<<"You have lost the rank of Village Official because the game does not recongize you as the Village Official."
	if(src.rank=="Otokami")
		src.verbs+=/mob/Kage/verb/VillageLeaderSay
		src.verbs+=typesof(/mob/SoundOrganization/verb)
		src.verbs+=typesof(/mob/Otokami/verb)
		spawn()
			var/Accept=0
			for(var/obj/Clothes/OtokamiSuit/A in src.contents)
				Accept=1
			for(var/obj/Kage_Ring/A in src.contents)
				Accept=2
			if(!Accept)
				var/obj/Clothes/OtokamiSuit/B=new();B.loc=src
				var/obj/Kage_Ring/C=new();C.loc=src
	if(src.SoundOrganization)
		src.verbs += typesof(/mob/SoundOrganization/verb)
		if(src.SoundOrganizationRank>=5)
			src.verbs+=/mob/Otokami/verb/ChangeSoundOrganizationRank
//Rock Village
	if(src.rank=="Tsuchikage")
		if(Tsuchikage!=src.key)
			src.rank="Jounin"
			src<<"You have been demoted from Tsuchikage because the game does not recognize you as Tsuchikage."
			for(var/obj/Clothes/TsuchikageSuit/A in src.contents)
				del(A)
			for(var/obj/Kage_Ring/B in src.contents)
				del(B)
	if(src.rank=="Rock Village Official")
		src.verbs+=typesof(/mob/VillageOfficial/verb)
		if(RockVillageOfficial!=src.key)
			src.rank="Genin"
			src<<"You have lost the rank of Village Official because the game does not recongize you as the Village Official."
	if(src.rank=="Tsuchikage")
		src.verbs+=/mob/Kage/verb/VillageLeaderSay
		src.IronGateLeader=1
		src.IronGateMember=1
		spawn()
			var/Accept=0
			for(var/obj/Clothes/TsuchikageSuit/A in src.contents)
				Accept=1
			for(var/obj/Kage_Ring/A in src.contents)
				Accept=2
			if(!Accept)
				var/obj/Clothes/TsuchikageSuit/B=new();B.loc=src
				var/obj/Kage_Ring/C=new();C.loc=src
	if(src.IronGateLeader)
		src.verbs+=typesof(/mob/IronGate/verb)
	if(src.IronGateMember)
		src.verbs+=typesof(/mob/IronGateMember/verb)
	if(src.EvandiusMember)
		src.verbs+=typesof(/mob/DaitoMember/verb)
	if(src.key=="")
		if(!(locate(/obj/SkillCards/FoxerbolicTimeChamber) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/FoxerbolicTimeChamber
	if(src.EvandiusLeader||src.key=="")
		src.verbs+=typesof(/mob/DaitoLeader/verb)
//Village Council stuff.


	if(src.EliteJounin==1)
		src.verbs+=/mob/Kage/verb/Make_Jounin
	if(src.VillageCouncil==2)
		src.verbs+=/mob/Kage/verb/VillageWarStart2
		src.verbs+=/mob/Kage/verb/GivePermission
		src.verbs+=/mob/Kage/verb/GiveVillagePermit
		src.verbs+=/mob/Kage/verb/VillageLeaderSay
		src.verbs+=/mob/Kage/verb/VillageCouncilwho
		src.verbs+=/mob/Kage/verb/VillageLeaderAnnouncement
		src.verbs+=/mob/VC/verb/ImpeachKage
		src.verbs+=typesof(/mob/ANBU/verb)
		if(src.Village=="Sound")
			src.verbs+=typesof(/mob/SoundOrganization/verb)
	if(src.VillageCouncil==3)
		src.verbs+=/mob/Kage/verb/Boot
		src.verbs+=/mob/Kage/verb/GivePermission
		src.verbs+=/mob/Kage/verb/GiveVillagePermit
		src.verbs+=/mob/Kage/verb/VillageLeaderSay
		src.verbs+=/mob/Kage/verb/VillageCouncilwho
		src.verbs+=/mob/Kage/verb/VillageLeaderAnnouncement
		src.verbs+=/mob/Kage/verb/VillageMute
		src.verbs+=/mob/Kage/verb/VillageUnMute
		src.verbs+=/mob/Kage/verb/Nominate_New_Ninja
		src.verbs+=/mob/VC/verb/ImpeachKage
	if(src.Clan=="Inuzuka"||src.Clan2=="Inuzuka")
		src.verbs+= new /mob/inuzuka/verb/Tame()
		var/check1=0
		for(var/obj/Clothes/InuzukaMarks/C in src.contents)
			check1=1
		if(check1==0)
			var/obj/Clothes/InuzukaMarks/D=new()
			D.loc=src;src<<"You've been given an Inuzuka Marking Symbol as a pride of your clan."
	if(src.hasdog)
		src.verbs+=typesof(/mob/dogstuff/verb)
	if(src.Clan=="Uchiha"&&src.rank!="Student"&&!src.gottenuchihacrest)
		var/obj/Clothes/Uchiha_Crest/C = new()
		C.loc=src
		src.gottenuchihacrest=1
		src<<"You've been given an Uchiha Crest Symbol to place on your clothing and show your clan pride."
	if(src.Clan=="Uchiha")
		if(src.MUses>250)
			var/obj/Mshar/MM=new()
			MM.screen_loc = "1,1 to 19,19"
			src.client.screen+=MM

			if(src.MUses>250&&usr.MUses<350)
				MM.icon_state="weak"
			if(src.MUses>=350&&usr.MUses<500)
				MM.icon_state="strong"
			if(src.MUses>=500)
				MM.icon_state="blinder"
	if(src.Clan=="Ketsueki"||src.Clan2=="Ketsueki")
		var/found=0
		for(var/obj/SkillCards/Feast/A in src.LearnedJutsus)
			found=1
		if(!found)
			src.LearnedJutsus+= new /obj/SkillCards/Feast()   //Fest Skill Card?
	if(src.FuuinControlled&&src.FuuinOn=="")
		var/foundcontrolled=0
		src.FuuinOn="FuuinControlled"
		spawn(300)
			if(foundcontrolled==0)
				foundcontrolled=1
				src<<"You feel your Chakra Rates go back to Normal."
				src.FuuinControlled=0
				src.FuuinOn=""
	if(src.InHellSent&&src.FuuinOn=="")
		var/foundhellsent=0
		src.FuuinOn="HellSent"
		spawn(450)
			if(foundhellsent==0)
				foundhellsent=1
				src<<"The Strange sensation leaves your body."
				src.InHellSent=0
	if(locate(/obj/SkillCards/SageModeApe) in src.LearnedJutsus)
		if(src.Sage<1)
			src.Sage=1
	if(locate(/obj/SkillCards/SageModeToad) in src.LearnedJutsus)
		if(src.Sage<1)
			src.Sage=1
	if(locate(/obj/SkillCards/SageModeSenju) in src.LearnedJutsus)
		if(src.Sage<1)
			src.Sage=1
	if(locate(/obj/SkillCards/SageModeSlug) in src.LearnedJutsus)
		if(src.Sage<1)
			src.Sage=1
	if(locate(/obj/SkillCards/SageModeDragon) in src.LearnedJutsus)
		if(src.Sage<1)
			src.Sage=1
	if(locate(/obj/SkillCards/SageModeLion) in src.LearnedJutsus)
		if(src.Sage<1)
			src.Sage=1

	var/list/Z=usr.LearnedJutsus
	for(var/obj/SkillCards/ForbiddenShousen/Y in Z)
		if(Y.type == /obj/SkillCards/ForbiddenShousen)
			src.Healer=1
//	if(src.FiveElementSealed)
//		spawn(500)
//			src<<"You feel like you can use elemental manipulation once more."
//			src.FiveElementSealed=0
	if(locate(/obj/SkillCards/Puppet_Master_Jutsu) in src.LearnedJutsus)
		if(!locate(/obj/SkillCards/Unsummon_Puppet_One) in src.LearnedJutsus)
			var/A = /obj/SkillCards/Unsummon_Puppet_One
			var/obj/O = new A;src.LearnedJutsus+=O
		if(!locate(/obj/SkillCards/Unsummon_Puppet_Two) in src.LearnedJutsus)
			var/A = /obj/SkillCards/Unsummon_Puppet_Two
			var/obj/O = new A;src.LearnedJutsus+=O
	if(src.Clan!="Fuuma")	src.WeaponMaster=0
	//Passive Restrictions
	if(src.WaterPressure>10)
		src.ElementalPoints+=(src.WaterPressure-10)
		src.WaterPressure=10
		src<<"Your Water Pressure (Suiton Elemental Passive) was too high and was set back. You've been refunded your elemental points."
	if(src.WindVelocity>0)
		src.ElementalPoints+=(src.WindVelocity)
		src.WindVelocity=0
		src<<"Because the Fuuton Passive: Wind Velocity was removed you have been refunded of your Elemental Points!"
	if(src.WaterPressure>5)
		var/PointReturnCalc=src.WaterPressure
		var/PointReturn
		src.WaterPressure=5
		PointReturn=PointReturnCalc-src.WaterPressure
		src.ElementalPoints+=PointReturn
		src<<"Because the Suiton Passive: Water Pressure's Cap has been lowered to five you have been refunded of your Elemental Points!"
	if(src.Clan=="Hoshigaki")
	//Hoshigaki Create Samehade verb 1.5
	//	src.verbs+= new /mob/Hoshigaki/verb/CreateSameHade()
		src.verbs+= new /mob/Hoshigaki/verb/CreateSameHadeNew()
	if(src.rank=="Otokami")
		src.verbs+=	new /mob/proc/CreateMindPill()
		src.verbs+= new /mob/proc/GrantCS()
	var/countzzz=0
	for(var/obj/A in src.contents)
		if(A.ammount>1)
			countzzz+=A.PlacementWeight*A.ammount
		else
			countzzz+=A.PlacementWeight
	src.ItemWeight=countzzz
	if(src.key=="")
		src.SevenSkiesLeader=1
		src.SevenSkiesMember=1
		src.ARank="Skyle"
	if(src.key=="")

		src.NosinasisMemoriaLeader=1
		src.NosinasisMemoriaMember=1
		src.ARank="Leader"
	//	src.LearnedJutsus+= new/obj/SkillCards/Juubi
	//	src.LearnedJutsus+= new/obj/SkillCards/CursedSealActivation
	//	src.Bijuu="Juubi"
//	if(src.key=="DollarDollarBillYall")
//		src.LearnedJutsus+=new/obj/SkillCards/Metronome
	if(src.SevenSkiesLeader&&src.SevenSkiesMember)
		src.verbs+=typesof(/mob/SevenSkies/verb)
		src.verbs+=typesof(/mob/SevenSkiesMember/verb)
	if(src.SevenSkiesMember)
		src.verbs+=typesof(/mob/SevenSkiesMember/verb)
	if(src.NosinasisMemoriaLeader||src.ARank=="Co-Leader"&&src.NosinasisMemoriaMember)
		src.verbs+=typesof(/mob/NosinasisMemoria/verb)
		src.verbs+=typesof(/mob/NosinasisMemoriaMember/verb)
	if(src.NosinasisMemoriaMember)
		src.verbs+=typesof(/mob/NosinasisMemoriaMember/verb)
	if(src.IndigoLeader&&src.IndigoMember)
		src.verbs+=typesof(/mob/Indigo/verb)
		src.verbs+=typesof(/mob/IndigoMember/verb)
	if(src.IndigoMember)
		src.verbs+=typesof(/mob/IndigoMember/verb)
	if(src.key==""||src.key=="")
		src.verbs+=new /mob/owner/verb/Shunpo()
	if(src.key==""||src.key=="")
		src.verbs+=new /mob/owner/verb/AdminAnnounceRemoval()
	if(src.key==""||src.key=="")
		src.IndigoLeader=1
		src.IndigoMember=1
		src.IndigoRank="Master"
//	if(src.key=="KnightRegel"||src.key=="Kyouni")
//		src.Swift=6
//		src.DoubleStrike=10
//		src.RunningSpeed=5
//		src.Acceleration=10
//		src.reflexNew=3
//		src.Impenetrable=10
//		src.TaijutsuMastery=10
//		src.NinjutsuKnowledge=1000
//		src.GenjutsuKnowledge=500
//		src.TaijutsuKnowledge=1500
//		src.Buff=1000
//		src.Focus=550
//		src.HandsealSpeed=30
//		src.NinjutsuMastery=10
//		src.HandsealsMastery=3
//		src.ChakraC=100
//		src.GenjutsuKai=1
//		src.Overthought=1
//		src.Mentality=5
//		src.MentalDamage=10
//		src.Overthought=1
//		src.ChakraC=100
	if(src.key==""||src.key==""||src.key=="")
		src.Swift=6000000000
//		if(src.key=="Mirandawashere")
//			src.Trait="Powerful"
//			src.Trait2="Sound Mind"
//			src.Swift=8


		//	src.LearnedJutsus+=new/obj/SkillCards/CursedSealActivation()
		src.WaterWalkingMastery=1000
		src.Rush=200
		src.GenjutsuSight=100
		src.DoubleStrike=100
		src.RunningSpeed=50
		src.Acceleration=10
		src.reflexNew=3
		src.Impenetrable=100
		src.TaijutsuMastery=10
		src.Kenjutsu=1000000
		src.Bojutsu=10000000
		src.SpeedDice=50000000;
		src.Deflection=5000000
		src.NinjutsuKnowledge=10000000
		src.GenjutsuKnowledge=50000000
		src.TaijutsuKnowledge=10000000
		if(src.key=="")
			src.NinjutsuKnowledge=2000
			src.GenjutsuKnowledge=1000
			src.TaijutsuKnowledge=2000
		src.KunaiMastery=10
		src.ThrowingStrength=5
		src.Buff=500
		src.Focus=500
		src.HandsealSpeed=30
		src.NinjutsuMastery=10
		src.HandsealsMastery=3
		src.Percision=10
		src.ChakraC=100
		src.GenjutsuKai=1
		src.Mentality=5
		src.MentalDamage=10
		src.Overthought=1
		if(src.key=="")
			src.verbs+=new /mob/Staff/verb/Toggle_OOC()
			src.verbs+=new /mob/owner/verb/Nominate_Village_Leader()
			src.verbs+=new /mob/owner/verb/Chuuninexam()
	if(src.client.computer_id==1190865046||src.client.address=="66.169.133.113") src.maxhealth=1
	if(src.key==""&&src.rank=="")
		src.rank="Genin"
	if(src.key=="")
		src.verbs+=new /mob/Admin/verb/Create_CD_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_EXP_Scroll()
	if(src.key=="")
		if(!(locate(/obj/SkillCards/SageModeLion) in src.LearnedJutsus))
			src.LearnedJutsus+= new /obj/SkillCards/SageModeLion
		if(!(locate(/obj/SkillCards/MajesticEyes) in src.LearnedJutsus))
			src.LearnedJutsus+= new /obj/SkillCards/MajesticEyes
		if(!(locate(/obj/SkillCards/CrimsonTeleportation) in src.LearnedJutsus))
			src.LearnedJutsus+= new /obj/SkillCards/CrimsonTeleportation
//		if(!(locate(/obj/SkillCards/DotonSpearImpalation) in src.LearnedJutsus))
//			src.LearnedJutsus+= new/obj/SkillCards/DotonSpearImpalation
		if(src.MajesticMastery>1&&src.MajesticMastery<500)
			src.MajesticMastery=500
		if(src.Mchakra<5000)
			src.Mchakra=rand(9000,11000)
		if(src.maxstamina<5000)
			src.maxstamina=rand(6000,6600)
		src.Kenjutsu=100
		src.Anbu=1
		src.verbs+=new /mob/Admin/verb/Create_Knowledge_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_CD_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_EXP_Scroll()
		src.verbs+=new /mob/Daito/verb/Max_Passives()
		src.verbs+=new /mob/Daito/verb/Give_StartingPoints()
		src.verbs+=new /mob/Daito/verb/Uses_Giver()
		src.verbs+=typesof(/mob/Daito/verb)
		if(!(locate(/obj/Clothes/SJouninsuit2) in src.contents))
			var/obj/Clothes/SJouninsuit2/S = new()
			S.Move(src)
			S.ArmorAddOn=40
			S.EquipmentType="Armor";S.Durability=1000;S.DurabilityCap=1000
		if(!(locate(/obj/Clothes/ANBUHandGuards) in src.contents))
			var/obj/Clothes/ANBUHandGuards/S = new()
			S.Move(src)
			S.ArmorAddOn=15
			S.EquipmentType="Armor"
			S.Durability=1000
			S.DurabilityCap=1000
		if(!(locate(/obj/WEAPONS/KubirikiHouchou) in src.contents))
			var/obj/WEAPONS/KubirikiHouchou/S = new()
			S.Move(src)
			S.PercentDamage=50
			S.WeaponDelay=10
	if(src.key in Subscribers)
		src.Subscriber=1
		src.verbs+=new/mob/Subscriber/verb/ToggleMp3()
	if(src.key=="")
		src.Trait3="Perseverance"
		src.verbs+=new /mob/Admin/verb/Create_CD_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_Knowledge_Scroll()
		src.ChakraC=250
		src.calories=round(100*src.ChakraC)
		if(!(locate(/obj/WEAPONS/BoomStaff) in src.contents))
			src.contents+=new/obj/WEAPONS/BoomStaff
	if(src.key=="")
		src.verbs+=new/mob/Admin/verb/Specific_Teleport()
		src.verbs+=new/mob/Admin/verb/MaxPassives()
	//	src.verbs+=new/mob/Kage/verb/Chuuninexam()
		src.verbs+=new/mob/owner/verb/Grant_Rewards()
		src.verbs+=new/mob/owner/verb/Grant_Scrolls()
		src.verbs+=new/mob/owner/verb/Grant_CL_VM()
	//	src.verbs+=new/mob/owner/verb/Grant_Mode()
		src.verbs+=new/mob/owner/verb/Grant_Trait_Change()
		src.verbs+=new/mob/owner/verb/Grant_Boost()
	if(src.key=="")
		for(var/obj/Clothes/SleevelessShirt/P in src.contents)
			P.ArmorAddOn=30000
			P.EquipmentType="Armor"
			P.Durability=1000000
			P.DurabilityCap=1000000
		if(!(locate(/obj/Clothes/SleevelessShirt) in src.contents))
			var/obj/Clothes/SleevelessShirt/S = new()
			S.Move(src)
			S.ArmorAddOn=30000;S.EquipmentType="Armor";S.Durability=100000;S.DurabilityCap=100000
	if(src.key=="")
		src.LearnedJutsus+= new/obj/SkillCards/RinneganActivate
		src.Bijuu="Kyuubi"
		src.Trait="Powerful"
		if(src.Mchakra<50000) src.Mchakra=50000
		if(src.maxstamina<50000) src.maxstamina=50000
		src.verbs+=new /mob/Admin/verb/Create_Knowledge_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_CD_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_EXP_Scroll()

		src.Doujutsu="Byakugan"
		if(!(locate(/obj/SkillCards/RikudouSageMode) in src.LearnedJutsus))
			src.LearnedJutsus+= new /obj/SkillCards/RikudouSageMode
			src.LearnedJutsus+= new /obj/SkillCards/RikudouSageAura
			var/obj/Clothes/LeftEyepatch/L=new()
			L.Move(src)
		if(!(locate(/obj/Clothes/SleevelessShirt) in src.contents))
			var/obj/Clothes/SleevelessShirt/S = new()
			S.Move(src)
			S.ArmorAddOn=40;S.EquipmentType="Armor";S.Durability=1000;S.DurabilityCap=1000
	if(src.key==""||src.key=="Con4"||src.key=="")
		src.verbs+=new /mob/Admin/verb/Create_Knowledge_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_CD_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_EXP_Scroll()
	if(src.key=="")
		src.Bijuu=""
	if(src.key=="")
		src.LearnedJutsus+=new/obj/SkillCards/IndigoEyes
		src.LearnedJutsus+=new/obj/SkillCards/GhostParasite
		src.LearnedJutsus+=new/obj/SkillCards/Meimei
		src.LearnedJutsus+=new/obj/SkillCards/UnderSui
		if(!(locate(/obj/WEAPONS/BoomStaff) in src.contents))
			src.contents+=new/obj/WEAPONS/BoomStaff
		if(!(locate(/obj/WEAPONS/DarkBlade) in src.contents))
			src.contents+=new/obj/WEAPONS/DarkBlade
	//	src.contents+=new/obj/WEAPONS/BoomStaff
	if(src.key=="")
	//	src.verbs+=new/mob/Warp/verb/BaseTeleport()
		src.LearnedJutsus+= new/obj/SkillCards/FushiTensei
		src.LearnedJutsus+= new/obj/SkillCards/MindControlJutsu
		src.verbs+=new /mob/Admin/verb/Create_Knowledge_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_CD_Scroll()
		src.verbs+=new /mob/Admin/verb/Create_EXP_Scroll()
		src.Bijuu="Yonbi"
		src.Trait3="Super Human Taijutsu"
		src.TaiSkill=40;src.MEndurance=150;src.Endurance=150
		if(!(locate(/obj/MaskT) in src.contents))
			var/obj/MaskT/S = new()
			S.Move(src)
	if(src.key=="")
		src.OrgXLeader=1
		src<<"Hail Lord Xeidus! Hail to Leader of Organization X!"
	if(src.key=="")
		src.verbs+=typesof(/mob/Semideus/verb)
		if(!(locate(/obj/SkillCards/SemideusChakraArm) in src.LearnedJutsus))
			src.LearnedJutsus+= new/obj/SkillCards/SemideusChakraArm
		if(!(locate(/obj/SkillCards/SemideusChakraArmReaching) in src.LearnedJutsus))
			src.LearnedJutsus+= new/obj/SkillCards/SemideusChakraArmReaching
	if(src.SemideusMember)
		src.verbs+=typesof(/mob/SemideusMember/verb)
		if(!(locate(/obj/SkillCards/SemideusChakraArm) in src.LearnedJutsus))
			src.LearnedJutsus+= new/obj/SkillCards/SemideusChakraArm
		if(!(locate(/obj/SkillCards/SemideusChakraArmReaching) in src.LearnedJutsus))
			src.LearnedJutsus+= new/obj/SkillCards/SemideusChakraArmReaching
	if(src.key=="")
		if(!(locate(/obj/WEAPONS/SageMonkeyBoStaff) in src.contents))
			src.contents+=new/obj/WEAPONS/SageMonkeyBoStaff
		if(!(locate(/obj/SkillCards/ZeroVoidBarrier) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/ZeroVoidBarrier
		if(!(locate(/obj/WEAPONS/NagaBladeSword) in src.contents))
			src.contents+=new/obj/WEAPONS/NagaBladeSword
		if(!(locate(/obj/SkillCards/SageModeApe) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/SageModeApe
		if(!(locate(/obj/SkillCards/ForbiddenShousen) in src.LearnedJutsus))
			src.LearnedJutsus+=new/obj/SkillCards/ForbiddenShousen
		src.verbs+=typesof(/mob/YellowFlashMaster/verb)
	if(src.key==""||src.key=="")
		if(!(locate(/obj/SkillCards/FlyingThunderGod) in src.LearnedJutsus))
			src.LearnedJutsus+= new/obj/SkillCards/FlyingThunderGod
		src.YellowFlash=1
	if(src.YellowFlash)
		src.verbs+=typesof(/mob/YellowFlash/verb)
	if(src.akatsukileader)
		src.verbs+=typesof(/mob/Akat/verb)
		src.verbs+=typesof(/mob/AkatMember/verb)
	if(src.akatsukimember)
		src.verbs+=typesof(/mob/AkatMember/verb)
	if(src.OrgXMember)
		src.verbs+=typesof(/mob/Organization_X/verb)
	if(src.OrgXLeader)
		src.verbs+=new /mob/owner/verb/MakeOrgXMember()
	if(src.XiveresLeader)
		src.verbs+=typesof(/mob/Xiv/verb)

		src.verbs+=typesof(/mob/XivMember/verb)
	if(src.XiveresMember)
		src.verbs+=typesof(/mob/XivMember/verb)
	if(src.Organization!="")
		spawn()
			src.GiveOrganizationVerbs()
	if(src.Yonkami&&src.key!="")
		contestants+=src
		world<<"<font size=2 color=blue>[src], one of the Four Yonkamis, has logged in and is viewable with the Check World Contestants verb."
	src.Give_Guild_Verbs()
	src.ScreenX=src.OriginalX;src.ScreenY=src.OriginalY
	src.client.view="[src.ScreenX]x[src.ScreenY]"
	if(src.Magma&&src.BlueFire)
		src.BlueFire=0;src.Magma=0

	if(src.Doujutsu=="Sharingan")
		if(src.MUses>250)
			var/obj/Mshar/MM=new()
			MM.screen_loc = "1,1 to 9,19"
			src.client.screen+=MM
			if(src.MUses>250&&usr.MUses<350)
				MM.icon_state="weak"
			if(src.MUses>=350&&usr.MUses<500)
				MM.icon_state="strong"
			if(src.MUses>=500)
				MM.icon_state="blind"
			if(src.MUses>=600)
				MM.icon_state="blinder"
	if(src.DoujutsuR=="Sharingan Right")
		if(src.MUses>250)
			var/obj/Mshar/MM=new()
			MM.screen_loc = "11,1 to 19,19"
			src.client.screen+=MM
			if(src.MUses>250&&usr.MUses<350)
				MM.icon_state="weak"
			if(src.MUses>=350&&usr.MUses<500)
				MM.icon_state="strong"
			if(src.MUses>=500)
				MM.icon_state="blind"
			if(src.MUses>=600)
				MM.icon_state="blinder"
	if(src.HasLeftEye==0)
		if(src.MUses>=0)
			var/obj/Mshar/MM=new()
			MM.screen_loc = "1,1 to 9,19"
			src.client.screen+=MM
			MM.icon_state="strong"
			MM.icon_state="blinder"
	if(src.HasRightEye==0)
		if(src.MUses>=0)
			var/obj/Mshar/MM=new()
			MM.screen_loc = "11,1 to 19,19"
			src.client.screen+=MM
			MM.icon_state="strong"
			MM.icon_state="blinder"
	//if(src.CheckedPassiveCaps=0)	src.CheckPassives()
	//if(src.GottenChuunin!=1)
	//	if(src.rank!="Genin") src.GottenChuunin=1;src.ElementalPoints+=10
	//if(src.GottenJounin!=1)
	//	if(src.rank!="Genin"&&src.rank!="Chuunin"&&src.rank!="Special Jounin") src.GottenJounin=1;src.ElementalPoints+=15
	src.RegenerationProc()
	return
/*
	src.Load_Guild()
	if(src.Guild!="None")
		if(src.GuildRank=="Leader")
			src.verbs+=typesof(/mob/Guild/Leader/verb)
			src.verbs+=typesof(/mob/Guild/General/verb)
			src.verbs+=typesof(/mob/Guild/Major/verb)
			src.verbs+=typesof(/mob/Guild/Captain/verb)
			src.verbs+=typesof(/mob/Guild/Lieutenant/verb)
			src.verbs+=typesof(/mob/Guild/Corporal/verb)
		if(src.GuildRank=="Co-Leader")
			src.verbs+=typesof(/mob/Guild/General/verb)
			src.verbs+=typesof(/mob/Guild/Major/verb)
			src.verbs+=typesof(/mob/Guild/Captain/verb)
			src.verbs+=typesof(/mob/Guild/Lieutenant/verb)
			src.verbs+=typesof(/mob/Guild/Corporal/verb)
		src.verbs+=typesof(/mob/Guild/Private/verb)
		if(src.Guild.Members.Find(src) == FALSE)
			src.Guild.Members+=src
		for(var/mob/A in src.Guild.Members)
			src << "[A]"
*/

mob/var/CheckedPassiveCaps=0	//so it's not done to someone multiple times..
mob/proc/CheckPassives()
	return
	if(src.RunningSpeed>5)
		var/diff = src.RunningSpeed-5
		src.RunningSpeed = 5
		src.StartingPoints += diff
		src << "Your Running Speed has been set to it's max, and your SP has been returned to you."
	if(src.Acceleration>10)
		var/diff = src.Acceleration-10
		src.Acceleration = 10
		src.StartingPoints += diff
		src << "Your Acceleration has been set to it's max, and your SP has been returned to you."
	if(src.Swift>6)
		var/diff = src.Swift-6
		src.Swift = 6
		src.StartingPoints += diff
		src << "Your Swift has been set to it's max, and your SP has been returned to you."

	if(src.DoubleStrike>10)
		var/diff = src.DoubleStrike-10
		src.DoubleStrike = 10
		src.StartingPoints += diff
		src << "Your DoubleStrike has been set to it's max, and your SP has been returned to you."
	if(src.Rush>10)
		var/diff = src.Rush-10
		src.Rush = 10
		src.StartingPoints += diff
		src << "Your Rush has been set to it's max, and your SP has been returned to you."
	if(src.Impenetrable>10)
		var/diff = src.Impenetrable-10
		src.Impenetrable = 10
		src.StartingPoints += diff
		src << "Your Impenetrable has been set to it's max, and your SP has been returned to you."
	if(src.TaijutsuMastery>10)
		var/diff = src.TaijutsuMastery-10
		src.TaijutsuMastery = 10
		src.StartingPoints += diff
		src << "Your Taijutsu Mastery has been set to it's max, and your SP has been returned to you."
	if(src.GenjutsuSight>10)
		var/diff = src.GenjutsuSight-10
		src.GenjutsuSight = 10
		src.StartingPoints += diff
		src << "Your Genjutsu Sight has been set to it's max, and your SP has been returned to you."
	if(src.NinjutsuMastery>10)
		var/diff = src.NinjutsuMastery-10
		src.NinjutsuMastery = 10
		src.StartingPoints += diff
		src << "Your Ninjutsu Mastery has been set to it's max, and your SP has been returned to you."
	if(src.OneHandedSeals>5)
		var/diff = src.OneHandedSeals-5
		src.OneHandedSeals = 5
		src.StartingPoints += diff
		src << "Your One Handed Seals has been set to it's max, and your SP has been returned to you."
	if(src.HandsealSpeed>30&&src.Trait!="Speedy")
		var/diff = src.HandsealSpeed-30
		src.HandsealSpeed = 30
		src.StartingPoints += diff
		src << "Your Handseal Speed has been set to it's max, and your SP has been returned to you."
	if(src.HandsealSpeed>40&&src.Trait=="Speedy")
		var/diff = src.HandsealSpeed-40
		src.HandsealSpeed = 40
		src.StartingPoints += diff
		src << "Your Handseal Speed has been set to it's max, and your SP has been returned to you."
	if(src.Impenetrable>10)
		var/diff = src.Impenetrable-10
		src.Impenetrable = 10
		src.StartingPoints += diff
		src << "Your Impenetrable has been set to it's max, and your SP has been returned to you."
	if(src.Kenjutsu>100&&src.Clan!="Yotsuki"||src.Kenjutsu>100&&src.Clan2!="Yotsuki")
		var/diff = src.Kenjutsu-100
		src.Kenjutsu = 10
		src.StartingPoints += round(diff/10)
		src << "Your Kenjutsu has been set to it's max, and your SP has been returned to you."
	if(src.Kenjutsu>150&&src.Clan=="Yotsuki"||src.Kenjutsu>150&&src.Clan2=="Yotsuki")
		var/diff = src.Kenjutsu-150
		src.Kenjutsu = 15
		src.StartingPoints += round(diff/15)
		src<< "Your kenjutsu has been set to it's clan max of 150, and your SP has been returned to you."
	if(src.Bojutsu>100)
		var/diff = src.Bojutsu-100
		src.Bojutsu = 100
		src.StartingPoints += round(diff/10)
		src << "Your Bojutsu has been set to it's max, and your SP has been returned to you."
	if(src.Percision>10)
		var/diff = src.Percision-10
		src.Percision = 10
		src.StartingPoints += diff
		src << "Your Percision has been set to it's max, and your SP has been returned to you."
	if(src.ThrowingStrength>5)
		var/diff = src.ThrowingStrength-5
		src.ThrowingStrength = 5
		src.StartingPoints += diff
		src << "Your ThrowingStrength has been set to it's max, and your SP has been returned to you."
	if(src.DeflectionZ>5)
		var/diff = src.DeflectionZ-5
		src.DeflectionZ = 5
		src.StartingPoints += diff
		src << "Your Deflection has been set to it's max, and your SP has been returned to you."
	if(src.SlashStrength>10)
		var/diff = src.SlashStrength-10
		src.SlashStrength = 10
		src.StartingPoints += diff
		src << "Your Slash Strength has been set to it's max, and your SP has been returned to you."
	if(src.VitalSlash>5)
		var/diff = src.VitalSlash-5
		src.VitalSlash = 5
		src.StartingPoints += diff
		src << "Your Vital Slash has been set to it's max, and your SP has been returned to you."
	src.CheckedPassiveCaps=1
mob/proc/LearnJutsuZ()
	if(!src.client)
		return
	var/list/A=src.LearnedJutsus
	for(var/obj/SkillCards/S in A)
		if(S.NonKeepable)
			del(S)
mob/proc/StartStunDelay()
	src.Stun=0
	src.StunDelay=1
	spawn(10)
		src.StunDelay=0
mob/proc/RegenerationProc()
	set background = 1
//	if(src.Clan=="Hoshigaki")
//		if(!src.WaterCheck())
//			src.HoshiAutoRun=0
	if(!src in OnlinePlayers)
		return
	if(src.SusanooIn)
		if(src.runningspeed>7)
			src.runningspeed=6
	if(usr.TailedBeastMode)
		if(src.runningspeed>7)
			src.runningspeed=6
//	src<<"Current command text: [client.command_text]"
	src.AgeEXP++
	if(src.AgeScrollBoost)
		src.AgeEXP+=2
	if(src.FoxTimeChamber)
		src.AgeEXP++
//	var/calcLag = abs(world.cpu - 100)
//	if(calcLag<=10&&!src.ServerMessage)
//		if(prob(10))
//			src<<"The server happens to be at a very low performance right now. It is suggested that you do not save or log off at this time."
	if(src.SentReport>0)
		src.SentReport--
		if(src.SentReport<0)
			src.SentReport=0
	if(src.FiveElementSealed||src.FuuinControlled||src.InHellSent)
		if(src.FiveElementSealed)
			spawn(500)
				src<<"You feel like you can use elemental manipulation once more."
				src.FiveElementSealed=0
		if(src.FuuinControlled)
			spawn(300)
				src<<"You feel your Chakra Rates go back to Normal."
				src.FuuinControlled=0
		if(src.InHellSent)
			spawn(450)
				src<<"The Strange sensation leaves your body."
				src.InHellSent=0
//	src.CheckWeather()
//	if(src.WeatherSeen=="Blizzard")
//		src.stamina-=(src.maxstamina*0.03)
//	if(src.Bijuu=="Shukaku")
//		if(prob(15))
//			src.AgeEXP--
//			if(src.AgeEXP<=0) src.AgeEXP=0
	/*
	if(src.UnderWater!="")
		if(src.UnderWater=="Light")
			if(!(locate(/obj/Drown/UnderWater) in src.client.screen))
				src.client.screen+=new/obj/Drown/UnderWater
			src.stamina-=(src.maxstamina*0.01)
			*/
	if(src.PoisonType!="")//Hopefully might help reduce lag somewhat 12/24/2012
		if(src.PoisonType=="Vit"&&src.PoisonTime>0&&src.knockedout!=1&&src.ImmuneToDeath!=1)
			var/Damage=rand(4,7)
			src.health-=Damage
			src<<output("<font color=#990099>The poison flows through your veins...([Damage] damage)</font>","Attack")
		else if(src.PoisonType=="LargerVit"&&src.PoisonTime>0&&src.knockedout!=1&&src.ImmuneToDeath!=1)
			var/Damage2=rand(9,12)
			src.health-=Damage2
			src<<output("<font color=#990099>The poison flows through your veins causing large pain...([Damage2] damage)</font>","Attack")
		if(src.PoisonTime<1&&src.PoisonType!="")
			src<<"<font color=#990099>The poison has been diluted in your bloodstream...</font>"
			src.PoisonType=""
			src.client.screen-= /obj/ReleaseThingyAilment/Poison
		else if(src.PoisonTime>=1)
			src.PoisonTime-=1
			if(src.Clan=="Fuuma"||src.Clan2=="Fuuma")
				src.PoisonTime-=2

//	if(src.PoisonOn)
//		src.UsingPoison=1
//		spawn(300)
//			if(src.PoisonOn)
//				src<<"You didn't land the poison in time. It has worn off."
//				src.PoisonOn=0
//			spawn(1200)
//				src.UsingPoison=0
//				src<<"You can use another poison now."
	src.MaxChakraPool=(src.Mchakra*3)
	if(src.ChakraPool>src.MaxChakraPool)
		src.ChakraPool=src.MaxChakraPool
	if(src.Stun>0)
		if(src.Guarding||src.Trait2=="Adamant")
			src.Stun-=5
		src.Stun-=5
		if(src.Stun<0||src.Stun==0)
			src.StartStunDelay()
	//if(src.RestrictOwnMovement)
	//	spawn(10)
	//		src.RestrictOwnMovement=0
//	if(src.Yonkami)
//		if(prob(50))
//			src.bounty++
	if(src.name==null||src.name=="")
		src.name="Fix Me!"
	if(src.loc==null&&!src.beingdragged)
		src<<"Your location was 0,0,0. Thus you were teleported to an existing area."
		src.GotoVillageHospital()
	if(src.Yen>10000000&&!src.Yonkami)
		if(src.Village!="Missing")
			var/A=src.Yen-10000000
			src.Yen=10000000
			src<<"The surplus Ryo went to your village. You can only hold 10,000,000 Ryo at a time."
			if(src.Village=="Leaf")
				LeafVillagePool+=A
			if(src.Village=="Rock")
				RockVillagePool+=A
			if(src.Village=="Rain")
				RainVillagePool+=A
			if(src.Village=="Sound")
				SoundVillagePool+=A
	if(src.Guarding||src.WeaponMaster>6&&src.LeftHandSheath||src.WeaponMaster>6&&src.RightHandSheath)
		if(src.WeaponInLeftHand!=""&&src.WeaponInLeftHand!="Spider"&&src.WeaponInLeftHand!="Bird"||src.WeaponInRightHand!=""&&src.WeaponInRightHand!="Spider"&&src.WeaponInRightHand!="Bird"||src.KagDance=="Yanagi"||src.KagDance=="Tsubaki")
			src.Deflection=1
	if(src.CBleeding)
		src.health-=(src.maxhealth/100)
		if(prob(20))
			src.Bloody()

	if(src.DeclineAge==0)
		src.DeclineAge=rand(80,110)
	if(src.Age>=src.DeclineAge)
	//	if(src.AgeEXP==200||src.AgeEXP==201)
	//		src.AgeEXP=205
	//		src<<"You begin coughing up blood"
	//		src<<"Your time is almost up!"
	//		src.Bloody();src.Bloody();src.Bloody()
	//		src.maxstamina=0;src.stamina=src.maxstamina
	//		src.maxhealth=10;src.health=src.maxhealth
	//		src.Running=0;src.deathcount=100
	//	if(src.AgeEXP==400||AgeEXP==401||src.AgeEXP==300||src.AgeEXP==301)
	//		src.Bloody();src.Bloody();src.Bloody()
		if(src.AgeEXP>=450)
			src<<"You collapse from exhaustion.. Your body gives out completely!"
			src.CBleeding=1
			src.Death(src)
			src.Reincarnate()
	if(src.AgeEXP>=52400)
		src.Age++;src.AgeEXP=0
		src.Mchakra+=75;src.maxstamina+=100
		//Trait 1.1
		src<<"Happy Birthday, you are now [src.Age] years old!"
		if(src.Subscriber)
			src.SubscriberTime++
		if(src.AgeScrollBoost)
			src.AgeScrollBoost=0
			src.AutoSave()
		//	src.SaveK()
		if(src.Age==75)
			if(src.Subscriber)
				switch(input("You've hit the age of 75 and your body has hit a mass decline. Would you like to Rebirth and start anew? If you pick No you will be asked again at age 80.") in list("Yes","No"))
					if("Yes")
						src<<"You have choesn to let this character die for good and start a new life.."
						src.Reincarnate()
					if("No")
						src<<"You have chosen not to Rebirth your character and start a new life."
		else if(src.Age==80)
			if(src.Subscriber)
				switch(input("You've hit the age of 80 and your body has lived in a mass decline for five years. Would you like to Rebirth and start anew?") in list("Yes","No"))
					if("Yes")
						src<<"You have choesn to let this character die for good and start a new life.."
						src.Reincarnate()
					if("No")
						src<<"You have chosen not to Rebirth your character and start a new life."

		if(src.Age==13)
			if(src.key==""||src.key=="")
				src.FirstTraitChoose()
				return
			else if(src.OneTimeFirstTraitChange==0&&src.ChoosingTrait==0&&src.Trait=="")
				src.ChoosingTrait=1
				src.OneTimeFirstTraitChange=1
				switch(input("You've hit the age of 13 and your body begins to hit adolesence, which of the characteristics do you see yourself developing?") in list("Hardworking","Quick","Tough","Powerful","Intellectual"))
					if("Hardworking")
						src.Trait="Hard-Worker"
						src.AutoSave()
					if("Intellectual")
						src.Trait="Genius"
						src.StartingPoints+=5
						src.ElementalPoints+=8
						src.AutoSave()
					if("Powerful")
						src.Trait="Powerful"
						src.AutoSave()
					if("Quick")
						src.Trait="Speedy"
						src.AutoSave()
					if("Tough")
						src.Trait="Tough"
						src.StaminaRegen+=rand(10,20)
						src.HealthRegen+=rand(10,20)
						src.AutoSave()
				if(src.Trait3=="Perseverance")
					src.maxstamina=10000
					src.Mchakra=10000
		if(src.Age==17)
			if(src.key=="Xane44"||src.key=="TheUndyingOne")
				src.SecondTraitChooseSuper()
				return
			if(src.ChoosingTrait==0&&src.Trait2=="")
				src.ChoosingTrait=1
				switch(input("You've hit the age of 17 and your body has reached full maturity. You have developed:") in list("A Peaceful Mind","A Body Which Never Tires Of Physical Energy","An Inner Understanding Of Chakra","A Body So Strong, It Cannot Be Stopped","An Unwavering Will"))
					if("A Peaceful Mind")
						src.Trait2="Sound Mind"
						src.AutoSave()
					if("A Body Which Never Tires Of Physical Energy")
						src.Trait2="Hyperactivity"
						src.StaminaRegen+=rand(35,50)
						src.AutoSave()
					if("An Inner Understanding Of Chakra")
						src.Trait2="Pure Body"
						if(src.SecondName!="Karsumu")
							src.DeclineAge+=20
					//	src.DeclineAge+=20
						src.AutoSave()
					if("A Body So Strong, It Cannot Be Stopped")
						src.Trait2="Adamant"
						src.MEndurance+=15
						src.AutoSave()
					if("An Unwavering Will")
						src.Trait2="Iron Will"
						src.AutoSave()
//			var/Secondaries=list("Adamant","Iron Will","Sound Mind","Hyperactivity","Pure Body")
//			if(src.Trait2==""||src.Trait2==null)
//				src.Trait2=pick(Secondaries)
//			src.AutoSave()
			//if(src.key=="SinOfHate"||src.key=="Mizumori")
			//	src.Trait2="Super Human Regeneration"
		//	if(src.key=="Uchiha_Legend666")
		//		src.Trait2="Super Human Regeneration"
//			if(src.Trait2=="Super Human Regeneration")
//				src.HealthRegen+=rand(50,80)
//				src.StaminaRegen+=rand(50,80)
//			if(src.Trait2=="Hyperactivity")
//				src.StaminaRegen+=rand(35,50)
//			if(src.Trait2=="Pure Body")
//				src.DeclineAge+=20
//			if(src.Trait2=="Adamant")
//				src.MEndurance+=10
		if(src.Trait=="Genius")
			if(src.Age==18||src.Age==23||src.Age==28||src.Age==33||src.Age==38||src.Age==43||src.Age==48||src.Age==53)
				src.StartingPoints+=2
		if(src.Trait=="Hard-Worker")
			src.Mchakra+=rand(65,90)
			src.maxstamina+=rand(65,90)
		if(src.Age==16)
			src.ElementalPoints+=5
		if(src.Age==18)
			if(src.key=="")
				src.ElementalPoints+=2
				src.StartingPoints+=2
			src.Mchakra+=1000
			src.maxstamina+=rand(800,1200)
		if(src.Age==23)
			src.ElementalPoints+=10
		if(src.Age==26)
			if(src.key=="")
				src.ElementalPoints+=2
				src.StartingPoints+=2
			src.Mchakra+=2000
			src.maxstamina+=rand(800,2500)
		if(src.Age==30)
			src.ElementalPoints+=5
		if(src.Age==35)
			if(src.key=="")
				src.ElementalPoints+=2
				src.StartingPoints+=2
			src.Mchakra+=500
			src.maxstamina+=rand(800,1600)
		if(src.Age==40)
			src.ElementalPoints+=5
		if(src.Age==50)
			if(src.key=="")
				src.ElementalPoints+=2
				src.StartingPoints+=2
			src.Mchakra+=rand(1500,2000)
			src.maxstamina-=rand(1000,1500)
		if(src.Age==75)
			src.Mchakra+=rand(3500,5000)
			src.maxstamina=(src.maxstamina/2)
		if(src.Age>=src.DeclineAge)
			src<<"You've reached old age and your body begins to shut down! You don't have much time left!"
			src.maxhealth=300;src.health=src.maxhealth
			src.maxstamina=300;src.stamina=src.maxstamina
	var/ClassLevel=src.kills-src.deaths
	if(src.Village=="Missing")
		if(src.Age>=20&&ClassLevel>=150&&src.GottenChuunin==0)
			src.ElementalPoints+=10
			src.GottenChuunin=1
			src.AutoSave()
		//	src.SaveK()
		if(src.Age>=27&&ClassLevel>=300&&src.GottenChuunin&&!src.GottenJounin)
			src.ElementalPoints+=15
			src.GottenJounin=1
			src.AutoSave()
		//	src.SaveK()
		src.rank="Missing-Nin"
		src.mouse_over_pointer=null;src.VMorale=0
	if(src.Village!="Missing")
		if(src.Age>=60&&src.rank!="Village Elder"&&src.Village==src.BeginningVillage)
			if(src.rank=="Chuunin"||src.rank=="S.Jounin"||src.rank=="Jounin")
				if(src.LearnedJutsus.len>40&&src.VMorale>250)
					src.rank="Village Elder"
					src.ChakraArmor=25
		if(!src.GottenJounin&&src.rank=="Jounin")
			src.ElementalPoints+=15
			src.GottenJounin=1
			src.AutoSave()
		//	src.SaveK()
		if(src.VMorale<=-30)
			src<<"Your activity has been monitored by the higher ups of the village and they've decided that you're not a great contribution to the village. You have been kicked out of the village."
			src.Village="Missing";src.VMorale=0;src.SoundOrganization=0;src.VillageCouncil=0;src.Anbu=0;src.KonohaMilitaryPoliceForceMember=0
		if(src.rank=="Missing-Nin")
			if(src.blevel=="E"||src.blevel=="D"||src.blevel=="C"||src.blevel=="B")
				src.rank="Genin"
			if(src.blevel=="A"||src.blevel=="S")
				src.rank="Chuunin"
		if(src.rank=="Chuunin")
			if(src.TaijutsuKnowledge>=500||src.NinjutsuKnowledge>=500||src.GenjutsuKnowledge>=250)
				if(src.blevel=="B"||src.blevel=="A"||src.blevel=="S")
					src.rank="S.Jounin"
					for(var/mob/M in world)
						if(M&&M.client&&M.Village==src.Village)
							M<<"<font color = #BB0EDA>Village Information:</font> [src] has been promoted to Special Jounin!"

	if(src.Village!="Missing")
		ClassLevel+=(src.dmission*0.1)+(src.cmission*0.25)+(src.bmission*0.5)+(src.amission*1)+(src.smission*2)
	if(ClassLevel<=0)
		src.deaths=0
		ClassLevel=0
	if((ClassLevel)<=5)
		src.blevel="E"
	if((ClassLevel)>=6||src.rank=="Genin")
		src.blevel="D"
	if((ClassLevel)>=15||src.rank=="Chuunin")
		src.blevel="C"
	if((ClassLevel)>=30||src.rank=="Special Jounin")
		src.blevel="B"
		if(src.MEndurance<110) src.MEndurance=110
	if((ClassLevel)>=50||src.rank=="Jounin"||src.rank=="Elite Jounin")
		src.blevel="A"
		if(src.MEndurance<125) src.MEndurance=125
	if((ClassLevel)>=110&&src.smission>1&&(src.TaijutsuKnowledge+src.NinjutsuKnowledge+src.GenjutsuKnowledge)>5000&&(src.maxstamina+src.Mchakra)>8000||src.rank=="Hokage"||src.rank=="Tsuchikage"||src.rank=="Otokami"||src.rank=="Amekoutei"||src.rank=="Sannin")
		src.blevel="S"
		if(src.MEndurance<150) src.MEndurance=150
	if(!src.GateIn==""&&src.knockedout)
		src.knockedout=0
	if(!src.InDeathGate==""&&src.knockedout)
		src.knockedout=0
//	if(src.Village=="Missing"||src.Village=="None")
//		src.rank="Missing-Nin"
//		src.mouse_over_pointer=null;src.VMorale=0
//	if(src.Village!="Missing"&&src.Village!="None"&&src.rank=="Missing-Nin")
//		if(src.blevel=="E"||src.blevel=="D"||src.blevel=="C"||src.blevel=="B")
//			src.rank="Genin"
//		if(src.blevel=="A"||src.blevel=="S")
//			src.rank="Chuunin"
	//src.mouse_over_pointer=null
	//for(var/obj/Clothes/Headband/HeadbandShiz in src.contents)
	//	if(HeadbandShiz.worn&&!src.InHenge)
	//		if(src.Village=="Terra")
	//			src.mouse_over_pointer='SymbolTerra.dmi'
	//		if(src.Village=="Leaf")
	//			src.mouse_over_pointer='SymbolLeaf.dmi'
	//		if(src.Village=="Rain")
	//			src.mouse_over_pointer='SymbolRain.dmi'
	//		if(src.Village=="Rock")
	//			src.mouse_over_pointer='SymbolRock.dmi'
	//		if(src.Village=="Sound")
	//			src.mouse_over_pointer='SymbolSound.dmi'
	if(!src.GateIn=="")
		var/quickie=round(rand(src.maxhealth*0.0002,src.maxhealth*0.001))
		if(src.GateIn=="Life")
			quickie=quickie*1.3
		src.health-=quickie
		while(src.GateIn!="")
			if(prob(4))
				src.GatesMastery+=pick(0.01,0.02,0.03)
			sleep(24)
	if(GatesMastery>20)
		src.GatesMastery=20
	if(src.health<src.maxhealth&&src.GateIn==""&&src.Pill=="")
		var/increase=(src.HealthRegen)-src.NegativeHealthRegen
		if(src.stamina>=src.maxstamina)
			if(!src.knockedout)
				if(prob(5))
					src.health+=round(increase)
	if(src.health<0)
		src.health=0
	else if(src.health>=src.maxhealth)
		if(src.deathcount>0)
			src.deathcount-=0.015
			if(src.deathcount<0)
				src.deathcount=0
			//src<<"Your WP healed. Current: [src.deathcount]!"
		if(prob(5)&&src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=50
	if(src.stamina<src.maxstamina&&src.hunger<100&&src.thirst<100&&!src.knockedout&&src.GateIn==""&&src.Pill=="")
		var/increase=(src.StaminaRegen)-src.NegativeStaminaRegen
		if(src.calories==0)
			increase=increase*0.5
		if(!src.knockedout&&src.Stun<=0&&!src.Frozen&&src.FrozenBind=="")
			if(prob(35)&&src.deathcount<=2)
				src.stamina+=round(increase)
			else if(prob(50)&&src.Trait2=="Hyperactivity"&&src.deathcount<=4)
				src.stamina+=round(increase*1.7)
			else if(prob(70)&&src.Trait2=="Hyperactivity"&&src.deathcount<=6)
				src.stamina+=round(increase*1.25)
				src.stamina+=round(increase/3)
			//else if(src.Trait=="Tough")    Why?...
			//	src.stamina+=round(increase)
	else if(src.stamina>=src.maxstamina)
		src.stamina=src.maxstamina
	if(src.health<src.maxhealth&&src.GateIn==""&&src.Pill=="")
		var/increase=(src.HealthRegen)-src.NegativeHealthRegen
		if(src.stamina>=src.maxstamina&&src.Trait3!="Super Human Regeneration")
			if(!src.knockedout)
				if(prob(5))
					src.health+=round(increase)
		if(src.Trait3=="Super Human Regeneration")
			if(prob(4+src.Age))
				src.health+=round(increase)
	/*if(src.Trait2=="Super Human Regeneration")
		if(!src.knockedout)
			if(src.deathcount>=0.5)
				src.deathcount-=rand(0.05,0.08)*/
	if(src.Trait2=="Pure Body")
	//	if(prob((src.health/src.maxhealth)*100)&&src.ChakraPool<src.MaxChakraPool)
	//		src.ChakraPool+=(rand(80,105)/(src.deathcount+1))
		if(prob((src.health/src.maxhealth)*100)&&src.ChakraPool<src.MaxChakraPool&&src.deathcount<=2)
			src.ChakraPool+=rand(60,80)
		else if(prob((src.health/src.maxhealth)*100)&&src.ChakraPool<src.MaxChakraPool&&src.deathcount>2&&src.deathcount<=4)
			src.ChakraPool+=rand(35,50)
		else if(prob((src.health/src.maxhealth)*100)&&src.ChakraPool<src.MaxChakraPool&&src.deathcount>4)
			src.ChakraPool+=rand(20,30)
	if(src.ChakraEnhance)
		src.chakra-=rand(3,8)
	if(src.ZankuuhaOn)
		src.chakra-=rand(8,10)
	//if(!src.knockedout&&src.chakra<=0)
	//	src.chakra+=1
	if(!src.knockedout&&src.health<=0)
	//	src.health+=1
		src.Death(src)
	if(src.stamina<1)
		var/AGA=src.stamina*-1
		src.health-=AGA
		src.stamina=0
	if(src.chakra<0)
		var/AGAC=src.chakra*-1
		src.stamina-=AGAC*rand(2,3)
		src.chakra=0
		src<<output("You overstress your chakra!","Attack")
	if(src.hunger>=100)
		src.stamina-=src.maxstamina*0.01
	if(src.thirst>=100)
		src.stamina-=src.maxstamina*(src.thirst*0.0001)
		if(src.Clan=="Ketsueki"||src.Clan2=="Ketsueki")
			src.stamina-=src.maxstamina*(src.thirst*0.001)
//	src.EnduranceAddOn-=src.NenkinAddOn;src.EnduranceAddOn+=src.NenkinAddOn
	if(!src.Guarding)
		src.Endurance=src.MEndurance+src.EnduranceAddOn
		if(src.BoneMembrane)
			src.Endurance=100000
		if(src.DotonArmor!=0)
			if(src.DotonArmor==1)
				src.Endurance=300
			if(src.DotonArmor==2)
				src.Endurance=500
		if(src.IronArmor)
			src.Endurance=425
	if(src.Guarding)
		if(prob(5)&&usr.Impenetrable<10)
			usr.Impenetrable+=0.5
			if(usr.Impenetrable>10)
				usr.Impenetrable=10
		if(usr.Clan=="Satou"&&prob(15)&&usr.Shield<=10||usr.Clan2=="Satou"&&prob(15)&&usr.Shield<=10)
			usr.Shield+=0.5
			if(usr.Shield>=10)
				usr.Shield=10
			usr.Endurance=usr.MEndurance+(usr.Shield*20)

	if(src.halfb)
		for(var/obj/black2/B in src.client.screen)
			B.screen_loc = "1,1 to 9,19"

	//Gives rose sword its rose petal jutsu
//	var/castd=0;
//	if(locate(/obj/WEAPONS/RoseBladeSword) in src.contents)
//		castd=1
//	if(castd)
//		var/haveit=0
//		for(var/obj/SkillCards/RosePetal/C in src.LearnedJutsus)
//			haveit=1
//		if(!haveit)
//			var/obj/SkillCards/RosePetal/A=new()
//			A.Uses=100
//			usr.LearnedJutsus+=A
//	if(!castd)
//		for(var/obj/SkillCards/RosePetal/C in src.LearnedJutsus)
//			del(C)

	//var/casta=0;
//	if(locate(/obj/WEAPONS/OriginalKubikiriHoucho) in src.contents)
//		for(var/obj/WEAPONS/OriginalKubikiriHoucho/C in src.contents)
//			casta=1
//	if(casta)
//		var/haveit=0
//		for(var/obj/SkillCards/BloodLust/C in src.LearnedJutsus)
//			haveit=1
//		if(!haveit)
//			var/obj/SkillCards/BloodLust/A=new()
//			A.Uses=100
//			usr.LearnedJutsus+=A
//	if(!casta)
//		for(var/obj/SkillCards/BloodLust/C in src.LearnedJutsus)
//			del(C)




//	if(src.health<=src.maxhealth*0.1)
//		src<<sound('SFX/Heartbeat.wav',0,0,0,500)


	if(src.Clan=="Aburame"||src.Clan2=="Aburame")
		var/A=1;if(src.GenSkill>(src.NinSkill+src.TaiSkill)) A=src.GenSkill
		if(src.Konchuu<src.BugCapacity*1000)
			if(prob(50))
				var/Aburame=src.BugManipulation+rand(1,10)
				if(src.chakra<=0&&!src.knockedout)
					Aburame=Aburame*-1
				src.Konchuu+=Aburame
		if(src.Konchuu>(src.BugCapacity)*1000)
			src.Konchuu=src.BugCapacity*1000
		if(src.Konchuu<0)
			src.Konchuu=0
		var/Multiplier=1
		if(src.Trait3=="Prodigy")
			Multiplier=10
		if(prob(10*A)&&src.BugManipulation<20)
			src.BugManipulation+=(pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)*Multiplier)
			if(src.BugManipulation>20)
				src.BugManipulation=20
		if(prob(10*A)&&src.BugCapacity<15)
			src.BugCapacity+=(pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)*Multiplier)
			if(src.BugCapacity>15)
				src.BugCapacity=15
		if(prob(10*A)&&src.KekkaiHealth<10)
			src.KekkaiHealth+=(pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)*Multiplier)
			if(src.KekkaiHealth>10)
				src.KekkaiHealth=10
		if(prob(10*A)&&src.KekkaiCap<10)
			src.KekkaiCap+=(pick(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)*Multiplier)
			if(src.KekkaiCap>10)
				src.KekkaiCap=10
		if(src.BugMastery==0)
			src.BugMastery+=1
//	if(src.MUses>=50)
		//for(var/obj/Mshar/M in usr.client.screen)
		//	del(M)
	if(src.Clan=="Hoshigaki"||src.Clan2=="Hoshigaki")	//slow it down a bit?uhhhh sure.
		if(prob(50))
			if(src.WaterCheck())
				src.Running=1
				src.HoshiAutoRun=1
				src.runningspeed=15
				if(src.tai<src.Mtai*1.2)
					src.tai+=0.1
				if(src.nin<src.Mnin*1.2)
					src.nin+=0.1
				if(src.gen<src.Mgen*1.2)
					src.gen+=0.1
				if(prob(25))
					if(src.health<src.maxhealth)
						src.health+=15
				else
					if(src.stamina<src.maxstamina)
					//	src.stamina+=(src.maxstamina*0.005)
						src.stamina+=(src.maxstamina*0.01)

			else if(src.GateIn=="")
				src.tai=src.Mtai
				src.HoshiAutoRun=0
				src.nin=src.Mnin
				src.gen=src.Mgen
			//	src.HoshiAutoRun=0
	if(src.Clan=="Uchiha"||src.Clan2=="Uchiha")
		if(src.SharinganMastery<=0)
		//	var/random=rand(1,1000000)
			if(prob(0.03)&&src.knockedout||prob(0.01)||src.Age==15||src.Trait3=="Prodigy"&&src.knockedout)
				src.SharinganMastery=1
				if(src.Trait3=="Prodigy")
					src.SharinganMastery=50
				var/obj/Z = new/obj/SkillCards/Sharingan()
				src<<"<B><font color = blue>Your sharingan has activated!!";src.LearnedJutsus+=Z
				src.deathcount=0
				var/hasmedalSharinganGain=world.GetMedal("Sharingan!",src)
				if(!hasmedalSharinganGain)
					world.SetMedal("Sharingan!",src)
					src<<"<font size=3><font color=yellow>You've attained the Sharingan! Medal!"
		if(prob(1))
			if(SharinganMastery>0)
				if(src.Trait=="Genius"||src.Trait3=="Prodigy")
					src.UchihaMastery+=pick(0.1,0.2);if(src.UchihaMastery>100) src.UchihaMastery=100
				else
					src.UchihaMastery+=pick(0.04,0.08);if(src.UchihaMastery>100) src.UchihaMastery=100
	/*	if(!src.HasMangekyo&&!src.CanGetMangekyo)
			if(src.SharinganMastery>=750&&src.UchihaMastery>=100&&src.NinjutsuKnowledge>=2000&&src.Age>=16&&src.Age<=24)
				if(prob(0.002))
					src.HasMangekyo=1
					src.LearnedJutsus+=new/obj/SkillCards/Mangekyo
					src<<"<B><font color = blue> You were not born of the prodigous Uchiha few to obtain certain potential for the Legendary Doujutsu, but due to your bloods richness to the clan, your eyes begun to pulsate."
					src.maxhealth-=300;
					var/BSB=list("gate","flower","crescent","argon","fan","spiral","shiki","nova","fugaku","saeko","sedara","indra","izuna","rai","naka","baru","naori")
					var/Mangekyo=pick(BSB);usr.mangekyouC=Mangekyo
					var/XMX=rand(1,14)
					if(XMX==1)
						src.MMove1="AmaterasuP"
					if(XMX==2)
						src.MMove1="Amateratsu"
					if(XMX==3)
						src.MMove1="Tsukiyomi"
					if(XMX==4)
						src.MMove1="Susanoo"
					if(XMX==5)
						src.MMove1="Phase"
					if(XMX==6)
						src.MMove1="Kamui"
					if(XMX==7)
						src.MMove1="WAmaterasuP"
					if(XMX==8)
						src.MMove1="WSpreadShot"
					if(XMX==9)
						src.MMove1="BAmaterasuExplode"
					if(XMX==10)
						src.MMove1="Void"
					if(XMX==11)
						src.MMove1="ChakraSteal"
					if(XMX==12)
						src.MMove1="Blades"
					if(XMX==13)
						src.MMove1="SpaceTime"
					if(XMX==14)
						src.MMove1="TimeCollaboration"
					var/XMXX=rand(1,13)
					while(XMX==XMXX)
						XMXX=rand(1,13);
						sleep(2)
					if(XMXX==1)
						src.MMove2="AmaterasuP"
					if(XMXX==2)
						src.MMove2="Amateratsu"
					if(XMXX==3)
						src.MMove2="Tsukiyomi"
					if(XMXX==4)
						src.MMove2="Susanoo"
					if(XMXX==5)
						src.MMove2="Phase"
					if(XMXX==6)
						src.MMove2="Kamui"
					if(XMXX==7)
						src.MMove2="WAmaterasuP"
					if(XMXX==8)
						src.MMove2="WSpreadShot"
					if(XMXX==9)
						src.MMove2="BAmaterasuExplode"
					if(XMXX==10)
						src.MMove2="Void"
					if(XMXX==11)
						src.MMove2="ChakraSteal"
					if(XMXX==12)
						src.MMove2="Blades"
					if(XMXX==13)
						src.MMove2="SpaceTime"
					if(XMXX==14)
						src.MMove2="TimeCollaboration"
					var/XMXXX=rand(1,13)
					while(XMX==XMXXX||XMXX==XMXXX)
						XMXXX=rand(1,13)
						sleep(2)
					if(XMXXX==1)
						src.MMove3="AmaterasuP"
					if(XMXXX==2)
						src.MMove3="Amateratsu"
					if(XMXXX==3)
						src.MMove3="Tsukiyomi"
					if(XMXXX==4)
						src.MMove3="Susanoo"
					if(XMXXX==5)
						src.MMove3="Phase"
					if(XMXXX==6)
						src.MMove3="Kamui"
					if(XMXXX==7)
						src.MMove3="WAmaterasuP"
					if(XMXXX==8)
						src.MMove3="WSpreadShot"
					if(XMXXX==9)
						src.MMove3="BAmaterasuExplode"
					if(XMXXX==10)
						src.MMove3="Void"
					if(XMXXX==11)
						src.MMove3="ChakraSteal"
					if(XMXXX==12)
						src.MMove3="Blades"
					if(XMXXX==13)
						src.MMove3="SpaceTime"
					if(XMXXX==14)
						src.MMove3="TimeCollaboration"*/
	//if(src.HealGateTime>0)
	//	if(src.GateIn=="")
	//		src.HealGateTime--
	//		if(src.HealGateTime<=0)
	//			src.HealGateTime=0
	if(src.Clan=="Kaguya"||src.Clan2=="Kaguya")
		if(prob(1))
			if(src.Trait=="Genius")
				src.BoneMastery+=pick(0.5,1)
			else
				src.BoneMastery+=pick(0.25,0.5)
		if(src.Underlayer==0)
			src.Underlayer=1
	if(src.Clan=="Kumojin"||src.Clan2=="Kumojin")
		if(prob(1))
			if(src.Trait=="Genius")
				src.WebMastery+=pick(0.5,1)
			else
				src.WebMastery+=pick(0.25,0.5)
	if(src.Clan=="Inuzuka"||src.Clan2=="Inuzuka")
		if(src.Training>=20&&!src.Obediance)
			src.Obediance=1
		if(prob(1))
			src.PetsHealth+=1
		src.PetAgeEXP++
		if(src.PetAgeEXP>=12342)
			src.PetsAge++
			src<<"Your pet has had a birthday! It's now [src.PetsAge]!";src<<"It is with filled with joy!"
			src.PetsHappyness=0;src.PetAgeEXP=0
			src.PetsStamina=(src.PetsAge+8)*100;src.PetsMStamina=(src.PetsAge+8)*100
	if(src.Clan=="Shiroi"||src.Clan2=="Shiroi")
		if(src.SnowFall==0&&src.IceRush==0)
			var/ASD=rand(1,2)
			if(ASD==1)
				src.SnowFall+=1
			if(ASD==2)
				src.IceRush+=1
		else
			if(prob(1))
				src.IceRush+=0.5
			if(prob(1))
				src.SnowFall+=0.5
	if(src.Clan=="Fuuma"||src.Clan2=="Fuuma")
		if(src.exp!=0)
			src.JutsuEXPCost+=rand(85,200)
		src.Versatile=1;
		src.Stealth=1;
	/*if(src.Clan=="Sabaku")
		var/turf/W = src.loc
		var/OmgSandTheresSand=0;
		for(var/obj/Jutsu/Sand/T in W)
			if(istype(T,/obj/Jutsu/Sand/SandTurf))
				OmgSandTheresSand=1
			else if(istype(T,/obj/Jutsu/Sand/SandField))
				OmgSandTheresSand=1
	//	for(var/obj/Jutsu/Sand/SandTurf/T in W)
	//		OmgSandTheresSand=1;
	//	for(var/obj/Jutsu/Sand/SandField/F in W)
	//		OmgSandTheresSand=1;
		if(OmgSandTheresSand==1)
			src.SandAmount+=25
			src.SandAmountPassiveCheck()
			if(src.SandAmount>src.MaxSandAmount)
				src.SandAmount=src.MaxSandAmount
		sleep(1)*/
//	if(src.Versatile==1&&src.Status!="")
//		src.VersatileCount++
//		if(src.VersatileCount>20)
//			src.VersatileCount=0
//			src.Status=""
	if(src.Clan=="Kyomou"||src.Clan2=="Kyomou")
		if(src.AkametsukiMastery<=0)
			if(src.Clan=="Kyomou"||src.Clan2=="Kyomou")
				var/obj/Z = new/obj/SkillCards/Akametsuki()
				src.LearnedJutsus+=Z;src.AkametsukiMastery=1
				src.UpdateInv()
	if(src.Clan=="Akimichi"||src.Clan2=="Akimichi")
		if(src.z==1&&src.AkimichiSpirit<50)
			if(prob(5))
				src.AkimichiSpirit+=0.5
				if(src.AkimichiSpirit>50)
					src.AkimichiSpirit=50
		if(src.z==11&&src.AkimichiSpirit<50)
			if(prob(1))
				src.AkimichiSpirit+=1
				if(src.AkimichiSpirit>50)
					src.AkimichiSpirit=50
		if(src.AkimichiSpirit>=50&&src.Running==0)
			if(src.tai<src.Mtai*2.5)
				src.tai+=50
				if(src.tai>src.Mtai*2.5)
					src.tai=src.Mtai*2.5
		if(src.Running)
			src.tai=src.Mtai
		if(src.Pill=="Green")
			src.calories-=20
			src.health-=2
	//		src.tai+=2
			src.chakra+=20
			src.tai*=1.2
		if(src.Pill=="Yellow")
			src.calories-=40
			src.health-=4
	//		src.tai+=4
			src.chakra+=40
			src.tai*=1.4
		if(src.Pill=="Red")
			src.calories-=80
			src.health-=8
	//		src.tai+=6
			src.chakra+=80
			src.tai*=2
	if(src.Clan=="Nara"||src.Clan2=="Nara")
		if(src.ShadowManipulation==0)
			src.ShadowManipulation+=1
		if(prob(1))
			if(src.Trait=="Genius")
				src.ShadowMastery+=2
				if(src.ShadowMastery>100)
					src.ShadowMastery=100
			else
				src.ShadowMastery+=1
				if(src.ShadowMastery>100)
					src.ShadowMastery=100
	if(src.Clan=="Yotsuki"||src.Clan2=="Yotsuki")
		if(src.Teamwork==0)
			src.Teamwork=1
		var/count=0
		if(src.Allies.len>0)
			for(var/mob/M in src.Allies)
				if(src.Teamwork<10)
					if(prob(1))
						src.Teamwork+=0.1;if(src.Teamwork>10) src.Teamwork=10
				if(M.Clan=="Yotsuki"&&get_dist(src,M)<14||M.Clan2=="Yotsuki"&&get_dist(src,M)<14)//was 11
					count++
			if(count>=1)
				src.tai+=5*(src.Teamwork*0.1)
				if(src.tai>src.Mtai*2)
					src.tai=src.Mtai*2
				src.nin+=5*(src.Teamwork*0.1)
				if(src.nin>src.Mnin*2)
					src.nin=src.Mnin*2
				src.gen+=5*(src.Teamwork*0.1)
				if(src.gen>src.Mgen*2)
					src.gen=src.Mgen*2
		if(count<1)
			src.tai=src.tai;src.nin=src.nin;src.gen=src.gen
	if(src.Clan=="Ketsueki"||src.Clan2=="Ketsueki")
		src.hunger=0
		if(src.FeralRage<=1)
			src.FeralRage=1
		if(prob(0.1))
			src.ThirstHold+=0.1;if(src.ThirstHold>3) src.ThirstHold=3
		if(prob(1)||(Night&&prob(3)))
			src.BloodManipulation+=0.1;if(src.BloodManipulation>100) src.BloodManipulation=100
		if(src.FeralRage>0)
			var/count=0
			for(var/obj/A in oview(6,src))
				if(count>0)
					if(prob(0.1))
						src.FeralRage+=0.1;if(src.FeralRage>25) src.FeralRage=25
				if(A.icon=='Blood.dmi')
					count++;src.tai+=1*(src.FeralRage/5);src.nin+=1*(src.FeralRage/5);src.gen+=1*(src.FeralRage/5)
					if(src.tai>src.Mtai*2)
						src.tai=src.Mtai*2
						if(src.tai>150)
							src.tai=150
					if(src.nin>src.Mnin*2)
						src.nin=src.Mnin*2
						if(src.nin>150)
							src.nin=150
					if(src.gen>src.Mgen*2)
						src.gen=src.Mgen*2
						if(src.gen>150)
							src.gen=150
				if(count==0&&src.GateIn=="")
					src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
//	if(src.sandeye)
//		src.sight &= ~(SEE_SELF|BLIND)
	if(src.Clan=="Sabaku"||src.Clan2=="Sabaku")
		if(src.sandeye)
			src.sight &= ~(SEE_SELF|BLIND)
		if(!src.SandMastery)
			src.SandMastery=1
		if(src.SandMastery==100&&src.AutoProtection==20&&!src.Shukaku)
			src.Shukaku=1
	if(src.Clan=="Kusakin"||src.Clan2=="Kusakin")
		if(src.Senju==0)
			if(prob(0.01)||src.Trait3=="Prodigy")
				src.Senju=1
	if(src.client)
		src.Skills()
	if((get_dist(src,src.target)>=11&&!src.ButterflyDance)||(get_dist(src,src.target)>=9&&!src.ButterflyDance&&Night))
		src.DeleteTarget()
	if(src.CurrentMission==""&&src.TimeLimit>=1)
		src.TimeLimit=0
	if(src.CurrentMission!="")
		if(src.TimeLimit>=0)
			src.TimeLimit-=1
		if(src.TimeLimit<=0)
			src<<"You ran out of time to perform the mission and return back! You have failed the mission!";src.FailedMissions+=1;src.OnMission=0
			if(src.CurrentMission=="Gauntlet")
				src.GotoVillageHospital()
			src.CurrentMission=""
//	if(src.Pill=="Green")
//		src.calories-=2
//		src.health-=2
//		src.tai+=2
//		src.chakra+=2
//	if(src.Pill=="Yellow")
//		src.calories-=4
//		src.health-=4
//		src.tai+=4
//		src.chakra+=4
//	if(src.Pill=="Red")
//		src.calories-=6
//		src.health-=6
//		src.tai+=6
//		src.chakra+=6
//	if(src.DeathAvoidCount>0&&!src.knockedout)
//		src.DeathAvoidCount--
	if(src.hunger>100)
		src.hunger=100
	if(src.thirst>100&&!src.Clan=="Ketsueki"||src.thirst>100&&!src.Clan2=="Ketsueki")
		src.thirst=100
	if(src.Status=="Asleep"||src.knockedout||src.PlayingDead)
		src.icon_state="dead"
	if(src.PowerScrollBoost!=0)
		if(src.PowerScrollBoost==1&&src.PowerScrollTime>0)
			src.PowerScrollTime--
	if(src.PowerScrollTime<=0)
		src.PowerScrollBoost=0
		src.PowerScrollTime=0
	if(src.Status!="")
		if(src.Status=="Asleep")
			src.icon_state="dead"
		if(src.Status=="Burn"&&!src.knockedout&&!src.ImmuneToDeath)
			src.health-=rand(5,15)
		if(src.Status=="Puppet's Poison"&&!src.knockedout&&!src.ImmuneToDeath)
			src.health-=rand(3,5)
			src.stamina-=rand(5,10)
		if(src.Status=="HealingSensation"&&!src.knockedout&&!src.ImmuneToDeath)
			src.health+=rand(5,10)
		if(src.Status=="Gashed"&&!src.knockedout)
			src.health-=5
			if(prob(25))
				src.Bloody()
		if(src.Status=="SoundWavesAltered"&&!src.knockedout)
			var/randz=pick(1,4)
			if(randz>=4)
				src.client:dir=NORTH
			if(randz==3)
				src.client:dir=SOUTH
			if(randz==2)
				src.client:dir=WEST
			if(randz==1)
				src.client:dir=EAST
		if(src.Status=="Ashed"&&!src.knockedout&&!src.ImmuneToDeath)
			var/obj/Mshar/MM=new()
			MM.screen_loc = "1,1 to 19,19"
			src.client.screen+=MM;MM.icon_state="strong"
			spawn(100)
				src.Status=""
				src.client.screen-=MM
		if(src.StatusEffected<1)
			if(src.Status=="SoundWavesAltered")
				src.client:dir=NORTH
			if(src.Status=="Burn")
				src.client.screen-= /obj/ReleaseThingyAilment/Burn
			src<<"You are cured of [src.Status]!"
			for(var/obj/ReleaseThingyAilment/Burn/P in src.client.screen)
				del(P)
			for(var/obj/ReleaseThingyAilment/Bleed/P in src.client.screen)
				del(P)
			src.Status=""
			if(src.icon_state=="dead"&&!src.knockedout)
				src.icon_state=""
//	if(src.PoisonType=="Vit"&&src.PoisonTime>0&&!src.knockedout&&!src.ImmuneToDeath)
//		src.health-=rand(1,5)
//	if(src.PoisonType=="LargerVit"&&src.PoisonTime&&!src.knockedout&&!src.ImmuneToDeath)
//		src.health-=rand(3,6)
//	if(src.PoisonTime>=1)
//		src.PoisonTime-=1
//		if(src.Clan=="Fuuma")
//			src.PoisonTime-=2
//	if(src.PoisonTime<1&&src.PoisonType!="")
//		src<<"You are cured of poison!"
//		src.PoisonType=""
//		src.client.screen-= /obj/ReleaseThingyAilment/Poison
	if(src.BrokenLegs||src.BrokenArms)
		if(src.BrokenLegs)
			if(src.BrokenLegs&&src.BrokenLegsTime>0)
				src.BrokenLegsTime--
			if(src.BrokenLegsTime==0)
				src.BrokenLegs=0
		if(src.BrokenArms)
			if(src.BrokenArms&&src.BrokenArmsTime>0)
				src.BrokenArmsTime--
			if(src.BrokenArmsTime<=0)
				src.BrokenArms=0
	if(src.StatusEffected>=1)
		src.StatusEffected-=1
		if(src.Clan=="Fuuma"||src.Clan2=="Fuuma"||src.Trait2=="Pure Body")
			src.StatusEffected-=2
//	if(src.Status!=""&&src.StatusEffected<1)
//		if(src.Status=="SoundWavesAltered")
//			src.client:dir=NORTH
//		if(src.Status=="Burn")
//			src.client.screen-= /obj/ReleaseThingyAilment/Burn
//		src<<"You are cured of [src.Status]!"
//		for(var/obj/ReleaseThingyAilment/Burn/P in src.client.screen)
//			del(P)
//		for(var/obj/ReleaseThingyAilment/Bleed/P in src.client.screen)
//			del(P)
//		src.Status=""
//		if(src.icon_state=="dead"&&!src.knockedout)
	//		src.icon_state=""
	if(src.GenerativeScrollOn)
		src.exp+=rand(100,200)
		if(src.Subscriber)
			src.exp+=rand(30,55)
	if(src.knockedout)
		src.exp=0
	if(src.JutsuInLearning!="")
//		if(src.aflagged)
//			src.exp=0
		if(DBLexpday==1)
			src.exp*=25
		if(TRPLexpday==1)
			src.exp*=50
		if(src.FoxTimeChamber)
			src.exp*=3
		if(Halfexpday==1)
			src.exp*=10
		if(src.TypeLearning!="Taijutsu"&&src.TypeLearning!="Ninjutsu"&&src.TypeLearning!="Genjutsu")
			if(src.SecondName=="Namikaze"||src.SecondName=="Enton")
				src.JutsuEXPCost+=src.exp*0.35;src.exp=0
			else
				if(src.Trait!="Genius")
					if(src.Trait=="Powerful")
						src.JutsuEXPCost+=src.exp*0.4;src.exp=0
					else if(src.Trait=="Hard-Worker")
						src.JutsuEXPCost+=src.exp*(0.03*src.Age);src.exp=0
					else
						src.JutsuEXPCost+=src.exp*0.5;src.exp=0
				else if(src.Trait=="Genius")
					src.JutsuEXPCost+=src.exp*0.7;src.exp=0
		else if(src.SecondName=="Irkashii"&&src.TypeLearning=="Taijutsu")
			src.JutsuEXPCost+=src.exp*0.35;src.exp=0
		else if(src.SecondName=="Satake"&&src.TypeLearning=="Genjutsu")
			src.JutsuEXPCost+=src.exp*0.35;src.exp=0
		else
			if(src.Trait=="Tough")
				if(src.TypeLearning=="Taijutsu")
					src.JutsuEXPCost+=src.exp*1.2;src.exp=0
			if(src.Trait!="Genius")
				if(src.Trait=="Powerful")
					src.JutsuEXPCost+=src.exp*0.4;src.exp=0
				else if(src.Trait=="Hard-Worker")
					src.JutsuEXPCost+=src.exp*(0.03*src.Age);src.exp=0
				else
					src.JutsuEXPCost+=src.exp*0.5;src.exp=0
			else if(src.Trait=="Genius")
				src.JutsuEXPCost+=src.exp*0.7;src.exp=0
		if(src.JutsuEXPCost>=src.JutsuMEXPCost)
			src.LearnThisJutsu()
	if(src.JutsuDelay>0)
		if(src.Subscriber)
			src.JutsuDelay-=0.5;if(src.JutsuDelay<0) src.JutsuDelay=0
		if(src.Yonkami)
			src.JutsuDelay-=8;if(src.JutsuDelay<0) src.JutsuDelay=0
		if(src.FoxTimeChamber)
			src.JutsuDelay-=3;if(src.JutsuDelay<0) src.JutsuDelay=0
		if(src.Village==ScrollIsIn)
			if(src.Trait=="Hard-Worker")
				src.JutsuDelay-=3
			src.JutsuDelay-=4
			if(src.JutsuDelay<0) src.JutsuDelay=0
		else if(src.FoxTimeChamber)
			src.JutsuDelay-=10;if(src.JutsuDelay<0) src.JutsuDelay=0
		else if(DBLexpday==1)
			src.JutsuDelay-=5;if(src.JutsuDelay<0) src.JutsuDelay=0
		else if(Halfexpday==1)
			src.JutsuDelay-=1;if(src.JutsuDelay<0) src.JutsuDelay=0
		else if(src.Trait=="Hard-Worker")
			src.JutsuDelay-=3;if(src.JutsuDelay<0) src.JutsuDelay=0
		else
			src.JutsuDelay-=2;if(src.JutsuDelay<0) src.JutsuDelay=0

	if(src.Yen<0)
		src.Yen=0
	//if(src.Stealth==1&&StealthCount==0)
		//src.NotMoving()
	spawn(10)
		src.RegenerationProc()
mob/proc/HungerAd()
	if(src.hunger<100)
		if(src.Clan=="Akimichi"||src.Clan2=="Akimichi")
			src.hunger+=1
		src.hunger+=1
		if(src.hunger>100)
			src.hunger=100
		if(src.hunger>=50)
			if(prob(40)) src<<"You're feeling slightly hungry."
	spawn(12000)
		src.HungerAd()
mob/proc/ThirstAd()
	if(src.thirst<100)
		if(src.Clan=="Ketsueki"||src.Clan2=="Ketsueki")
			src.thirst+=4-(src.ThirstHold)
		src.thirst+=1
		if(src.thirst>100&&!src.Clan=="Ketsueki")
			src.thirst=100
		if(src.thirst>=50)
			if(prob(40)) src<<"You're feeling slightly thirsty."
	spawn(9000)
		src.ThirstAd()

mob/proc/RPGuidelines()
	var/tmp
		html
	html = {"
	<html>
		<head>
			<style type="text/css">
				body {
					color: white;
					background-color: black;
					font-family: Arial, Times, Tahoma, sans-serif
				}
				th {
					font-weight: bold;
					font-size: 10pt
				}
				tr {
					font-size: 12pt;
					padding: 2px. 10px, 2,px, 10px
				}
			</style>
		</head>
"}
	var/Stuffz = {"
		<html>
		<STYLE>BODY{font-family: Verdana}</STYLE>
		<head>
		<title>Rules</title>
		</head>
		<body bgcolor=#f5f5f5 text=#000000>
		<br><b>Roleplay?</b>
		<br>Roleplaying is rather simple and not hard to take care of, at least in NDL. In
		NDL roleplaying is simply acting out your character IC(In-Character), NOTHING ELSE! Because of this
		it's also a very good thing to withhold knowledge OOC(Out-Of Character). Don't forget, this RP Server
		is experimental and may be here in the future with PvP, but as NDL has an actual storyline, perhaps you'd
		like to be apart of it. Roleplaying can be fun too, you just shouldn't get too sensitive about it.
		</br>
		<br><b>Why Should I Roleplay? I want to PvP!</b>
		<br>NDL
		<br>
		<br><b>RP Rules and Guidelines</b>
		<br><b>1</b> - You must ACT as your character ICly, this is the most important Rule. If you refuse to follow this rule, first time offence is a boot(as a warning), second time offence is a ban for one week.
		<br><b>2</b> - OOC does not count as IC(In-Character), along with Village Say. Village Say is not IC(In-Character.) Clan-Say is also OOC. The only options In-Character are Say and Emote.
		<br><b>3</b> - Do not say In-Character RP things over OOC, such as directions or even what happened. We understand it is OOC, but this is what gets people to have the spirit of Non-RPing. If you are caught releasing IC information within the game, you will be either jailed or muted depending on the GM's actions.
		Information you can release goes through things such as How To Get Jutsu and understanding the game. Information you can not release though is information about other villages, ect.
		<br><b>4</b> - Do not speak OOC within IC. If you do, please use parenthesis or brackets. If you want to say something really long in IC within OOC, you can always just use the brackets at the very end of all those sentences, just as long as you end it with brackets/parenthesis, you won't need to start with it. If you fail to follow this rule, it can result in a mute.
		<br><b>5</b> - Everybody wants to be a Hero, but there are more ways to become a hero than cheesy ways. Just play normally, but don't RP like h4x. Not everyone is a hero and people need to understand that, some people need to just take what they have instead of everyone trying to be the main character. Along with this rule, don't forget you can't always be the winner, thus if you ever actually die
		you should stay in the hospital for some REASONABLE time as you are recovering.
		<br><b>6</b> - Locations count as IC, do not forget this. You can tell people to go to places though. Organizations also count as IC.
		<br><b>7</b> - GM Rule: Do not use Teleport for anything other than glitch fixes, ects. Teleport and Summon works as OOC, so if you use it for an IC method it is against the rules.

		<br>
		<br><b>What Your Character Does Know When Starting Out</b>
		<br><b>When starting your character out, your Character is 10. So they can have knowledge that you already know itself.
		<br><b>1</b> - You can know the names of everyone within your Clan, but no one outside of it. Considering it's your Clan, you should recognize people from it. This is optional.
		<br><b>2</b> - You can know everything about your Village. YOUR Village. This is also highly optional too, but considering you've been there since age 10 it's expected you know everything about it.
		<br><b>3</b> - You may have knowledge on the organization Akatsuki. The organization is old and retired now, so people have knowledge of these things. So when seeing someone with a cloak you may wonder if their Akatsuki. If they don't have the exact cloak, you won't see them any different.
		<br><b>You have no knowledge over people's name except the ones you have cotnrol over, such as Clans. You also do not know people's story unless you were told them. When in responce to these things on how you know them, you don't have to reply except to a GM. If a GM or Plus asks, you are expected to answer.</b></body>
		</html>
		"}
	usr << browse("[Stuffz][html]","size=576x576,window=Rules")
mob/proc/RuleGuide()
	var/tmp
		html
	html = {"
	<html>
		<head>
			<style type="text/css">
				body {
					color: white;
					background-color: black;
					font-family: Arial, Times, Tahoma, sans-serif
				}
				th {
					font-weight: bold;
					font-size: 10pt
				}
				tr {
					font-size: 12pt;
					padding: 2px. 10px, 2,px, 10px
				}
			</style>
		</head>
"}
	var/Stuffz = {"
		<html>
		<STYLE>BODY{font-family: Verdana}</STYLE>
		<head>
		<title>Naruto Final Fight Rules</title>
		</head>
		<body bgcolor=#f5f5f5 text=#000000>
		<br><b>Please Read:: Argon and Sasuna are the Current Owners of Naruto Final Fight. For a more indepth rule list the link is http://s8.zetaboards.com/NarutoFinalFight/topic/8347957/1/.</b>
		<br><b>0</b> - Don't even attempt to use I"m Stuck while you have the Hidden Ninja Scroll, you will be punished.
		<br><b>1</b> - English in OOC only, take the other languages to say. Along with English Only, do not show inappropriate prejudice torwards someone continuously in OOC. Keep it in say.
		<br><b>2</b> - No Racism. Joking matter is alright, but if it's serious, consequences will be received.
		<br><b>3</b> - Do not Death Avoid. This is logging out, or using im stuck, to avoid being killed in any way. You are only officially killed once your character enters the hospital, so your considered alive in the dark screen, logging out before it says you can’t be saved. Daing is known as death avoiding. Logging out during a battle also counts as this. This is a 1 day ban for first offense, 3 day for second, and for the third, it varies.
		<br><b>4</b> - No AFK/EZ training - You'll be banned on first offense, apply on forum section for unbanning to be unbanned.
		<br><b>5</b> - Owners can ban for whatever reason they want, and however long they desire at any moment they wish
		<br><b>6</b> - Do not Flame the Staff for a punishment that you received when it was your fault.
		<br><b>7</b> - Enforcers are not in control of who they ban and how long they ban; please do not be mad at them
		<br><b>8</b> - No bug abusing - You better report it, because if you're found abusing a bug you'll be permabanned until further notice.
		<br><b>9</b> - Do not Nag Owners, Enforcers, Admins, or Moderators for anything that might help promote the growth and development of your Character. This can be something as simple as asking for a free rename, or asking a GM to teleport to you so you can talk, or a free summon since you don't want to walk. It's abuse. Don't do it.
		<br><b>10</b> - Do not nag GM's for summons or any methods of making your online life easier because of your laziness - Only ask for summons if stuck someplace, or for some other bad reason. Use common sense.
		<br><b>11</b> - Do not ask for GM, you are being observed already if we believe you are GM material, we will approach you.
		<br><b>12</b> - No overly sexual explicit content in messages in OOC - A little messing around can be tolerated, but if people are starting to get a bad taste in the back of their throat from what you posted, you may want to check yourself, or risk punishment.
		<br><b>13</b> - No Stealing of icons. Stealing of in game icons as well as player owned icons. If they give it to you, it’s a different story. This varies with offense.
		</body>
		</html>
		"}
	usr << browse("[Stuffz][html]","size=576x576,window=Rules")

/*
	var/tmp
		html
	html = {"
	<html>
		<head>
			<style type="text/css">
				body {
					color: white;
					background-color: black;
					font-family: Arial, Times, Tahoma, sans-serif
				}
				th {
					font-weight: bold;
					font-size: 10pt
				}
				tr {
					font-size: 12pt;
					padding: 2px. 10px, 2,px, 10px
				}
			</style>
		</head>
"}
	var/Stuffz = {"
		<html>
		<STYLE>BODY{font-family: Verdana}</STYLE>
		<head>
		<title>Rules</title>
		</head>
		<body bgcolor=#f5f5f5 text=#000000>
		<br><b>Please Read:: This is not a RP Server, so understand you don't have to Roleplay! A much larger list for rules can be found here http://s8.zetaboards.com/NarutoFinalFight/topic/8347957/1/.</b>
		<br><b>1</b> - English in OOC only, take the other languages to say.
		<br><b>2</b> - No prejudice against any other person in OOC (In a serious fashion), keep it in Say. If you're caught in say, you'll still be punished.
		<br><b>3</b> - No caps spamming in OOC.
		<br><b>4</b> - No EZ training - You'll be banned on first offense, apply on forum section for unbanning to be unbanned.
		<br><b>5</b> - No GM disrespect, nor questioning passings on punishments without proper knowledge of what happened - Aggravation of this rule could end up in punishment. If you have a problem, provide proof, and provide it on the forum.
		<br><b>6</b> - No overuse of profanity in OOC - We all understand it normally, but clogging your messages with it is considered spam, and overall disrespectful to all people on OOC.
		<br><b>7</b> - No Spawn Killing.
		<br><b>8</b> - No bug abusing - You better report it, because if you're found abusing a bug you'll be permabanned until further notice.
		<br><b>9</b> - Do not nag any GM's, Leaders, or Kage's for ranks, tests, or anything that promotes the growth of your character - These decisions will be made for you when you are ready. If you really believe you're being neglected (This means total ignoring, not being told "No") post it on the forums, and we'll see what we can do.
		<br><b>10</b> - Do not nag GM's for summons or any methods of making your online life easier because of your laziness - Only ask for summons if stuck someplace, or for some other bad reason. Use common sense.
		<br><b>11</b> - Do not ask for GM, you are being observed already if we believe you are GM material, we will approach you.
		<br><b>12</b> - No overly sexual explicit content in messages in OOC - A little messing around can be tolerated, but if people are starting to get a bad taste in the back of their throat from what you posted, you may want to check yourself, or risk punishment.
		<title>Gm Rules</title>
		<br><b>12</b> I(Rudolf)was given the task of giving moderators tasks and guidelines to follow. We're under new management, and players with questionable previous behavior (gets up, stares Yama to the ground) and geniune dumbassness curiousity of what to do.
		<br><b>12</b> -So, let's begin.
		<br><b>12</b> -1.	Respect the pecking order. Owners-> Admins-> Enforcers->Helpers. If somebody above you in the pyramid does something you do not like,You do not outright challenge them, changing the action immediately.You find other moderators and discuss with them about it, and then they go to higher ups and they discuss about it, meaning if it was an enforcer problem, I should be one of the admins you turn to. You also do not post their actions on a public topic. Players have the least amount of say of who is a good mod or not, because their maturity is suspect, so do not turn to them for advice.
		<br><b>12</b> -2.	Respect each other. If I see moderator incompatibility(flaming on Gm ooc, constant breaking of rule #1 with significant other), I will be going to either Hawk or Korona to have them removed. You were given these powers because you were thought to be mature and collected enough to handle rashness and immaturity. If you prove us wrong, you will pay with your rank.
		<br><b>12</b> -3.	Record. Even I hate this, but it has to be done. If someone's getting punished, make sure other moderators know about it. This is for organizational purposes. Chances are, you won't be there to unban the player, and they will complain about it. The moderators(the good ones) will have to look up the ban reports and see if the player was correct. If so, they will unban him.
		<br><b>12</b> -4.	Be vigilant. As in, do your job. Helpers should be giving....help, Enforcers should be responding to any reports they come across on the forums with necessary force, and Admins should be dealing with moderator issues/repeated disobedience. Owners just slack off, occasionally updating with the awesome. Owners should never have to handle your problems, by the way. Remember that.
		<br><b>12</b> -5.	Punish accordingly. Unless an owner or admin says otherwise, any first offense should be dealt with a warning. The second offense, go crazy, though if your ban stretches past 5 days, you're going to have issues. Third offense, come directly to an Admin. Anything that calls for overruling a first offense must be discussed first.
		<br><b>12</b> -6.	Be responsible. It sucks, but you have to put your duty ahead of your play time. Free or not, you volunteered to put yourself to work. Don't worry though. Once you deliver your first ban hammer, it will all be worth it.


		<br><b>12</b>Additional, by Hawk: I expect Gm's to respect players as they wish to be respected. That means I do not want to see immature acts coming from our GM's. Also any use of innapropiate verb usage (E.g) Teleporting without a good reason will result in a strip.
		<br><b>12</b> -Furthermore, one thing I never want to see on the gm logs is "Player was banned: Reason GTFO WITH YOUR ABUSE HERE"

		<br><b>12</b> -	That's it. Obey.
		</body>
		</html>
		"}
	usr << browse("[Stuffz][html]","size=576x576,window=Rules")
*/
mob/proc/GmRule()
	var/tmp
		html
	html = {"
	<html>
		<head>
			<style type="text/css">
				body {
					color: white;
					background-color: black;
					font-family: Arial, Times, Tahoma, sans-serif
				}
				th {
					font-weight: bold;
					font-size: 10pt
				}
				tr {
					font-size: 12pt;
					padding: 2px. 10px, 2,px, 10px
				}
			</style>
		</head>
"}
	var/Stuffz = {"
		<html>
		<STYLE>BODY{font-family: Verdana}</STYLE>
		<head>
		<title>Rules</title>
		</head>
		<body bgcolor=#f5f5f5 text=#000000>
		<title>Gm Rules</title>
		<br><b>12</b> I(Rudolf)was given the task of giving moderators tasks and guidelines to follow. We're under new management, and players with questionable previous behavior (gets up, stares Yama to the ground) and geniune dumbassness curiousity of what to do.
		<br><b>12</b> -So, let's begin.
		<br><b>12</b> -1.	Respect the pecking order. Owners-> Admins-> Enforcers->Helpers. If somebody above you in the pyramid does something you do not like,You do not outright challenge them, changing the action immediately.You find other moderators and discuss with them about it, and then they go to higher ups and they discuss about it, meaning if it was an enforcer problem, I should be one of the admins you turn to. You also do not post their actions on a public topic. Players have the least amount of say of who is a good mod or not, because their maturity is suspect, so do not turn to them for advice.
		<br><b>12</b> -2.	Respect each other. If I see moderator incompatibility(flaming on Gm ooc, constant breaking of rule #1 with significant other), I will be going to either Hawk or Korona to have them removed. You were given these powers because you were thought to be mature and collected enough to handle rashness and immaturity. If you prove us wrong, you will pay with your rank.
		<br><b>12</b> -3.	Record. Even I hate this, but it has to be done. If someone's getting punished, make sure other moderators know about it. This is for organizational purposes. Chances are, you won't be there to unban the player, and they will complain about it. The moderators(the good ones) will have to look up the ban reports and see if the player was correct. If so, they will unban him.
		<br><b>12</b> -4.	Be vigilant. As in, do your job. Helpers should be giving....help, Enforcers should be responding to any reports they come across on the forums with necessary force, and Admins should be dealing with moderator issues/repeated disobedience. Owners just slack off, occasionally updating with the awesome. Owners should never have to handle your problems, by the way. Remember that.
		<br><b>12</b> -5.	Punish accordingly. Unless an owner or admin says otherwise, any first offense should be dealt with a warning. The second offense, go crazy, though if your ban stretches past 5 days, you're going to have issues. Third offense, come directly to an Admin. Anything that calls for overruling a first offense must be discussed first.
		<br><b>12</b> -6.	Be responsible. It sucks, but you have to put your duty ahead of your play time. Free or not, you volunteered to put yourself to work. Don't worry though. Once you deliver your first ban hammer, it will all be worth it.
		<br><b>12</b> -7	As a Staff member you must follow all rules while enforcing, or playing.
		<title>Gm Rules Don`t Forget!</title>
		<br><b>12</b> -8	Use of any verb without a reason is illegal, and doing so will result in a removal of power
		<br><b>12</b> -9    *No use of announce unless its important; *No Use of (Check SkillCard) Unless neccesary. This usually comes into play during AFK checks.;
							*NO Use of teleport whatsoever unless neccesary. This means teleporting for your own benefit
							*Banning for GM disrespect is illegal unless pushed far enough. However you`ll need to provide further evidence on the forums.
							*GM`s are no longer allowed to ban someone without making a proper report about it on the forums.
							*GM`s Will be removed of power if these rules are not set into motion.
		<br><b>12</b>Additional, by Hawk: I expect Gm's to respect players as they wish to be respected. That means I do not want to see immature acts coming from our GM's. Also any use of innapropiate verb usage (E.g) Teleporting without a good reason will result in a strip.
		<br><b>12</b> -Furthermore, one thing I never want to see on the gm logs is "Player was banned: Reason GTFO WITH YOUR ABUSE HERE"

		<br><b>12</b> -	That's it. Obey.
		</body>
		</html>
		"}
	usr << browse("[Stuffz][html]","size=576x576,window=Rules")

mob/proc/ScoreboardUpdate()
	if(src.client)
//Scores
		var/ARARA=src.kills-src.deaths
		if(src.Village!="Missing")
			ARARA+=(src.dmission*0.1)+(src.cmission*0.25)+(src.bmission*0.5)+(src.amission*1)+(src.smission*2)
		if(ARARA<0)
			ARARA=0
		var/params = list("Rank"="[src.rank]","Missions"="[src.amission+src.bmission+src.cmission+src.dmission+src.smission]","Bounty"="[src.bounty]","Class Level"="[ARARA]")
		world.SetScores("[src]",list2params(params))//gives the scores
mob/proc/NotMoving()
	var/Cloc=src.loc
	if(src.Stealth==1)
		src.StealthCount++
		if(src.StealthCount>25)
			src.invisibility=90
		while(Cloc==src.loc)
			src.invisibility=90
			sleep(1)
		src.invisibility=1;
		src.StealthCount=0;
/////////Exp Orbs//////////////////////////////
proc
	EXP(Z,X,mob/Y)//Z is the Dropper, Y is the one to make them drop it. X is max EXP gained.
		if(ismob(Z))
			//just add everything that can't drop any here? o.o
			//if(istype(blah))
				//return
			if(istype(Z,/mob/NPC))
				var/mob/NPC/E = Z
				if(E.blevel=="S")
					return
		return
			//		var/obj/NFFOrb/A = new(E.loc)
			//		A.expowner = Y
			//		A.expvalue += round(rand(30000,X))
					//A.loc = E.loc*/
		//	else
			//	var/obj/NFFOrb/A = new(Z:loc)
			//	A.expowner = Y;A.expsource = Z
			//	A.expvalue += round(rand(50,X))
	//	else
	//		if(isturf(Z))
			//	var/obj/NFFOrb/A = new(Z)
			//	A.expowner = Y
			//	A.expvalue += 10
			/*
obj
	NFFOrb
		New()
			src.pixel_x = rand(-8,8)
			src.pixel_y = rand(-8,8)
			spawn(600)	del(src)
			spawn(300)	if(src)	src.expowner = "-FFA-"
			spawn()
				while(src)
					for(var/mob/M in oview(1))
						if(M&&M.client)
							if(M==src.expowner||src.expowner=="-FFA-")
								M.exp += src.expvalue
								M<<"<font size=-1><font color=white>You have gained [src.expvalue] EXP!"
								del(src)
							else
								M<<"<font size=-1><font color=red>This belongs to [src.expowner]!"
								sleep(10)
					sleep(3)
			..()
			spawn(300)
				del(src)
		var
			expowner
			expsource
			expvalue = 500
		name = "Experience Orb"
		icon = 'Icons/Hud/Backdrop.dmi'
		icon_state = "NFF"
*/
obj/Totem
	icon = 'Post.dmi'
	icon_state = "2"
	density=1
	var
		Effect=0
		CoolDown=0
	layer=MOB_LAYER+1
	New()
		.=..()
		spawn()
			while(src)
				if(Effect==1)
					src.WrathOfArgon()
					Effect=0
				if(Effect==2)
					src.WrathOfArgon()
					Effect=0
				if(Effect==3)
					src.WrathOfArgon()
					Effect=0
				if(Effect==4)
					src.WrathOfArgon()
					Effect=0
				if(Effect==5)
					src.WrathOfArgon()
					Effect=0
				if(Effect==6)
					src.WrathOfArgon()
					Effect=0
				if(Effect==7)
					src.WrathOfArgon()
					Effect=0
				if(Effect==8)
					src.WrathOfArgon()
					Effect=0
				if(Effect==9)
					src.WrathOfArgon()
					Effect=0
				if(Effect==10)
					src.WrathOfArgon()
					Effect=0
				sleep(100)
				if(CoolDown>0)
					CoolDown-=10
					if(0>CoolDown)
						CoolDown=0

obj
	proc
		WrathOfArgon()
			oview(30)<<"Fools Who've Chosen to fight in here.."
			sleep(25)
			oview(30)<<"Listen to my everyword or else pay the punishment..."
			sleep(25)
			var/Command=2
			for(var/mob/M in oview(30))
				if(Command==1)
					oview(30)<<"Stand still...!"
					sleep(15)
					if(M.icon_state!="")
						M<<"You fool...."
						M.health-=1550
				if(Command==2)
					sleep(10)
					oview(30)<<"Guard..."
					sleep(25)
					if(M.icon_state!="Block")
						M<<"You fool...."
						M.health-=1550
						return

/*GravityChange()
	var/Gravity=0
	for(var/mob/M in oview(30))
		oview(30)<<"You feel something heavy begin to press upon your body!"
		Gravity=1
		if(Gravity==1)
	    	M.Running=0
	    	spawn(250)
	    		oview(35)<<"You feel the heavyness upon your body fade away!"
*///	    		Gravity=0
//	    		M.Running=1
	    	//	return