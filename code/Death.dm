var/tmp/ContestantSet="Normal"
mob/var
	tmp/owned=0
	tmp/warning=0
	knockedout = 0
	tmp/victim=list()
	tmp/CKOS=0
	tmp/MCKOS=5
	tmp/ImmuneToDeath=0
	deathcount=0
	killer=""
	remaking=0
mob/proc
	DeleteMultipleCopySkillCards()
		for(var/obj/SkillCards/S in src.LearnedJutsus)
			for(var/obj/SkillCards/SS in src.LearnedJutsus)
				if(S.type==SS.type&&S!=SS)
					del(SS)
//THESE GO IN BS
mob/proc/DeleSelf(Time)
	spawn(Time-200)
		viewers(10,src)<<"[src] is decomposing.."
		spawn(200)
			if(!src.beingdragged&&src.Dead)
				del(src)
			else
				src.DeleSelf(200)
mob/proc/Reincarnate()
	var/True=0
//	var/Skillpoints=0
	if(!ChuuninPermaDeath)
		for(var/mob/M in world)
			if(M.name == "[src.name]'s corpse")
				src<<"Because your body escaped harm, the gods have decided to return you to life!"
				True=1
	//if(src.Age<18&&!(ChuuninPermaDeath))
	//	src<<"The gods have decided you were too young to be stolen away from the world and thus have ressurected you and your body."
	//	True=1
	if(True&&!src.remaking)
		src.VariablesTakeAway()
		src.GotoVillageHospital()
		return
	else if(!True&&!src.remaking)
		src<<"Your body has been destroyed and you are now dead, but the gods like their solitude and have decided to reincarnate you."
		if(!SilentRebirth)
			world<<"<font color=#8b0000>[src] has been murdered by [src.killer].</font>"
		src.remaking=1
		src.SaveK()
		sleep(20)
		src<<"To being the reincarnation process, reconnect to the game, and select Load."
		DeadPeople+=src.key
		del(src)
	if(src.remaking)
		src<<"However, the gods have decided to bless you with some 'perks' this time around..You will automatically start with any element you choose as well as 60 Elemental Points and extra Starting Points. You'll also begin with 50 knowledge in your dominant stat, and have 20,000 Ryo."
		src<<"<font size=2>(If you log out before this process is over, you'll have to make a new character without the benefits listed here.)</font>"
		src.Yen=20000
		src.StartingPoints=60;src.ElementalPoints=60
		src.loc=locate(170,170,1)
		PickVillage
		var/Village=input(src,"Which Village do you want to be born in?") in list("Leaf","Rock","Rain","Sound")
		if(Village=="Leaf")
			src.Village="Leaf"
			var/Clan=input(src,"Alright, now which clan do you want to be born into?") in list("Hyuuga","Aburame","Inuzuka","Nara","Akimichi","Kusakin","Basic","Cancel")
			if(Clan=="Cancel")
				goto PickVillage
			else
				src.Clan=Clan
				if(Clan=="Hyuuga") src.Clan="Hyuuga"
				if(Clan=="Aburame") src.Clan="Aburame"
				if(Clan=="Inuzuka") src.Clan="Inuzuka"
				if(Clan=="Nara") src.Clan="Nara"
				if(Clan=="Akimichi") src.Clan="Akimichi"
				if(Clan=="Kusakin") src.Clan="Kusakin"
				if(Clan=="Yamanaka") src.Clan="Yamanaka"
				if(Clan=="Kurama") src.Clan="Kurama"
		if(Village=="Rock")
			src.Village="Rock"
			var/Clan=input(src,"Alright, now which clan do you want to be born into?") in list("Sabaku","Iwazuka","Satou","Kiro","Basic","Shojin","Cancel")
			if(Clan=="Cancel")
				goto PickVillage
			else
				src.Clan=Clan
				if(Clan=="Sabaku") src.Clan="Sabaku"
				if(Clan=="Iwazuka") src.Clan="Iwazuka"
				if(Clan=="Satou") src.Clan="Satou"
				if(Clan=="Kiro") src.Clan="Kiro"
				if(Clan=="Shojin") src.Clan="Shojin"
		if(Village=="Rain")
			src.Village="Rain"
			var/Clan=input(src,"Alright, now which clan do you want to be born into?") in list("Shiroi","Fuuma","Hoshigaki","Kyomou","Ketsueki","Basic","Cancel")
			if(Clan=="Cancel")
				goto PickVillage
			else
				src.Clan=Clan
				if(Clan=="Shiroi") src.Clan="Shiroi"
				if(Clan=="Fuuma") src.Clan="Fuuma"
				if(Clan=="Hoshigaki") src.Clan="Hoshigaki"
				if(Clan=="Kyomou") src.Clan="Kyomou"
				if(Clan=="Ketsueki") src.Clan="Ketsueki"
		if(Village=="Sound")
			src.Village="Sound"
			var/Clan=input(src,"Alright, now which clan do you want to be born into?") in list("Kaguya","Uchiha","Kumojin","Yotsuki","Basic","Cancel")
			if(Clan=="Cancel")
				goto PickVillage
			else
				src.Clan=Clan
				if(Clan=="Kaguya") src.Clan="Kaguya"
				if(Clan=="Uchiha") src.Clan="Uchiha"
				if(Clan=="Kumojin") src.Clan="Kumojin"
				if(Clan=="Yotsuki") src.Clan="Yotsuki"
		var/sk = 50+(rand(5,10))
		var/TotalPoints=sk
		Skill
		sk=TotalPoints
		src.StartingPoints=sk
		alert(src,"Time to choose your Potential. Your Potential determines your stats and pretty much what you can do. Divide them wisely (this will determine the amount of damage you can inflict for a lot of things among others.)")
		var/b = input(src,"What is your Physique? This will determine your damaged inflicted by physical attacks, and your overall Physical abilities(such as stamina.): 40 is the maximum you can use on this skill, 5 is the minimum, and you have a total of [sk] points left.",) as num
		if(b<5)
			b=5
		if(b>40)
			b = 40
		if(b>sk)
			src<<"Nope, sorry you've used up too much of your Skill Points, start over."
			goto Skill
		sk -= b
		src.TaiSkill = b
		//////////////////////////
		var/c=input(src,"What is your Chakra Capacity? Your Chakra Capacity is the intensity of your chakra, thus the more of this you have the more damage your initial techniques involving chakra will perform and the maximum chakra you have.: 40 is the maximum you can use on this skill, 5 is the minimum, and you have a total of [sk] points left.",) as num
		if(c<5)
			c=5
		if(c>40)
			c = 40
		if(c>sk)
			src<<"Nope, sorry you've used up too much of your Skill Points, start over."
			goto Skill
		sk -= c
		src.NinSkill = c
			//////////////////////////
		var/d = input(src,"What is your Chakra's Control? This stat is much different from your Chakra Control as it is your Chakra's Controlling nature. This determines things involving control over your enemy such as Genjutsu since it involves controlling your opponent's chakra.: 40 is the maximum you can use on this skill, 5 is the minimum, and you have a total of [sk] points left.",) as num
		if(d<5)
			d=5
		if(d>40)
			d = 40
		if(d>sk)
			src<<"Nope, sorry you've used up too much of your Skill Points, start over."
			goto Skill
		sk -= d
		src.GenSkill = d
		switch(input(usr,"You have [usr.TaiSkill] Physical Potential, [usr.NinSkill] Capacity Potential, and [usr.GenSkill] Controlling Potential with [sk] Starting Points remaining. Is This correct?",) in list ("Yes","No"))
			if("No")
				goto Skill
		src.StartingPoints=sk
		if((src.GenSkill+src.NinSkill+src.TaiSkill+src.StartingPoints)!=TotalPoints)
			usr<<"Something went wrong in the creation process. Please try again."
			goto Skill
		var/list/L
		L=list("Fire","Water","Wind","Earth","Lightning")
		if(src.Element==""||!src.Element)
			src.Element=input(src,"What Element do you want to start off with?") in L
		if(src.Clan=="Shiroi")
			src<<"Shiroi's automatically start off with both Water and Wind"
			src.Element="Water";src.WaterE=1;src.WindE=1
		else if(src.Clan=="Kusakin")
			src<<"Kusakin's automatically start off with both Earth and Water"
			src.EarthE=1;src.WaterE=1;src.Element="Earth"
			src.FireE=0;src.WindE=0;src.LightningE=0
		else if(src.Clan=="Shojin")
			src<<"Shojin's automatically start off with Earth"
			src.EarthE=1;src.WaterE=0;src.Element="Earth"
			src.FireE=0;src.WindE=0;src.LightningE=0
		else
			if(src.Element=="Fire")
				src.FireE=1
			if(src.Element=="Water")
				src.WaterE=1
			if(src.Element=="Lightning")
				src.LightningE=1
			if(src.Element=="Wind")
				src.WindE=1
			if(src.Element=="Earth")
				src.EarthE=1
		src.ElementalCapacity=5
		if(src.Clan=="Kyomou")
			src.ChakraColorR=180;src.ChakraColorG=0;src.ChakraColorB=0
		else
			src.ChakraColorR=100;src.ChakraColorG=100;src.ChakraColorB=255
		src.ChakraC=rand(50,75)
		if(prob(25))
			var/choice=rand(1,3)
			if(choice==1)
				src.TaiSkill+=5
			if(choice==2)
				src.NinSkill+=5
			if(choice==3)
				src.GenSkill+=5
		var/B=rand(1,250)
		if(B==1)
			src.Trait3="Super Taijutsu"
			src.TaiSkill+=10
		if(B==2)
			src.Trait3="Super Ninjutsu"
			src.NinSkill+=10
		if(B==3)
			src.Trait3="Super Genjutsu"
			src.GenSkill+=10
		if(B==4)
			src.Trait3="Super Human Endurance"
			src.MEndurance+=250;src.Endurance=src.MEndurance
		if(B==5)
			src.Trait3="Super Human Regeneration"
		if(B==6)
			src.Trait3="Super Human Speed"
		if(B==7)
			src.Trait3="Prodigy"
		if(src.Clan=="Uchiha")
			if(prob(60)||src.Trait3=="Prodigy")
				src.CanGetMangekyo=1
				var/ASA=list("obito","itachi","madara","sasuke","star","bladed","gridlock","shuriken","shin")
				var/Mangekyo=pick(ASA);src.mangekyouC=Mangekyo
		if((prob(25)||usr.Clan=="Fuuma"))
			var/choice=rand(1,3)
			if(choice==1)
				usr.TaiSkill+=5
			if(choice==2)
				usr.NinSkill+=5
			if(choice==3)
				usr.GenSkill+=5
		src.HealthRegen=rand(5,15);src.StaminaRegen=rand(10,20)
		/*if(src.Trait2=="Super Human Regeneration")
			if(src.deathcount<=1)
				src.deathcount-=rand(1,3)
			src.HealthRegen+=rand(70,100)*/
		if(src.Clan=="Iwazuka")
			src.LearnedJutsus+= new /obj/SkillCards/Katsu
			src.LearnedJutsus+= new /obj/SkillCards/SetLeftHand
			src.LearnedJutsus+= new /obj/SkillCards/SetRightHand

		src.BoyOrGirl()
		src.GoToThingy()
		src.NameChoose()
		src.cansave=1
		src.OOC=1
		src.desc=""
		//src.Move_Delay=src.Savedspeed
		src.view=9
		src.OOC = 1
		src.cansave=1
//		src.Updates()
		src.loggedin=1
		src.Frozen = 0
		src.sight &= ~BLIND
		src.FrozenBind = ""
		usr.StartingPoints+=10
		src.firing = 0
		src.resting = 0
	//	src.RuleGuide()
		src.verbs+=typesof(/mob/GainedAfterLogIn/verb)
		spawn()
			src.AddHud()
			src.HungerAd()
			src.Huds()
			src.ThirstAd()
			src.RegenerationProc()
		src.maxhealth=1500;src.health=src.maxhealth
		usr.maxstamina=2500+(usr.TaiSkill*30+usr.GenSkill*15)
		usr.Mchakra=2500+(usr.NinSkill*40+usr.GenSkill*25)
		if(src.Clan=="Aburame")
			src.Mchakra-=rand(900,1500);src.chakra=src.Mchakra
		if(src.Clan=="Hoshigaki")
			src.Mchakra=rand(7000,10000);src.chakra=src.Mchakra
		if(src.TaiSkill>src.NinSkill&&src.TaiSkill>src.GenSkill)
			src.TaijutsuKnowledge=50
			src.TaijutsuMastery=5
			src.Acceleration=2.5
			src.Swift=3
			src.DoubleStrike=5
		if(src.NinSkill>src.TaiSkill&&src.NinSkill>src.GenSkill)
			src.NinjutsuKnowledge=50
			src.NinjutsuMastery=5
			src.WaterWalkingMastery=5
			src.HandsealsMastery=3
			src.HandsealSpeed=20
		if(src.GenSkill>src.TaiSkill&&src.GenSkill>src.NinSkill)
			src.GenjutsuKnowledge=50
			src.GenjutsuSight=5
			src.GenjutsuKai=1
			src.ChakraC=rand(75,90)
		if(src.Clan=="Basic")
			switch(src.SecondName)
				if("Uzumaki")
					usr.Mchakra=rand(7000,9000);usr.chakra=usr.Mchakra
					usr.DeclineAge=rand(100,125)
				if("Hatake")
					usr.Mchakra=rand(2500,3500);usr.chakra=usr.Mchakra
					usr.maxstamina=rand(3000,3500);usr.stamina=usr.maxstamina
					usr.WhiteChakra=100
					usr.StartingPoints+=3
				if("Sarutobi")
					usr.maxstamina+=rand(1000,1600)
					usr.DeclineAge=rand(60,75)//75 80
					usr<<"The Sarutobi Last name is famous because of it's long living!"
				if("Kasuke")
					usr.HealthRegen+=rand(30,40)
					usr.StaminaRegen+=rand(40,60)
				if("Loren")
					usr.Mchakra-=2500;usr.chakra=usr.Mchakra
					usr.Mtai+=250;usr.tai=usr.Mtai
				if("Haruno")
					usr.GenSkill+=rand(4,5)
					usr.ChakraC=100
				if("Namikaze")
					usr.NinSkill+=rand(4,6)
					usr.Acceleration=rand(3,6)
				if("Jashin")
					usr.TaiSkill+=rand(3,4)
					usr.DeclineAge=rand(200,500)
					usr.Survive=1
				if("Momochi")
					usr.TaiSkill+=rand(4,6)
					usr.MEndurance=150
				if("Irkashii")
					usr.maxstamina+=rand(1000,2200)
					usr.RunningSpeed=5
				if("Renden")
					usr.Mchakra+=rand(1100,2000);usr.chakra=usr.Mchakra
					usr.MEndurance=140//Was 200...My God again..
				if("Naga")
					usr.Mchakra=rand(500,1200);usr.chakra=usr.Mchakra
					usr.maxstamina=rand(4000,5000)
				if("Saru")
					usr.maxstamina+=rand(1000,1500);usr.stamina=usr.maxstamina
					usr.MEndurance=125
					usr.StartingPoints+=2
				if("Satake")
					usr.GenSkill+=rand(3,5)
					usr.StartingPoints+=1
				if("Enton")
					usr.NinSkill+=rand(6,8)
				if("Naiobatsu")
					usr.DeclineAge=rand(150,175)
					usr.HealthRegen=rand(20,30)
					usr.maxstamina-=rand(1000,2000)
					if(usr.maxstamina<750)
						usr.maxstamina=750;usr.stamina=750
				if("Bayamo")
					usr<<"The Bayamo Last name is known for its mastery of the wind element!"
				if("Crimson")
					usr<<"The Crimson Last name is known for its mastery of the fire element!"
				if("Hozuki")
					usr<<"The Hozuki Last name is known for its mastery of the water element!"
				if("Bachi")
					usr<<"The Bachi Last name is known for its mastery of the earh element!"
				if("Ryouken")
					usr<<"The Ryouken Last name is known for its mastery of the lightning element!"
				if("Shimura")
					usr.GenjutsuSight=10
					usr.ChakraC=100
				if("Shiranui")
					usr.ChakraArmor=5
				if("Namiashi")
					usr.ThrowingStrength=7
				if("Terumi")
					usr.ElementalPoints+=13
					usr.TaiSkill-=rand(2,4)
				if("Kurosuki")
					usr.SpeedDice=8
					usr.GenSkill-=rand(2,3)
				if("Atsuzawa")
					usr.maxstamina+=rand(500,1200)
					var/choice=rand(1,3)
					if(choice==1)
						usr.TaiSkill+=rand(1,5)
					if(choice==2)
						usr.NinSkill+=rand(1,5)
					if(choice==3)
						usr.GenSkill+=rand(1,5)
				if("Suikazan")
					usr.Mchakra=rand(10000,15000);usr.chakra=usr.Mchakra
					usr.maxhealth=1000
				if("Munashi")
					usr.Kenjutsu=25
					usr.MEndurance=90
				if("Akebino")
					usr.Kenjutsu=30;usr.SpeedDice=2;usr.SlashStrength=7
					usr.MEndurance=80
				if("Matsuro")
					usr.maxhealth=1200
					usr.NinSkill+=rand(2,5)
					usr.GenSkill+=rand(2,5)
					usr.DeclineAge-=15
					usr.Mchakra+=rand(1000,1500);usr.chakra=usr.Mchakra
					usr.maxstamina-=rand(100,900);usr.stamina=usr.maxstamina
					if(usr.maxstamina<750) {usr.maxstamina=750;usr.stamina=usr.maxstamina}
					usr.HealthRegen+=rand(10,20)
				if("Karsumu")
					usr.Mchakra+=10000;usr.chakra=usr.Mchakra
					usr.GenSkill+=rand(10,15)
					usr.DeclineAge=rand(20,25)
					usr.BaseR=156;usr.BaseG=156;usr.BaseB=156;usr.FixMyIcon()
				if("Cobra")
					usr.PoisonKnowledge=3000
					usr.PoisonExpert=20
					usr<<"The Cobra Last name was invented by the master orochimaru when he started using poison!"
				else
					usr<<"As a result of using no special last name or creating a unique one, you have been given an additional 5 Starting Points! Thank you for being original."
					usr.StartingPoints+=15
					if(prob(1))
						usr.AbleToGetConversusin=1
		if(src.Trait3=="Super Genjutsu")
			src.ChakraC=rand(90,100)
		if(src.Clan=="Aburame")
			src.loc=locate(156,150,1)
		else if(src.Clan=="Akimichi")
			src.loc=locate(156,150,1)
		else if(src.Clan=="Fuuma")
			src.loc=locate(144,170,6)
		else if(src.Clan=="Hoshigaki")
			src.loc=locate(152,125,6)
		else if(src.Clan=="Hyuuga")
			src.loc=locate(156,150,1)
		else if(src.Clan=="Nara")
			src.loc=locate(156,150,1)
		else if(src.Clan=="Kusakin")
			src.loc=locate(156,150,1)
		else if(src.Clan=="Yamanaka")
			src.loc=locate(156,150,1)
//Sound
		else if(src.Clan=="Uchiha")
			src.loc=locate(46,51,21)
		else if(src.Clan=="Kumojin")
			src.loc=locate(121,38,21)
		else if(src.Clan=="Kaguya")
			src.loc=locate(98,43,21)
		else
			if(src.Village=="Leaf")
				src.loc=locate(156,150,1)
			if(src.Village=="Rain")
				src.loc=locate(82,100,6)
			if(src.Village=="Sound")
				src.loc=locate(119,130,4)
			if(src.Village=="Rock")
				src.loc=locate(84,72,14)
		for(var/mob/M in world)
			if(M.Village==usr.Village)
				M<<"<font color = #BB0EDA>Village Information:</font> [usr] has become a Genin of the village!"
		src.rank ="Genin"
		src.score=0
		var/obj/Clothes/Headband/BAA=new();BAA.loc=src
		src<<"You were given a couple of items to start your Genin career."
		var/obj/BonusScrolls/CoolDown/D=new();D.ammount=10;D.loc=src
		var/obj/BonusScrolls/EXP/EXPSCROLL=new();EXPSCROLL.ammount=10;EXPSCROLL.loc=src
		var/obj/BonusScrolls/Knowledge_Scroll/F=new();F.ammount=10;F.loc=src//
		//src << "To appologize for the recent, accidental wipes caused by an unfortunate bug, you've been given a Knowledge Boosting scroll. ~The Owners"

		if(src.Clan=="Uchiha")
			var/obj/Clothes/Uchiha_Crest/C = new()
			C.loc = src
			src.gottenuchihacrest=1
			src<<"You've been given an Uchiha Crest Symbol to place on your clothing and show your clan pride."
		var/obj/WEAPONS/Kunai/AAA=new();AAA.ammount=10;AAA.loc=src
		var/obj/WEAPONS/Shuriken/C=new();C.ammount=10;C.loc=src
		var/obj/BonusScrolls/Knowledge_Scroll/R=new();R.loc=usr
		var/obj/BonusScrolls/Knowledge_Scroll/O=new();O.loc=usr
		var/obj/BonusScrolls/Knowledge_Scroll/W=new();W.loc=usr
		var/obj/BonusScrolls/Knowledge_Scroll/G=new();G.loc=usr
		var/obj/BonusScrolls/Knowledge_Scroll/N=new();N.loc=usr
		var/obj/BonusScrolls/Knowledge_Scroll/J=new();J.loc=usr
		src.pixel_step_size=0
		src.controlled=null
		src.remaking=0
		src.Normal()
		src.CHECK()
		src.AutoSave()

mob/var/tmp/StruggledUp=0
mob/var/tmp/StruggleAgainstDeath=0
mob
	proc
		DeathStruggle(mob/M,InstaKill=0)
			spawn(1)
			//	if(src==M)
			//		src.DeathAvoidCount=0
				if(!src.knockedout||src.Dead)
					return
				if((src&&M)&&src in M.Allies)
					M<<output("You can't struggle [src] because you have them targetted an ally!","Attack")
					return
				if(src.client)
					Unsummon("All")
				if(M.MassMurderer==1||InstaKill==1)
					src.SDelAllJutsu()
					src.StruggleAgainstDeath=0
					src.Struggle=0
					src.deathcount+=10
					src.CBleeding=0
					src.Struggle=0
					src.icon_state = ""
					src.Frozen=0
					src.firing=0
					src.density=1
					src.knockedout=0
					src.Endurance=src.MEndurance
					src.Frozen=0
					src.icon_state=""
					src.Guarding=0
					src.gencounter=0
					src.nin=src.Mnin;src.tai=src.Mtai;src.gen=src.Mgen
					src.Dead=1
					spawn()
						if(src.client) src.SaveK()
					src<<"You feel like the light around is slipping away as a shivering coldness begins to consume you."
					src.FrozenBind="Dead"
					src<<sound('SadnessAndSorrow.mid',0,0,75,80)
					spawn(3000)
						src<<sound(null,channel=75)
					src.icon_state="dead"
				//	if(M!=src&&MassMurder==1)
				//		if(M.MassMurderer)
				//			world<<"<font color = red size = 3>[M] has murdered [src]!</font>"
					/*for(var/obj/WEAPONS/NagaBladeSword/A in src.contents)
						A.loc=src.loc
					for(var/obj/WEAPONS/RoseBladeSword/A in src.contents)
						A.loc=src.loc
					for(var/obj/WEAPONS/InvisibleKaito/A in src.contents)
						A.loc=src.loc*/
					if(!src.client)
						if(istype(src,/mob/NPC/Animals/Wolf))
							if(prob(95))
								var/obj/RandomEquipment/WolfMane/A=new();A.loc=src.loc
							if(M.CurrentMission=="Kill A Wolf")
								M<<"You've killed [NumberOfWolvesKilled] wolves."
								M.NumberOfWolvesKilled++
						if(istype(src,/mob/NPC/Animals/FierceWolf))
							if(prob(95))
								var/obj/RandomEquipment/DarkWolfMane/A=new();A.loc=src.loc
							if(M.CurrentMission=="Kill A Wolf")
								M<<"You've killed [NumberOfWolvesKilled] wolves."
								M.NumberOfWolvesKilled++
							if(M.CurrentMission=="Fierce Wolves")
								M.MissionComplete()
					if(M.CurrentMission=="Kill A Wolf"&&M.NumberOfWolvesKilled>=M.NumberOfWolvesNeededToKill)
						M.MissionComplete()
					if(src.AOS||src.AWA||src.NPC)
						del(src)
					orange(12,src)<<"<font size = 2>[src] was defeated and not able to be saved..</font>"
					var/mob/P = new /mob/player
					P.health=5000;P.icon=src.icon;P.overlays=src.overlays;P.name="[src]'s corpse"
					P.icon_state="dead";P.loc=src.loc;P.knockedout=1;P.Dead=1;P.FrozenBind="Dead"
					spawn() P.EdoGetStats(src)
					spawn()
						P.DeleSelf(9000)
					src.beingdragged=0
					for(var/mob/Mx in world)
						if(Mx.DragPerson=="[src.name]")
							Mx.DragPerson="None"
					src.VariablesTakeAway()
					spawn()
						src.WakeUp()
						src.Respawn()
		//			if(!src.Jailed)
		//				src.GotoVillageHospital()
				if(istype(M,/mob/Bugs/Kekkai)||istype(M,/mob/Clone/WoodClone)||istype(M,/mob/Bugs/Swarm)||istype(M,/mob/Bugs/BugShield)||istype(M,/mob/Bugs/SpecialSwarm)||istype(M,/mob/Sand/SunaNoTate)||istype(M,/mob/Jutsu/Elemental/Shoton/CrystalMirror))
					return
				if(src.knockedout&&M&&!src.ImmuneToDeath&&src.StruggleAgainstDeath<1)
					if(src.InHenge)
						var/obj/SmokeCloud/S=new()
						S.loc=locate(src.x,src.y,src.z)
						src.overlays=null
						src.icon=src.Oicon
						src.overlays+=src.hair
						src.overlays+=src.Overlays
						src.firing=0
						src.name=src.savedname
						src.InHenge=0
						if(src.HengeVillage)
							src.Village=src.SavedHengeVillage
							src.HengeVillage="";src.SavedHengeVillage=""
					src<<output("You are dieing, quickly tap Space rapidly to save yourself. You have 30 seconds!","Attack")
					if(src.Gender=="Male")
						viewers(src)<<"[src] is struggling for his life!"
					if(src.Gender=="Female")
						viewers(src)<<"[src] is struggling for her life!"
					if(!src.client)
						if(src.name == "Masaharu Morimoto Nemesis")
							var/obj/O = new/obj/reflex/reflexOneQuestScroll2Number2
							O.loc = locate(130,15,33)
					if(!src.client)
						if(src.name == "Morimoto Master's Assassin")
							var/obj/A = new/obj/reflex/reflexEnhancer
							A.loc = locate(src.x,src.y,src.z)
					if(prob(10))
						if(src.Clan=="Fuuma")
							src.Survivability+=0.3;if(src.Survivability>10) src.Survivability=10
						else
							src.Survivability=0
					var/CurrentDC=src.deathcount
					src.StruggleAgainstDeath=((rand(45,65))+src.deathcount*rand(20,30))
					src.Struggle=0
					spawn(300)
						if(src.PlayingDead==2)
							if(src.Struggle>=src.StruggleAgainstDeath || !src.StruggleAgainstDeath)
								orange(12,src)<<"<font size = 2>[src] is dead and was defeated by [src.killer]!</font>"
								/*if(src.RemovedUpperCloathing&&src.ReverseFourSymbolsPlaced)
									orange(12,src)<<"<font size = 2>[src]'s body begins to release a large black area that consumes everything! Run!</font>"
								//	spawn(20)
									sleep(15)
									for(var/turf/TT in getcircle(src,6))
										var/obj/Jutsu/Fuuinjutsu/FourSymbolsConsume/AA=new/obj/Jutsu/Fuuinjutsu/FourSymbolsConsume(locate(TT.x,TT.y,TT.z))
										AA.layer=TT.layer
										AA.loc=TT
										AA.Owner=src
									src.RemovedUpperCloathing=0
									src.ReverseFourSymbolsPlaced=0*/
								if(src.Village==M.Village)
									for(var/mob/Q in world)
										if(Q.client&&Q.Village==M.Village)
											if(M.CurrentMission=="Village Betrayal Enforcement")
												if((src in VillageAttackers)&&M.ATarget==src)
													VillageAttackers-=src
													M.MissionComplete()
													M.RewardMission()
													return
											else
												VillageAttackers+=M
											Q<<"<font color=yellow>Village Alert:</font> [M] has defeated his fellow village mate, [src]!"
						if(CurrentDC!=src.deathcount)
							return
						if(src.Struggle>=src.StruggleAgainstDeath)
							src.WakeUp();return
						if(prob(src.Survivability*3))
							src.WakeUp();return
						if(prob(src.Survive*75))
							src.WakeUp();return
						if(src.Indra==1)
							if(prob(5))
								IndraAwaken();return
						if(src.Ashura==1)
							if(prob(5))
								AsuraAwaken();return
						if(src.StruggleAgainstDeath>0&&src.knockedout)
							src.SDelAllJutsu()
							src.StruggleAgainstDeath=0
							src.Struggle=0
							src.deathcount+=10
							src.CBleeding=0
							src.Struggle=0
							src.icon_state = ""
							src.Frozen=0
							src.firing=0
							src.density=1
							src.knockedout=0
							src.Endurance=src.MEndurance
							src.Frozen=0
							src.icon_state=""
							src.Guarding=0
							src.gencounter=0
							if(src.rank=="Hokage")
								src<<"Your loss has caused the Village to be more open to enemy attack. Your Village Pool was Lowered."
								LeafVillagePool-=(LeafVillagePool*0.10)
							if(src.rank=="Tsuchikage")
								src<<"Your loss has caused the Village to be more open to enemy attack. Your Village Pool was Lowered."
								RockVillagePool-=(RockVillagePool*0.10)
							if(src.rank=="Otokami")
								src<<"Your loss has caused the Village to be more open to enemy attack. Your Village Pool was Lowered."
								SoundVillagePool-=(SoundVillagePool*0.10)
							if(src.rank=="Amekoutei")
								src<<"Your loss has caused the Village to be more open to enemy attack. Your Village Pool was Lowered."
								RainVillagePool-=(RainVillagePool*0.10)
							if(src in InAssassinEvent)
								if(M in Assassin)
									world<<"<font color = blue size = 2> The Assassin has claimed another victim...</font>"
									InAssassinEvent-=src
							if(src in Assassin)
								if(M in InAssassinEvent)
									world<<"<font color = blue size = 2> The Assassin has been defeated...</font>"
									Assassin-=src
									src.TheAssassin=0

							if(src in CurrentFighters)
								if(M in CurrentFighters)
									if(M!=src)
										world<<"<font color = green size = 3>[M] has defeated [src]!</font>"
										M.loc = locate(154,85,32)
										contestants-=src
										CurrentFighters-=src
										for(var/mob/P in world)
											if(P.client&&P.watchingcontestant&&P.client.eye==src)
												P.client.eye=P
												P.client.perspective=MOB_PERSPECTIVE
												P.watchingcontestant=0
									else
										world<<"<font color = green size = 3>[src] has defeated himself!</font>"
										contestants-=src;CurrentFighters-=src
										for(var/mob/P in world)
											if(P.client&&P.watchingcontestant&&P.client.eye==src)
												P.client.eye=P
												P.client.perspective=MOB_PERSPECTIVE
												P.watchingcontestant=0
								else
									world<<"<font color = green size = 3>[src] has been defeated!</font>"
									contestants-=src;CurrentFighters-=src
									for(var/mob/P in world)
										if(P.client&&P.watchingcontestant&&P.client.eye==src)
											P.client.eye=P
											P.client.perspective=MOB_PERSPECTIVE
											P.watchingcontestant=0
							else if(src in SecondPartDeath)
								src.TakingPartInChuunins=0
								if(M in SecondPartDeath)
									if(M!=src)
										if(M in SecondPartDeath)
											world<<"<font color = green size = 2>[M] has defeated [src], leaving [SecondPartDeath.len] ninja remaining in part two!</font>"
											SecondPartDeath.Remove(src)
											M<<"You can now Continue to fight, or wait until time is over and part 3 begins."
									else
										world<<"<font color = green size = 2>[src] has killed himself, leaving [SecondPartDeath.len] ninja remaining in part two!</font>"
										SecondPartDeath.Remove(src)
							else if(src in contestants)
								if(M in contestants)
									if(M!=src)
										world<<"<font color = green size = 3>[M] has defeated [src]!</font>"
										if(ContestantSet=="Chuunin")
											M.loc = locate(154,85,32)
										contestants-=src
										contestants-=M
										for(var/mob/P in world)
											if(P.client&&P.watchingcontestant&&P.client.eye==src)
												P.client.eye=P
												P.client.perspective=MOB_PERSPECTIVE
												P.watchingcontestant=0
									else
										world<<"<font color = green size = 3>[src] has defeated himself!</font>"
										contestants-=src
										for(var/mob/P in world)
											if(P.client&&P.watchingcontestant&&P.client.eye==src)
												P.client.eye=P
												P.client.perspective=MOB_PERSPECTIVE
												P.watchingcontestant=0
								else
									world<<"<font color = green size=3>[src] was defeated by an outside ninja!</font>"
									contestants-=src
									for(var/mob/P in world)
										if(P.client&&P.watchingcontestant)
											P.client.eye=P
											P.client.perspective=MOB_PERSPECTIVE
											P.watchingcontestant=0
							if(src.Village=="Missing"&&M!=src)
								if(M.CurrentMission=="Track And Defeat")
									M.HowManyMissingNeededToKill-=1
									if(M.HowManyMissingNeededToKill<0)
										M.HowManyMissingNeededToKill=0
									if(M.HowManyMissingNeededToKill==0)
										M.MissionComplete()
							if(M&&M.Village==src.Village&&M.Village!="Missing")
								M<<output("Your bounty did not increase because you defeated someone from your own village!","Attack")
							else if(M!=src)
								if(istype(src,/mob/NPC/Animals/Wolf)||istype(src,/mob/NPC/Animals/FierceWolf))
									M.bounty+=0
								else
									if(src.bounty>0)
										if(M.Village==ScrollIsIn)
											M.Yen+=(src.bounty*2)
											M<<output("The bounty payout double from [src]'s bounty. ([src.bounty*2])","Attack")
										else
											M<<output("You gained [src.bounty] Ryo from [src]'s bounty.","Attack")
											M.Yen+=src.bounty
										M.bounty+=((src.bounty*0.5)+5000)
										src.bounty=0
									else
										M.bounty+=5000
							if(src.name==M.ATarget&&src.client)
								M<<"Congratulations, you've defeated your target! Head back to the Mission Jounin!"
								M.MissionComplete()
							M.victim="[src]"
							src.killer="[M]"
				//			if(M.DeathAvoidCount>0)
				//				M.DeathAvoidCount=0
							if(istype(src,/mob/pet)&&src.isdog&&!src.owned)
								del(src)
							src.exp=0
							var/KilLGainAmount=0
							if(M.client&&src.client&&src.client.address!=M.client.address&&src.deathcount>=2)
								if(M.Village!=src.Village)
									if(src.blevel=="E")
										KilLGainAmount=0.5
										M.JutsuDelay-=50
										if(M.Subscriber)
											M.JutsuDelay-=50
										EXP(src,5*src.Age,M)
									if(src.blevel=="D")
										KilLGainAmount=1
										M.JutsuDelay-=1500
										if(M.Subscriber)
											M.JutsuDelay-=500
										EXP(src,50*src.Age,M)
									if(src.blevel=="C")
										KilLGainAmount=1.5
										M.JutsuDelay-=5000
										if(M.Subscriber)
											M.JutsuDelay-=1500
										EXP(src,500*src.Age,M)
									if(src.blevel=="B")
										KilLGainAmount=2
										M.JutsuDelay-=10000
										if(M.Subscriber)
											M.JutsuDelay-=3000
										EXP(src,5000*src.Age,M)
									if(src.blevel=="A")
										KilLGainAmount=2.5
										M.JutsuDelay-=15000
										if(M.Subscriber)
											M.JutsuDelay-=5000
										EXP(src,10000*src.Age,M)
									if(src.blevel=="S")
										KilLGainAmount=3
										M.JutsuDelay-=20000
										if(M.Subscriber)
											M.JutsuDelay-=10000
										EXP(src,50000*src.Age,M)//that seem fine? o.o u o-o obj doesn't appear?
								else
									for(var/mob/Q in world)
										if(Q.client&&Q.Village==M.Village)
											if(M.CurrentMission=="Village Betrayal Enforcement")
												if((src in VillageAttackers)&&M.ATarget==src)
													VillageAttackers-=src
													M.MissionComplete()
													M.RewardMission()
													return
											else
												VillageAttackers+=M
											Q<<"<font color=yellow>Village Alert:</font> [M] has defeated his fellow village mate, [src]!"
									M.VMorale-=5
								//	M.kills-=5
							if(M.client&&src.client&&src.client.address==M.client.address)
								KilLGainAmount=0
							M.kills+=KilLGainAmount
							src.deaths+=1
							if(M.Village==src.Village)
								M.VMorale-=KilLGainAmount
							if(M.Village!="Missing")
								if(M.Village!=src.Village)
									M.VMorale++
							if(M!=src)
								if(src.Yen>1000)
									var/GainedYen=src.Yen*0.75;M<<"You pick [GainedYen] Ryo off of [src]!";src.Yen-=GainedYen;M.Yen+=GainedYen
								if(src.Age>12&&M.Age>12)
									if(src.client&&M.client&&M.client.address!=src.client.address)
										M.exp+=((src.Age*2000)+rand(-100,150))
										if(M.Subscriber)
											M.exp+=((src.Age*2000)+rand(-100,150))
								if(M.Clan=="Uchiha")
									var/hasmedalSharinganGain=world.GetMedal("I Can See!",M)
									if(!hasmedalSharinganGain)
										if(M.shari)
											world.SetMedal("I Can See!",M)
											M<<"<font size=3><font color=yellow>You've attained the I Can See! Medal!"

								if(M.Clan=="Kaguya")
									var/hasmedalSharinganGain=world.GetMedal("Bone Death",M)
									if(!hasmedalSharinganGain)
										if(M.KagDance=="Sawarabi")
											world.SetMedal("Bone Death",M)
											M<<"<font size=3><font color=yellow>You've attained the Bone Death Medal!"
								if(M.deathcount>=5)
									var/hasmedalSharinganGain=world.GetMedal("Tough",M)
									if(!hasmedalSharinganGain)
										world.SetMedal("Tough",M)
										M<<"<font size=3><font color=yellow>You've attained the Tough Medal!"
								if(src.deathcount==1)
									var/hasmedalSharinganGain1=world.GetMedal("Rock'd!",src)
									if(!hasmedalSharinganGain1)
										world.SetMedal("Rock'd!",src)
										src<<"<font size=3><font color=yellow>You've attained the Rock'd! Medal!"

									var/hasmedalSharinganGain=world.GetMedal("Go To Work",M)
									if(!hasmedalSharinganGain)
										world.SetMedal("Go To Work",M)
										M<<"<font size=3><font color=yellow>You've attained the Go To Work Medal!"
							src.nin=src.Mnin;src.tai=src.Mtai;src.gen=src.Mgen
							src.Dead=1
							if(src.killer=="[src]")
								orange(12,src)<<"<font size = 2>[src] has defeated themself!</font>"
							else
								orange(12,src)<<"<font size = 2>[src] is dead and was defeated by [src.killer]!</font>"
							if(src.RemovedUpperCloathing&&src.ReverseFourSymbolsPlaced)
								range(12,src)<<"<font size = 2>[src]'s body begins to release a large black area that consumes everything! Run!</font>"
						//		spawn(20)
								for(var/turf/TT in getcircle(src,7))
									var/obj/Jutsu/Fuuinjutsu/FourSymbolsConsume/AA=new()
									AA.layer=TT.layer
									AA.loc=TT;
									AA.Owner=src

								src.RemovedUpperCloathing=0
								src.ReverseFourSymbolsPlaced=0
							if(global.villageWarBloodLust&&src.villageWarParticipating)
								var/Points=0
								if((src.Village == global.villageWarTeamOne)&&(src.villageWarParticipating == 1))
									Points++
									if(src.rank!="Genin")
										Points++
									if(src.rank!="Genin"&&src.rank!="Chuunin"&&src.rank!="S.Jounin")
										Points++
									if(src.rank!="Genin"&&src.rank!="Chuunin"&&src.rank!="S.Jounin"&&src.rank!="Jounin")
										Points++
									if(src.Anbu==1)
										Points=4
									world<<"[global.villageWarTeamTwo] scored on [src] ([Points] Points)."
									global.villageWarTeamTwoScore+=Points
								else if ((src.Village == global.villageWarTeamTwo)&&(src.villageWarParticipating == 1))
									Points++
									if(src.rank!="Genin")
										Points++
									if(src.rank!="Genin"&&src.rank!="Chuunin"&&src.rank!="S.Jounin")
										Points++
									if(src.rank!="Genin"&&src.rank!="Chuunin"&&src.rank!="S.Jounin"&&src.rank!="Jounin")
										Points++
									if(src.Anbu==1)
										Points=4
									world<<"[global.villageWarTeamOne] scored on [src] ([Points] Points)."
									global.villageWarTeamOneScore+=Points
								else if (( src.Village == "Missing")&&(src.villageWarParticipating == 1))
									src<<"Missing ninja can only participate in the war, not win them."
							/*for(var/obj/WEAPONS/NagaBladeSword/A in src.contents)
								A.loc=src.loc
							for(var/obj/WEAPONS/RoseBladeSword/A in src.contents)
								A.loc=src.loc
							for(var/obj/WEAPONS/InvisibleKaito/A in src.contents)
								A.loc=src.loc*/
							if(!src.client)
								if(istype(src,/mob/NPC/Animals/Wolf))
									if(prob(95))
										var/obj/RandomEquipment/WolfMane/A=new();A.loc=src.loc
									if(M.CurrentMission=="Kill A Wolf")
										M<<"You've killed [NumberOfWolvesKilled] wolves."
										M.NumberOfWolvesKilled++
								if(istype(src,/mob/NPC/Animals/FierceWolf))
									if(prob(95))
										var/obj/RandomEquipment/DarkWolfMane/A=new();A.loc=src.loc
									if(M.CurrentMission=="Kill A Wolf")
										M.NumberOfWolvesKilled++
									if(M.CurrentMission=="Fierce Wolves")
										M.MissionComplete()
							if(M.CurrentMission=="Kill A Wolf"&&M.NumberOfWolvesKilled>=M.NumberOfWolvesNeededToKill)
								M.MissionComplete()
							if(src.client) src.SaveK()
							src<<"You feel like the light around is slipping away as a shivering coldness begins to consume you as you were defeated by [src.killer]"
							/*
							if(!src.Subscriber)
								for(var/obj/WEAPONS/NagaBladeSword/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/RoseBladeSword/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/InvisibleKaito/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/OriginalSamehade/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/LightBlade/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/DarkBlade/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/Evanesence/A in src.contents)
									A.loc=src.loc
								for(var/obj/WEAPONS/Shibuki/A in src.contents)
									A.loc=src.loc
							else
								if(src.Subscriber&&prob(50))
									for(var/obj/WEAPONS/NagaBladeSword/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/RoseBladeSword/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/InvisibleKaito/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/OriginalSamehade/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/LightBlade/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/DarkBlade/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/Evanesence/A in src.contents)
										A.loc=src.loc
									for(var/obj/WEAPONS/Shibuki/A in src.contents)
										A.loc=src.loc
								*/
							if(global.AutoFreeForAllCount==2)
								if(src in AutoFreeForAll)
									world<<"[src] has been removed from the FFA!"
									AutoFreeForAll.Remove(src)
							if(src.MassMurderer&&M.client&&!M.MassMurderer&&MassMurder)
								if(MassMurder)
									src.MassMurderer=0
									src.SaveK()
									src<<"You've been slain..."
									M<<"You've become the new Mass Murderer...."
									M.MassMurderer=1
									world<<"font color=red size=2>[src] was killed by [M]! [M] is now a Killer...</font>"
									M.SaveK()
							if(src.Yonkami&&!M.Yonkami&&M.client)
								src.Yonkami=0
								src.SaveK()
								src<<"You've lost your title as Yonkami."
								M<<"You've taken [src]'s title as Yonkami!"
								world<<"<font color=red size=2>[src] was killed by [M]! [M] is now a Yonkami!</font>"
								M.Yonkami=1
								contestants+=M
								M.SaveK()
								M.kills+=10
								M.amission++
							src.FrozenBind="Dead"
							src.icon_state="dead"
							if(src.Bijuu=="Ichibi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Nibi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Sanbi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Yonbi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Gobi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Rokubi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Shichibi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Nanabi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Hachibi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							if(src.Bijuu=="Kyuubi")
								if(prob(50)&&src.BijuuMastery<10||src.BijuuMastery>=10&&prob(20))
									src.sight&=~(SEE_SELF|BLIND)
									src.Frozen=0
									src.ReleaseBijuu()
							var/Time=1000
							if(src.villageWarParticipating)
								Time=50
							spawn(Time)
								if(src.AOS||src.AWA||src.NPC)
									del(src)
								if(src.Dead)
									orange(12,src)<<"<font size = 2>[src] was not able to be saved..</font>"
									src.deathcount=0
									var/mob/P = new /mob/player
									P.health=5000;P.icon=src.icon;P.overlays=src.overlays;P.name="[src]'s corpse"
									P.icon_state="dead";P.loc=src.loc;P.knockedout=1;P.Dead=1;P.FrozenBind="Dead"
								//	spawn() P.EdoGetStats(src)
									spawn()
										P.DeleSelf(6000)
									if(ChuuninPermaDeath&&src.TakingPartInChuunins==2)
										if(src.z==32||src.z==37&&src.rank=="Genin")
											src.Reincarnate()
										else
											src.beingdragged=0
											for(var/mob/Mx in world)
												if(Mx.DragPerson=="[src.name]")
													Mx.DragPerson="None"
											src.VariablesTakeAway()
											spawn()
												src.WakeUp()
												src.Respawn()
								//			src.GotoVillageHospital()
										return
									else if(!PermDeath)
										src.beingdragged=0
										for(var/mob/Mx in world)
											if(Mx.DragPerson=="[src.name]")
												Mx.DragPerson="None"
										src.VariablesTakeAway()
										spawn()
											src.WakeUp()
											src.Respawn()
								//		src.GotoVillageHospital()

									else
										src<<"<font size=3>You're dead, and an owner has set death to be temporarily permanent. So you will wait here until its turned off.</font>"
										src.sight&=~(SEE_SELF|BLIND)
										src<<"In the meantime, feel free to walk around via remote viewing and talk in Village Say."
										var/mob/hyuuga/ByakuganTrack/E=new()
										E.health=1000000;E.stamina=10000000
										E.loc=locate(src.x-1,src.y,src.z)
										E.Owner=src
										src.controlled = E
										src.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
										src.client.eye = E
										while(PermDeath)
											src.FrozenBind=""
											src.icon_state="dead"
											sleep(50)
										src.firing=0
										src.controlled=null
										src.client.perspective=MOB_PERSPECTIVE
										src.client.eye=src
										for(var/mob/hyuuga/ByakuganTrack/I in world)
											if(I.Owner == src) del(I)
										src<<"Perm Death was deactivated."
										if(src.Dead)
											src.Reincarnate()
										//src.VariablesTakeAway()
										//src.GotoVillageHospital()
								else
									return
							return
					while(src.StruggleAgainstDeath>0)
						if(src.Struggle>=src.StruggleAgainstDeath)
							src.WakeUp()
						sleep(10)
mob/var/tmp/CantRunTimer=0
mob/proc
	WakeUp()
		if(src.StruggleAgainstDeath>0)
			src.ImmuneToDeath=1
			src.StruggleAgainstDeath=0
			src.StruggledUp=1
			if(src.PlayingDead!=2) viewers(src)<<"[src] struggles back to their feet.";src.Stun=0
			if(src.deathcount>=3&&src.Trait2!="Iron Will"||src.deathcount>=4.25&&src.Trait=="Iron Will")
				src.Running=0
				src<<"You're getting tired and forced to walk.."
				var/Timer=(deathcount-2)*100
				if(src.Trait2=="Hyperactivity")
					Timer=(deathcount-2)*70
				CantRunTimer=1
				spawn(Timer)
					CantRunTimer=0
					src<<"Your body feels a little bit strong; You feel capable of running again."
					if(src.Trait2=="Hyperactivity")
						src.Running=1

			src.Stun=0
			src<<output("You get back to your feet!","Attack")
			src.sight&=~(SEE_SELF|BLIND)
			src.chakra+=1000
			src.Struggle=0
			src.icon_state=""
			src.Frozen=0
			src.firing=0
			src.knockedout=0
			src.Endurance=src.MEndurance
			src.Frozen=0
			src.icon_state=""
			src.Guarding=0
			src.gencounter=0
			src.health+=round(src.maxhealth/3)
			src.stamina+=round(src.maxstamina/3)
			if(src.Trait2=="Adamant")
				src.health+=round(src.maxhealth/(rand(3,5)))
				src.stamina+=round(src.maxstamina/(rand(3,5)))
				if(src.chakra<src.Mchakra/5&&src.ChakraPool>0)
					var/amnt=min(src.Mchakra/2,src.ChakraPool)
					src.chakra+=amnt;src.ChakraPool-=amnt

			//var/Gain=(src.Mchakra/3)
			//if(Gain>src.ChakraPool)
			//	Gain=src.ChakraPool
			//src.chakra+=Gain
			//src.ChakraPool-=Gain
			spawn(70)
				src.ImmuneToDeath=0
			if(src.client)
				src.SaveK()

mob/var/tmp/TryingToKill=""
mob
	proc
		Death(mob/M)
			src.Normal()
			spawn()
				if(src.CNNPC)
					return
				if(istype(src,/mob/IndigoRingBarrier/))
					del(src)
				if(src.SpiderNPC==1)
					del(src)
				if(istype(src,/mob/Clones/Clone)&&src:CloneType!="GenjutsuClone")
					var/obj/SmokeCloud/S=new()
					S.loc = locate(src.x,src.y,src.z)
					src.loc=null
				//	spawn(100)
					del(src)
				if(src.client)
					Unsummon("All")
				else if(istype(src,/mob/Clones/Clone)&&src:CloneType=="GenjutsuClone"&&src.health<0)
					for(var/mob/W in world)
						if(W.client&&W.client.eye==src)
							if(W!=src.Owner)
								W.client.eye=src.Owner
							else
								W.client.eye=W;W.client.perspective=MOB_PERSPECTIVE;W.controlled=null
					src.icon_state="dead"
					sleep(25)
					del(src)
				if(src.isdog&&src.health<=0)
					if(src.Owner=="")
						del(src)
					var/mob/O=src.Owner
					if(!O){return}
					O<<"Your pet has fainted!";O.PetOut=0

					O.PetsHealth=src.health;O.PetsMHealth=src.maxhealth;O.PetsStamina=src.stamina;O.PetsMStamina=src.maxstamina;O.PetsChakra=src.chakra;O.PetsMChakra=src.maxstamina

					O.PTai=src.tai;O.PMTai=src.Mtai;O.PNin=src.nin;O.PMNin=src.Mnin;O.PGen=src.gen;O.PMGen=src.Mgen
					del(src)
				if(src.health<0&&!src.client)
					if(istype(src,/mob/IndigoRingBarrier))
						del(src)
					if(istype(src,/mob/Bugs/Kekkai)||istype(src,/mob/Clone/WoodClone)||istype(src,/mob/Bugs/Swarm)||istype(src,/mob/Bugs/BugShield)||istype(src,/mob/Bugs/SpecialSwarm)||istype(src,/mob/Sand/SunaNoTate)||istype(M,/mob/Jutsu/Elemental/Shoton/CrystalMirror))
						del(src)
					if(istype(src,/mob/Kibaku/))
						del(src)
				if(src.name=="Crows"&&!src.client)
					if(src.icon=='Icons/Jutsus/Crows.dmi'||src.icon=='Icons/Jutsus/Crows2.dmi')
						var/obj/SmokeCloud/S=new /obj/SmokeCloud
						S.loc = locate(src.x,src.y,src.z)
						del(src)

				if(istype(src,/mob/Summons/Controllable_Summons)&&src.health<=0)

					var/obj/SmokeCloud/S=new()
					S.loc=src.loc
					del(src)
				if(istype(src,/mob/Puppet/)&&src.health<=0)
					var/mob/Puppet/ASCA=src
					var/mob/OSS=ASCA.Owner
					OSS.ReturnPuppet(ASCA.ControlType)
				if(src.ImmuneToDeath)
					return
				if(src.InHenge)
					if(prob(10))
						var/obj/SmokeCloud/S=new();S.loc=locate(src.x,src.y,src.z);src.overlays=null;src.icon=src.Oicon;src.overlays+=src.hair;src.overlays+=src.Overlays;src.firing=0;src.name=src.savedname;src.InHenge=0
						if(src.HengeVillage)
							src.Village=src.SavedHengeVillage
							src.HengeVillage="";src.SavedHengeVillage=""
				if(src.StruggleAgainstDeath>0 || src.PlayingDead)
					if(prob(10))
						M<<"Stop KO Attacking. He's already struggling!"
						if(src.StruggleAgainstDeath>0)
							var/hasmedalSharinganGain=world.GetMedal("Overkill",M)
							if(!hasmedalSharinganGain)
								world.SetMedal("Overkill",M)
								M<<"<font size=3><font color=yellow>You've attained the Overkill Medal!"

					return
				if(src.knockedout)
			//		src.DeathAvoidCount=15
					if(findtext(src.name,"corpse",1,0)==1&&src.health<=0)
						del(src)
						return
					if(istype(M,/mob/pet))	//Calling the Struggle procbefore the "real" one, in case you're controlling a mob such as a pet, or summon.
						var/mob/O = M.Owner
						src.DeathStruggle(O)
						return
					if(istype(M,/mob/Clones))
						var/mob/O = M.Owner
						src.DeathStruggle(O)
						return
					if(istype(M,/mob/Puppet))
						var/mob/O = M.Owner
						src.DeathStruggle(O)
						return
					if(istype(M,/mob/Summons/Controllable_Summons))
						var/mob/O = M.Owner
						src.DeathStruggle(O)
						return

					src.DeathStruggle(M)
					return
				if(src.health>0||src.Dead)
					return
				if(src.icon=='animals.dmi'&&!src.AOS&&!src.client&&src.name=="Bunny Rabbit")
					M.KRA++
					M.exp+=40
					M<<"Oh my god..you killed a bunny..you're heartless."
					del(src)
				if(!src) return
				else if(!src.knockedout&&src.health<=0&&src.StruggleAgainstDeath<1&&!src.Dead||!src.knockedout&&src.health<=0&&src.stamina<=0&&!src.Dead)
					for(var/mob/XXC in range(10,src))
						if(src.name in XXC.namesknown)
							XXC<<"[src] has been knocked out!"
							if((XXC.BloodLust)||(XXC.Bijuu=="Shukaku"&&XXC.TailState>=0.5))
								XXC<<"Killing [src] Makes you stronger..."
								XXC.health+=150
								XXC.stamina+=100
								if(XXC.stamina>XXC.maxstamina) XXC.stamina=XXC.maxstamina
								if(XXC.health>XXC.maxhealth) XXC.health=XXC.maxhealth
						else
							XXC<<"[src.Village] Ninja has been knocked out!"
							if((XXC.BloodLust)||(XXC.Bijuu=="Shukaku"&&XXC.TailState>=0.5))
								XXC<<"Killing [src] Makes you stronger..."
								XXC.health+=150
								XXC.stamina+=1000
								if(XXC.stamina>XXC.maxstamina) XXC.stamina=XXC.maxstamina
								if(XXC.health>XXC.maxhealth) XXC.health=XXC.maxhealth
			//		spawn(1)
	//					if(src.InGenjutsu=="HekiKonchuu Ishuu")
	//						for(var/image/c in src.client.images)
	//							if(c.icon=='Swarm.dmi')
	//								del(c)
	//						for(var/obj/FakeSwarm/F in world)
	//							if("[F.Owner]"==src.GenjutsuBy)
	//								del(F)
	//						src.InGenjutsu=""
					src.Frozen = 1
					src.StruggledUp=0
					src.firing = 1
					src.knockedout = 1
					src.resting=0
					src.CanRest=1
					if(src.CursedSealActivated)
						src.CursedSealActivated=0;src.CursedSealActivatedS=0;src<<"The power of your Curse Mark fades..."
						src.icon=usr.Oicon;src.nin=src.Mnin;src.tai=src.Mtai;src.gen=src.Mgen;
						src.Endurance=src.MEndurance;src.Focus=src.OldFocus;src.RunningSpeed=5;src.overlays-='Icons/Jutsus/Bijuu/Heavenly Cursed Seal (State 2).dmi'
						src.overlays-=/obj/CurseMarkWings/A;src.overlays-=/obj/CurseMarkWings/B
					if(src.RaiArmor)
						src.overlays-='Icons/Jutsus/RaiArmor.dmi'
						src.overlays-='Icons/Jutsus/RaiArmor2.dmi'
						src.overlays-='RaitonYoroi.dmi'
						src.RaiArmor=0
						src.Touei=0
					if(src.Butterfly)
						src.underlays-='Icons/Jutsus/ButterflyModeUnderlay.dmi'
						src.overlays-='Icons/Jutsus/ButterflyModeOverlay.dmi'
						src.tai=src.Mtai
						src.Butterfly=0
					src.UsingAmaterasu=0
					if(src.name=="Kikaichu"&&!src.client)
						del(src)
					for(var/obj/Jutsu/Elemental/Raiton/RairyuuTatsumaki/K in world)
						if(K.Owner==src)
							del(K)
					for(var/mob/Clones/Clone/A in world)
						if(A.Owner==src)
							A.Death(src)
					for(var/obj/Jutsu/Kiro/ShurikenStar/A in world)
						if(A.Owner==src)
							del(A)
					src.FrozenBind=""
					if(src.Age>12&&M.Age>12)
						if(src.client&&M.client&&M.client.address!=src.client.address)
							M.exp+=((src.Age*500)+rand(src.maxstamina/10,src.maxstamina))
							if(M.Subscriber)
								M.exp+=((src.Age*100)+rand(src.maxstamina/10,src.maxstamina))
					if(src.GateIn!="")
						src<<"You release the gates."
						spawn(600)
							src.HealGateTime=0
						src.GateIn=""
						src.icon=src.Oicon
						src.overlays-='Icons/Jutsus/WonderAura.dmi' + rgb(132,215,255)
						src.overlays-='Icons/Jutsus/WonderAura.dmi' + rgb(136,0,51)
						src.overlays-='Icons/Jutsus/BEyes.dmi'
						src.tai=src.Mtai
						src.pixel_step_size=0
						for(var/obj/ReleaseThingy/AXX in src.client.screen)
							del(AXX)
					if(src.InDeathGate!=1)
						src.InDeathGate=2
					if(src.InDeathGate!=2)
						src<<"You released the Death gate."
						var/Chance=85
						if(prob(Chance))
							src<<"Your body burns from the inside-out and crumbles to ash"
							var/mob/P = new /mob/player
							P.health=5000;P.icon=src.icon;P.overlays=src.overlays;P.name="[src]'s corpse"
							P.icon_state="dead";P.loc=src.loc;P.knockedout=1;P.Dead=1;P.FrozenBind="Dead"
							spawn()
								P.EdoGetStats(src)
							spawn()
								P.DeleSelf(6000)
							var/firstletter=copytext(usr.ckey, 1, 2)
							fdel("Saves/[firstletter]/[src.ckey].sav")
							world<<"<font color=#8b0000>[src] has died due to the effects of the death gate...</font>"
							src << "Character Deleted"
							del(src)
						else
							usr.GotoVillageHospital()
							src<<"You were a lucky one of few, and survived the gate of death, only slightly."
							src<<"Due to it's effects, your body has been severely damaged, permanently."
							src.maxhealth=750
						src.GateIn=""
						src.InDeathGate=0
						src.icon=usr.Oicon
						src.overlays-='Icons/Jutsus/BEyes.dmi'
						src.overlays-='Icons/Jutsus/WonderAura.dmi' + rgb(136,0,51)
						src.tai=usr.Mtai
						src.pixel_step_size=0
						sleep(1)
					if(src.SusanooIn)
						for(var/obj/Jutsu/Uchiha/Susanoo/A in world)
							if(A.Owner==src)
								del(A)
						src.SusanooIn=0
					if(src.Pill!="")
						src<<"You release the pill's effects!"
						src.Pill=""
						for(var/obj/ReleaseThingy/AXX in src.client.screen)
							del(AXX)
					if(src.SunaNoTate)
						for(var/mob/Sand/SunaNoTate/S in world)
							if(S.Owner==src)
								del(S)
					if(src.CMirror)
						for(var/mob/Jutsu/Elemental/Shoton/CrystalMirror/S in world)
							if(S.Owner==src)
								del(S)
					if(src.HasHiddenScroll)
						src.HasHiddenScroll=0
						for(var/obj/Hidden_Ninja_Scroll/H in src.contents)
							H.loc=src.loc
							H.VillageIn=""
							src.pickedup=0
						world<<"<font color=red size=2>[src] was knockedout by [M], forcing [src] to drop the scroll</font>"
					for(var/obj/earthscroll/S in src.contents)
						S.loc = M.loc
					for(var/obj/heavenscroll/F in src.contents)
						F.loc = M.loc
					for(var/obj/MissingStuff/PeaceNote/F in src.contents)
						F.loc = M.loc
					src.deathcount+=1
					if(src.hunger>99)
						src.hunger=50
					if(src.thirst>99)
						src.thirst=50
					MER
					spawn(300)
						if(!src.beingdragged&&src.StruggleAgainstDeath<=0&&!src.Dead)
							src.sight &= ~(SEE_SELF|BLIND)
							src.icon_state = ""
							src.Frozen = 0
							src.firing = 0
							src.knockedout = 0
							src.Endurance=src.MEndurance
							src.Frozen=0
							src.icon_state=""
							src.Guarding=0
							src.gencounter=0
							if(AOS)
								if(src.Village=="Leaf")
									spawn(1) src.LeafANBU()
									return
								if(src.Village=="Rock")
									spawn(1) src.RockANBU()
									return
							src.SaveK()
							viewers(src)<<"[src] begins to come to.";src.StruggleAgainstDeath=0;src.Struggle=0//src.Stun=0
							//src.Stun=0
							src.health+=round(src.maxhealth/3);if(src.health>src.maxhealth) src.health=src.maxhealth
							src.stamina+=round(src.maxstamina/3);if(src.stamina>src.maxstamina) src.stamina=src.maxstamina
							//if(src.Trait=="Tough")   //Again, why?..
							//	src.health+=round(src.maxhealth/6);if(src.health>src.maxhealth) src.health=src.maxhealth
							//	src.stamina+=round(src.maxstamina/6);if(src.stamina>src.maxstamina) src.stamina=src.maxstamina
							if(!src.StruggledUp)
								src.health+=round(src.maxhealth/3);if(src.health>src.maxhealth) src.health=src.maxhealth
								src.stamina+=round(src.maxstamina/3);if(src.stamina>src.maxstamina) src.stamina=src.maxstamina
								src.ImmuneToDeath=1
								spawn(50)
									src.ImmuneToDeath=0
							return
						else if(src.StruggleAgainstDeath<=0&&!src.Dead)
							var/random = rand(1,10)
							if(random==1&&src.knockedout)
								src.sight &= ~(SEE_SELF|BLIND)
								src.icon_state = ""
								var/a = round(src.maxhealth/25)
								src.health += a
								src.Frozen = 0
								//src.firing = 0
								src.knockedout = 0
								src.Endurance=src.MEndurance
								src.Frozen=0
								src.icon_state=""
								src.Guarding=0
								src.gencounter=0
								src.SaveK()
								src<<"You begin to come to.";src.StruggleAgainstDeath=0;src.Struggle=0//src.Stun=0
								//src.Stun=0
								src.health += round(src.maxhealth/3);if(src.health>src.maxhealth) src.health=src.maxhealth
								src.awokefromdrag=1
								if(AOS)
									if(src.Village=="Leaf")
										spawn(1) src.LeafANBU()
										return
									if(src.Village=="Leaf")
										spawn(1) src.RockANBU()
										return
								return

							else
								goto MER

					src.sight |= (SEE_SELF|BLIND)
					src.icon_state = "dead"

					src.RasenganCharge=0
					src.RasenganD=0
					src.Rasenganon=0
					src.Chidorion=0
					src.Raikirion=0
					src.ChidoriCharge=0
					src.ChidoriD=0
					src.ChargedChakraForPunch=0
					src.UserChargingForChakraPunch=0
					src.ChargedChakraForPunch=0
					src.UserChargingForChakraKick=0
					src.ChargedChakraForKick=0
					src.overlays-='Icons/Jutsus/Chidori.dmi'
					src.overlays-='Icons/Jutsus/Rasengan2.dmi'
					src.overlays-='Icons/Jutsus/OdamaRasengan.dmi'
					src.overlays-='Icons/Jutsus/KatonRasengan.dmi'
					src.overlays-='Icons/Jutsus/FuutonRasengan.dmi'
					src.overlays-='Icons/Jutsus/Rasengan4.dmi'
					src.overlays-='New Icons(Con4)/PlanetaryRasengan(NEW).dmi'
					src.overlays-='New Icons(Con4)/Rasen-Shuriken(NEW).dmi'
					src.overlays-='Icons/Jutsus/Rasengan5.dmi'
					src.overlays-='Icons/Jutsus/Rasengan6.dmi'
					src.overlays-='Icons/Jutsus/Rasengan3.dmi'
					src.overlays-='Icons/Jutsus/Rasengan4.dmi'
					if(src.client)
						src.SaveK()
					return
mob/proc/Respawn()
	src<<"You wake up in the same spot after being badly wounded. Wait here for 2 minutes before leaving."
	src.Frozen=1;src.FrozenBind="Dead"
	src.sight &= ~(SEE_SELF|BLIND)
	src.icon_state = ""
	src.firing = 0
	src.knockedout = 0
	src.TakingPartInChuunins=0
	src.Endurance=src.MEndurance
	src.icon_state=""
	src.Guarding=0
	src.gencounter=0
	viewers(src)<<"[src] begins to come to.";
	src.SaveK();
	src.StruggleAgainstDeath=0;
	src.Struggle=0;src.Stun=0
//	src.health+=round(src.maxhealth/3);
//	if(src.health>src.maxhealth) src.health=src.maxhealth
//	src.stamina+=round(src.maxstamina/3);
//	if(src.stamina>src.maxstamina) src.stamina=src.maxstamina
//	src.chakra+=round(src.Mchakra/3);
//	if(src.chakra>src.Mchakra) src.chakra=src.Mchakra
	src.health=src.maxhealth
	src.stamina=src.maxstamina
	src.chakra=src.Mchakra
	if(src.Village=="Leaf")
		spawn(LeafBedTime)
			alert(src,"Do you wish to get moving now?","Yes")
			src.Frozen=0;src.FrozenBind="";src.Dead=0;src.resting=0
	else if(src.Village=="Rock")
		spawn(RockBedTime)
			alert(src,"Do you wish to get moving now?","Yes")
			src.Frozen=0;src.FrozenBind="";src.Dead=0;src.resting=0
	else if(src.Village=="Rain")
		spawn(RainBedTime)
			alert(src,"Do you wish to get moving now?","Yes")
			src.Frozen=0;src.FrozenBind="";src.Dead=0;src.resting=0
	else if(src.Village=="Sound")
		spawn(SoundBedTime)
			alert(src,"Do you wish to get moving now?","Yes")
			src.Frozen=0;src.FrozenBind="";src.Dead=0;src.resting=0
	else
		spawn(0)
			alert(src,"Do you wish to get moving now?","Yes")
			src.Frozen=0;src.FrozenBind="";src.Dead=0;src.resting=0
mob/proc/GotoVillageHospital()
	//Added in a spot for village war respawn
	if(src.villageWarParticipating == 1)
		src.villageWarRespawn()
		return
	if(src.z==35)
		if(src.Village!="Sound")
			return
		else if(src.Suspended)
			return
		else
			src.SoundVillateHospitalTele()
			return
	if(src.key=="Megum2")
		src.loc=locate(112,120,20)
		src<<"You wake up in the kitchen... Your heart sinks. Better make the men sandwiches..."
		return
	if(src.z==1) //Prison Maps
		if(src.Village!="Leaf")
			if(src.x>=150&&src.x<=185&&src.y>=103&&src.y<=118)
				src.PrisonTele()
				return
			else if(src.Village=="Leaf")
				src.LeafVillageHospitalTele()
				return
			else if(src.Village=="Rock")
				src.RockVillageHospitalTele()
				return
			else if(src.Village=="Rain")
				src.RainVillageHospitalTele()
				return
			else if(src.Village=="Sound")
				src.SoundVillateHospitalTele()
				return
			else if(src.Village=="Missing"||src.Village=="None")
				src.MissingHospitalTele()
				return
		else if(src.Suspended)
			src.PrisonTele()
			return
		else if(src.Village=="Leaf")
			src.LeafVillageHospitalTele()
			return
		else if(src.Village=="Rock")
			src.RockVillageHospitalTele()
			return
		else if(src.Village=="Rain")
			src.RainVillageHospitalTele()
			return
		else if(src.Village=="Sound")
			src.SoundVillateHospitalTele()
			return
		else if(src.Village=="Missing"||src.Village=="None")
			src.MissingHospitalTele()
		else if(src.Village=="Mist")
			src.MistHospitalTele()
//		else if(src.sevenswordsmenmember==1)
//			src.SMHospitalTele()
//			return
	else
		if(src.Village=="Leaf")
			src.LeafVillageHospitalTele()
			return
		else if(src.Village=="Rock")
			src.RockVillageHospitalTele()
			return
		else if(src.Village=="Rain")
			src.RainVillageHospitalTele()
			return
		else if(src.Village=="Sound")
			src.SoundVillateHospitalTele()
			return
		else if(src.Village=="Missing"||src.Village=="None"||src.Village=="Xiveres"||src.Village=="Akatsuki")
			src.MissingHospitalTele()
		else if(src.Village=="Mist")
			src.MistHospitalTele()
//		else if(src.sevenswordsmenmember==1)
//			src.SMHospitalTele()
		else if(src.Village=="Snow")
			src.SnowHospitalTele()
		else if(src.Village=="Cloud")
			src.CloudHospitalTele()
			return

mob/proc/PrisonTele()
	var/randbed=rand(1,6)
	if(randbed==1)
		src.loc=locate(153,115,1)
	if(randbed==2)
		src.loc=locate(158,115,1)
	if(randbed==3)
		src.loc=locate(163,115,1)
	if(randbed==4)
		src.loc=locate(153,109,1)
	if(randbed==5)
		src.loc=locate(158,109,1)
	if(randbed==6)
		src.loc=locate(163,109,1)
//	src.resting=1
	src<<"You wake up in the prison... Your heart sinks.."
//	src.Frozen=1
//	while(src.resting)
//		if(src.health<src.maxhealth)
//			src.health+=(src.maxhealth/50)
//		if(src.stamina<src.maxstamina)
//			src.stamina+=(src.maxstamina/75)
//		if(src.ChakraPool<src.MaxChakraPool)
//			src.ChakraPool+=(src.MaxChakraPool/210)
//		sleep(10)
mob/proc/MissingHospitalTele()
	var/randbed=rand(1,9)
	if(randbed==1)
		src.loc=locate(127,107,2)
	if(randbed==2)
		src.loc=locate(129,107,2)
	if(randbed==3)
		src.loc=locate(131,107,2)
	if(randbed==4)
		src.loc=locate(127,105,2)
	if(randbed==5)
		src.loc=locate(129,105,2)
	if(randbed==6)
		src.loc=locate(131,105,2)
	if(randbed==7)
		src.loc=locate(127,103,2)
	if(randbed==8)
		src.loc=locate(129,103,2)
	if(randbed==9)
		src.loc=locate(131,103,2)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/MistHospitalTele()
	var/randbed=rand(1,21)
	if(randbed==1)
		src.loc=locate(117,47,5)
	if(randbed==2)
		src.loc=locate(119,47,5)
	if(randbed==3)
		src.loc=locate(121,47,5)
	if(randbed==4)
		src.loc=locate(126,47,5)
	if(randbed==5)
		src.loc=locate(129,105,2)
	if(randbed==6)
		src.loc=locate(128,47,5)
	if(randbed==7)
		src.loc=locate(130,47,5)
	if(randbed==8)
		src.loc=locate(132,47,5)
	if(randbed==9)
		src.loc=locate(117,45,5)
	if(randbed==10)
		src.loc=locate(119,45,5)
	if(randbed==11)
		src.loc=locate(121,45,5)
	if(randbed==12)
		src.loc=locate(126,45,5)
	if(randbed==13)
		src.loc=locate(129,45,2)
	if(randbed==14)
		src.loc=locate(128,45,5)
	if(randbed==15)
		src.loc=locate(130,45,5)
	if(randbed==16)
		src.loc=locate(132,45,5)
	if(randbed==17)
		src.loc=locate(117,47,5)
	if(randbed==18)
		src.loc=locate(119,47,5)
	if(randbed==19)
		src.loc=locate(121,47,5)
	if(randbed==20)
		src.loc=locate(126,47,5)
	if(randbed==21)
		src.loc=locate(129,47,2)
	if(randbed==22)
		src.loc=locate(128,47,5)
	if(randbed==23)
		src.loc=locate(130,47,5)
	if(randbed==24)
		src.loc=locate(132,47,5)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/SMHospitalTele()
	var/randbed=rand(1,7)
	if(randbed==1)
		src.loc=locate(9,185,20)
	if(randbed==2)
		src.loc=locate(12,185,20)
	if(randbed==3)
		src.loc=locate(15,185,20)
	if(randbed==4)
		src.loc=locate(18,185,20)
	if(randbed==5)
		src.loc=locate(21,185,20)
	if(randbed==6)
		src.loc=locate(24,185,20)
	if(randbed==7)
		src.loc=locate(27,185,20)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/SnowHospitalTele()
	var/randbed=rand(1,6)
	if(randbed==1)
		src.loc=locate(186,179,22)
	if(randbed==2)
		src.loc=locate(188,17,22)
	if(randbed==3)
		src.loc=locate(191,179,22)
	if(randbed==4)
		src.loc=locate(191,177,22)
	if(randbed==5)
		src.loc=locate(188,177,22)
	if(randbed==6)
		src.loc=locate(186,177,22)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/CloudHospitalTele()
	var/randbed=rand(1,6)
	if(randbed==1)
		src.loc=locate(139,69,3)
	if(randbed==2)
		src.loc=locate(141,69,3)
	if(randbed==3)
		src.loc=locate(143,69,3)
	if(randbed==4)
		src.loc=locate(145,69,3)
	if(randbed==5)
		src.loc=locate(146,69,3)
	if(randbed==6)
		src.loc=locate(147,69,3)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/LeafVillageHospitalTele()
	var/randbed=rand(1,12)
	if(randbed==1)
		src.loc=locate(54,186,29)
	if(randbed==2)
		src.loc=locate(56,186,29)
	if(randbed==3)
		src.loc=locate(58,186,29)
	if(randbed==4)
		src.loc=locate(54,184,29)
	if(randbed==5)
		src.loc=locate(56,184,29)
	if(randbed==6)
		src.loc=locate(58,184,29)
	if(randbed==7)
		src.loc=locate(54,182,29)
	if(randbed==8)
		src.loc=locate(56,182,29)
	if(randbed==9)
		src.loc=locate(58,182,29)
	if(randbed==10)
		src.loc=locate(54,180,29)
	if(randbed==11)
		src.loc=locate(56,180,29)
	if(randbed==12)
		src.loc=locate(58,180,29)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/RockVillageHospitalTele()
	var/randbed=rand(1,20)
	if(randbed==1)
		src.loc=locate(93,178,29)
	if(randbed==2)
		src.loc=locate(93,176,29)
	if(randbed==3)
		src.loc=locate(93,174,29)
	if(randbed==4)
		src.loc=locate(93,172,29)
	if(randbed==5)
		src.loc=locate(96,178,29)
	if(randbed==6)
		src.loc=locate(96,176,29)
	if(randbed==7)
		src.loc=locate(96,174,29)
	if(randbed==8)
		src.loc=locate(96,172,29)
	if(randbed==9)
		src.loc=locate(99,178,29)
	if(randbed==10)
		src.loc=locate(99,176,29)
	if(randbed==11)
		src.loc=locate(99,174,29)
	if(randbed==12)
		src.loc=locate(99,172,29)
	if(randbed==13)
		src.loc=locate(102,178,29)
	if(randbed==14)
		src.loc=locate(102,176,29)
	if(randbed==15)
		src.loc=locate(102,174,29)
	if(randbed==16)
		src.loc=locate(102,172,29)
	if(randbed==17)
		src.loc=locate(105,178,29)
	if(randbed==18)
		src.loc=locate(105,176,29)
	if(randbed==19)
		src.loc=locate(105,174,29)
	if(randbed==20)
		src.loc=locate(105,172,29)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/RainVillageHospitalTele()
	var/randbed=rand(1,9)
	if(randbed==1)
		src.loc=locate(101,71,29)
	if(randbed==2)
		src.loc=locate(101,69,29)
	if(randbed==3)
		src.loc=locate(101,67,29)
	if(randbed==4)
		src.loc=locate(105,71,29)
	if(randbed==5)
		src.loc=locate(105,69,29)
	if(randbed==6)
		src.loc=locate(105,67,29)
	if(randbed==7)
		src.loc=locate(107,71,29)
	if(randbed==8)
		src.loc=locate(107,69,29)
	if(randbed==9)
		src.loc=locate(107,67,29)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)
mob/proc/SoundVillateHospitalTele()
	var/randbed=rand(1,18)
	if(randbed==1)
		src.loc=locate(140,40,21)
	if(randbed==2)
		src.loc=locate(142,40,21)
	if(randbed==3)
		src.loc=locate(144,40,21)
	if(randbed==4)
		src.loc=locate(147,40,21)
	if(randbed==5)
		src.loc=locate(151,40,21)
	if(randbed==6)
		src.loc=locate(149,40,21)
	if(randbed==7)
		src.loc=locate(140,38,21)
	if(randbed==8)
		src.loc=locate(142,38,21)
	if(randbed==9)
		src.loc=locate(144,38,21)
	if(randbed==10)
		src.loc=locate(147,38,21)
	if(randbed==11)
		src.loc=locate(151,38,21)
	if(randbed==12)
		src.loc=locate(140,36,21)
	if(randbed==13)
		src.loc=locate(142,36,21)
	if(randbed==14)
		src.loc=locate(144,36,21)
	if(randbed==15)
		src.loc=locate(147,36,21)
	if(randbed==16)
		src.loc=locate(151,36,21)
	if(randbed==17)
		src.loc=locate(149,36,21)
	if(randbed==18)
		src.loc=locate(149,38,21)
//	src.resting=1
	src<<"You rest in the bed."
//	src.Frozen=1
	while(src.resting)
		if(src.health<src.maxhealth)
			src.health+=(src.maxhealth/50)
		if(src.stamina<src.maxstamina)
			src.stamina+=(src.maxstamina/75)
		if(src.ChakraPool<src.MaxChakraPool)
			src.ChakraPool+=(src.MaxChakraPool/210)
		sleep(10)

mob/proc
	VariablesTakeAway()
		src.points=0
		src.screwed=0;src.FrozenBind=""
		src.resting=0;src.Frozen=0;src.firing=0
		src.caught=0;src.Shibari=0;src.kubi=0;return
mob/proc//Temporary
	SDelAllJutsu()
		for(var/obj/Nara/Shibari/K in world)
			if(K.Owner==src)
				del(K)
		for(var/obj/Jutsu/Elemental/Hyouton/DemonMirror/S in world)
			if(S.Owner==src)
				src.hyoushou=0
				del(S)
		for(var/obj/Jutsu/Elemental/Shoton/CrystalLabyrinth/S in world)
			if(S.Owner==src)
				src.Labyrinth=0
				del(S)
		return
mob/proc
	FindLoc()
		if(!src)
			return
		FindLoc
		if(src.Village=="Leaf")
			var/ranx=rand(20,140)
			var/rany=rand(20,140)
			src.loc=locate(ranx,rany,2) //For the Leaf Village
			for(var/turf/T in range(0,src))
				if(T.density)
					goto FindLoc
				else
					src<<"good"
		if(src.Village=="Rock")
			var/ranx=rand(40,140)
			var/rany=rand(90,180)
			src.loc=locate(ranx,rany,14) //For the Leaf Village
			for(var/turf/T in range(0,src))
				if(T.density)
					goto FindLoc
				else
					src<<"good"
mob/var/tmp/DragPerson = "None"
mob/var/beingdragged = 0
mob/var/tmp/awokefromdrag=0
proc/Dragging(mob/M,mob/A)
	while(A.DragPerson!="None"&&A.stamina>0&&A.chakra>0&&!M.awokefromdrag&&M.knockedout||A.DragPerson!="None"&&A.stamina>0&&A.chakra>0&&M.Dead)
		var/turf/T = get_step(A,turn(A.dir,180))
		if(!T.density)
			M.loc=T
		/*if(A.dir==NORTH)
			M.loc = locate(A.x,A.y-1,A.z)
		if(A.dir==SOUTH)
			M.loc = locate(A.x,A.y+1,A.z)
		if(A.dir==WEST)
			M.loc = locate(A.x+1,A.y,A.z)
		if(A.dir==EAST)
			M.loc = locate(A.x-1,A.y,A.z)
		if(A.dir==NORTHWEST)
			M.loc = locate(A.x+1,A.y-1,A.z)
		if(A.dir==NORTHEAST)
			M.loc = locate(A.x-1,A.y-1,A.z)
		if(A.dir==SOUTHWEST)
			M.loc = locate(A.x+1,A.y+1,A.z)
		if(A.dir==SOUTHEAST)
			M.loc = locate(A.x-1,A.y+1,A.z)*/
		sleep(1)
	A<<"You drop [M]."
	oviewers(A)<<"[A] drops [M]."
	A.DragPerson="None"
	M.beingdragged=0
	M.awokefromdrag=0
	return
mob/GainedAfterLogIn/verb/Drag()
	if(usr.KBunshinOn)
		var/A=usr.controlled
		usr=A
	else
		usr=usr
	if(usr.DragPerson!="None")
		usr.DragPerson="None"
		return
	for(var/mob/M in get_step(src,src.dir))
		if(!M.knockedout&&M.Status!="Asleep")
			src<<"You can't drag an awake person!"
			return
		else if(M.resting!=0)
			return
		else if(usr==global.contestantOne||usr==global.contestantTwo)
			usr<<"You can't use this while in an arena match."
			return
		else
			viewers(usr)<<"[src] grabs ahold of [M] and begins dragging him."
			usr.DragPerson = "[M.name]"
			spawn() Dragging(M,usr)
			M.beingdragged=1
			break

mob/proc/Dragz()
	if(src.DragPerson!="None")
		src.DragPerson="None"
		return
	for(var/mob/M in get_step(src,src.dir))
		if(!M.knockedout)
			src<<"You can't drag an awake person!"
			return
		else
			viewers(src)<<"[src] grabs ahold of [M] and begins dragging him."
			src.DragPerson = "[M.name]"
			spawn() Dragging(M,src)
			M.beingdragged=1
			break
mob/proc
	IndraAwaken()
		src.TaiSkill+=10;src.NinSkill+=10;src.GenSkill+=10;src.MEndurance+=50
		src.Endurance=src.MEndurance
		src.Indra+=1;src.WakeUp();src.deathcount=0;src<<"You feel a strong willed Spirit begin to take over and empower you.";return
mob/proc
	AsuraAwaken()
		src.MEndurance+=100
		src.Endurance=src.MEndurance
		src.LearnedJutsus+=new /obj/SkillCards/RikudouSageMode()
		src.LearnedJutsus+=new /obj/SkillCards/RikudouSageAura()
		src.Ashura+=1;src.WakeUp();src.deathcount=0;src<<"You feel a strong willed Spirit begin to take over and empower you.";return