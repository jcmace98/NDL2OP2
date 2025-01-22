mob/var/ElementalPoints = 50
mob/var/ElementalPointDeduction=0
mob/var/tmp/TalkingToElementalTeacher=0

mob/New_Teachers/
	//Katon
	Katon_Fire_Master
		name = "Adroushan"
		CNNPC = 1
		health = 9999999999999999999
		Village = "Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Shirt+=rgb(61,100,60)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"[src]: I am the one true Master of Katon in this land."
			if(usr.FireE)
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(83,35,20)
				usr<<"[src]: What jutsu would you like to learn?"
				usr.Frozen=0
				return
		/*	else if(usr.TalkingToElementalTeacher)
			//	if(!usr.Frozen)
			//		usr<<"Looks like we caught some bug abuse..."
			//		sleep(20)
			/		world<<"<b><font color=red><TT>Server: Caught [usr] in an attempt to gain multiple 'first' elements by unfreezing themselves and talking to another teacher while leaving the previous pop up open.</TT></font></b>"
			//		sleep(20)
			//		Bans:Add(usr.key)
			//		world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [usr.key] has been Key-Banned by server.</font>"
			//		text2file("[time2text(world.realtime)]: [usr.key] was Key Banned by server for attempted bug abuse.<BR>","GMlog.html")
			//		BanSave()
					del(usr)
				else
					return*/
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to become a Apperentice of Katon?") in list ("Yes, I want to burn my enemies down.","Other Elemental powers call me.."))
					if("Other Elemental powers call me..")
						usr<<"[src]: I see, your destiny does not burn so brightly"
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0
						return
					if("Yes, I want to burn my enemies down.")
						usr<<"[src]: Well answer me this."
						var/katonknow = input("[src]: 'Feed me and I live, give me drink and I die. What am I?'")
						if(findtext(katonknow, "Fire",1,0))
							usr<<"[src]: Very wise, I shall grant you the power of Katon."
							if(usr.ElementalPoints < 10)
								usr<<"[src]: I am afraid you are not capable of learning the power of Katon."
								usr.Frozen = 0
								usr.TalkingToElementalTeacher=0
								return
							else
								usr<<"[src]: Your future is burning brightly."
								sleep(11)
								usr<<"[usr] has begun training the Katon Element"
								sleep(15)
								usr<<"[src]: Let's see how many Chakra Natures you have."
								var/count=0
								if(usr.FireE)
									count+=1
								if(usr.WaterE)
									count+=1
								if(usr.WindE)
									count+=1
								if(usr.EarthE)
									count+=1
								if(usr.LightningE)
									count+=1
								if(count == 0)
									usr<<"[src]: So this is your first element."
									sleep(5)
									usr<<"[src]: Now watch very closely."
									usr.Frozen = 1
									sleep(20)
									usr<<"[src]: Demonstrates Fire Chakara."
									var/image/I=image('Icons/Jutsus/KatonTechniques.dmi',src,"Demonstrate Fire",5,SOUTH)
									usr<<I
									sleep(100)
									del(I)
									usr<<"[usr] has learned how to utilize Fire Chakra!"
									//if(usr.Clan=="Uchiha")
									//	usr<<"[src]: You did well to make this your first element.."
									//else
									//	usr.ElementalPoints-=0
									usr.FireE=1
									usr.Frozen = 0
									usr.TalkingToElementalTeacher=0
								else
									usr<<"[src]: Alright, let's teach you!"
									usr.TalkingToElementalTeacher=0
									var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
									if(usr.WaterE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.LightningE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.EarthE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.WindE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
										usr<<"[src]: You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									if (usr.ElementalPoints > 10)
										usr.LearnJutsu("Fire Chakra",AmountofExp,"FireChakra","The Fire Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform fire techniques. These techniques primarily hit health and stamina.","Ninjutsu")
										usr.ElementalPointDeduction = 10
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									else
										usr<<"[src]: I am afraid you dont have the ability to learn this Element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
								usr.TalkingToElementalTeacher=0
	//Suiton
	Suiton_Water_Master
		name = "Aerwyna "
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi';Shirt+=rgb(55,41,122)
				var/Hair='Icons/New Base/Hair/KiraH.dmi';Hair+=rgb(0,0,100)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			if(usr.WaterE)
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(113,34,20)
				usr<<"[src]: What jutsu would you like to learn?"
				usr.Frozen=0
				return
		/*	else if(usr.TalkingToElementalTeacher)
				if(!usr.Frozen)
					usr<<"Looks like we caught some bug abuse..."
					sleep(20)
					world<<"<b><font color=red><TT>Server: Caught [usr] in an attempt to gain multiple 'first' elements by unfreezing themselves and talking to another teacher while leaving the previous pop up open.</TT></font></b>"
					sleep(20)
					Bans:Add(usr.key)
					world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [usr.key] has been Key-Banned by server.</font>"
					text2file("[time2text(world.realtime)]: [usr.key] was Key Banned by server for attempted bug abuse.<BR>","GMlog.html")
					BanSave()
					del(usr)
				else
					return*/
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to become a Apperentice of Suiton?") in list ("Yes, I want to wash my enemies away.","Other Elemental powers call me.."))
					if("Other Elemental powers call me..")
						usr<<"[src]: I see, your destiny is washing away.."
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0
						return
					if("Yes, I want to wash my enemies away.")
						usr<<"[src]: Well answer me this."
						var/katonknow = input("[src]: 'What runs and has no feet, roars but has no mouth?'")
						if(findtext(katonknow, "Water",1,0))
							usr<<"[src]: Very wise, I shall grant you the power of Suiton."
							if(usr.ElementalPoints < 10)
								usr<<"[src]: I am afraid you are not capitable of learning the power of Suiton."
								usr.Frozen = 0
								usr.TalkingToElementalTeacher=0
								return
							else
								usr<<"[src]: Your destiny is as deep as the ocean."
								usr<<"[usr] has begin training the Suiton Element"
								usr<<"[src]: Let's see how many Chakra Natures you have."
								var/count=0
								if(usr.FireE)
									count+=1
								if(usr.WaterE)
									count+=1
								if(usr.WindE)
									count+=1
								if(usr.EarthE)
									count+=1
								if(usr.LightningE)
									count+=1
								if(count == 0)
									usr<<"[src]: So this is your first element."
									sleep(5)
									usr<<"[src]: Now watch very closely."
									usr.Frozen = 1
									sleep(20)
									usr<<"[src]: Demonstrates Water Chakra."
									var/image/I=image('Icons/Jutsus/SuitonTechniques.dmi',src,"Demonstrate Water",5,SOUTH)
									usr<<I
									sleep(50)
									del(I)
									usr<<"[usr] has learned how to utilize Water Chakra!"
									if(usr.Clan=="Hoshigaki"||usr.Clan=="Kusakin"||usr.Clan=="Shiroi")
										usr<<"[src]: You did well to make this your first element.."
										usr.ElementalPoints-=0
									else
										usr.ElementalPoints-=0
									usr.WaterE=1
									usr.Frozen = 0
									usr.TalkingToElementalTeacher=0
								else
									usr<<"[src]: Alright, let's teach you!";
									var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
									if(usr.WaterE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.LightningE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.EarthE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.WindE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
										usr<<"[src]: You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									if (usr.ElementalPoints > 10)
										usr.LearnJutsu("Water Chakra",AmountofExp,"WaterChakra","The Water Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Water-based techniques. These techniques primarily hit stamina.","Ninjutsu")
										usr.ElementalPointDeduction = 10
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									else
										usr<<"[src]: I am afraid you dont have the ability to learn this Element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
								usr.TalkingToElementalTeacher=0


	//Fuuton
	Fuuton_Wind_Master
		name = "Harmattan"
		Village="Rock"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SpikedPonytailH.dmi'
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(128,064,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			if(usr.WindE)
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(132,59,20)
				usr<<"[src]: What jutsu would you like to learn?"
				usr.Frozen=0
				return
		/*	else if(usr.TalkingToElementalTeacher)
				if(!usr.Frozen)
					usr<<"Looks like we caught some bug abuse..."
					sleep(20)
					world<<"<b><font color=red><TT>Server: Caught [usr] in an attempt to gain multiple 'first' elements by unfreezing themselves and talking to another teacher while leaving the previous pop up open.</TT></font></b>"
					sleep(20)
					Bans:Add(usr.key)
					world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [usr.key] has been Key-Banned by server.</font>"
					text2file("[time2text(world.realtime)]: [usr.key] was Key Banned by server for attempted bug abuse.<BR>","GMlog.html")
					BanSave()
					del(usr)
				else
					return*/
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to become a Apperentice of Fuuton?") in list ("Yes, I want to blow my enemies away.","Other Elemental powers call me.."))
					if("Other Elemental powers call me..")
						usr<<"[src]: I see, your destiny is washing away.."
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0
						return
					if("Yes, I want to blow my enemies away.")
						usr<<"[src]: Well answer me this."
						var/katonknow = input("[src]: 'I pass before the sun, yet make no shadow.'")
						if(findtext(katonknow, "Wind",1,0))
							usr<<"[src]: Very wise, I shall grant you the power of Fuuton."
							if(usr.ElementalPoints < 10)
								usr<<"[src]: I am afraid you are not capitable of learning the power of Fuuton."
								usr.Frozen = 0
								usr.TalkingToElementalTeacher=0
								return
							else
								usr<<"[src]: Your destiny will roar like the mighty winds."
								usr<<"[usr] has begin training the Fuuton Element"
								usr<<"[src]: Let's see how many Chakra Natures you have."
								var/count=0
								if(usr.FireE)
									count+=1
								if(usr.WaterE)
									count+=1
								if(usr.WindE)
									count+=1
								if(usr.EarthE)
									count+=1
								if(usr.LightningE)
									count+=1
								if(count == 0)
									usr<<"[src]: So this is your first element."
									sleep(5)
									usr<<"[src]: Now watch very closely."
									usr.Frozen = 1
									sleep(20)
									usr<<"[src]: Demonstrates Wind Chakra."
									var/image/I=image('Icons/Jutsus/FuutonTechniques.dmi',src,"Demonstrate Wind",5,SOUTH)
									usr<<I
									sleep(100)
									del(I)
									usr<<"[usr] has learned how to utilize Wind Chakra!"
									if(usr.Clan=="Kiro"||usr.Clan=="Shiroi")
										usr<<"[src]: You did well to make this your first element.."
										usr.ElementalPoints-=0
									else
										usr.ElementalPoints-=0
									usr.WindE=1
									usr.Frozen = 0
									usr.TalkingToElementalTeacher=0
								else
									usr<<"[src]: How many other elements you have mastered"
								/*	if(usr.WaterE)
										if(usr.SuitonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Fuuton? Get some more Knowledge with Suiton!";return
									if(usr.FireE)
										if(usr.KatonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Fuuton? Get some more Knowledge with Katon!";return
									if(usr.EarthE)
										if(usr.DotonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Fuuton? Get some more Knowledge with Doton!";return
									if(usr.LightningE)
										if(usr.RaitonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Fuuton? Get some more Knowledge with Raiton!";return*/
									usr<<"[src]: Alright, let's teach you!";
									var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
									if(usr.WaterE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.LightningE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.EarthE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.WindE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
										usr<<"[src]: You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									if (usr.ElementalPoints > 10)
										usr.LearnJutsu("Wind Chakra",AmountofExp,"WindChakra","The Wind Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Wind-based techniques. These techniques primarily hit health.","Ninjutsu")
										usr.ElementalPointDeduction = 10
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									else
										usr<<"[src]: I am afraid you dont have the ability to learn this Element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
								usr.TalkingToElementalTeacher=0

	//Doton
	Doton_Earth_Master
		name = "Jaeger"
		CNNPC = 1
		health = 9999999999999999999
		Village = "Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"[src]: I am the one true Master of Doton in this land."
			if(usr.EarthE)
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(108,60,20)
				usr<<"[src]: What jutsu would you like to learn?"
				usr.Frozen=0
				return
		/*	else if(usr.TalkingToElementalTeacher)
				if(!usr.Frozen)
					usr<<"Looks like we caught some bug abuse..."
					sleep(20)
					world<<"<b><font color=red><TT>Server: Caught [usr] in an attempt to gain multiple 'first' elements by unfreezing themselves and talking to another teacher while leaving the previous pop up open.</TT></font></b>"
					sleep(20)
					Bans:Add(usr.key)
					world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [usr.key] has been Key-Banned by server.</font>"
					text2file("[time2text(world.realtime)]: [usr.key] was Key Banned by server for attempted bug abuse.<BR>","GMlog.html")
					BanSave()
					del(usr)
				else
					return*/
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to become a Apperentice of Doton?") in list ("Yes, I want to bury my enemies.","Other Elemental powers call me.."))
					if("Other Elemental powers call me..")
						usr<<"[src]: I see, your destiny is as cold as stone"
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0
						return
					if("Yes, I want to bury my enemies.")
						usr<<"[src]: Well answer me this."
						var/katonknow = input("[src]: 'I am foundation to all, yet I am number three. Without me you would fall, What am I?'")
						if(findtext(katonknow, "Earth",1,0))
							usr<<"[src]: Very wise, I shall grant you the power of Doton."
							if(usr.ElementalPoints < 10)
								usr<<"[src]: I am afraid you are not capitable of learning the power of Doton."
								usr.Frozen = 0
								usr.TalkingToElementalTeacher=0
								return
							else
								usr<<"[src]: Your future is written in stone."
								usr<<"[usr] has begin training the Doton Element"
								usr<<"[src]: Let's see how many Chakra Natures you have."
								var/count=0
								if(usr.FireE)
									count+=1
								if(usr.WaterE)
									count+=1
								if(usr.WindE)
									count+=1
								if(usr.EarthE)
									count+=1
								if(usr.LightningE)
									count+=1
								if(count == 0)
									usr<<"[src]: So this is your first element."
									sleep(5)
									usr<<"[src]: Now watch very closely."
									usr.Frozen = 1
									sleep(20)
									usr<<"[src]: Demonstrates Earth Chakra."
									src.dir=WEST
									src.DotonDorukiGaeshi()
									sleep(20)
									src.dir=SOUTH
									sleep(20)
									usr<<"[usr] has learned how to utilize Earth Chakra!"
									if(usr.Clan=="Iwazuka"||usr.Clan=="Kusakin"||usr.Clan=="Sabaku")
										usr<<"[src]: You did well to make this your first element.."
										usr.ElementalPoints-=0
									else
										usr.ElementalPoints-=0
									usr.EarthE=1
									usr.Frozen = 0
									usr.TalkingToElementalTeacher=0
								else
									usr<<"[src]: How many other elements you have mastered"
								/*	if(usr.WaterE)
										if(usr.SuitonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Doton? Get some more Knowledge with Suiton!";return
									if(usr.WindE)
										if(usr.FuutonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Doton? Get some more Knowledge with Fuuton!";return
									if(usr.FireE)
										if(usr.KatonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Doton? Get some more Knowledge with Katon!";return
									if(usr.LightningE)
										if(usr.RaitonKnowledge<1000)
											usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Doton? Get some more Knowledge with Raiton!";return
									usr<<"[src]: Alright, let's teach you!";*/
									var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
									if(usr.WaterE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.LightningE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.EarthE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.WindE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
										usr<<"[src]: You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									if (usr.ElementalPoints > 10)
										usr.LearnJutsu("Earth Chakra",AmountofExp,"EarthChakra","The Earth Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform earth-based techniques. These techniques primarily hit stamina.","Ninjutsu")
										usr.ElementalPointDeduction = 10
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									else
										usr<<"[src]: I am afraid you dont have the ability to learn this Element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
								usr.TalkingToElementalTeacher=0

	//Raiton
	//Chidori Skill tree is on hold as well as gian
	Raiton_Lightning_Teacher
		name = "Levina"
		CNNPC = 1
		health = 9999999999999999999
		Village = "Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KakashiH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,200)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Shirt+=rgb(61,100,60)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"[src]: I am the one true Master of Raiton in this land."
			if(usr.LightningE)
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(62,97,20)
				usr<<"[src]: What jutsu would you like to learn?"
				usr.Frozen=0
				return
		/*	else if(usr.TalkingToElementalTeacher)
				if(!usr.Frozen)
					usr<<"Looks like we caught some bug abuse..."
					sleep(20)
					world<<"<b><font color=red><TT>Server: Caught [usr] in an attempt to gain multiple 'first' elements by unfreezing themselves and talking to another teacher while leaving the previous pop up open.</TT></font></b>"
					sleep(20)
					Bans:Add(usr.key)
					world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [usr.key] has been Key-Banned by server.</font>"
					text2file("[time2text(world.realtime)]: [usr.key] was Key Banned by server for attempted bug abuse.<BR>","GMlog.html")
					BanSave()
					del(usr)
				else
					return*/
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to become a Apperentice of Raiton?") in list ("Yes, I want to zap my enemies .","Other Elemental powers call me.."))
					if("Other Elemental powers call me..")
						usr<<"[src]: I see, your destiny looks shockingly bad.."
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0
						return
					if("Yes, I want to zap my enemies .")
						usr<<"[src]: Well answer me this."
						var/katonknow = input("[src]: 'I am, in truth, a yellow fork, From tables in the sky, By inadvertent fingers dropped, The awful cutlery. Of mansions never quite disclosed, And never quite concealed, The apparatus of the dark, To ignorance revealed.?'")
						if(findtext(katonknow, "Lightning",1,0))
							usr<<"[src]: Very wise, I shall grant you the power of Raiton."
							if(usr.ElementalPoints < 10)
								usr<<"[src]: I am afraid you are not capitable of learning the power of Raiton."
								usr.Frozen = 0
								usr.TalkingToElementalTeacher=0
								return
							else
								usr<<"[src]: Your future is flashing brightly."
								usr<<"[usr] has begin training the Raiton Element"
								usr<<"[src]: Let's see how many Chakra Natures you have."
								var/count=0
								if(usr.FireE)
									count+=1
								if(usr.WaterE)
									count+=1
								if(usr.WindE)
									count+=1
								if(usr.EarthE)
									count+=1
								if(usr.LightningE)
									count+=1
								if(count == 0)
									usr<<"[src]: So this is your first element."
									sleep(5)
									usr<<"[src]: Now watch very closely."
									usr.Frozen = 1
									sleep(20)
									usr<<"[src]: Demonstrates Lightning Chakara."
									var/image/I=image('Icons/Jutsus/RaitonTechniques.dmi',src,"Demonstrate Lightning",5,SOUTH)
									usr<<I
									sleep(100)
									del(I)
									usr<<"[usr] has learned how to utilize Lightning Chakra!"
									if(usr.Clan=="Yotsuki")
										usr<<"[src]: You did well to make this your first element.."
										usr.ElementalPoints-=0
									else
										usr.ElementalPoints-=0
									usr.LightningE=1
									usr.Frozen = 0
									usr.TalkingToElementalTeacher=0
								else
									usr<<"[src]: How many other elements you have mastered"
									usr<<"[src]: Alright, let's teach you!";
									var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
									if(usr.WaterE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.LightningE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.EarthE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.WindE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
										usr<<"[src]: You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									if (usr.ElementalPoints > 10)
										usr.LearnJutsu("Lightning Chakra",AmountofExp,"LightningChakra","The Lightning Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Lightning-based techniques. These techniques primarily hit health.","Ninjutsu")
										usr.ElementalPointDeduction = 10
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									else
										usr<<"[src]: I am afraid you dont have the ability to learn this Element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
								usr.TalkingToElementalTeacher=0

	//Black Raiton
	//Chidori Skill tree is on hold as well as gian
	Black_Raiton_Lightning_Teacher
		name = "Donju"
		CNNPC = 1
		health = 9999999999999999999
		Village = "Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KakashiH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,200)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Shirt+=rgb(61,100,60)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"[src]: I am the one true Master of Raiton in this land."
			usr.Frozen = 1
			if(usr.LightningE)
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(62,97,20)
				usr<<"[src]: What jutsu would you like to learn?"
				usr.Frozen=0
				return
			else if(usr.TalkingToElementalTeacher)
				if(!usr.Frozen)
					usr<<"Looks like we caught some bug abuse..."
					sleep(20)
					world<<"<b><font color=red><TT>Server: Caught [usr] in an attempt to gain multiple 'first' elements by unfreezing themselves and talking to another teacher while leaving the previous pop up open.</TT></font></b>"
					sleep(20)
					Bans:Add(usr.key)
					world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [usr.key] has been Key-Banned by server.</font>"
					text2file("[time2text(world.realtime)]: [usr.key] was Key Banned by server for attempted bug abuse.<BR>","GMlog.html")
					BanSave()
					del(usr)
				else
					return
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to become a Apperentice of Black Raiton?") in list ("Yes, I want to zap my enemies .","Other Elemental powers call me.."))
					if("Other Elemental powers call me..")
						usr<<"[src]: I see, your destiny looks shockingly bad.."
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0
						return
					if("Yes, I want to zap my enemies .")
						usr<<"[src]: Well answer me this."
						var/katonknow = input("[src]: 'I am, in truth, a yellow fork, From tables in the sky, By inadvertent fingers dropped, The awful cutlery. Of mansions never quite disclosed, And never quite concealed, The apparatus of the dark, To ignorance revealed.?'")
						if(findtext(katonknow, "Black Lightning",1,0))
							usr<<"[src]: Very wise, I shall grant you the power of Raiton."
							if(usr.ElementalPoints < 10)
								usr<<"[src]: I am afraid you are not capitable of learning the power of Black Raiton."
								usr.Frozen = 0
								usr.TalkingToElementalTeacher=0
								return
							else
								usr<<"[src]: Your future is flashing brightly."
								usr<<"[usr] has begin training the Black Raiton Element"
								usr<<"[src]: Let's see how many Chakra Natures you have."
								var/count=0
								if(usr.FireE)
									count+=1
								if(usr.WaterE)
									count+=1
								if(usr.WindE)
									count+=1
								if(usr.EarthE)
									count+=1
								if(usr.LightningE)
									count+=1
								if(count == 0)
									usr<<"[src]: So this is your first element."
									sleep(5)
									usr<<"[src]: Now watch very closely."
									usr.Frozen = 1
									sleep(20)
									usr<<"[src]: Demonstrates Black Lightning Chakara."
									var/image/I=image('Icons/Jutsus/BlackRaitonTechniques.dmi',src,"Demonstrate Lightning",5,SOUTH)
									usr<<I
									sleep(100)
									del(I)
									usr<<"[usr] has learned how to utilize Lightning Chakra!"
									if(usr.Clan=="Yotsuki")
										usr<<"[src]: You did well to make this your first element.."
										usr.ElementalPoints-=0
									else
										usr.ElementalPoints-=0
									usr.LightningE=1
									usr.Frozen = 0
									usr.TalkingToElementalTeacher=0
								else
									usr<<"[src]: How many other elements you have mastered"
									usr<<"[src]: Alright, let's teach you!";
									var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
									if(usr.WaterE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.LightningE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.EarthE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.WindE)
										AmountofExp+=0;NinjutsuKnowledgeReq+=200
									if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
										usr<<"[src]: You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									if (usr.ElementalPoints > 15)
										usr.LearnJutsu("Lightning Chakra",AmountofExp,"LightningChakra","The Black Lightning Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Black Lightning-based techniques. These techniques primarily hit health.","Ninjutsu")
										usr.ElementalPointDeduction = 15
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
									else
										usr<<"[src]: I am afraid you dont have the ability to learn this Element."
										usr.Frozen = 0
										usr.TalkingToElementalTeacher=0
										return
								usr.TalkingToElementalTeacher=0










