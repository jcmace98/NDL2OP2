mob/var/tmp/Skill_Tree=0
mob/var/tmp/clicking=0
mob/var/DarkFlames=0
obj/PassiveUp
	icon='Icons/Jutsus/Skillcards.dmi'
	icon_state="SwiftYes"
	layer=8

	pixel_y=32
	New()
		..()
		spawn(15)
			del(src)
mob/GainedAfterLogIn/verb
	WeaponSkill()
		set hidden=1
		if(usr.Skill_Tree||!usr.loggedin||!usr.cansave)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.Skill_Tree=0
			return
		else
			usr.EquipmentTree=0
			usr<<"Your view has changed, but you are still in the same spot."
			usr<<sound('SFX/click1.wav',0)
			usr.Skill_Tree=1
			client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			client.eye=locate(113,182,30)
			return
	ElementalView()
		set name="Check Element Info"
		set category="Commands"
		if(usr.Skill_Tree||!usr.loggedin||!usr.cansave)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.Skill_Tree=0
			return
		else
			usr.EquipmentTree=0
			usr<<"Your view has changed, but you are still in the same spot."
			usr<<sound('SFX/click1.wav',0)
			usr.Skill_Tree=1
			client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			client.eye=locate(34,13,30)
			return
	ElementalSkill()
		set hidden=1
		if(usr.Skill_Tree||!usr.loggedin||!usr.cansave)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.Skill_Tree=0
			return
		else
			usr.EquipmentTree=0
			usr<<"Your view has changed, but you are still in the same spot."
			usr<<sound('SFX/click1.wav',0)
			usr.Skill_Tree=1
			client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			client.eye=locate(68,182,30)
			return
	GenSkill()
		set hidden=1
		if(usr.Skill_Tree||!usr.loggedin||!usr.cansave)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.Skill_Tree=0
			return
		else
			usr.EquipmentTree=0
			usr<<"Your view has changed, but you are still in the same spot."
			usr<<sound('SFX/click1.wav',0)
			usr.Skill_Tree=1
			client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			client.eye=locate(159,182,30)
			return
	JutSkill()
		set hidden=1
		if(usr.Skill_Tree||!usr.loggedin||!usr.cansave)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.Skill_Tree=0
			return
		else
			usr.EquipmentTree=0
			usr<<"Your view has changed, but you are still in the same spot."
			usr<<sound('SFX/click1.wav',0)
			usr.Skill_Tree=1
			client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			client.eye=locate(10,182,1)
			return
	ClanSkill()
		set hidden=1
		if(usr.Skill_Tree||!usr.loggedin||!usr.cansave)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.Skill_Tree=0
			return
		else
			usr.EquipmentTree=0
			usr<<sound('SFX/click1.wav',0)
			if(src.Clan2!="")
				switch(input(usr,"What Clan tree?") in list ("Main Clan","Sub Clan"))
					if("Main Clan")
						if(usr.Clan=="Aburame")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(160,159,30);return
						if(usr.Clan=="Akimichi")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(114,135,30);return
						if(usr.Clan=="Fuuma")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,135,30);return
						if(usr.Clan=="Hoshigaki")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(22,135,30);return
						if(usr.Clan=="Hyuuga")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(22,159,30);return
						if(usr.Clan=="Inuzuka")
							usr<< "Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(114,159,30);return
						if(usr.Clan=="Iwazuka")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,111,30);return
						if(usr.Clan=="Kaguya")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(122,116,30);return
						if(usr.Clan=="Ketsueki")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(68,159,30);return
						if(usr.Clan=="Kumojin")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,159,30);return
						if(usr.Clan=="Shojin")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,182,30);return
						if(usr.Clan=="Kusakin")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(137,135,30);return
						if(usr.Clan=="Kyomou")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(91,135,30);return
						if(usr.Clan=="Nara")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(91,159,30);return
						if(usr.Clan=="Sabaku")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(160,135,30);return
						if(usr.Clan=="Shiroi")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,135,30);return
						if(usr.Clan=="Yotsuki")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(68,135,30);return
						if(usr.Clan=="Uchiha")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,159,30)
							usr.ClanPassives()
						if(usr.Clan=="Satou")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(92,119,30);return
						if(usr.Clan=="Yamanaka")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(29,145,20);return
					if("Sub Clan")
						if(usr.Clan2=="Aburame")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(160,159,30);return
						if(usr.Clan2=="Akimichi")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(114,135,30);return
						if(usr.Clan2=="Fuuma")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,135,30);return
						if(usr.Clan2=="Hoshigaki")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(22,135,30);return
						if(usr.Clan2=="Hyuuga")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(22,159,30);return
						if(usr.Clan2=="Inuzuka")
							usr<< "Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(114,159,30);return
						if(usr.Clan2=="Iwazuka")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,111,30);return
						if(usr.Clan2=="Kaguya")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(122,116,30);return
						if(usr.Clan2=="Ketsueki")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(68,159,30);return
						if(usr.Clan2=="Kumojin")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,159,30);return
						if(usr.Clan2=="Shojin")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,182,30);return
						if(usr.Clan2=="Kusakin")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(137,135,30);return
						if(usr.Clan2=="Kyomou")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(91,135,30);return
						if(usr.Clan2=="Nara")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(91,159,30);return
						if(usr.Clan2=="Sabaku")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(160,135,30);return
						if(usr.Clan2=="Shiroi")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,135,30);return
						if(usr.Clan2=="Yotsuki")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(68,135,30);return
						if(usr.Clan2=="Uchiha")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,159,30)
							usr.ClanPassives()
						if(usr.Clan2=="Satou")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(92,119,30);return
						if(usr.Clan2=="Yamanaka")
							usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(29,145,20);return
			else
				if(usr.Clan=="Aburame")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(160,159,30);return
				if(usr.Clan=="Akimichi")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(114,135,30);return
				if(usr.Clan=="Fuuma")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,135,30);return
				if(usr.Clan=="Hoshigaki")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(22,135,30);return
				if(usr.Clan=="Hyuuga")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(22,159,30);return
				if(usr.Clan=="Inuzuka")
					usr<< "Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(114,159,30);return
				if(usr.Clan=="Iwazuka")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,111,30);return
				if(usr.Clan=="Kaguya")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(122,116,30);return
				if(usr.Clan=="Ketsueki")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(68,159,30);return
				if(usr.Clan=="Kumojin")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,159,30);return
				if(usr.Clan=="Shojin")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(45,182,30);return
				if(usr.Clan=="Kusakin")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(137,135,30);return
				if(usr.Clan=="Kyomou")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(91,135,30);return
				if(usr.Clan=="Nara")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(91,159,30);return
				if(usr.Clan=="Sabaku")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(160,135,30);return
				if(usr.Clan=="Shiroi")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,135,30);return
				if(usr.Clan=="Yotsuki")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(68,135,30);return
				if(usr.Clan=="Uchiha")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(183,159,30)
					usr.ClanPassives()
				if(usr.Clan=="Satou")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(92,119,30);return
				if(usr.Clan=="Yamanaka")
					usr<<"Your view has changed, but you are still in the same spot.";usr.Skill_Tree=1;client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE;client.eye=locate(29,145,20);return

mob/proc
	ClanPassives()
		for(var/image/I in src.client.images)
			if(I.icon=='Icons/Jutsus/Skilltree.dmi')
				del(I)
		if(src.Clan=="Uchiha"||src.Clan2=="Uchiha")
			var/turf/Sharingan=locate("Sharingan Mastery");var/turf/Sharingan1=locate("Sharingan 1");var/turf/Sharingan2=locate("Sharingan 2");var/turf/Sharingan3=locate("Sharingan 3")
			var/turf/Haste=locate("Haste");var/turf/Goukakyuu=locate("Goukakyuu Mastery");var/turf/DarkFlames=locate("Dark Flames");var/turf/LoveHate=locate("Love and Hate")
			var/turf/Sleep=locate("Sleep");var/turf/Stakes=locate("Stakes");var/turf/Counter=locate("Counter");var/turf/Copy=locate("Copy")

			var/image/I1 = image('Icons/Jutsus/Skilltree.dmi',Sharingan,"Unavailable",110);var/image/I2 = image('Icons/Jutsus/Skilltree.dmi',Sharingan1,"Unavailable",110)
			var/image/I3 = image('Icons/Jutsus/Skilltree.dmi',Sharingan2,"Unavailable",110);var/image/I4 = image('Icons/Jutsus/Skilltree.dmi',Sharingan3,"Unavailable",110)
			var/image/I5 = image('Icons/Jutsus/Skilltree.dmi',Haste,"Unavailable",110);var/image/I6 = image('Icons/Jutsus/Skilltree.dmi',Goukakyuu,"Unavailable",110)
			var/image/I7 = image('Icons/Jutsus/Skilltree.dmi',DarkFlames,"Unavailable",110);var/image/I8 = image('Icons/Jutsus/Skilltree.dmi',LoveHate,"Unavailable",110)
			var/image/I9 = image('Icons/Jutsus/Skilltree.dmi',Sleep,"Unavailable",110);var/image/I10 = image('Icons/Jutsus/Skilltree.dmi',Stakes,"Unavailable",110)
			var/image/I11 = image('Icons/Jutsus/Skilltree.dmi',Counter,"Unavailable",110);var/image/I12 = image('Icons/Jutsus/Skilltree.dmi',Copy,"Unavailable",110)

			if(src.UchihaMastery>=1)
				I5.icon_state="";I6.icon_state=""
				if(src.UchihaMastery>=100)
					I5.icon_state="Achieved";I6.icon_state="Achieved"

			if(src.SharinganMastery>1)
				I1.icon_state="Achieved";I2.icon_state="Achieved";I3.icon_state=""
				if(src.SharinganMastery>=76)
					I3.icon_state="Achieved";I4.icon_state=""
					if(src.SharinganMastery>=121)
						I4.icon_state="Achieved";I9.icon_state="";I10.icon_state="";I11.icon_state="";I12.icon_state=""
						if(locate(/obj/SkillCards/Konsui) in src.LearnedJutsus)
							I9.icon_state="Achieved"
						if(locate(/obj/SkillCards/Kasegui) in src.LearnedJutsus)
							I10.icon_state="Achieved"
						if(locate(/obj/SkillCards/GenjutsuCounter) in src.LearnedJutsus)
							I11.icon_state="Achieved"
						if(locate(/obj/SkillCards/SharinganCopy) in src.LearnedJutsus)
							I12.icon_state="Achieved"

						if(I9.icon_state=="Achieved"&&I10.icon_state=="Achieved"&&I11.icon_state=="Achieved"&&I12.icon_state=="Achieved")
							I7.icon_state=""
							if(src.DarkFlames)
								I7.icon_state="Achieved";I8.icon_state=""
								if(src.LoveAndHate)
									I8.icon_state="Achieved"

			src<<I1;src<<I2;src<<I3;src<<I4;src<<I5;src<<I6;src<<I7;src<<I8;src<<I9;src<<I10;src<<I11;src<<I12
		else
			var/turf/Uchiha=locate("Uchiha Mastery")
			var/image/I = image('Icons/Jutsus/Skilltree.dmi',Uchiha,"Unavailable",110)
			src<<I


turf
	Skilltree
		icon = 'Icons/Jutsus/Skilltree.dmi'
		Unavailble
			icon_state="Unavailable"
			layer=MOB_LAYER+99
		Background
			icon='PNG/ST copy.PNG'
			layer =4
		Left_Right
			icon_state = "Left - Right"
			layer = MOB_LAYER+98
		Up_Down
			icon_state = "Up - Down"
			layer = MOB_LAYER+98
		Turn
			icon_state = "Turn"
			layer = MOB_LAYER+98
		JutsuTreeTai
			layer=MOB_LAYER+98
			icon='PNG/Hud/Taijutsu.png'
			Click()
				usr.EquipmentTree=0
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(10,159,1)
				usr<<sound('SFX/click1.wav',0)
		JutsuTreeNin
			layer=MOB_LAYER+98
			icon='PNG/Hud/Ninjutsu.png'
			Click()
				usr.EquipmentTree=0
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(33,159,1)
				usr<<sound('SFX/click1.wav',0)
		JutsuTreeGen
			layer=MOB_LAYER+98
			icon='PNG/Hud/Genjutsu.png'
			Click()
				usr.EquipmentTree=0
				usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
				usr.client.eye=locate(56,159,1)
				usr<<sound('SFX/click1.wav',0)
///////////////////////////////////////////////////////////////
//Basic Jutsu
////////////////////////////////////////////////////////////////////////////////////////////////
turf
	Skilltree/JutsuTree
		layer=MOB_LAYER+98
		icon='Icons/Hud/JutsuTree.dmi'
		Click()
			usr<<sound('SFX/click1.wav',0)
		BunshinTechnique
			name="Bunshin No Jutsu"
			icon_state="Bunshin"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/BunshinJutsu in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Bunshin No Jutsu",0,"BunshinJutsu","Bunshin No Jutsu is a basic clone technique that creates an image of yourself. It is not real but can be used for distraction purposes.","Ninjutsu")
		HengeTechnique
			name="Henge No Jutsu"
			icon_state="Henge"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/Henge in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Henge No Jutsu",0,"Henge","Henge No Jutsu is a basic ninja technique that disguises yourself in another's appearance.","Ninjutsu")
		KawaTechnique
			name="Kawarimi No Jutsu"
			icon_state="Subsitution"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/Kawarimi in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Kawarimi No Jutsu",0,"Kawarimi","Kawarimi No Jutsu is a basic jutsu that substitutes you with a log to escape harm.","Ninjutsu")
		ExpKawaTechnique
			name="Exploding Kawarimi No Jutsu"
			icon_state="ExpSubsitution"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/ExpKawarimi in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Exploding Kawarimi No Jutsu",0,"ExpKawarimi","Exploding Kawarimi No Jutsu is a more advanced substitution jutsu that replaces you with an exploding log.","Ninjutsu")
		ShunshinTechnique
			name="Shunshin No Jutsu"
			icon_state="Shunshin"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/Shushin in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Shushin No Jutsu",0,"Shushin","Shushin No Jutsu is a body flicker technique for high speed movement over a short distance.","Ninjutsu")
		NawanukeTechnique
			name="Escaping Skill"
			icon_state="Nawanuke"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/Nawanuke in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Escaping Skill",0,"Nawanuke","A basic Ninpo technique which allows a ninja to escape from wires. Very useful..","Ninjutsu")
		Choke
			name="Choke"
			icon_state="Choke"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/Choke in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Choke",0,"Choke","Choke is a powerful physical technique to pick up an opponent by the neck, and suffocate them.","Taijutsu")
		HiddenLotus//HiddenLotus
			name="Hidden Lotus"
			icon_state="Gate2"
			Click()
				var/list/P=usr.LearnedJutsus
				if(/obj/SkillCards/HiddenLotus in P)
					sd_Alert(usr, "You already know this technique!","[src.name]")
					return
				else if(usr.LimitGate!=1)
					usr<<"You need to learn the Fifth Gate to learn this jutsu!";return
				else
					usr.LearnJutsu("Hidden Lotus",0,"HiddenLotus","Hidden Lotus is a jutsu Requiring the use of Gates to use, the user is able to rush at the speed of light, destroying the Opponent's body like a pingpong ball.","Taijutsu")
		GateAssault//GateAssault
			name="Gates Assault"
			icon_state="Gate1"
			Click()
				var/list/P=usr.LearnedJutsus
				if(/obj/SkillCards/GateAssault in P)
					sd_Alert(usr, "You already know this technique!","[src.name]")
					return
				else if(usr.LifeGate!=1)
					usr<<"You need the Fourth gate to learn this jutsu!";return
				else
					usr.LearnJutsu("Gates Assault",0,"GateAssault","Gates Assault is a jutsu that allows you to beat your opponent with brutal Force at fast speed so they have no time to defend themselves.","Taijutsu")
		ChokeSlam
			name="Choke"
			icon_state="ChokeSlam"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/Choke in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else if(!(locate(/obj/SkillCards/Choke) in A))
					usr<<"You need to learn Choke before learning this Jutsu!";return
				else
				//	usr.LearnJutsu("Choke Slam",8500,"ChokeSlam","Choke is a powerful physical technique to pick up an opponent by the neck, and suffocate them, but by then slamming them, even more damage is caused!","Taijutsu")
		FingerPush
			name="Finger Push"
			icon_state="FingerPush"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/FingerPush in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					if(usr.rank!="Special Jounin"&&usr.rank!="Jounin"&&usr.rank!="Hokage"&&usr.rank!="Tsuchikage"&&usr.rank!="Otokami"&&usr.rank!="Amekoutei"&&usr.rank!="Raikage"&&usr.rank!="Mizukage"&&usr.rank!="Daimyou"&&usr.rank!="Sannin")
						usr<<"You need to be at least a Special Jounin to gain this jutsu.";return
					usr.LearnJutsu("Finger Push",0,"FingerPush","Finger Push is a physical technqiue that requires little effort but extreme taijutsu. Using one finger it flicks an opponent quickly across a large area very quickly, dealing small damage.","Taijutsu")
		ExplodingFormation
			name="Exploding Formation"
			icon_state="ExplodingFormation"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/ExplodingFormation in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Exploding Formation",0,"ExplodingFormation","Exploding Formation is a ninjutsu technique that explodes all of the user's Exploding Tags at the same time instead of seperately.","Ninjutsu")
		PersonSwapJutsu
			name="Person Swap Jutsu"
			icon_state="PerSubsitution"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/BodySwitch in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//		color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Person Swap Jutsu",0,"BodySwitch","The Person Swap Jutsu is a technique which allows you to swap positions quickly with another person granted that they are not skilled enough to stop you.","Ninjutsu")
		BunshinSubstitution
			name="Clone Substitution Jutsu"
			icon_state="Bunshin Swap"
			Click()
				var/list/A=usr.LearnedJutsus
				if(/obj/SkillCards/BunshinSubsitutionJutsu in A)
				//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
						color:white;}</style>"
					sd_Alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
					return
				else
					usr.LearnJutsu("Clone Substitution Jutsu",0,"BunshinSubsitutionJutsu","A quick substitution jutsu which creates a shadow clone to take your place while you are able to make a quick escape.","Ninjutsu")

////////////////////////////////////////////////////////////////////////////////////////////////
//Passives
///////////////////////////////////////////////////
//BasicPassives
turf
	Skilltree/Passives/BasicPassives
		layer = MOB_LAYER+97
		StaminaRegeneration
			name="Recovery"
			icon_state="StaminaRegeneration"
		DurabilityMastery
			name="Durability"
			icon_state="DurabilityMastery"
		BodyFlickerRepetition
			name="Body Flicker Repetition"
			icon_state="BFR"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/Shushin) in usr.LearnedJutsus))
					alert(usr,"This passive is unavailable to you at this time. You need to learn the Body Flicker Jutsu first!")
					return
				alert(usr, "[src] decreases the delay of Body Flicker by 2 seconds per point, but can only reach a minimum of a 0.5 second delay. How to Train it: [price] [usr.BodyFlickerRepetition]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.BodyFlickerRepetition<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<150*(usr.BodyFlickerRepetition))
								usr<<"You need [150*(usr.BodyFlickerRepetition)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BodyFlickerRepetition++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		BodyFlickerDistance
			name="Body Flicker Distance"
			icon_state="BFD"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=4
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/Shushin) in usr.LearnedJutsus))
					alert(usr,"This passive is unavailable to you at this time. You need to learn the Body Flicker Jutsu first!")
					return
				alert(usr, "[src] increases the number of tiles you can jump using Body Flicker by 1 per point. How to Train it: [price] [usr.BodyFlickerDistance]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<50*(usr.BodyFlickerDistance))
								usr<<"You need [50*(usr.BodyFlickerDistance)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BodyFlickerDistance++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0

		BodyFlickerMaster
			name="Body Flicker Master"
			icon_state="BFM"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/Shushin) in usr.LearnedJutsus))
					alert(usr,"This passive is unavailable to you at this time. You need to learn the Body Flicker Jutsu first!")
					return
				alert(usr, "[src] decreases the Chakra Drain of the Body Flicker Jutsu. How to Train it: [price] [usr.BodyFlickerMaster]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<200*(usr.BodyFlickerMaster+1))
								usr<<"You need [200*(usr.BodyFlickerMaster+1)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BodyFlickerMaster++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Acceleration
			name="Acceleration"
			icon_state="Acceleration"
			var/price="By running."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.RunningSpeed<1)
					alert(usr,"This passive is unavailable to you at this time. You need 1 / 5 Running Speed before you can view this passive.")
					return
				alert(usr, "[src] is a passive that decreases the amount of time it takes to reach maximum speed when running. How to Train it: [price] [usr.Acceleration]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Acceleration<10)
								usr.Acceleration++;usr.StartingPoints--;usr.clicking=0
							else
								alert(usr,"Sorry, this passive cannot go any higher.")
					usr.clicking=0
		RunningSpeed
			name="RunningSpeed"
			icon_state="RunningSpeed"
			var/price="By running."
			var/maxprice=5
			Click()
				if(usr.TaijutsuKnowledge<10)
					alert(usr,"This passive is unavailable to you at this time. You need 10 Taijutsu Knowledge before you can view this passive.")
					return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that increases the maximum speed when running. How to Train it: [price] [usr.RunningSpeed]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.RunningSpeed<5)
								usr.RunningSpeed++;usr.StartingPoints--;usr.clicking=0
							else
								alert(usr,"Sorry, this passive cannot go any higher.")
					usr.clicking=0
//Elemental Passives
turf
	Skilltree/Passives/ElementalPassives
		layer = MOB_LAYER+97
		icon='Icons/Jutsus/Skilltree.dmi'
		ReturnToScreen
			icon='Icons/Hud/BaseSelectStuff.dmi'
			icon_state="Doner"
			layer=105
			Click()
				usr<<sound('SFX/click1.wav',0)
				usr.client.perspective=MOB_PERSPECTIVE
				usr.client.eye=usr
		Convert
			icon_state="Convert"
			Click()
				//Argon code #111125
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to convert some of your Starting Points to Elemental Points? WARNING: This cannot be reversed..") in list("No","Yes"))
						if("Yes")
							var/Number=input(usr,"How many points do you wish to convert?") as num
							if(Number>usr.StartingPoints)
								Number=usr.StartingPoints
							if(Number<1)
								Number=1
							switch(input(usr,"CONFIRM: Convert [Number] Starting Points to [Number*3] Elemental Points for a total of [(Number*3)+usr.ElementalPoints] Elemental Points and [usr.StartingPoints-Number] Starting Points?") in list("No","Yes"))
								if("Yes")
									usr.StartingPoints-=Number;usr.ElementalPoints+=Number*3
									alert(usr,"Conversion Successful.")
					usr.clicking=0
				else if(usr.clicking)
					alert(usr,"Slow down. One pop up at a time.");return
				else
					alert(usr,"You have no Starting Points to convert to Elemental Points!");return
		Jutsus
			icon='Icons/Jutsus/Skillcards.dmi'
			//Katon
			Hikibou
				icon_state="Hikibou"
				Click()
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Katon Hikibou No Jutsu",0,"Hikibou","Katon Hikibou No Jutsu is a technique where the user heats the air around the target. After heating the air, that region will combust in flames. It is very useless at the beginning, but the more you use it the stronger it gets. 3 Elemental Points","Katon",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			DragonFury
				icon_state="FireFurry"
				Click()
					if(usr.Magma==0)
						usr<<"You need to know Magma first!";return
					if(usr.WindE==0)
						usr<<"You need to know Fuuton first!";return
					for(var/obj/SkillCards/DragonFury/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<200)
						usr<<"You need at least 200 Katon Knowledge first!";return
					if(usr.ElementalPoints >=5)
						usr.LearnJutsu("Fire Furry",0,"DragonFury"," shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			KatonArmour
				icon_state="KatonArmor"
				Click()
					if(usr.Magma==0)
						usr<<"You need to know Magma first!";return
					if(usr.WindE==0)
						usr<<"You need to know Fuuton first!";return
					for(var/obj/SkillCards/KatonArmor/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<200)
						usr<<"You need at least 200 Katon Knowledge first!";return
					if(usr.ElementalPoints >=5)
						usr.LearnJutsu("Katon Armor",0,"KatonArmor"," shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."

			RaseKa
				icon_state="Spinning Fire"
				Click()
					for(var/obj/SkillCards/Hikibou/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(!(locate(/obj/SkillCards/Hikibou) in usr.LearnedJutsus))
						usr<<"You need to know Hikibou before you can learn this jutsu.";return
					if(usr.FireChakra<2)
						usr<<"YOu need at least 2 / 20 Fire Mastery before you can learn this jutsu.";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >=15))
						usr.LearnJutsu("Katon Spinning Fire",0,"SpinningFire","Katon RaseKa is a jutsu that shoots a ball of fire torwards the opponent, engulfing them in flames if hit and nearby katon jutsu also. 4 Elemental Points","Katon",4)
					//	usr.ElementalPointDeduction=4
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."
			Housenka
				icon_state="Housenka"
				Click()
					if((usr.ElementalPoints>=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Katon Housenka No Jutsu",0,"Housenka","Katon Housenka No Jutsu is a jutsu that shoots multiple fire balls from the mouth that explode in fire on contact of a target. 3 Elemental Points","Katon",3)
					//	usr.ElementalPointDeduction =3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."

			HousenkaTsumabeni
				icon_state="FireShuriken"
				Click()
					if(!(locate(/obj/SkillCards/KatonHouka) in usr.LearnedJutsus))
						usr<<"You need to know Houka before you can learn this jutsu.";return
					for(var/obj/SkillCards/KatonHouka/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FireChakra<3)
						usr<<"You need at least 3/20 Fire Mastery before you can learn this jutsu.";return
					if((usr.ElementalPoints>=3)&&(usr.Mnin>=15))
						usr.LearnJutsu("Katon: Pheonix Sage Flower",0,"PhoenixSageFlower","Katon Pheonix Sage Flower is a jutsu that allows the opponent to utilize their Chakra and Shuriken to create flaming shurikens. 3 Elemental Points","Katon",3)
					//	usr.ElementalPointDeduction=3
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			KatonFlameBullet
				icon_state="KaNoSenbon"
				Click()
					if(usr.FireChakra<1)
						usr<<"You need at least 1/20 Fire Mastery before you can learn this jutsu.";return
					if((usr.ElementalPoints>=3)&&(usr.Mnin>=15))
						usr.LearnJutsu("Katon Endan",0,"KatonFlameBullet","Katon Endan is a jutsu utilizing a small fire projectile that explodes on contact. 3 Elemental Points","Katon",3)
				//		usr.ElementalPointDeduction=3
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			KatonFlameBulletAdvance
				icon_state="KaNoSenbon"
				Click()
					if(usr.FireChakra<3)
						usr<<"You need at least 3/20 fire mastery before you can learn this jutsu.";return
					if(!(locate(/obj/SkillCards/KatonFlameBullet) in usr.LearnedJutsus))
						usr<<"You need to learn Katon Flame Bullet first.";return
					for(var/obj/SkillCards/KatonFlameBullet/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=4)&&(usr.Mnin>=19))
						usr.LearnJutsu("Katon Dai Endan",0,"KatonFlameBulletAdvance","Katon Dai Endan is like Katon Endan but the user utilizes even more powerful projectiles. 4 Elemental Points","Katon",4)
				//		usr.ElementalPointDeduction=4
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			KatonFlameEmber
				icon_state="KaNoSenbon"
				Click()
					if(usr.FireChakra<5)
						usr<<"You need at least 5/20 Fire Mastery before you can learn this jutsu.";return
					if(!(locate(/obj/SkillCards/KatonFlameBulletAdvance) in usr.LearnedJutsus))
						usr<<"You need to learn Katon Dai Endan First.";return
					for(var/obj/SkillCards/KatonFlameBulletAdvance/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=3)&&(usr.Mnin>=21))
						usr.LearnJutsu("Katon Flame Ember",0,"FlameEmber","Katon Flame Ember is similar to the jutsu like Endan, however this one has a severe chance to burn the opponent. 3 Elemental Points","Katon",3)
					//	usr.ElementalPointDeduction=3
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			Goukakyuu
				icon_state="Goukakyuu"
				Click()
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Katon Goukakyuu No Jutsu",0,"Goukakyuu","Katon Goukakyuu No jutsu is a field ranged jutsu that releases fire from the mouth. It covers a small radius, that can improve, so it can be very useful in combat. 3 Elemental Points","Katon",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."


			AshPileBurning
				icon_state="AshRelease"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Burning Ash: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Goukakyuu) in usr.LearnedJutsus))
						usr<<"You need to learn Goukakyuu first.";return
					for(var/obj/SkillCards/Goukakyuu/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 24))
						usr.LearnJutsu("Katon: Ash Pile Burning",0,"AshPileBurning","Katon Ash Pile Burning is a jutsu that allows the user to create their katon into a foggy like substance, dealing less damage, but having a larger chance to burn. Also isn't destroyed by water. 4 Elemental Points","Katon",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			Gouenkyuu
				icon_state="FireDragon"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Fireball Advanced: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Goukakyuu) in usr.LearnedJutsus))
						usr<<"You need to learn Goukakyuu first.";return
					for(var/obj/SkillCards/Goukakyuu/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=5)&&(usr.Mnin>=25))
						usr.LearnJutsu("Katon: Gouenkyuu",0,"KatonHoukaAdvanced","Katon Gouenkyuu is an advanced version of Goukakyuu, allowing the user to shoot the fire projectile, which then pushes anything it catches, until it engulfes in flames. 5 Elemental Points","Katon",5)
				//		usr.ElementalPointDeduction=5
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			GoukaMekkyaku
				icon_state="Kaheki"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Burning Ash: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/KatonHoukaAdvanced) in usr.LearnedJutsus))
						usr<<"You need to learn Katon Gouenkyuu first.";return
					for(var/obj/SkillCards/KatonHoukaAdvanced/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=5)&&(usr.Mnin>=28))
						usr.LearnJutsu("Katon: Great Majestic Fire Annihilation",0,"GoukaMekkyakuNoJutsu","A technique once used by the Legendary Uchiha Madara, this technique destroys anything in it's past with a huge wave of Fire. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction=5
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."

			Ryuusenka
				icon_state="Ryuusenka"
				Click()
					if(!(locate(/obj/SkillCards/Ryuuka) in usr.LearnedJutsus))
						usr<<"You need to know Ryuuka first!";return
					for(var/obj/SkillCards/Ryuuka/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<500)
						usr<<"You need at least 500 katon knowledge first!";return
					if((usr.ElementalPoints>=6)&&(usr.Mnin>=25))
						usr.LearnJutsu("Katon: Ryuusenka",0,"KatonDragonWar","Katon Ryuusenka is truly a dangerous jutsu. Allowing the user to combine Houka and Katon Ryuuka into one fierce and deadly combination. 6 Elemental Points","Katon",6)
					//	usr.ElementalPointDeduction=6
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."
			Ryuuka
				icon_state="Ryuuka"
				Click()
//					if(usr.blevel=="D"||usr.blevel=="E")
//						usr<<"Ryuuka no Jutsu: Your class is too low for this technique.";return
					if(usr.KatonKnowledge<150)
						usr<<"You need at least 150 Katon Knowledge first!";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 25))
						usr.LearnJutsu("Katon Ryuuka No Jutsu",0,"Ryuuka","Katon Ryuuka No Jutsu is a concentrated form of Karyuu Endan that shoots a concentrated blast that explodes on contact of a physical object. 3 Elemental Points","Katon",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Houka
				icon_state="Houka"
				Click()
					if(!(locate(/obj/SkillCards/Housenka) in usr.LearnedJutsus))
						usr<<"You need to know Katon Housenka first!";return
					for(var/obj/SkillCards/Housenka/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<50)
						usr<<"You need at least 50 Katon Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Katon Houka",0,"KatonHouka","Katon Houka is a powerful fireball technique that can be considered an enhancement to Housenka. It works by shooting a giant fireball that explodes on contact or through time to an even bigger flame. 4 Elemental Points","Katon",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			ChouHouka
				icon_state="ChouHouka"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"ChouHouka: Your class is too low for this technique.";return
					if(usr.DragonsRage<1)
						usr<<"You need at least 1 point in Dragons Rage before you can learn this jutsu!";return
					if(usr.KatonKnowledge<200)
						usr<<"You need at least 200 Katon Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 33))
						usr.LearnJutsu("Katon Chou Houka",0,"ChouHouka","Katon Chou Houka is a powerful fireball and the new enhancement to Houka! This jutsu is typically the same as Houka except less concentrated and less powerful, shooting multiple fireballs in all directions once trained enough. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			KaryuuEndan
				icon_state="KaryuuEndan"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"KaruuEndan: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/KatonFlameBulletAdvance) in usr.LearnedJutsus))
						usr<<"You need to know Katon Dai Endan first!";return
					for(var/obj/SkillCards/KatonFlameBulletAdvance/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<200)
						usr<<"You need at least 200 Katon Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 32))
						usr.LearnJutsu("Katon Karyuu Endan",0,"KaryuuEndan","Katon Karyuu Endan shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			DragonFury
				icon_state="FireFurry"
				Click()
					if(usr.Magma==0)
						usr<<"You need to know Magma first!";return
					if(usr.WindE==0)
						usr<<"You need to know Fuuton first!";return
					for(var/obj/SkillCards/DragonFury/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<200)
						usr<<"You need at least 200 Katon Knowledge first!";return
					if(usr.ElementalPoints >=5)
						usr.LearnJutsu("Fire Furry",0,"DragonFury"," shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			KatonArmour
				icon_state="KatonArmor"
				Click()
					if(usr.Magma==0)
						usr<<"You need to know Magma first!";return
					if(usr.WindE==0)
						usr<<"You need to know Fuuton first!";return
					for(var/obj/SkillCards/KatonArmor/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<200)
						usr<<"You need at least 200 Katon Knowledge first!";return
					if(usr.ElementalPoints >=5)
						usr.LearnJutsu("Katon Armor",0,"KatonArmor"," shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio. 5 Elemental Points","Katon",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."

			Gouryuuka
				icon_state="Gouryuuka"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Gouryuuka: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/KatonDragonWar) in usr.LearnedJutsus))
						usr<<"You need to know Katon Ryuukasenka first!.";return
					for(var/obj/SkillCards/KatonDragonWar/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.KatonKnowledge<500)
						usr<<"You need at least 500 Katon Knowledge first!";return
					if((usr.ElementalPoints >=6)&&(usr.Mnin >= 34))
						usr.LearnJutsu("Katon Gouryuuka",0,"Gouryuuka","Gouryuuka is a powerful firey dragon head expelled from the mouth of the user. It incinerates all in its path. 6 Elemental Points","Raiton",5)
				//		usr.ElementalPointDeduction = 6
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			//Raiton
			Raikyuu
				icon_state="Raikyu"
				Click()
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Raiton; Raikyuu No Jutsu",0,"Raikyuu","Raiton; Raikyuu No Jutsu is a technique where the user charges chakra within their hands and shoot it off. 3 Elemental Points","Raiton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Ikazuchi
				icon_state="Ikazuchi"
				Click()
					if(!(locate(/obj/SkillCards/RairyuuGarou) in usr.LearnedJutsus))
						usr<<"You need to know Rairyuu Garou first!";return
					for(var/obj/SkillCards/RairyuuGarou/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<50)
						usr<<"You need at least 50 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Raiton; Ikazuchi No Kiba",0,"IkazuchiKiba","Raiton; Ikazuchi No Kiba is a powerful Raiton technique which shoots bolts of lightning on all side of the user! 4 Elemental Points","Raiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Touei
				icon_state="Touei"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Touei: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Tatsumaki) in usr.LearnedJutsus))
						usr<<"You need to know Raiton Rairyuu no Tatsumaki first!";return
					for(var/obj/SkillCards/Tatsumaki/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<550)
						usr<<"You need at least 550 Raiton Knowledge first!";return
					if((usr.ElementalPoints>=5)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Raiton, Touei",0,"Touei","Raiton Touei is a jutsu that allows you to temporarily focus your elemental chakra into quick bursts for instantaneous-like movement. 5 Elemental Points","Raiton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."
			Garou
				icon_state="Garou"
				Click()
					if(usr.LightningChakra<1)
						usr<<"You need 1 / 20 Lightning Mastery before you can learn this jutsu!";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Raiton; Rai no Garou",0,"RairyuuGarou","Raiton; Rai no Garou is a technique where the user spins rapidly in a fierce tornado, attracting static energy which they can rip the opponent to shreds. 3 Elemental Points","Raiton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			OldGian
				icon_state="Gian"
				Click()
					if(!(locate(/obj/SkillCards/Jibashi) in usr.LearnedJutsus)&&!(locate(/obj/SkillCards/Hinoko) in usr.LearnedJutsus))
						usr<<"You need to know Raiton Jibashi or Rairyuu Hinoko first!";return
					for(var/obj/SkillCards/Jibashi/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					for(var/obj/SkillCards/Hinoko/C in usr.LearnedJutsus)
						if(C:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<450)
						usr<<"You need at least 450 Raiton Knowledge first!";return
					if((usr.ElementalPoints>=5)&&(usr.Mnin>=30))
						usr.LearnJutsu("Raiton: Impaling Electrocution",0,"OldGian","Raiton: Impaling Electrocution is similar to the legendary Raiton: Gian Technique. The User creates a horizontal blast of Raiton Chakra that impales the enemy, causing continous damage and stunning the enemy. 5 Elemental Points","Raiton",5)
				//		usr.ElementalPointDeduction=5
						usr.Frozen=0
						return
					else
						usr<<"[src]: I am afraid you don't have the ability to learn this jutsu."
			Tatsumaki
				icon_state="Tatsumaki"
				Click()
					if(!(locate(/obj/SkillCards/Jibashi) in usr.LearnedJutsus)&&!(locate(/obj/SkillCards/Hinoko) in usr.LearnedJutsus))
						usr<<"You need to know Raiton Jibashi or Rairyuu Hinoko first!";return
					for(var/obj/SkillCards/Jibashi/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					for(var/obj/SkillCards/Hinoko/C in usr.LearnedJutsus)
						if(C:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<450)
						usr<<"You need at least 450 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 37))
						usr.LearnJutsu("Raiton; Rairyuu no Tatsumaki",0,"Tatsumaki","Raiton; Rairyuu No Tatsumaki is a jutsu where the user creates a strong dragon that is controllable in movement and damage. 5 Elemental Points","Raiton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			RaiYoroi
				icon_state="RaiYoroi"
				Click()
					if(!(locate(/obj/SkillCards/Raikyuu) in usr.LearnedJutsus))
						usr<<"You need to know Raikyuu first!";return
					for(var/obj/SkillCards/Raikyuu/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<50)
						usr<<"You need at least 50 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Raiton; Raigeki No Yoroi",0,"Yoroi","Raiton; Raigeki No Yoroi is a powerful technique that absorbs all Raiton techniques shot at the user! 4 Elemental Points","Raiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Gian
				icon_state="Gian"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Gian: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Tatsumaki) in usr.LearnedJutsus)||!(locate(/obj/SkillCards/ChidoriEisou) in usr.LearnedJutsus))
						usr<<"You need to know both Rairyuu Tatsumaki and Chidori Senbon.";return
					if(usr.RaitonKnowledge<500)
						usr<<"You need at least 500 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=7)&&(usr.Mnin >= 37))
						usr.LearnJutsu("Raiton; Gian",0,"Gian","Raiton; Gian is an incredibly powerful technique which shoots a line of lightning from the user which zaps the target powerfully! 7 Elemental Points","Raiton",7)
					//	usr.ElementalPointDeduction = 7
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Jibashi
				icon_state="Jibashi"
				Click()
					if(!(locate(/obj/SkillCards/IkazuchiKiba) in usr.LearnedJutsus))
						usr<<"You need to know both Ikazuchi Kiba first!";return
					for(var/obj/SkillCards/IkazuchiKiba/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<150)
						usr<<"You need at least 150 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Raiton; Jibashi",0,"Jibashi","Raiton; Jibashi is a jutsu where eletrical pulses are shot at the designated target, shocking and stunning them! 4 Elemental Points","Raiton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Hinoko
				name="Hinoko"
				icon_state="Hinoko"
				Click()
					if(!(locate(/obj/SkillCards/Yoroi) in usr.LearnedJutsus))
						usr<<"You need to know Raigeki Yoroi first!";return
					for(var/obj/SkillCards/Yoroi/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.RaitonKnowledge<350)
						usr<<"You need at least 350 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Raiton; Hinoko",0,"Hinoko","Raiton; Hinoko is a fast electrical jutsu that utilizes shape and nature manipulation to form a vibrating blade of lightning that travels quickly and deals heavy damage to its targets, as well as temporarily numbing their bodies! 4 Elemental Points","Raiton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			//Chidori
			Chidori
				icon_state="Chidori"
				Click()
					if(usr.LightningChakra<5)
						usr<<"You need at least 5 / 20 Lightning Mastery before you can learn this jutsu!";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Chidori",0,"Chidori","Chidori is a technique which generates so much chakra that it becomes visible as eletricity. A powerful move that can damage the opponent entirely! 3 Elemental Points","Ninjutsu",3)
				//		usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
						usr.Frozen = 0
						return
			Raikiri
				icon_state="Raikiri"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Raikiri: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Chidori) in usr.LearnedJutsus))
						usr<<"You need to know Chidori first!";return
					if(usr.RaitonKnowledge<350)
						usr<<"You need at least 150 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Raikiri",0,"Raikiri","Raikiri is a stronger alteration of Chidori, allowing more mobility for the user. 5 Elemental Points","Ninjutsu",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
						usr.Frozen = 0
						return
			DoubleRaikiri
				icon_state="DoubleRaikiri"
			RaikiriWolf
				icon_state="RaikiriWolf"
				Click()
					if(!(locate(/obj/SkillCards/Raikiri) in usr.LearnedJutsus))
						usr<<"You need to know Raikiri first!";return
					if(usr.RaitonKnowledge<250)
						usr<<"You need at least 250 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 36))
						usr.LearnJutsu("Raikiri Wolf",0,"RaikiriWolf","Raikiri Wolf is a strong technique utilizing Raikiri at the fullest chakra manipulation, manifesting a lightning wolf. 5 Elemental Points","Ninjutsu",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
						usr.Frozen = 0
						return
			ChidoriSenbon
				icon_state="ChidoriSenbon"
				Click()
					if(!(locate(/obj/SkillCards/Chidori) in usr.LearnedJutsus))
						usr<<"You need to know Chidori first!";return
					if(usr.RaitonKnowledge<50)
						usr<<"You need at least 50 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 20))
						usr.LearnJutsu("Chidori Senbon",0,"ChidoriSenbon","Chidori Senbon is an alteration of Chidori. It uses shape manipulation to make a senbon using Chidori's natural properties. 4 Elemental Points","Ninjutsu",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
						usr.Frozen = 0
						return
			ChidoriNagashi
				icon_state="ChidoriNagashi"
				Click()
					if(!(locate(/obj/SkillCards/ChidoriSenbon) in usr.LearnedJutsus))
						usr<<"You need to know Chidori Senbon first!";return
					if(usr.RaitonKnowledge<100)
						usr<<"You need at least 100 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 25))
						usr.LearnJutsu("Chidori Current",0,"ChidoriNagashi","Chidori Current is an alteration of Chidori. It is a paralyzing current that is transferred through the body and outward. 5 Elemental Points","Ninjutsu",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
						usr.Frozen = 0
						return
			ChidoriEisou
				icon_state="ChidoriEisou"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Chidori Spear: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/ChidoriNagashi) in usr.LearnedJutsus))
						usr<<"You need to know Chidori Nagashi first!";return
					if(usr.RaitonKnowledge<150)
						usr<<"You need at least 150 Raiton Knowledge first!";return
					if((usr.ElementalPoints >=6)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Chidori Spear",0,"ChidoriEisou","Chidori Spear is an alteration of Chidori. It is an extending spear of lightning able to cut through anything and paralyze a body it peirces through the sheer electrical charge. 6 Elemental Points","Ninjutsu",6)
				//		usr.ElementalPointDeduction = 6
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
						usr.Frozen = 0
						return
			//Doton
			DoryoDango
				icon_state="DoryoDango"
				Click()
					if((usr.ElementalPoints>=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Doton Doryo Dango",0,"DoryoDango","Doton Doryo Dango is a technique in which the user uses their strength to pull a boulder from the ground and throw it with great force. 3 Elemental Points","Doton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			RockFist
				icon_state="DotonFist"
				Click()
					if((usr.ElementalPoints>=3))
						usr.LearnJutsu("Earth Style: Rock Fist",0,"DotonKengan","Doton Rock Fist is a technique in which the user uses their strength to create a fist of pure Earth; truly damaging the opponent. 3 Elemental Points","Doton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			DotonSpear
				icon_state="DotonSpear"
				Click()
					if(!(locate(/obj/SkillCards/DotonKengan) in usr.LearnedJutsus))
						usr<<"You need to know Doton Kengan first!";return
					for(var/obj/SkillCards/DotonKengan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.EarthChakra<4)
						usr<<"You need 4/20 Earth Mastery first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Earth Style: Spear",0,"DotonSpear","Doton Doryo Dango is a technique in which the user uses their strength to pull a boulder from the ground and throw it with great force. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			DotonArmor
				icon_state="DotonArmor"
				Click()
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Earth Style: Rock Armor",0,"DotonArmor","Rock Armor is a technique in which the user manipulates their chakra to form a Rock Hard armor ontop of their body, protecting them from damage. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen=0
						return
					else
						usr<<"I am afraid you don't have the ability to learn this jutsu."
			KoukaArmor
				icon_state="DotonArmorStronger"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Earth Armor: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/DotonArmor) in usr.LearnedJutsus))
						usr<<"You need to learn Doton Armor first!";return
					for(var/obj/SkillCards/DotonArmor/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=5))
						usr.LearnJutsu("Earth Style: Rock Armor Advanced",0,"KoukaArmor","Kouka Armor is a much more advanced and stronger version of Rock Armor.","Doton");return
			Doryuudan
				icon_state="Doryuudan"
				Click()
			//		if(!(locate(/obj/SkillCards/Taiga) in usr.LearnedJutsus))
			//			usr<<"You need to know Taiga first!";return
					for(var/obj/SkillCards/Taiga/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<100)
						usr<<"You need at least 100 Doton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Doton; Doryuudan No Jutsu",0,"Doryuudan","Doton; Doryuudan No Jutsu is a strong jutsu that summons a dragon that shoots spikes from its mouth. 4 Elemental Points","Doton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			DotonDoseikiryuu
				icon_state="Doryuudan"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Doseikiryuu: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Doryuudan) in usr.LearnedJutsus))
						usr<<"You need to know Doryuudan first!";return
					for(var/obj/SkillCards/Doryuudan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<200)
						usr<<"You need at least 200 Doton Knowledge first!";return
					if((usr.ElementalPoints>=5)&&(usr.Mnin >= 34))
						usr.LearnJutsu("Doton; Earth and Stone Dragon",0,"DotonDoseikiryuu","Doton; Earth and Stone Dragon is a strong jutsu that summons a dragon that will demolish the opponent, much Stronger of an impact than Doryuudan. 5 Elemental Points","Doton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Doryuuheki
				icon_state="Doryuuheki"
				Click()
					if(!(locate(/obj/SkillCards/MoveStopper) in usr.LearnedJutsus))
						usr<<"You need to know MoveStopper first!";return
					for(var/obj/SkillCards/MoveStopper/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<100)
						usr<<"You need at least 100 Doton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 20))
						usr.LearnJutsu("Doton; Doryuuheki No Jutsu",0,"Doryuuheki","Doton; Doryuuheki is a jutsu that creates a strong wall of defence in front of you to block techniques. 4 Elemental Points","Doton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			YomiNuma
				icon_state="YomiNuma"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Yomi Numa: Your class is too low for this technique.";return
			//		if(!(locate(/obj/SkillCards/DoryoDango) in usr.LearnedJutsus))
			//			usr<<"You need to know Doryo Dango first!";return
			//		for(var/obj/SkillCards/DoryoDango/P in usr.LearnedJutsus)
			//			if(P:Copied==1)
			//				usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
			//				return
					if(!(locate(/obj/SkillCards/SwampBrambles) in usr.LearnedJutsus))
						usr<<"You need to know Swamp Brambles first!";return
					for(var/obj/SkillCards/SwampBrambles/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<250)
						usr<<"You need at least 250 Doton Knowledge first!";return
					if((usr.ElementalPoints>=5)&&(usr.Mnin >= 37))
						usr.LearnJutsu("Doton; Yomi Numa No Jutsu",0,"YomiNuma","Doton; Yomi Numa produces a strong swamp that captures all who are within it. 5 Elemental Points","Doton",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."


			DotonArijigoku
				icon_state="DotonHole"
				Click()
					if(!(locate(/obj/SkillCards/SwampBrambles) in usr.LearnedJutsus))
						usr<<"You need to know Swamp Brambles first!";return
					for(var/obj/SkillCards/YomiNuma/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<250)
						usr<<"You need at least 250 Doton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 35))
						usr.LearnJutsu("Antlion",0,"DotonArijigoku","A jutsu which changes the properties of the earth to spiral inwards on a central point,forcing the opponent to struggle out, or face severe damage. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			SwampBrambles
				icon_state="SwampBrambles"
				Click()
					if(!(locate(/obj/SkillCards/DoryoDango) in usr.LearnedJutsus))
						usr<<"You need to know Doryo Dango first!";return
					for(var/obj/SkillCards/DoryoDango/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
				//	if(!(locate(/obj/SkillCards/YomiNuma) in usr.LearnedJutsus))
				//		usr<<"You need to know Yomi Numa first!";return
			//		for(var/obj/SkillCards/YomiNuma/P in usr.LearnedJutsus)
			//			if(P:Copied==1)
			//				usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
			//				return
					if(usr.DotonKnowledge<125)
						usr<<"You need at least 125 Doton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 32))
						usr.LearnJutsu("Rushing Swamp Waves",0,"SwampBrambles","This jutsu is a more weaker version of its parent jutsu, Swamp of the Underworld. It's capable of capturing anyone who steps foot in it and slowing them down while dealing damage. 4 Elemental Points","Doton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			DorukiGaeshi
				icon_state="DorukiGaeshi"
				Click()
					if(usr.EarthChakra<1)
						usr<<"You need 1 / 20 Earth Mastery first!";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Doton; Doruki Gaeshi",0,"DorukiGaeshi","Doton; Doruki Gaeshi is a jutsu which places a earth wall of defence in front of you to protect you. 3 Elemental Points","Doton",3)
				//		usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			MoveStopper
				icon_state="MoveStopper"
				Click()
					if(!(locate(/obj/SkillCards/DorukiGaeshi) in usr.LearnedJutsus))
						usr<<"You need to know Doruki Gaeshi first!";return
					for(var/obj/SkillCards/DorukiGaeshi/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<50)
						usr<<"You need at least 50 Doton Knowledge first!";return
					if((usr.ElementalPoints > 4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Move Stopper",0,"MoveStopper","Move Stopper is a earth technique that creates a barrier around the opponent trapping them from moving. A good catching technique. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Mole
				icon_state="Mole"
				Click()
					if(usr.SoftEarth<1)
						usr<<"You need 1 / 4 Soft Earth first!";return
					if(usr.DotonKnowledge<50)
						usr<<"You need at least 50 Doton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Doton: Moguragakure No Jutsu",0,"Moguragakure","Doton: Moguragakure No Jutsu is a jutsu where the user remains hidden deep underground which they can use to their advantage for a couple of other things they need. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			TsuchiWana
				icon_state="TsuchiWana"
				Click()
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Doton; Tsuchi Wana",0,"TsuchiWana","Doton; Tsuchi Wana is a technique that creates a field of rocks around the target, binding them. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Taiga
				icon_state="Taiga"
				Click()
					if((usr.ElementalPoints >=2)&&(usr.Mnin >= 20))
						usr.LearnJutsu("Doton; Doryu Taiga",0,"Taiga","Doton; Doryuu Taiga is a technique which creates a flow of river made out of mud, pushing the target away. 2 Elemental Points","Doton",2)
					//	usr.ElementalPointDeduction = 2
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			RisingEarthSpikes
				icon_state="RisingEarthSpikes"
				Click()
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 25))
						usr.LearnJutsu("Doton;Rising Earth Spikes",0,"RisingEarthSpikes","The user stomps the ground creating a series of spikes leading in a straight line. 4 Elemental Points","Doton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			RisingEarthPillars
				icon_state="RisingEarthSpikes"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Earth Pillars: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/RisingEarthSpikes) in usr.LearnedJutsus))
						usr<<"You need to know Rising Earth Spikes first!";return
					for(var/obj/SkillCards/RisingEarthSpikes/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<200)
						usr<<"You need at least 100 Doton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Doton;Earth Pillars",0,"RisingEarthPillars","Doton;Earth Pillars slowly creates a mass amount of Pillars around the User..that will easily penetrate enemies around them if caught....5 Elemental Points","Doton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			ColumnSpikes
				icon_state="ColumnSpikes"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Column Coffin: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/RisingEarthSpikes) in usr.LearnedJutsus))
						usr<<"You need to know Doryuudan first!";return
					for(var/obj/SkillCards/RisingEarthSpikes/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<400)
						usr<<"You need at least 400 Doton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Doton;Earth Column Spikes",0,"ColumnSpikes","Doton;Earth Column Spikes creates four medium sized pillers which sourround the target and impale him/her repetetively..5 Elemental Points","Doton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Domu
				icon_state="Domu"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Domu: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/TsuchiWana) in usr.LearnedJutsus))
						usr<<"You need to know TsuchiWana first!";return
					for(var/obj/SkillCards/TsuchiWana/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<125)
						usr<<"You need at least 125 Doton Knowledge first!";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 36))
						usr.LearnJutsu("Doton: Dorou Domu",0,"DorouDomu","Doton: Dorou Domu is a defensive earth sphere. It surrounds you and prevents almost any attack from penetrating. Unfortunately it is difficult to master and while in use you are unable to see outside. 3 Elemental Points","Doton",3)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			DotonKakouSekkan
				icon_state="DomuCrush"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Stone Coffin: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/DorouDomu) in usr.LearnedJutsus))
						usr<<"You need to know DorouDomu first!";return
					for(var/obj/SkillCards/DorouDomu/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<250)
						usr<<"You need at least 250 Doton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Doton: Descending Stone Coffin",0,"DotonKakouSekkan","Doton: Descending Stone Coffin is a jutsu utilizing what you learned from Darou Domu. It surrounds the opponent and prevents almost any attack from penetrating. 5 Elemental Points","Doton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			DomuCrush
				icon_state="DomuCrush"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Burning Ash: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/DorouDomu) in usr.LearnedJutsus))
						usr<<"You need to know Dorou Domu first!";return
					for(var/obj/SkillCards/DorouDomu/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.DotonKnowledge<450)
						usr<<"You need at least 450 Doton Knowledge first!";return
					if((usr.ElementalPoints>=6)&&(usr.Mnin >= 36))
						usr.LearnJutsu("Doton; Earth Crush Jutsu",0,"DorouDomuCrush","Doton; Earth Crush Jutsu is a strong jutsu that covers the enemy with a barrier of Earth that can crush over them for a killing blow. 6 Elemental Points","Doton",6)
					//	usr.ElementalPointDeduction = 6
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			//Fuuton
			WindTrick
				icon_state="WindTrick"
				Click()
					if((usr.ElementalPoints>4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Wind Trick",0,"WindTrick","Wind Trick is a jutsu utilizing wind currents. It produces a strong turrent of wind that pushes back nearby targets and possible attackers, the wind current increase in size the more mastery of it. 4 Elemental Points","Fuuton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			SpinningWind
				icon_state="SpinningWind"
				Click()
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Spinning Wind",0,"SpinningWind","Spinning Wind is a technique that emits a small gust that leaves the target within a spinning wind for a small amount of time. 3 Elemental Points","Fuuton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			KazeDangan
				icon_state="KazeDangan"
				Click()
					if(usr.WindChakra<1)
						usr<<"You need 1 / 20 Wind Mastery before you can learn this jutsu.";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Kaze Dangan No Jutsu",0,"KazeDangan","Fuuton Kaze Dangan No Jutsu is a technique that shoots a fast paced bullet that hits the opponent with incredible force and pressure. 3 Elemental Points","Fuuton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Reppushou
				icon_state="Reppushou"
				Click()
					if(usr.WindChakra<1)
						usr<<"You need 1 / 20 Wind Mastery before you can learn this jutsu.";return
					if((usr.ElementalPoints > 3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Fuuton Reppushou No Jutsu",0,"Reppushou","Fuuton Reppushou No Jutsu is a jutsu that shoots a wave of wind that can shoot back the enemy or speed up things. 3 Elemental Points","Fuuton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Daitoppa
				icon_state="Daitoppa"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Daitoppa: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Reppushou) in usr.LearnedJutsus))
						usr<<"You need to Reppushou first!";return
					for(var/obj/SkillCards/Reppushou/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FuutonKnowledge<250)
						usr<<"You need at least 250 Fuuton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 16))
						usr.LearnJutsu("Fuuton Daitoppa No Jutsu",0,"Daitoppa","Fuuton Daitoppa No jutsu is a technique that fires a gust of wind that shoots targets back. It can be used for combustion. 4 Elemental Points","Fuuton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			KazeKiri
				icon_state="Kazekiri"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Kazekiri: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/VacuumCannon) in usr.LearnedJutsus))
						usr<<"You need to know Vacuum Cannon first!";return
					for(var/obj/SkillCards/VacuumCannon/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FuutonKnowledge<150)
						usr<<"You need at least 150 Fuuton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Kaze Kiri No Jutsu",0,"KazeKiri","Kaze Kiri No Jutsu is a technique that's very easily dodgable but incredibly powerful. It shoots a blade of wind that literally goes through the target, which can deal a lot of damage and go to each target. 4 Elemental Points","Fuuton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			KazeGai
				icon_state="KazeGai"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Kaze Gai: Your class is too low for this technique.";return
					if(usr.FuutonKnowledge<600)
						usr<<"You need at least 600 Fuuton Knowledge first!";return
					if(!(locate(/obj/SkillCards/KazeKiri) in usr.LearnedJutsus))
						usr<<"You need to know Fuuton KazeKiri before you can learn this jutsu.";return
					for(var/obj/SkillCards/KazeKiri/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints >=6)&&(usr.Mnin >= 37))
						usr.LearnJutsu("Kaze Gai No Jutsu",0,"KazeGai","Kaze Gai no jutsu is easily an A rank technique. The edges are sharp yet hold enough brute force to be concentrated as a wind technique, not only pushing the target back but slicing them up as they get pushed making this technique ruthless. It takes up a lot of chakra though. 6 Elemental Points","Fuuton",6)
					//	usr.ElementalPointDeduction = 6
						usr.Frozen = 0
						return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			Renkuudan
				icon_state="Renkuudan"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Renkuudan: Your class is too low for this technique.";return
					if(usr.FuutonKnowledge<450)
						usr<<"You need at least 450 Fuuton Knowledge first!";return
					if((usr.ElementalPoints >=7)&&(usr.Mnin >= 45))
						for(var/obj/SkillCards/Daitoppa/P in usr.LearnedJutsus)
							if(P:Copied==1)
								usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
								return
						if(!(locate(/obj/SkillCards/Daitoppa) in usr.LearnedJutsus))
							usr<<"You need to know Daitoppa before you can learn this jutsu."
							usr.Frozen = 0
							return
						else
							usr.LearnJutsu("Fuuton Renkuudan No Jutsu",0,"Renkuudan","Fuuton Renkuudan No Jutsu is a strong, powerful blast of wind that explodes on contact with the enemy! 7 Elemental Points","Fuuton",7)
					//		usr.ElementalPointDeduction = 7
							usr.Frozen = 0
							return
					else
						usr<<"[src]: I am afraid you dont have the ability to learn this jutsu."
			VacuumWave
				icon_state="SenbonDice"
				Click()
					if(usr.WindChakra<1)
						usr<<"You need 1 / 20 Wind Mastery before you can learn this jutsu.";return
					if((usr.ElementalPoints > 3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("VacuumWave",0,"VacuumWave","A jutsu which causes the user to take a deep breath and spin around while exhaling, compressing the air that they release into a solitary blade of wind that can surround the user. 3 Elemental Points","Fuuton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			VacuumSerialWaves
				icon_state="SenbonDice"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Serial Waves: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/VacuumWave) in usr.LearnedJutsus))
						usr<<"You need to know Vacuum Wave first!";return
					for(var/obj/SkillCards/VacuumWave/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Vacuum Fuuton: Serial Waves",0,"VacuumSerialWaves","A jutsu which creates a massive amount of blades of wind that are shot from the user at varying angles. 5 Elemental Points","Ninjutsu",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			SenbonDice
				icon_state="SenbonDice"
				Click()
					if(!(locate(/obj/SkillCards/ChidoriNagashi) in usr.LearnedJutsus))
						usr<<"You need to know Chidori Nagashi first!";return
					if((usr.ElementalPoints >=6)&&(usr.Mnin >= 30))
					//	usr.LearnJutsu("Chidori Spear",10000,"ChidoriEisou","Chidori Spear is an alteration of Chidori. It is an extending spear of lightning able to cut through anything and paralyze a body it peirces through the sheer electrical charge.","Ninjutsu",3)
					//	usr.ElementalPointDeduction = 6
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Yaiba
				icon_state="WindBlade"
				Click()
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Fuuton Kaze No Yaiba",0,"Yaiba","Fuuton Kaze No Yaiba is a powerful technique that gives the user a wind sword that slices its victim. 4 Elemental Points","Fuuton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			DaiKamaitachi
				icon_state="KazeNoSenbon"
				Click()
					if(!(locate(/obj/SkillCards/Yaiba) in usr.LearnedJutsus))
						usr<<"You need to know Kaze Yaiba first!";return
					for(var/obj/SkillCards/Yaiba/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FuutonKnowledge<150)
						usr<<"You need at least 150 Fuuton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Giant WindCutter Jutsu",0,"DaiKamaitachi","A jutsu that slices up the target’s body and is able to push away projectiles and people with mere ease. 4 Elemental Points","Fuuton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			Kakeami
				icon_state="KazeNoSenbon"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Kakeami: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/DaiKamaitachi) in usr.LearnedJutsus))
						usr<<"You need to know Giant Windcutter Jutsu first!";return
					for(var/obj/SkillCards/DaiKamaitachi/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FuutonKnowledge<275)
						usr<<"You need at least 275 Fuuton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 34))
						usr.LearnJutsu("Casting Wind Net",0,"Kakeami","The user creates multiple narrow currents of wind that form a large net of sorts. These winds are sharp enough to slice through an opponent, inflicting severe injuries to them in a criss-cross pattern. 5 Elemental Points","Fuuton",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			VacuumCannon
				icon_state="KazeNoSenbon"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Vacuum Cannon: Your class is too low for this technique.";return
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Vacuum Cannon",0,"VacuumCannon","The user shoots small, powerful and near-invisible blasts of wind. 3 Elemental Points","Fuuton",3)
				//		usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			VacuumSphere
				icon_state="KazeNoSenbon"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Vacuum Sphere: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/VacuumCannon) in usr.LearnedJutsus))
						usr<<"You need to know Vacuum Cannon first!";return
					for(var/obj/SkillCards/VacuumCannon/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FuutonKnowledge<150)
						usr<<"You need at least 150 Fuuton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Vacuum Sphere",0,"VacuumSphere","Wind Release: Vacuum Sphere is a technique that shoots many bullet size wind projectile that have the capabilities of piercing an enemy. It shoots incredibly fast making it very lethal. 5 Elemental Points","Fuuton",5)
			//			usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			VacuumGreatSphere
				icon_state="KazeNoSenbon"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Great Vacuum Sphere: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/VacuumSphere) in usr.LearnedJutsus))
						usr<<"You need to know Vacuum Sphere first!";return
					for(var/obj/SkillCards/VacuumSphere/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.FuutonKnowledge<250)
						usr<<"You need at least 250 Fuuton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Vacuum Great Sphere",0,"VacuumGreatSphere","Wind Release: Vacuum Great Sphere is a technique that shoots many bullet size wind projectile that have the capabilities of piercing an enemy. It shoots incredibly fast making it very lethal; much stronger then the Average Vacuum Sphere. 5 Elemental Points","Fuuton",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			//Suiton
			Mizurappa
				icon_state="Mizurappa"
				Click()
					if((usr.ElementalPoints >=3)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Suiton Mizurappa No Jutsu",0,"Mizurappa","Suiton Mizurappa No Jutsu is a beam-water technique that shoots water out from the user's mouth with great force and pressure. 3 Elemental Points","Suiton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			BubbleCapture
				icon_state="Mizurappa"
				Click()
					if(usr.WaterChakra<1)
						usr<<"You need 1 / 20 Water Mastery first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 15))
						usr<<"For fucks sakes, it doesn't work!";return
						usr.LearnJutsu("Suiton Bubble Capture",0,"BubbleCapture","Suiton BubbleCapture is a Jutsu that allows the user to create a bubble that can entrap an opponent and slowly suffocate them within it when the air runs out. 4 Elemental Points","Suiton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			BubbleBeam
				icon_state="Mizurappa"
				Click()
					if(usr.WaterChakra<4)
						usr<<"You need 4 / 20 Water Mastery first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 15))
						usr.LearnJutsu("Suiton Bubble Beam",0,"BubbleBeam","Suiton BubbleBeam is a Jutsu that allows the user to create a large amount of Bubbles in the shape of a V to rush at the opponent, slamming them and pushing them back severly when hit. 5 Elemental Points","Suiton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Syrup
				icon_state="StickySyrup"
				Click()
					if(!(locate(/obj/SkillCards/Mizurappa) in usr.LearnedJutsus))
						usr<<"You need to know Mizurappa first!";return
					for(var/obj/SkillCards/Mizurappa/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<50)
						usr<<"You need at least 50 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Mizuame Nabara No Jutsu",0,"MizuameNabara","Mizuame Nabara No Jutsu is a jutsu that creates sticky syrup around the user making those stuck in it immobile. 4 Elemental Points","Suiton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Suigadan
				icon_state="Suigadan"
				Click()
					if(!(locate(/obj/SkillCards/MizuBunshin) in usr.LearnedJutsus))
						usr<<"You need to know Mizu Bunshin first!";return
					for(var/obj/SkillCards/MizuBunshin/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<100)
						usr<<"You need at least 100 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suigadan",0,"Suigadan","Suigdan is a powerful water jutsu that sends four spiraling tendrills of water to strike an opponent from underneath. This attack must be well timed because it cannot be preformed if the target is not standing on water. 4 Elemental Points","Suiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Suiryuudan
				icon_state="Suiryuudan"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Suiryuudan: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Suikoudan) in usr.LearnedJutsus))
						usr<<"You need to know Suikoudan first!";return
					for(var/obj/SkillCards/Suikoudan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<350)
						usr<<"You need at least 350 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Suiryuudan No Jutsu",0,"Suiryuudan","Suiton Suiryuudan No Jutsu is a jutsu which summons a dragon made out of water from water to attack a targetted player. 5 Elemental Points","Suiton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Suikoudan
				icon_state="Suikoudan"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Suikoudan: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/WaterCreation) in usr.LearnedJutsus))
						usr<<"You need to know WaterCreation first!";return
					for(var/obj/SkillCards/WaterCreation/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<250)
						usr<<"You need at least 250 Suiton Knowledge first!";return
					if((usr.ElementalPoints>=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Suikoudan No Jutsu",0,"Suikoudan","Suiton Suikoudan No Jutsu is a jutsu whcih summons a shark made out of water from water to attack a targetted player. 5 Elemental Points","Suiton",5)
					//	usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			Daikoudan
				icon_state="Suikoudan"
				Click()
					if(!(locate(/obj/SkillCards/Suikoudan) in usr.LearnedJutsus))
						usr<<"You need to know Suikoudan first!";return
					for(var/obj/SkillCards/Suikoudan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<250)
						usr<<"You need at least 250 Suiton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Daikoudan No Jutsu",0,"Daikoudan","Suiton Daikoudan No Jutsu is a jutsu whcih summons an even larger shark made out of water from water to attack any victim in sight. 4 Elemental Points","Suiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			Senjikizame
				icon_state="MultipleSharks"
				Click()
					if(!(locate(/obj/SkillCards/Suikoudan) in usr.LearnedJutsus))
						usr<<"You need to know Suikoudan first!";return
					for(var/obj/SkillCards/Suikoudan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<250)
						usr<<"You need at least 250 Suiton Knowledge first!";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Thousand Man Eating Sharks",0,"Senjikizame","Suiton Thousand man eating sharks creates a large amount of sharks to devour any enemies in their path. 4 Elemental Points","Suiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Daibakufu
				icon_state="Daibakufu"
				Click()
					if(!(locate(/obj/SkillCards/MizuTeppou) in usr.LearnedJutsus))
						usr<<"You need to know MizuTeppou first";return
					for(var/obj/SkillCards/MizuTeppou/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<150)
						usr<<"You need at least 150 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Daibakufu No Jutsu",0,"Daibakufu","Suiton Daibakufu No Jutsu is a jutsu which shoots a large torrent which keeps the enemy in repetive damage. 4 Elemental Points","Suiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			Daibakuryuu
				icon_state="Whirlpool"
				Click()
					if(!(locate(/obj/SkillCards/MizuTeppou) in usr.LearnedJutsus))
						usr<<"You need to learn Mizu Teppou first";return
					for(var/obj/SkillCards/MizuTeppou/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<150)
						usr<<"You need at least 150 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Daibakuryuu",0,"Daibakuryuu","Suiton Daibakuryuu is a jutsu that allows the opponent to create a strong tide of water, sucking in the opponent and damaging them. 5 Elemental Points","Suiton",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			BakuSuishouha
				icon_state="BakuSuishou"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Baku Suishouha: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/MizuameNabara) in usr.LearnedJutsus))
						usr<<"You need to know Mizuame Nabara first!";return
					for(var/obj/SkillCards/MizuameNabara/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<200)
						usr<<"You need at least 200 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=5)&&(usr.Mnin >= 35))
						usr.LearnJutsu("Suiton Baku Suishouha No Jutsu",0,"BakuSuishouha","Suiton Baku Suishou No jutsu is a technique that shoots a large torrent wave that covers the field with water that can be used to the user's advantage. 5 Elemental Points","Suiton",5)
				//		usr.ElementalPointDeduction = 5
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			WaterCreation
				icon_state="WaterCreation"
				Click()
					if(usr.WaterChakra<1)
						usr<<"You need 1 / 20 Water Mastery first!";return
					if((usr.ElementalPoints>=2)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Water Creation Jutsu",0,"WaterCreation","Water Creation Jutsu is a jutsu that creates a supply of water allowing players to use. 2 Elemental Points","Suiton",2)
				//		usr.ElementalPointDeduction = 2
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Suijinheki
				icon_state="Suijinheki"
				Click()
					if(!(locate(/obj/SkillCards/WaterCreation) in usr.LearnedJutsus))
						usr<<"You need to know Water Creation first!";return
					for(var/obj/SkillCards/WaterCreation/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<150)
						usr<<"You need at least 150 Suiton Knowledge first!";return
					if((usr.ElementalPoints>=3)&&(usr.Mnin >= 22))
						usr.LearnJutsu("Suiton Suijinheki No Jutsu",0,"Suijinheki","Suiton Suijinheki No Jutsu is a jutsu that creates a quick block infront of the user to block incoming techniques. 3 Elemental Points","Suiton",3)
				//		usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			Teppoudama
				icon_state="Water Bullet"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Teppoudama: Your class is too low for this technique.";return
					if((usr.ElementalPoints>=4)&&(usr.Mnin >= 30))
						usr.LearnJutsu("Suiton Teppoudama",0,"Teppoudama","Suiton Teppoudama is a strong and fast water bullet projectile that when it colldies with something bursts with a large shockwave knocking anyone nearby away with great force. 4 Elemental Points","Suiton",4)
				//		usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			MizuTeppou
				icon_state="WaterGun"
				Click()
					if(!(locate(/obj/SkillCards/Teppoudama) in usr.LearnedJutsus))
						usr<<"You need to learn Teppoudama first!";return
					for(var/obj/SkillCards/Teppoudama/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=4)&&(usr.Mnin>=30))
						usr.LearnJutsu("Suiton Water Gun",0,"MizuTeppou","Suiton Water Gun is an advanced jutsu that shoots a powerful blast of water at the opponent, damaging them fiercely. 4 Elemental Points","Suiton",4)
				//		usr.ElementalPointDeduction=4
						usr.Frozen=0
						return
					else
						usr<<"I am afraid you don't have the ability to learn this jutsu."

			MizuBunshin
				icon_state="SuitonBunshin"
				Click()
					if(!(locate(/obj/SkillCards/Suikoudan) in usr.LearnedJutsus))
						usr<<"You need to learn Suikoudan first!";return
					for(var/obj/SkillCards/Suikoudan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if((usr.ElementalPoints>=4)&&(usr.Mnin>=30))
						usr.LearnJutsu("Suiton: Water Clones",0,"MizuBunshin","Suiton Water Clones is a jutsu that enables the ninja to create clones from water. 5 Elemental Points","Suiton",5)
				//		usr.ElementalPointDeduction=5
						usr.Frozen=0
						return
					else
						usr<<"I am afraid you don't have the ability to learn this jutsu."

			WaterPrison
				icon_state="WaterPrison"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Water Prison: Your class is too low for this technique.";return
					if(!(locate(/obj/SkillCards/Suiryuudan) in usr.LearnedJutsus))
						usr<<"You need to know Suiryuudan first!";return
					for(var/obj/SkillCards/Suiryuudan/P in usr.LearnedJutsus)
						if(P:Copied==1)
							usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
							return
					if(usr.SuitonKnowledge<300)
						usr<<"You need at least 300 Suiton Knowledge first!";return
					if((usr.ElementalPoints >=4)&&(usr.Mnin >= 45))
						usr.LearnJutsu("Suiton Suirou",0,"WaterPrison","Is a suiton technique that engulfs an opponent with a barrier freezing both user and victim. 4 Elemental Points","Suiton",4)
					//	usr.ElementalPointDeduction = 4
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."
			SteamGas
				icon_state="SteamGas"
				Click()
					if(usr.WaterE==0)
						usr<<"WOOT";return
					if(usr.FireE==0)
						usr<<"WOOT";return
					if(usr.ElementalPoints >=5)
						usr.LearnJutsu("steam gas",0,"SteamGas","Suiton Mizurappa No Jutsu is a beam-water technique that shoots water out from the user's mouth with great force and pressure. 3 Elemental Points","Suiton",3)
					//	usr.ElementalPointDeduction = 3
						usr.Frozen = 0
						return
					else
						usr<<"I am afraid you dont have the ability to learn this jutsu."

			Shousen
				icon_state="Shousen"
				Click()
					if(!(locate(/obj/SkillCards/Shousen) in usr.LearnedJutsus))
						if(usr.GenSkill+(usr.ChakraC/25)>=14)
							if(usr.NinjutsuKnowledge>150)
								usr.LearnJutsu("Heal",0,"Shousen","Shousen is a medical Jutsu that enables one to heal someone by utilizing their chakra.","Ninjutsu")
							else
								usr<<"You need more Ninjutsuknowledge!";return
						else if(usr.GenSkill<14)
							usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
					else
						usr<<"You have already learned [src]!";return
			ShousenMastery
				name="Shousen Mastery"
				icon_state="ShousenUpgrade"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=3
				var/cost=2
				Click()
					if(locate(/obj/SkillCards/Shousen) in usr.LearnedJutsus)
						if(3<=usr.ShousenMastery)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] is a passive that allows you to increase the Healing Cap by 200 per point on Shousen. How to Train it: [price] [usr.ShousenMastery]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.ShousenMastery++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
									return
					else
						usr<<"You must know Shousen first!";return
			ForbiddenShousen
				icon_state="Cure"
				Click()
					if(!(locate(/obj/SkillCards/ForbiddenShousen/) in usr.LearnedJutsus))
						if(usr.GenSkill+(usr.ChakraC/25)>=19)
							if(usr.NinjutsuKnowledge>750)
								usr.LearnJutsu("Advanced Heal",0,"ForbiddenShousen","Forbidden Shousen is the highest form of medical Jutsu that enables one to heal someone by utilizing their chakra.","Ninjutsu")
							else
								usr<<"You need more Ninjutsuknowledge!";return
						else if(usr.GenSkill<19)
							usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
					else
						usr<<"You have already learned [src]!";return

			Chikatsu
				icon_state="Chikatsu"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Chikatsu: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/Shousen) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/Chikatsu) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=17)
								if(usr.NinjutsuKnowledge>250)
									usr.LearnJutsu("Chikatsu Saisei no Jutsu",0,"Chikatsu","Chikatsu Saisei no Jutsu is a technique that heals people in range of your technique. The better you are at healing, the further the range.","Ninjutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<14)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
							else if(!(locate(/obj/SkillCards/Shousen) in usr.LearnedJutsus))
								usr<<"You need to learn Shousen first!";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Shousen first!";return
			Cure
				name="Advanced Healing"
				icon_state="Cure"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=1
				var/cost=1
				Click()
					if(locate(/obj/SkillCards/Chikatsu) in usr.LearnedJutsus)
						if(1<=usr.Cure)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] is a passive that allows you to also heal additional affects such as Poison, Burn, and Paralysis with Shousen.. How to Train it: [price] [usr.Cure]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.Cure++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
									return
					else
						usr<<"You must know Chikatsu first!";return
			SelfHeal
				icon_state="Meisagakure"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Self Heal: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/Chikatsu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/SelfHeal) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=20)
								if(usr.NinjutsuKnowledge>500)
									usr.LearnJutsu("Self Regeneration",0,"SelfHeal","Self Regeneration is a technique known to only the strongest of medical ninja. It allows them to heal themselves by converting their chakra into life force, healing their wounds and vital organs.","Ninjutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<19)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
							else if(!(locate(/obj/SkillCards/Chikatsu) in usr.LearnedJutsus))
								usr<<"You need to learn Chikatsu first!";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chikatsu first!";return
			GenerationMastery
				name="Self Healing Mastery"
				icon_state="GenerationMastery"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=2
				var/cost=2
				Click()
					if(locate(/obj/SkillCards/SelfHeal) in usr.LearnedJutsus)
						if(2<=usr.GenerationMastery)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] is a passive raised by those who have learned to sustain their ability to heal themselves. Reducing Chakra Cost, and raises the rate at which you heal for each point.How to Train it: [price] [usr.GenerationMastery]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.GenerationMastery++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
									return
					else
						usr<<"You must know Self Heal first!";return
			ChakraNoMesu
				icon_state="ChakraNoMesu"
				Click()
					if(locate(/obj/SkillCards/Shousen) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=12)
								if(usr.NinjutsuKnowledge>150)
									usr.LearnJutsu("Chakra No Mesu",0,"ChakraNoMesu","Chakra No Mesu is scapeling technique that allow Medics to rip open bodies for surgery. It can be used for offensive tactics also, though.","Ninjutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<11)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Shousen first!";return
			Leg_Slice
				icon_state="ChakraNoMesu"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Leg Slice: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/Leg_Slice) in usr.LearnedJutsus))
							if((usr.GenSkill+(usr.ChakraC/25))>=15)
								if(usr.ScalpelMastery>=2)
									if(usr.NinjutsuKnowledge>150)
										usr.LearnJutsu("Leg Slice",0,"Leg_Slice"," Leg Slice is a technique utilizing the chakra Scalpels to slice the legs of the victim, rendering them from Running.","Ninjutsu")
									else
										usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<12)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			Muscle_Slice
				icon_state="ChakraNoMesu"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Muscle Slice: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/Muscle_Slice) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=14)
								if(usr.ScalpelMastery>=2)
									if(usr.NinjutsuKnowledge>150)
										usr.LearnJutsu("Muscle Slice",0,"Muscle_Slice","Muscle Slice is a technique utilizing the chakra scalpels, causing the opponent to bleed severly over time.","Ninjutsu")
									else
										usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<12)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			Neck_Slice
				icon_state="ChakraNoMesu"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Neck Slice: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/Neck_Slice) in usr.LearnedJutsus))
							if(usr.GenSkill>=8)
								if(usr.ScalpelMastery>=1)
									if(usr.NinjutsuKnowledge>150)
										usr.LearnJutsu("Neck Slice",0,"Neck_Slice","Neck Slice is a technique utilizing the chakra scalpels, causing the opponent to feel massive pain once struck in the neck..","Ninjutsu")
									else
										usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<8)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			DNAExtract
				icon_state="ChakraNoMesu"
				Click()
					if(usr.blevel=="B"||usr.blevel=="C"||usr.blevel=="D"||usr.blevel=="E")
						usr<<"DNA Extract: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/DNAExtract) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=14)
								if(usr.ScalpelMastery>=2)
									if(usr.NinjutsuKnowledge>7000)
										usr.LearnJutsu("DNA Extraction",0,"DNAExtract","D.N.A. Extract is a technique that allows the user to literally extract blood samples from a body.","Ninjutsu")
									else
										usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<15)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			EyeExtract
				icon_state="ChakraNoMesu"
				Click()
					if(usr.blevel=="B"||usr.blevel=="C"||usr.blevel=="D"||usr.blevel=="E")
						usr<<"Eye Extract: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/EyeExtract) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=14)
								if(usr.ScalpelMastery>=2)
									if(usr.NinjutsuKnowledge>7500)
										usr.LearnJutsu("Eye Extraction",0,"EyeExtract","Eye Extraction is an advanced Medical Ninjutsu technique, utilizing Chakra Scapels to incise a person's eye, making it removable.","Ninjutsu")
									else
										usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<14)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			ScalpelMastery
				name="Scalpel Mastery"
				icon_state="ChakraNoMesuUpgrade"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=2
				var/cost=1
				Click()
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(usr.GenSkill+(usr.ChakraC/25)<15)
							usr<<"You don't have enough control over your chakra to learn this.";return
						if(2<=usr.ScalpelMastery)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] is a passive proving your knowledge of Chakra Scalpels; enabling you to learn techniques for them .How to Train it: [price] [usr.ScalpelMastery]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.ScalpelMastery++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
									return
					else
						usr<<"You must know Chakra Scaples first!";return
			ChakraAbsorbtion
				icon_state="ChakraAbsorb"
				Click()
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/ChakraAbsorb) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=17)
								if(usr.NinjutsuKnowledge>500)
									usr.LearnJutsu("Chakra Absorbtion Technique",0,"ChakraAbsorb","Chakra Absorbtion Technique is a very powerful Jutsu that allows the user to steal the chakra from a living being once they get close enough just by placing their hand upon them.","Ninjutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<15)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return

						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			ChakraLeech
				name="Chakra Leech"
				icon_state="ChakraAbsorb"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=2
				var/cost=2
				Click()
					if(locate(/obj/SkillCards/ChakraAbsorb) in usr.LearnedJutsus)
						if(2<=usr.ChakraLeech)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] is a passive for those who want to strengthen their Chakra Absorbtion Technique. This causes chakra to be drained at a much faster rate, along with a slightly increase in drain amount. How to Train it: [price] [usr.ChakraLeech]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.ChakraLeech++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
									return
					else
						usr<<"You must know Chakra Absorb first!";return
			Oukashou
				icon_state="Oukashou"
				Click()
					if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/Oukashou) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=18)
								if(usr.NinjutsuKnowledge>300)
									usr.LearnJutsu("Oukashou",0,"Oukashou","Oukashou is a jutsu that generates chakra into the user hand to release for a strong taijutsu attack!","Taijutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<15)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Chakra Scaples first!";return
			AdvanceChakraControl
				name="Advanced Chakra Control"
				icon_state="Oukashou"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=2
				var/cost=2
				Click()
					if(locate(/obj/SkillCards/Oukashou) in usr.LearnedJutsus)
						if(2<=usr.OukashouMastery)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] is a passive for those who have learned to fully utilize their Chakra Punching Abilities, learning to even use multiple punches per use!. How to Train it: [price] [usr.OukashouMastery]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.OukashouMastery++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
									return
					else
						usr<<"You must know Oukashou first!";return
			PoisonGas
				name="Medical Ninjutsu: Poison Gas"
				icon_state="TripleChakraWave"
				Click()
					if(!(locate(/obj/SkillCards/PoisonFog) in usr.LearnedJutsus))
						if(usr.GenSkill+(usr.ChakraC/25)>=15)
							if(usr.NinjutsuKnowledge>100)
								usr.LearnJutsu("Medical Ninjutsu: Poison Fog",0,"PoisonFog","Poison Fog is a medical Ninjutsu that creates a poisinous gass that can greatly damage the opponent.","Ninjutsu")
							else
								usr<<"You need more Ninjutsuknowledge!";return
						else if(usr.GenSkill<12)
							usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
					else
						usr<<"You have already learned [src]!";return

			PoisonMist
				name="Medical Ninjutsu: Poison Mist"
				icon_state="TripleChakraWave"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Poison Mist: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/PoisonFog) in usr.LearnedJutsus)
						if(usr.GenSkill+(usr.ChakraC/25)>=16)
							if(usr.NinjutsuKnowledge>300)
								if(usr.PoisonKnowledge>50)
									usr.LearnJutsu("Medical Ninjutsu: Poison Mist",0,"PoisonMist","Poison Mist is a medical Ninjutsu that causes the opponent to make poison surround them, easily poisoning people who like to get up close.","Ninjutsu")
								else
									usr<<"You need more Poison Knowledge to learn this technique!";return
							else
								usr<<"You need more ninjutsu knowledge!";return
						else if(usr.GenSkill+(usr.ChakraC/25)<13)
							usr<<"You don't have enough control with your chakra to learn this Jutsu.";return
					else
						usr<<"You need to learn Poison Fog before you can learn this Jutsu!";return
			PoisonClone
				name="Medical Ninjutsu: Poison Clone Release"
				icon_state="PoisonClone"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Poison Fog Clone: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/PoisonMist) in usr.LearnedJutsus)
						if(usr.GenSkill+(usr.ChakraC/25)>18)
							if(usr.NinjutsuKnowledge>350)
								if(usr.PoisonKnowledge>50)
									usr.LearnJutsu("Medical Ninjutsu: Poison Clone Release",0,"PoisonClone","Poison Clone Release is a medical Ninjutsu allowing the medic to enfuse their bunshin with poison gas, causing poison gas to spew from the bunshin once it's destroyed.","Ninjutsu")
								else
									usr<<"You need more Poison Knowledge to learn this technique";return
							else
								usr<<"You need more Ninjutsu Knowledge!";return
						else if(usr.GenSkill+(usr.ChakraC/25)<18)
							usr<<"You don't have enough control with your chakra to learn this Jutsu.";return
					else
						usr<<"You need to learn Poison Mist and Clone Jutsu before you can learn this Jutsu!";return


			ChakraMode
				icon_state="Meisagakure"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Chakra Mode: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/SelfHeal) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/ChakraMode) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=28)
								if(usr.NinjutsuKnowledge>750)
									usr.LearnJutsu("Forbidden Medical Ninjutsu: Chakra Release",0,"ChakraMode","Chakra Release, a forbidden Medical Ninjutsu, is known to only a few medics within the World due to it's extreme power. Do not use this jutsu unless you're willing to face the consequences.","Ninjutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<24)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Self Heal first!";return
			ForbiddenMedicalKnowledge
				name="Forbidden Medical Ninjutsu Knowledge"
				icon_state="Meisagakure"
				var/price="By raising it with leftover Elemental Points"
				var/maxprice=1
				var/cost=3
				Click()
					if(locate(/obj/SkillCards/ChakraMode) in usr.LearnedJutsus)
						if(1<=usr.ChakraModeMastery)
							usr<<"You cannot raise this any further." ; return
						usr<<sound('SFX/click1.wav',0)
						alert(usr,"[src] has learned the most dangerous Medical Ninjutsu, but you can increase the strength of it with this passive.... How to Train it: [price] [usr.ChakraModeMastery]/[maxprice]","[src.name]")
						if(usr.ElementalPoints>=cost&&!usr.clicking)
							usr.clicking=1
							switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
								if("Yes")
									usr.ChakraModeMastery++;usr.ElementalPoints-=cost;usr.clicking=0
								else
									usr.clicking=0
					else
						usr<<"You must know Chakra Mode first!";return
			ChakraKick
				icon_state="Oukashou"
				Click()
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Heaven Kick of Pain: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/Oukashou) in usr.LearnedJutsus)
						if(!(locate(/obj/SkillCards/ChakraKick) in usr.LearnedJutsus))
							if(usr.GenSkill+(usr.ChakraC/25)>=22)
								if(usr.NinjutsuKnowledge>500)
									usr.LearnJutsu("Cherry Blossom Slam",0,"ChakraKick","Chakra Blossom Slam is a much more powerful version of Cherry Blossom Collision, but utilizing the leg for a much more devastating attack.","Ninjutsu")
								else
									usr<<"You need more Ninjutsuknowledge!";return
							else if(usr.GenSkill<19)
								usr<<"You don't have enough Control with your chakra to learn this Jutsu..";return
						else
							usr<<"You have already learned [src]!";return
					else
						usr<<"You must know Oukashou first!";return

		//Passives
		FireChakra
			name="Fire Mastery"
			icon_state="FireChakra"
			var/price="Using fire based techniques.."
			var/maxprice=20
			var/cost=1
			Click()
				if(usr.FireChakra>19)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				alert(usr,"[src] is a passive that allows you to increase your damage done by fire jutsu. How to Train it: [price] [usr.FireChakra]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							usr.FireChakra++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		KatonKnowledge
			name="Katon Knowledge"
			icon_state="KatonKnowledge"
			var/price="Using fire based techniques.."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to learn stronger fire based techniques. How to Train it: [price] [usr.KatonKnowledge]/[maxprice]","[src.name]")
		Broil
			icon_state="Broil"
			var/maxprice=5
			var/cost=1
			Click()
				if(5<=usr.Broil)
					usr<<"You cannot raise this any further." ; return
				alert(usr,"[src] is a passive that increases your chance to leave your opponents with a burn, as well as the duration of the burn. Current: [usr.Broil]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<50*(usr.Broil+1))
								usr<<"You need [50*(usr.Broil+1)] Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Broil++;usr.ElementalPoints-=cost;usr.clicking=0

						else
							usr.clicking=0
							return
		Inferno
			icon_state="Inferno"
			var/maxprice=3
			var/cost=1
			Click()
				if(3<=usr.Inferno)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Goukakyuu) in usr.LearnedJutsus))
					usr<<"You need to know Katon Goukakyuu first!";return
				for(var/obj/SkillCards/Goukakyuu/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the size of your Fireball (Goukakyuu) Jutsu. Current: [usr.Inferno]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<25*(usr.Inferno+1))
								usr<<"You need [25*(usr.Inferno+1)] Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Inferno++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Housenka_Expert
			icon_state="HousenkaExpert"
			var/maxprice=2
			var/cost=2
			Click()
				if(2<=usr.HousenkaExpert)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Housenka) in usr.LearnedJutsus))
					usr<<"You need to know Katon Housenka first!";return
				for(var/obj/SkillCards/Housenka/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the number of fireballs shot when using Phoenix Flower (Housenka) Jutsu. Current: [usr.HousenkaExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<25*(usr.HousenkaExpert+1))
								usr<<"You need [25*(usr.HousenkaExpert+1)] Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.HousenkaExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Dragons_Rage
			icon_state="DragonsRage"
			var/maxprice=2
			var/cost=2
			Click()
				if(2<=usr.DragonsRage)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Ryuuka) in usr.LearnedJutsus))
					usr<<"You need to know Ryuuka first!";return
				for(var/obj/SkillCards/Ryuuka/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the range of your fire style jutsus' explosions. Current: [usr.DragonsRage]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<100*(usr.DragonsRage+1))
								usr<<"You need [100*(usr.DragonsRage+1)] Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DragonsRage++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Dragon_Tamer
			icon_state="DragonTamer"
			var/maxprice=3
			var/cost=2
			Click()
				if(3<=usr.DragonTamer)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Gouryuuka) in usr.LearnedJutsus))
					usr<<"You need to know Katon Gouryuuka first!";return
				for(var/obj/SkillCards/Gouryuuka/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the mastery of your dragon heads shot when using Grand Dragon Fire (Gouryuuka) Jutsu.. The Strength, Speed, and Chakra Drain will all increase(Drain will lower). It also increases how fast you are able to master Jutsu such as Gouryuuka and Chou Houka much quicker. Current: [usr.DragonTamer]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<200*(usr.DragonTamer+1))
								usr<<"You need [200*(usr.DragonTamer+1)] Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DragonTamer++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		FireImmunity
			name="Flame Resistance"
			icon_state="FireImmunity"
			var/maxprice=5
			var/cost=1
			Click()
				if(5<=usr.FireImmunity)
					usr<<"You cannot raise this any further." ; return
				if(usr.FireChakra<1)
					usr<<"You need at least 1 point in Fire Master before you can raise this passive!";return
				alert(usr,"[src] is a passive that increases your resistance to your own fire, so you can use them at close range with less recoil. Damage is reduced by 15% for each point. Current: [usr.FireImmunity]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<35*(usr.FireImmunity+1))
								usr<<"You need [35*(usr.FireImmunity+1)] Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.FireImmunity++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		BlueFire
			name="Blue Fire"
			icon_state="BlueFlames"
			var/maxprice=1
			var/cost=7
			Click()
				if(1<=usr.BlueFire)
					usr<<"You cannot raise this any further." ; return
				if(usr.Magma==1)
					usr<<"You already have Magma, you can't learn this!";return
				if(usr.BlueFire==1)
					usr<<"You already have this.";return
				if(!(locate(/obj/SkillCards/KaryuuEndan) in usr.LearnedJutsus)||(!(locate(/obj/SkillCards/GoukaMekkyakuNoJutsu) in usr.LearnedJutsus)))
					usr<<"You need to know Katon Karyuu Endan first and Mekkyaku first!";return
				for(var/obj/SkillCards/KaryuuEndan/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				for(var/obj/SkillCards/GoukaMekkyakuNoJutsu/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the power of your Fire Style Jutsus by 1.5x and also permanently changes the color of them to blue. Current: [usr.BlueFire]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<1250)
								usr<<"You need 1250 Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BlueFire=1;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Magma
			name="Magma"
			icon_state="Magma"
			var/maxprice=1
			var/cost=5
			Click()
				if(usr.Magma==1)
					usr<<"You cannot raise this any further." ; return
				if(usr.Magma==1)
					usr<<"You already have this.";return
				if(usr.BlueFire==1)
					usr<<"You already have Blue Fire, you can't learn this!";return
			//	if(!(locate(/obj/SkillCards/ChouHouka) in usr.LearnedJutsus))
			//		usr<<"You need to know Chou Houka and Katon Ryuusenka first!";return
				if(!(locate(/obj/SkillCards/KatonDragonWar) in usr.LearnedJutsus))
					usr<<"You need to know both Katon Ryuusenka first!";return
				for(var/obj/SkillCards/KatonDragonWar/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the residual heat around your fireballs, so opponents are damanged just by being near them. Current: [usr.Magma]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.KatonKnowledge<1000)
								usr<<"You need 1000 Katon Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Magma=1;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		SuitonKnowledge
			name="Suiton Knowledge"
			icon_state="SuitonKnowledge"
			var/price="Using water based techniques.."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to learn stronger water based techniques. How to Train it: [price] [usr.SuitonKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		WaterChakra
			name="Water Mastery"
			icon_state="WaterChakra"
			var/price="Using water based techniques.."
			var/maxprice=20
			var/cost=1
			Click()
				if(usr.WaterChakra>19)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to increase your damage done by water jutsu. How to Train it: [price] [usr.WaterChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							usr.WaterChakra++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		WaterPressure
			name="Water Pressure"
			icon_state="WaterPressure"
			var/maxprice=5
			var/cost=1
			Click()
				if(10<=usr.WaterPressure)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Mizurappa) in usr.LearnedJutsus))
					usr<<"You need to know Mizurappa first!";return
				for(var/obj/SkillCards/Mizurappa/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] Increases the pressure of water projectiles dealing 15% more damage for each point.. Current: [usr.WaterPressure]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking&&usr.WaterPressure<5)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.SuitonKnowledge<35*(usr.WaterPressure+1))
								usr<<"You need [35*(usr.WaterPressure+1)] Suiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WaterPressure++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		WaterSpawn
			name="Water Creation"
			icon_state="WaterSpawn"
			var/maxprice=3
			var/cost=2
			Click()
				if(3<=usr.WaterSpawn)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/WaterCreation) in usr.LearnedJutsus))
					usr<<"You need to know Water Creation first!";return
				for(var/obj/SkillCards/WaterCreation/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that allows you to utilize water jutsus without an existing water source. They will be weaker than normal (50%), however, but the damage increases by 10% for each additional point. Current: [usr.WaterSpawn]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.SuitonKnowledge<50*(usr.WaterSpawn+1))
								usr<<"You need [50*(usr.WaterSpawn+1)] Suiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WaterSpawn++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		OneWithWater
			name="One With Water"
			icon_state="OneWithWater"
		SuikoudanMastery
			icon_state="SuikoudanMastery"
			var/maxprice=4
			var/cost=1
			Click()
				if(4<=usr.WaterSharksExpert)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Suikoudan) in usr.LearnedJutsus))
					usr<<"You need to know Suikoudan first!";return
				for(var/obj/SkillCards/Suikoudan/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the number of water sharks created when you use Man Eating Water Sharks (Suikoudan) Jutsu. Current: [usr.WaterSharksExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.SuitonKnowledge<75*(usr.WaterSharksExpert+1))
								usr<<"You need [75*(usr.WaterSharksExpert+1)] Suiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WaterSharksExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		SuiyuudanMastery
			icon_state="SuiryuudanMastery"
			var/maxprice=2
			var/cost=2
			Click()
				if(2<=usr.WaterDragonMaster)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Suiryuudan) in usr.LearnedJutsus))
					usr<<"You need to know Suiryuudan first!";return
				for(var/obj/SkillCards/Suiryuudan/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the efficiency of your Water Dragon (Suiryuudan) Jutsu. Current: [usr.WaterDragonMaster]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.SuitonKnowledge<100*(usr.WaterDragonMaster+1))
								usr<<"You need [100*(usr.WaterDragonMaster+1)] Suiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WaterDragonMaster++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		BakuSuihouExpert
			icon_state="BakuExpert"
			var/maxprice=2
			var/cost=2
			Click()
				if(2<=usr.BakuExpert)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/BakuSuishouha) in usr.LearnedJutsus))
					usr<<"You need to know Baku Suishouha first!";return
				for(var/obj/SkillCards/BakuSuishouha/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the range your Bursting Collision Water Waves (Baku Suishouha) Jutsu covers when used. Current: [usr.BakuExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.SuitonKnowledge<125*(usr.BakuExpert+1))
								usr<<"You need [125*(usr.BakuExpert+1)] Suiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BakuExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		RaitonKnowledge
			name="Raiton Knowledge"
			icon_state="RaitonKnowledge"
			var/price="Using lightning based techniques."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				sd_Alert(usr, "[src] is a passive that allows you to learn stronger lightning based techniques. How to Train it: [price] [usr.RaitonKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		LightningChakra
			name="Lightning Mastery"
			icon_state="LightningChakra"
			var/price="Using lightning based techniques.."
			var/maxprice=20
			var/cost=1
			Click()
				if(usr.LightningChakra>19)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to increase your damage done by lightning jutsu. How to Train it: [price] [usr.LightningChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							usr.LightningChakra++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Static
			name="Static"
			icon_state="Static"
			var/maxprice=3
			var/cost=2
			Click()
				if(3<=usr.Static)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/IkazuchiKiba) in usr.LearnedJutsus))
					usr<<"You need to know Ikazuchi Kiba first!";return
				for(var/obj/SkillCards/IkazuchiKiba/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the duration your opponents are stunned for upon being struck with a Lightning Style Jutsu. Current: [usr.Static]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.RaitonKnowledge<50*(usr.Static+1))
								usr<<"You need [50*(usr.Static+1)] Raiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Static++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Electromagnetivity
			name="Electromagnetivity"
			icon_state="Electromagnetivity"
			var/maxprice=3
			var/cost=2
			Click()
				if(3<=usr.Electromagnetivity)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Tatsumaki) in usr.LearnedJutsus))
					usr<<"You need to know Rairyuu Tatsumaki first!";return
				for(var/obj/SkillCards/Tatsumaki/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the chance you will temporarily screw up an opponent's nervous system upon being struck with a Lightning Style Jutsu. Current: [usr.Electromagnetivity]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.RaitonKnowledge<100*(usr.Electromagnetivity+1))
								usr<<"You need [100*(usr.Electromagnetivity+1)] Raiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Electromagnetivity++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		ShockTreatment
			name="Shock Treatment"
			icon_state="ShockTreatment"
			var/maxprice=5
			var/cost=2
			Click()
				if(5<=usr.ShockTreatment)
					usr<<"You cannot raise this any further.";return
				if(!(locate(/obj/SkillCards/Raikiri) in usr.LearnedJutsus))
					usr<<"You need to know Raikiri first!";return
				for(var/obj/SkillCards/Raikiri/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that allows your raiton to cause such strong electrucutions they have the ability to screw with the brain, disabling usage of handseals for a while.Each point raises the chance by 10%. Current: [usr.ShockTreatment]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental points per point.") in list("No","Yes"))
						if("Yes")
							if(usr.RaitonKnowledge<100*(usr.ShockTreatment+1))
								usr<<"You need [100*(usr.ShockTreatment+1)] Raiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.ShockTreatment++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return


		RaikyuuExpert
			name="Raikyuu Expert"
			icon_state="RaikyuuExpert"
			var/maxprice=3
			var/cost=1
			Click()
				if(3<=usr.RaikyuuExpert)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Raikyuu) in usr.LearnedJutsus))
					usr<<"You need to know Raikyuu first!";return
				for(var/obj/SkillCards/Raikyuu/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that upgrades the size and power of your Lightning Ball (Raikyuu) Jutsu. Current: [usr.RaikyuuExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.RaitonKnowledge<50*(usr.RaikyuuExpert+1))
								usr<<"You need [50*(usr.RaikyuuExpert+1)] Raiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.RaikyuuExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		ChidoriSenbonExpert
			name="Chidori Senbon Expert"
			icon_state="ChidoriSenbon"
			var/maxprice=2
			var/cost=1
			Click()
				if(usr.ChidoriSenbonExpert>2)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/ChidoriSenbon) in usr.LearnedJutsus))
					usr<<"You need to know Chidori Senbon first!";return
				alert(usr,"[src] is a passive that increases the number of electrical senbon thrown when using Chidori Senbon Jutsu. Current: [usr.ChidoriSenbonExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.RaitonKnowledge<75*(usr.ChidoriSenbonExpert+1))
								usr<<"You need [75*(usr.ChidoriSenbonExpert+1)] Raiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.ChidoriSenbonExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		ChidoriNagashiExpert
			name="Chidori Nagashi Expert"
			icon_state="NagashiExpert"
			var/maxprice=2
			var/cost=1
			Click()
				if(usr.NagashiExpert>2)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/ChidoriNagashi) in usr.LearnedJutsus))
					usr<<"You need to know Chidori Nagashi first!";return
				alert(usr,"[src] is a passive that increases the range of your Chidori Current (Nagashi) Jutsu. Current: [usr.NagashiExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.RaitonKnowledge<90*(usr.NagashiExpert+1))
								usr<<"You need [90*(usr.NagashiExpert+1)] Raiton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.NagashiExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		FuutonKnowledge
			name="Fuuton Knowledge"
			icon_state="FuutonKnowledge"
			var/price="Using wind based techniques."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to learn stronger wind based techniques. How to Train it: [price] [usr.FuutonKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		WindChakra
			name="Wind Mastery"
			icon_state="WindChakra"
			var/price="Using wind based techniques.."
			var/maxprice=20
			var/cost=1
			Click()
				if(usr.WindChakra>19)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to increase your damage done by wind jutsu. How to Train it: [price] [usr.WindChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							usr.WindChakra++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		ReppushouExpert
			icon_state="ReppushouExpert"
			var/maxprice=3
			var/cost=1
			Click()
				if(3<=usr.ReppushouExpert)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Reppushou) in usr.LearnedJutsus))
					usr<<"You need to know Reppushou first!";return
				for(var/obj/SkillCards/Reppushou/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the size of your Wind Palm (Reppushou) Jutsu. Current: [usr.ReppushouExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<70*(usr.ReppushouExpert+1))
								usr<<"You need [70*(usr.ReppushouExpert+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.ReppushouExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		DaitoppaMastery
			icon_state="DaitoppaMastery"
			var/maxprice=2
			var/cost=2
			Click()
				if(usr.DaitoppaExpert>2)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Daitoppa) in usr.LearnedJutsus))
					usr<<"You need to know Daitoppa first!";return
				for(var/obj/SkillCards/Daitoppa/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the range of your Great Breakthrough (Daitoppa) Jutsu. Current: [usr.DaitoppaExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&usr.DaitoppaExpert<2&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<100*(usr.DaitoppaExpert+1))
								usr<<"You need [100*(usr.DaitoppaExpert+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DaitoppaExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		WindSwordMastery
			icon_state="WindSwordMastery"
			var/maxprice=2
			var/cost=1
			Click()
				if(usr.WindSwordMastery>2)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/Yaiba) in usr.LearnedJutsus))
					usr<<"You need to know Kaze Yaiba first!";return
				for(var/obj/SkillCards/Yaiba/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the range and damage of your Wind Sword (Kaze Yaiba) Jutsu. Current: [usr.WindSwordMastery]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&usr.WindSwordMastery<2&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<60*(usr.WindSwordMastery+1))
								usr<<"You need [60*(usr.WindSwordMastery+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WindSwordMastery++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		VacuumSphereExpert
			icon_state="VacuumSphere"
			var/maxprice=2
			var/cost=2
			Click()
				if(usr.VacuumSphereExpert>2)
					usr<<"You cannot raise this any further." ; return
				if(!(locate(/obj/SkillCards/VacuumSphere) in usr.LearnedJutsus))
					usr<<"You need to know Vacuum Sphere first!";return
				for(var/obj/SkillCards/VacuumSphere/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr,"[src] is a passive that increases the number of shots fired when you use Vacuum Sphere Jutsu. Current: [usr.VacuumSphereExpert]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<120*(usr.VacuumSphereExpert+1))
								usr<<"You need [120*(usr.VacuumSphereExpert+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.VacuumSphereExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		WindVelocity
			icon_state="WindVelocity"
			var/maxprice=5
			var/cost=1
			Click()
				return
			/*
				if(5<=usr.WindVelocity)
					usr<<"You cannot raise this any further." ; return
				if(usr.WindChakra<1)
					usr<<"You need at least 1 / 20 Wind Mastery before you can view this passive!";return
				alert(usr,"[src] is a passive that increases the speed of your Wind Jutsus. Current: [usr.WindVelocity]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<20*(usr.WindVelocity+1))
								usr<<"You need [20*(usr.WindVelocity+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WindVelocity++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
							*/
		Torrential_Winds
			icon_state="TorrentialWinds"
			var/maxprice=3
			var/cost=1
			Click()
				if(3<=usr.TorrentialWinds)
					usr<<"You cannot raise this any further." ; return
	//			if(usr.WindVelocity<2)
	//				usr<<"You need at least 2 / 5 Wind Velocity before you can view this passive!";return
				alert(usr,"[src] is a passive that leaves a trail of streaming air, that will damage anyone caught in them, behind all your Wind Jutsus if you press and hold Z before firing them. Current: [usr.TorrentialWinds]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<100*(usr.TorrentialWinds+1))
								usr<<"You need [100*(usr.TorrentialWinds+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.TorrentialWinds++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Tornado
			icon_state="Tornado"
			var/maxprice=1
			var/cost=5
			Click()
				if(usr.Tornado>1)
					usr<<"You cannot raise this any further." ; return
				alert(usr,"[src] is a passive gives your Wind Jutsus the ability to suck in all opponents in a 1 tile range around them. Current: [usr.Tornado]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.FuutonKnowledge<200*(usr.Tornado+1))
								usr<<"You need [200*(usr.Tornado+1)] Fuuton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Tornado++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		EarthChakra
			name="Earth Mastery"
			icon_state="EarthChakra"
			var/price="Using earth based techniques.."
			var/maxprice=20
			var/cost=1
			Click()
				if(usr.EarthChakra>19)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to increase your damage done by earth jutsu. How to Train it: [price] [usr.EarthChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							usr.EarthChakra++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		DotonKnowledge
			name="Doton Knowledge"
			icon_state="DotonKnowledge"
			var/price="Using earth based techniques.."
			var/maxprice=20
			Click()

				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that allows you to learn stronger earth based techniques. How to Train it: [price] [usr.DotonKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Like_A_Stone
			icon_state="LikeAStone"
			var/maxprice=4
			var/cost=1
			Click()
				if(usr.LikeAStone>=4)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that increases your resistance to unwanted movement from jutsus or other forms of attacks. Current: [usr.LikeAStone]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<50*(usr.LikeAStone+1))
								usr<<"You need [50*(usr.LikeAStone+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.LikeAStone++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Like_A_Mountain
			icon_state="LikeAMountain"
			var/maxprice=4
			var/cost=2
			Click()
				if(usr.LikeAMountain>=4)
					usr<<"You cannot raise this any further."
					return
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that increases your resistance to being stunned or flinching from punches for each point. Current: [usr.LikeAMountain]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<60*(usr.LikeAMountain+1))
								usr<<"You need [60*(usr.LikeAMountain+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.LikeAMountain++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		DangoExpert
			icon_state="BoulderExpert"
			var/maxprice=1
			var/cost=2
			Click()
				if(usr.BoulderExpert>1)
					usr<<"You cannot raise this any further."
					return
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/DoryoDango) in usr.LearnedJutsus))
					usr<<"You need to know Doryo Dango first!";return
				for(var/obj/SkillCards/DoryoDango/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr, "[src] is a passive that increases the speed of your boulder, as well as the damage by 1.5x normal. Current: [usr.BoulderExpert]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.BoulderMaster)
					usr<<"You already have Boulder Master so you cannot obtain this passive.";return
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<75*(usr.BoulderExpert+1))
								usr<<"You need [75*(usr.BoulderExpert+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BoulderExpert++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		DangoMaster
			icon_state="BoulderMaster"
			var/maxprice=1
			var/cost=2
			Click()
				if(usr.BoulderMaster>1)
					usr<<"You cannot raise this any further."
					return
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/DoryoDango) in usr.LearnedJutsus))
					usr<<"You need to know Doryo Dango first!";return
				for(var/obj/SkillCards/DoryoDango/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr, "Upgrades size of boulder and damage multiples 1.75x normal. Current: [usr.BoulderMaster]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.BoulderExpert)
					usr<<"You already have Boulder Expert so you cannot obtain this passive.";return
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<75*(usr.BoulderMaster+1))
								usr<<"You need [75*(usr.BoulderMaster+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.BoulderMaster++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		DoryuudanMaster
			icon_state="DoryuudanMaster"
			var/maxprice=3
			var/cost=1
			Click()
				if(usr.DoryuudanMaster>=3)
					usr<<"You cannot raise this any further."
					return
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/Doryuudan) in usr.LearnedJutsus))
					usr<<"You need to know Doryuudan first!";return
				for(var/obj/SkillCards/Doryuudan/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr, "Increases number of earth spikes shot out by 2 when using Mud Dragon Jutsu. Current: [usr.DoryuudanMaster]/[maxprice]","[src.name]")
				if(usr.ElementalPoints>=cost&&!usr.clicking&&usr.DoryuudanMaster<3)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<80*(usr.DoryuudanMaster+1))
								usr<<"You need [80*(usr.DoryuudanMaster+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DoryuudanMaster++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		DoryuuhekiExpert
			icon_state="DoryuuhekiExpert"
		SoftEarth
			icon_state="SoftEarth"
			var/maxprice=4
			var/cost=2
			Click()
				if(!(locate(/obj/SkillCards/DorukiGaeshi) in usr.LearnedJutsus))
					usr<<"You need to know Doruki Gaeshi first!";return
				if(usr.SoftEarth>4)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				if(usr.EarthChakra<10)
					usr<<"You need 10 / 20 Earth Mastery first!";return
				alert(usr, "[src] is a passive that raises the efficiency of your Earth Style jutsus when used on muddy turfs or other forms of soft earth. Current: [usr.SoftEarth]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<75*(usr.SoftEarth+1))
								usr<<"You need [75*(usr.SoftEarth+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.SoftEarth++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
		Call_of_the_Swamp
			icon_state="CalloftheSwamp"
			var/maxprice=4
			var/cost=1
			Click()
				if(usr.CalloftheSwamp>3)
					usr<<"You cannot raise this any further." ; return
				usr<<sound('SFX/click1.wav',0)
				if(!(locate(/obj/SkillCards/YomiNuma) in usr.LearnedJutsus))
					usr<<"You need to know Yomi Numa first!";return
				for(var/obj/SkillCards/YomiNuma/P in usr.LearnedJutsus)
					if(P:Copied==1)
						usr<<"You used Sharingan Copy to learn this Jutsu! You need to know how to preform it originally!"
						return
				alert(usr, "[src] is a passive that increases the range of your swamp by 2 tiles for each point. Current: [usr.CalloftheSwamp]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.ElementalPoints>=cost&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points? COST: [cost] Elemental Points per point.") in list ("No","Yes"))
						if("Yes")
							if(usr.DotonKnowledge<100*(usr.CalloftheSwamp+1))
								usr<<"You need [100*(usr.CalloftheSwamp+1)] Doton Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.CalloftheSwamp++;usr.ElementalPoints-=cost;usr.clicking=0
						else
							usr.clicking=0
							return
//ClanPassives
turf
	Skilltree/Passives/ClanPassives
		layer = MOB_LAYER+99
		layer= 99
		icon='Icons/Jutsus/Skilltree.dmi'
		AkametsukiMastery
			name="Akametsuki Mastery"
			icon_state="AkametsukiMastery"
			var/price="Increases as the user has Akametsuki On."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				sd_Alert(usr, "[src] increases mastery over Akametsuki. Needed to reach more forms and also decreases chakra usage. How to Train it: [price] [usr.AkametsukiMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		ParticleMastery
			name="Particle Mastery"
			icon_state="ParticleMastery"
			var/price="Increases as the user uses their chakra-based particle techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				sd_Alert(usr, "[src] allows the user to perform their clan-related techniques. How to Train it: [price] [usr.ParticleMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Distortion
			name="Distortion"
			icon_state="Distortion"
			var/price="Increases as the user performs clones."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				sd_Alert(usr, "[src] increases the mastery over the Particle Clones. How to Train it: [price] [usr.Distortion]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		ParticleUsage
			name="Particle Usage"
			icon_state="ParticleUsage"
			var/price="Increases as the user performs particles."
			var/maxprice=10
			Click()
				usr<<sound('click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				sd_Alert(usr, "Particles normally require 90% chakra for them to be released from your body, but as you gain control you can reduce that max amount of chakra by 5% each point. How to Train it: [price] [usr.ParticleUsage]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

//Aburame
		BugManipulation
			name="Bug Manipulation"
			icon_state="BugManipulation"
			var/price="Naturally increases for an Aburame."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				sd_Alert(usr, "[src] increases the amount of bugs that is made by the user each second. How to Train it: [price] [usr.BugManipulation]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		BugMastery
			name="Bug Mastery"
			icon_state="BugMastery"
			var/price="Increases the more you use and summon/unsummon your bugs."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				sd_Alert(usr, "[src] allows you to get new Kikaichu Jutsu. How to Train it: [price] [usr.BugMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		BugKeeper
			name="Bug Keeper"
			icon_state="BugKeeper"
			var/price="Increases the more you use and summon/unsummon your bugs after you've mastered Bug Mastery."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] allows you to get new Kikaichu Jutsu. How to Train it: [price] [usr.BugKeeper]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Feast
			name="Feast"
			icon_state="Feast"
			var/price="Increases the more your Kikaichu feast on someone."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] allows you to get new Kikaichu Jutsu. How to Train it: [price] [usr.Feast]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		BugCapacity
			name="Bug Capacity"
			icon_state="BugCapacity"
			var/price="Naturally increases for an Aburame."
			var/maxprice=15
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the maximum amount of bugs an Aburame can hold. How to Train it: [price] [usr.BugCapacity]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		KekkaiHealth
			name="Kekkai Health"
			icon_state="KekkaiHealth"
			var/price="Naturally increases for an Aburame."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the maximum health of bugs by 25 a point. How to Train it: [price] [usr.KekkaiHealth]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		KekkaiCap
			name="Kekkai Cap"
			icon_state="KekkaiCap"
			var/price="Naturally increases for an Aburame."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the maximum damage a bug can deal by 50. How to Train it: [price] [usr.KekkaiCap]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		KekkaiDrain
			name="Kekkai Drain"
			icon_state="KekkaiDrain"
			Click()
				usr<<sound('SFX/click1.wav',0)
				usr.LearnJutsu("Kikkaichu Drain",0,"KikkaichuDrain","Kikkaichu Drain is a technique utilizing the Female bugs and the Kikkaichu's ability to drain chakra, letting them drain the chakra of people with female bugs on them.","Ninjutsu")
		KekkaiTracking
			name="Kekkai Tracking"
			icon_state="KekkaiTracking"
			Click()
				usr<<sound('SFX/click1.wav',0)
				usr.LearnJutsu("Kikkaichu Tracking",0,"KonchuuTracking","Kikkaichu Tracking is a technique utilizing an Aburame's Female bugs, allowing theAburame to track down these females and find the location of an enemy.","Ninjutsu")
///////////////////////////////////////////////Sarutobi Clan///////////////////////////////////////////////////////////////////
		WillOfFire
			name="Will Of Fire"
			icon_state="WillOfFire"
			var/price="Naturally increases for an Sarutobi"
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src]The will to never give up increases your will power.. How to Train it: [price] [usr.WillOfFire]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		JutsuMastery
			name="Jutsu Mastery"
			icon_state="JutsuMastery"
			var/price="Increases the more you use elemental Ninjutsu"
			var/maxprice=25
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src]For every point your ninjutsu damage increases for elemental techniques.. How to Train it: [price] [usr.JutsuMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		HeartOfALeader
			name="Heart Of A Leader"
			icon_state="HeartOfALeader"
			var/price="Increases through combat"
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src]For every point your phy/cap/con raise by one point.. How to Train it: [price] [usr.HeartOfALeader]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		MonkeyStyle
			name="Monkey Stance"
			icon_state="MonkeyStyle"
			var/price="By attacking"
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src]Is a passive that unlocks your potential. How to Train it: [price] [usr.MonkeyStyle]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
////////////////////////Complete Sarutobi//////////////////////////////////////////////////////////////////////






/////////////////////////////////////
		ByakuganMastery
			name="Byakugan Mastery"
			icon_state="ByakuganMastery"
			var/price="By having Byakugan on."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] is a passive that enables your Byakugan and enhances it, making it better. Needed to learn new phases of Byakugan. How to Train it: [price] [usr.ByakuganMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		StanceMastery
			name="Stance Mastery"
			icon_state="StanceMastery"
			var/price="By attacking!"
			var/maxprice=75
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] is a passive that allows you to learn differences in your Hyuuga stances and learning it. How to Train it: [price] [usr.StanceMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ChakraPercision
			name="Chakra Percision"
			icon_state="ChakraPercision"
			var/price="By using Jyuken taijutsu and landing successful hits as long as Byakugan is on!"
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "The more a Hyuuga uses Jyuken the better they get at hitting tenketsu, eventually increasing the amount of chakra that is \
				taken when a tenketsu is hit. For each blow it takes away +10 more chakra \
				static damage.. How to Train it: [price] [usr.ChakraPercision]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		TenketsuAccuracy
			name="Tenketsu Accuracy"
			icon_state="TenketsuAccuracy"
			var/price="By using Jyuken taijutsu and landing successful hits as long as Byakugan is on!"
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "The more a Hyuuga uses Jyuken the better they have a chance of hitting someone's chakra tenketsu \
				each time. This passive increases the accuracy as long as Byakugan is on. \
				Increases accuracy by 4% each level. static damage.. How to Train it: [price] [usr.TenketsuAccuracy]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SensoryRange
			name="Sensory Range"
			icon_state="SensoryRange"
			var/price="By dodging with Byakugan on!"
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "Hyuuga have a higher chance of dodging weapons when Byakugan is on, because of the range. This passive increases the chance by 5% each time. Also helps guard against Jyuken Style attacks directed towards you. How to Train it: [price] [usr.SensoryRange]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Rejection
			name="Rejection"
			icon_state="Rejection"
			var/price="By dodging taijutsu successfuly!"
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "A chance to block and push back an opponet using taijutsu from any side but behind while byakugan is activated 4% chance that increase by another 4% per point. How to Train it: [price] [usr.Rejection]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		HakkeBaindo
			name="Hakke Baindo"
			icon_state="HakkeBaindo"
		ChakraFilm
			name="Chakra Film"
			icon_state="ChakraFilm"
		SuperiorityComplex
			name="Superiority Complex"
			icon_state="SuperiorityComplex"
		StrivingforSuccess
			name="Striving For Success"
			icon_state="StrivingForSuccess"
/////////////////////////////////////
		Uchiha
			name="Uchiha Mastery"
			icon_state="Uchiha"
			var/price="Naturally increases for an Uchiha!"
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that once you max it out you are able to be a full Uchiha. All Uchiha type jutsu are strengthened.. How to Train it: [price] [usr.UchihaMastery]/[maxprice] Note:: Activation Type Passive","[src.name]")//,,,,0,"400x150",,style)
		LoveAndHate
			name="Love And Hate"
			icon_state="UchihaPast"
			var/price="Learn about your Clan's horrid past"
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive to remind Uchihas of the second Uchiha Massacre by Uchiha, Argon and to give the current generation of Uchihas hope for the future..How to Train it: [price] [usr.LoveAndHate]/[maxprice]","[src.name]")
		//	name="Uchiha Mastery"
		ArgonReincarnate
			name="Reincarnation Of Argon"
			icon_state="ReincarnationArgon"
			var/price="Repeat the past of Uchiha, Argon"
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive received by Uchihas whom care not for other members of their clan, but rather just themselves..and have proven it by repeating the evil acts of Uchiha, Argon.    How to Train it: [price] [usr.ArgonReincarnate]/[maxprice]","[src.name]")
		SharinganMastery
			name="Sharingan Mastery"
			icon_state="Sharingan Mastery"
			var/price="Naturally increases the longer Sharingan is on."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] is a passive that increases the ability of Sharingan. Increasing it raises your natural reflexes with each new stage of Sharingan while it is on. How to Train it: [price] [usr.SharinganMastery]/[maxprice]","[src.name]")
		SharinganOne
			name="Sharingan Active"
			icon_state="Sharingan1"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SharinganMastery>0)
					alert(usr, "Your Sharingan is active. It only has one tomoe, but you're well on your way to becoming a powerful Uchiha.","[src.name]")
				else
					alert(usr,"Sharingan is the pride of the Uchiha Clan. One day it will activate in times of stress or need. Until then you can only wait.","[src.name]")
		SharinganOneTwo
			name="Sharingan Adept"
			icon_state="Sharingan2"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SharinganMastery>=75)
					alert(usr, "Your Sharingan is developing well, and it now contains two tomoe. You're eyes are powerful and now capable of reading handsigns, but there is still room to grow.","[src.name]")
				else
					alert(usr,"Sharingan develops in stages, and with each stage it grants it's host more and stronger abilities and enhancements. Use it more to develop it.","[src.name]")
		SharinganOneTwoThree
			name="Sharingan Mature"
			icon_state="Sharingan3"
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.TomoeThree>=1)
					alert(usr, "Your Sharingan has reach maturity. You are now a fully fledged Uchiha, but are there even further heights to reach?","[usr.TomoeThree]/[maxprice]","[src.name]")
				else
					alert(usr,"Sharingans that reach maturity of three tomoe have the ability to cast powerful genjutsu, see through and counter jutsus, and even copy them to an extent.","[usr.TomoeThree]/[maxprice]","[src.name]")
		SharCopy
			name="Sharingan Copy"
			icon_state="SharCopy"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SharinganMastery<91)
					usr<<"You need more Sharingan Mastery.";return
				usr.LearnJutsu("Sharingan Copy",0,"SharinganCopy","Sharingan Copy is one of the Sharingan's really beautiful natures, allowing you to copy a technique and use it fully until next relog.","Ninjutsu")
		GenjutsuCounter
			name="Demonic Illusion: Mirror Heaven and Earth Change"
			icon_state="GenjutsuCounter"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SharinganMastery<91)
					usr<<"You need more Sharingan Mastery.";return
				if(usr.GenjutsuKnowledge<100)
					usr<<"You need more Genjutsu Knowledge.";return
				usr.LearnJutsu("Demonic Illusion: Mirror Heaven and Earth Change",0,"GenjutsuCounter","Demonic Illusion: Mirror Heaven and Earth Change is a spectacular Sharingan ability that literally counter-acts an enemy's Genjutsu.","Genjutsu")
		Kasegui
			name="Demonic Illusion: Shackling Stakes"
			icon_state="Kasegui"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SharinganMastery<91)
					usr<<"You need more Sharingan Mastery.";return
				usr.LearnJutsu("Demonic Illusion: Shackling Stakes",0,"Kasegui","Demonic Illusion: Shackling Stakes is one of Sharingan's principle Genjutsu techniques, allowing you to bind someone within shakles merely by looking into their eyes.","Genjutsu")
		Sleep
			name="Demonic Illusion: Hypnosis"
			icon_state="Sleep"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SharinganMastery<91)
					usr<<"You need more Sharingan Mastery.";return
				usr.LearnJutsu("Demonic Illusion: Hypnosis",0,"Konsui","Demonic Illusion: Hypnosis is a interesting technique of the Sharingan, allowing you to cause someone to fall asleep simply by looking them in the eye and rotating your eyes, causing a hypnosis-like function.","Genjutsu")
		Haste
			name="Haste"
			icon_state="Haste"
			var/price="Activated the second Uchiha Mastery is full."
			var/maxprice2=0
			var/maxprice=1
			Click()
				if(usr.UchihaMastery==100)
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "The Uchiha Ninja are known for their fast movements and successful assassinations. This allows the user to move at high-speed Shushins without any delay. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")
		GoukakyuuMastery
			name="Goukakyuu Mastery"
			icon_state="GoukakyuuMastery"
			var/price="Activated the second Uchiha Mastery is full."
			var/maxprice2=0
			var/maxprice=1
			Click()
				if(usr.UchihaMastery==100)
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "A Uchiha ninja is finally considered a ninja when they successfully perform a Fireball Jutsu. Essentially, their original flames and passion of the Uchiha will always remain and burn hotter than others. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		DarkFlames
			name="Dark Flames"
			icon_state="DarkFlames"
			var/price="Hidden Requirements."
			var/maxprice2=0
			var/maxprice=1
			Click()
				//if(usr.UchihaMastery==100)
				//	maxprice2=1
				maxprice2=0
				if(usr.key=="")
					maxprice2=1
					usr.DarkFlames=1
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "The Uchiha Ninja are said to have a dark chakra, so dark that they can influance even strong demons like the Kyuubi. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)


/////////////////////////////////////
		BoneMastery
			name="Bone Mastery"
			icon_state="BoneMastery"
			var/price="Naturally increases for a Kaguya as they grow."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] allows the user to learn new bone techniques. How to Train it: [price] [usr.BoneMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		DanceMastery
			name="Dance Mastery"
			icon_state="DanceMastery"
			var/price="Naturally increases for a Kaguya as they perform their dances."
			var/maxprice=30
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] allows the user to learn new bone techniques. How to Train it: [price] [usr.DanceMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		BoneArmor
			name="Bone Armor"
			icon_state="BoneHarden"
			var/price="Has a chance of raising when you use Bone Armor."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] allows the user to lower their drain for Bone Harden. How to Train it: [price] [usr.BoneArmor]/[maxprice]","[src.name]")
		SawaMaster
			name="Lord of Sawarabi"
			icon_state="SawaMaster"
			var/price="Has a chance of raising when you use Sawarabi."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] allows the user to withstand the drain Sawa puts on their body, and extend the reach Sawa is able to go. How to Train it: [price] [usr.SawaMaster]/[maxprice]","[src.name]")
		Underlayer
			name="Underlayer"
			icon_state="Underlayer"
			var/price="Starts Maxed"
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr,"[src] You have a tight Bone Mass of underlayer underneath your skin. Because of this you're ineffective to critical hits. How to Train it: [price] [usr.Underlayer]/[maxprice]","[src.name]")
		Terpsichorean
			name="Terpsichorean"
			icon_state="Terpsichorean"
/////////////////////////////////////
		Training
			name="Training"
			icon_state="Training"
			var/price="Through training and using your dog."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases mastery over Inuzuka Training proficiency in learning techniques. How to Train it: [price] [usr.Training]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Obediance
			name="Obediance"
			icon_state="Obediance"
			var/price="By getting Training on 20."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] teaches your dog obediance. How to Train it: [price] [usr.Obediance]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SpeedTraining
			name="Speed Training"
			icon_state="SpeedTraining"
			var/price="By commanding your dog to move."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the dogs speed! How to Train it: [price] [usr.SpeedTraining]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Aggression
			name="Aggression"
			icon_state="Aggression"
			var/price="By commanding your dog to attack."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the dogs critical percentage. How to Train it: [price] [usr.Aggression]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Canine
			name="Canine"
			icon_state="Canine"
			var/price="Just by having your dog out and being around it."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the user's canine-abilities! How to Train it: [price] [usr.Canine]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Scent
			name="Scent"
			icon_state="Scent"
			Click()
				usr<<sound('SFX/click1.wav',0)
		NinjaHound
			name="Ninja Hound"
			icon_state="NinjaHound"
			Click()
				usr<<sound('SFX/click1.wav',0)
		Friendship
			name="Friendship"
			icon_state="Friendship"

		LupineSpeed
			name="Lupine Speed"
			icon_state="LupineSpeed"
			var/price="When Shikyaku is learned."
			var/maxprice=1
			var/maxprice2=0
			Click()
				var/caught=0
				for(var/obj/SkillCards/Shikyaku/A in usr.LearnedJutsus)
					caught=1
				if(usr.Clan=="Inuzuka"||usr.Clan2=="Inuzuka"&&caught)
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "Allows Inuzuka to run 1 1/2 times faster than a noraml Ninja while in Beast mode.. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SuperHearing
			name="Super Hearing"
			icon_state="SuperHearing"
			var/price="By being in beast mode."
			var/maxprice=6
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "Allows you to hear people 4 squares off your screen while in beast mode. Increases 1 square per point. How to Train it: [price] [usr.SuperHearing]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
/////////////////////////////////
		ShadowManipulation
			name="Shadow Manipulation"
			icon_state="ShadowManipulation"
			var/price="Just by using your shadow."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the user's shadow proficiency! How to Train it: [price] [usr.ShadowManipulation]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShadowReach
			name="Shadow Reach"
			icon_state="ShadowReach"
			var/price="Just by moving your shadow."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the user's shadow reaching techniques! How to Train it: [price] [usr.ShadowReach]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShadowStrength
			name="Shadow Strength"
			icon_state="ShadowStrength"
			var/price="By capturing with your shadow and other binding techniques."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the user'strength of their binding techniques! How to Train it: [price] [usr.ShadowStrength]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShadowMastery
			name="Shadow Mastery"
			icon_state="ShadowMastery"
			var/price="Increases naturally for Nara."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
				//var/style = "<style>BODY {margin:0;font:arial;background:black;\
				//	color:white;}</style>"
				alert(usr, "[src] allows the user knowledge over their Shadows and using them properly. How to Train it: [price] [usr.ShadowMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShadowLimit
			name="Shadow Limit"
			icon_state="ShadowLimit"
			var/price="Increases as you use Shibari."
			var/maxprice=15
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] diminishes the amount of chakra used to move a shadow by a percentage. How to Train it: [price] [usr.ShadowLimit]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShadowExtension
			name="Shadow Extension"
			icon_state="ShadowExtension"
			var/price="Once Shadow Limit is maxed, it allows you to increase its range by double."
			var/maxprice2=0
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.ShadowLimit>=10)
					maxprice2=1
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] diminishes the amount of chakra used to move a shadow by a percentage. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShadowKnowledge
			name="Shadow Knowledge"
			icon_state="ShadowKnowledge"
		ShadowCreativity
			name="Shadow Creativity"
			icon_state="ShadowCreativity"
		ShadowRelease
			name="Shadow Release"
			icon_state="ShadowRelease"
/////////////////////////////
		BloodFeast
			name="Blood Feast"
			icon_state="BloodFeast"
			var/price="Raises from using Feast"
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the amount of EXP gained from Drinking someone's Blood. Also decreases how much thirst rises when using Ketseuki Seal Jutsus. How to Train it: [price] [usr.BloodFeast]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ThirstHold
			name="Thirst Hold"
			icon_state="ThirstHold"
			var/price="Raises naturally over time."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] increases the user's control, making them have control over their Vampiric urges. How to Train it: [price] [usr.ThirstHold]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		FeralRage
			name="Feral Rage"
			icon_state="FeralRage"
			var/price="Raises as a Ketsueki Ninja sees blood."
			var/maxprice=25
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] makes it so everytime the user is in view of blood they become stronger. How to Train it: [price] [usr.FeralRage]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		BloodManipulation
			name="Blood Manipulation"
			icon_state="BloodManipulation"
			var/price="Raises naturally for a Ketsueki Ninja. Also raises the more you use your jutsu."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you to manipulate blood cells to do your bidding for techniques. How to Train it: [price] [usr.BloodManipulation]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SealMastery
			name="Seal Mastery"
			icon_state="SealMastery"
			var/price="Raises the more you perform complex Ketsueki Seals!"
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you to learn more complex Sealing techniques based off of your Ketsueki Heritage. How to Train it: [price] [usr.SealMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		BloodClot
			name="Blood Clot"
			icon_state="BloodClot"
//////////////////////
		SpiderMastery
			name="Spider Mastery"
			icon_state="SpiderMastery"
			var/price="Raises the more you use nenkin-related jutsu."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you to learn spider related techniques and truly master your skills. How to Train it: [price] [usr.SpiderMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		WebMastery
			name="Web Mastery"
			icon_state="WebMastery"
			var/price="Raises naturally for a Kumojin Ninja. Also raises the more you use your jutsu."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you to learn web related techniques and truly master your skills. How to Train it: [price] [usr.WebMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		WebStrength
			name="Web Strength"
			icon_state="WebMastery"
			var/price="Raises the more you use your web based jutsu."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] Strengthens the durability of your webs, making it harder to struggle out of. How to Train it: [price] [usr.WebStrength]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		BodyofanArachnid
			name="Body of an Arachnid"
			icon_state="SpiderMastery"
			var/price="Hidden Requirement."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] Over time Kumojins grow multiple arms that will assist them in combat. How to Train it: [price] [usr.BodyofanArachnid]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		GoldnowDiamond
			name="Gold now Diamond."
			icon_state="GoldnowDiamond"
			var/price="Raises as you use your Kumojin armor."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] Over time Kumojins grow multiple arms that will assist them in combat. How to Train it: [price] [usr.GoldnowDiamond]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)


		GoldenSpike
			name="Golden Spikes"
			icon_state="GoldenSpike"
			var/price="Raises as you perform Kumonenkin related attacks."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] increases the damage of all Golden Spike related techniques. How to Train it: [price] [usr.GoldenSpike]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
///////////////////////
		SnowFall
			name="Snowfall"
			icon_state="SnowFall"
			var/price="Raises naturally, also by using clan related techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you learn Snow techniques in the Hyouton Range. How to Train it: [price] [usr.SnowFall]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		IceRush
			name="Ice Rush"
			icon_state="IceRush"
			var/price="Raises naturally, also by using clan related techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you learn Ice techniques in the Hyouton Range. How to Train it: [price] [usr.IceRush]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		IceChakra
			name="Ice Mastery"
			icon_state="IceChakra"
			var/price="Using wood based techniques.."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] is a passive that allows you to increase your damage done by ice jutsu. How to Train it: [price] [usr.IceChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

//////////////////////
		SandMastery
			name="SandMastery"
			icon_state="SandMastery"
			var/price="Raises as you perform Sand related techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you learn sand related techniques and master your sand. How to Train it: [price] [usr.SandMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		AutoProtection
			name="Auto Protection"
			icon_state="AutoProtection"
			var/price="Raises as you guard successfully using your Sand."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The [src] passive is a passive that makes sand protect you from Attacks such as the Attack\
				 verb completely, as long as the user is defending. Increasing this increases your chance to defend against so \
				 for each time bought by 5%. It uses up chakra each time defended. How to Train it: [price] [usr.AutoProtection]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Shukaku
			name="Shukaku"
			icon_state="Shukaku"
			var/price="Hidden requirement."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The [src] was a highly regarded figure of the Sabaku Clan, giving the original artist of the clan, \
						Gaara, the ability to control sand. Because it is considered like a god to now a days Sabaku Clan members, \
						the Shukaku plays a big influence on their techniques. Learning this allows you to learn artistic techniques \
						based on the Shukaku. How to Train it: [price] [usr.Shukaku]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SandCapacity
			name="SandCapacity"
			icon_state="SandMastery"
			var/price="Raises as you perform Sand related techniques."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you to carry more sand within your gourd. How to Train it: [price] [usr.SandCapacity]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SandPackage
			name="SandCapacity"
			icon_state="SandMastery"
			var/price="Raises as you perform Sand related techniques."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you to carry more sand. How to Train it: [price] [usr.SandPackage]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Erosion
			name="Erosion"
			icon_state="SandMastery"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SandMastery<50)
					usr<<"You need more Sand Mastery.";return
				usr.LearnJutsu("Erosion",35000,"SandErosion","Erosion allows you to convert your doton into sand for your sand jutsu.","Ninjutsu")

//////////////////////
		GrassMastery
			name="Grass Mastery"
			icon_state="GrassMastery"
			var/price="Raises as you perform Grass related techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows the user knowledge over controlling foilage to their bidding to use for techniques. How to Train it: [price] [usr.GrassMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Senju
			name="Senju Clan"
			icon_state="Senju"
			var/price="The first stat to actually be able to learn Wood technique raises at a random point in time. After that, it raises as you perform Wood related techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The Kusakin's Kekkai Genkai is said to be derived from a Rogue Senju \
				member from long ago. It is unknown why they had changed their name, but the ability to create \
				life still retained. This passive allows you to learn Mokuton Techniques. How to Train it: [price] [usr.Senju]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		WoodChakra
			name="Wood Mastery"
			icon_state="WoodChakra"
			var/price="Using wood based techniques.."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] is a passive that allows you to increase your damage done by wood jutsu. How to Train it: [price] [usr.WoodChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SturdyComposition
			name="Sturdy Composition"
			icon_state="WoodChakra"
			var/price="Using your wood and grass based techniques.."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] is a passive that allows you to mold your Doton and Suiton into much stronger forms that you're able to utilize, making your creations much more durable,stronger and even possible to reach higher possible abilites. How to Train it: [price] [usr.SturdyComposition]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		NatureBond
			name="Nature's Bond"
			icon_state="lit"
			var/price="Automatically when you're a Kusakin"
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] is a passive that shows your bonds with Nature. It allows faster understanding of leraning Wood and Grass Style Jutsu by using those related types and speeds up the rate at which you get Doton and Suiton Knowledge. How to Train it: [price] 1/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
///////////////////////
		ShotonKnowledge
			name="Shoton Knowledge"
			icon_state="ShotonKnowledge"
			var/price="Raises by using clan related techniques."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows you learn Crystal techniques. How to Train it: [price] [usr.ShotonKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ShotonMastery
			name="Crystal Mastery"
			icon_state="ShotonMastery"
			var/price="Raises as you perform Shoton related attacks."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] increases the proficiency of all Crystal related techniques. How to Train it: [price] [usr.ShotonMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		CrystalChakra
			name="Crystal Chakra"
			icon_state="CrystalChakra"
			var/price="Raises as you perform Shoton related attacks."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the damage of all Crystal related techniques. How to Train it: [price] [usr.CrystalChakra]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

//////////////////////
		AkimichiSpirit
			name="Akimichi Spirit"
			icon_state="AkimichiSpirit"
			var/price="Increases as you remain close to your clan."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "An Akimichi should have pride over who they are. How to Train it: [price][usr.AkimichiSpirit]/[maxprice] Note:: Activation Type Passive","[src.name]")//,,,,0,"400x150",,style)
		Blubber
			name="Blubber"
			icon_state="Blubber"
			var/price="Activated the second Akimichi Spirit is full."
			var/maxprice2=0
			var/maxprice=1
			Click()
				if(usr.AkimichiSpirit==50)
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The Akimichi clan needs to keep their calories high, so as long as they have 1000 Calories it becomes impossible to land a critical hit on them.How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Ingestion
			name="Ingestion"
			icon_state="Ingestion"
			var/price="Activated the second Akimichi Spirit is full."
			var/maxprice2=0
			var/maxprice=1
			Click()
				if(usr.AkimichiSpirit==50)
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Being really good eaters, as long as they keep it up they won't have to worry about passing out from over eating and just continue eating to their content. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Tank
			name="Tank"
			icon_state="Tank"
			var/price="Activated the second Akimichi Spirit is full."
			var/maxprice2=0
			var/maxprice=1
			Click()
				if(usr.AkimichiSpirit==50)
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "An Akimchi is scarier when walking! When walking their damage in taijuts uattacks become dramatically different. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)




		SizeMastery
			name="Size Mastery"
			icon_state="SizeMastery"
			var/price="Increases as you use Baika No Jutsu."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows the user more knowledge over increasing their size in use of their calories. How to Train it: [price] [usr.SizeMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		SizeCap
			name="Size Cap"
			icon_state="SizeCap"
			var/price="Increases as you use Baika No Jutsu to the maximum."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] increases the cap of Baika No Jutsu related techniques, allowing stronger variations. How to Train it: [price] [usr.SizeCap]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)


////////////////////
		Teamwork
			name="Teamwork"
			icon_state="Teamwork"
			var/price="Increases the more you're around your fellow Clansmen."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] makes it to where you gain boosts as long as you are close to your fellow Yotsuki Clansman. How to Train it: [price] [usr.Teamwork]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Buffet
			name="Buffet"
			icon_state="Buffet"
			var/price="The more you use a sword."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] is a useful passive that makes it to where for every time you're hit in hand-to-hand combat, your katana will do more damage until your next slash. Once you finally do that slash, the boost will end. How to Train it: [price] [usr.Buffet]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		AdvancedWielding
			name="Advanced Wielding"
			icon_state="Kenjutsu"
			var/price="Maxed once you max Buffet."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] Proficient enough with a sword, you've learned how to use a two handed sword, with just one hand, allowing numerous possibilities in the art of Kenjutsu. How to Train it: [price] [usr.AdvancedWielding]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		OneWiththeSword
			name="Natural Born User"
			icon_state="Buffet"
			var/price="Born with this maxed."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] being one of your clan, you have the ability to learn how to use Swords faster and more efficiently, being able to raise sword passives much faster then the Average Ninja. How to Train it: [price] [usr.OnewiththeSword]/[maxprice]","[src.name]")


		SlashandBeyond
			name="Slash and Beyond"
			icon_state="Sharper"
			var/price="Born with this Maxed."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] being proud to be a Yotsuki, you're able to learn every slight detail of injuring with a bladed weapon, allowing you to go above and beyond the normal capabilities of causing harm with a weapon. How to Train it: [price] 1/[maxprice]","[src.name]")

		LightningArmorYotsuki
			name="Instinctive Armor"
			icon_state="Static"
			var/price="Born with this Maxed."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] Your clan is naturally better with the element Raiton; especially the jutsu Rai no Yoroi, allowing a very largely reduced Chakra Drain for it. How to Train it: [price] 1/[maxprice]","[src.name]")

		LightningChakraYotsuki
			name="Instinctive Element"
			icon_state="Electromagnetivity"
			var/price="Born with this Maxed."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] due to being Yotsuki, the usage of your chakra to create Raiton Techniques feels a lot more natural to you, reducing Chakra Costs for Raiton techs. How to Train it: [price] 1/[maxprice]","[src.name]")
/////////Yamanaka
		ChakraManipulation
			name="Chakra Manipulation"
			icon_state="ChakraManipulationP"
			var/price="By SP :D"
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.GenjutsuKnowledge<50)
					usr.ChakraManipulation=0;alert(usr,"This passive is unavailable to you at this time. You need 50 Genjutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] is a passive that allows you to increase your Chakra Control. How to Train it: [price] [usr.ChakraManipulation]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.ChakraManipulation>=5)
								usr<<"You can't take this passive any further!";usr.clicking=0;return
							if(usr.GenjutsuKnowledge<75*(usr.ChakraManipulation+1))
								usr<<"You need [75*(usr.ChakraManipulation+1)] Genjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.ChakraManipulation++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
//////////////////Hoshigaki
		samehadeUnleash
			name = "Samehade Unleash"
			icon_state = "SamehadePassive"
			var/price =  "By using Samehade Unleash, increases faster from going into Unleash Mode. Higher levels increase the amount of jutsus given."
			var/maxprice = 4
			Click()
				if(usr.Clan == "Hoshigaki")
					alert(usr, "Lets the Hoshigaki convert chakra into special jutsus.\
					How to train : [price]  [usr.samehadeUnleash] / [maxprice]")

		samehadeChakaraDrain
			name = "Samehade Chakra Drain"
			icon_state = "SamehadePassive"
			var/price =  "By using Samehade Chakra Drain, affects amount of chakra stolen."
			var/maxprice = 3
			Click()
				if(usr.Clan == "Hoshigaki")
					alert(usr, "Lets the Hoshigaki drain more chakara through the Samehade.\
					How to train : [price]  [usr.samehadeChakaraDrain] / [maxprice]")
		samehadeStrength
			name = "Samehade Throwing Strength"
			icon_state = "SamehadePassive"
			var/price =  "By using Samehade Shred, affects Shred's damage and attack range."
			var/maxprice = 3
			Click()
				if(usr.Clan == "Hoshigaki")
					alert(usr, "Lets the Hoshigaki Shred attack hit more, and do more damage.\
					How to train : [price]  [usr.samehadeStrength] / [maxprice]")
		samehadeThrowingStrength
			name = "Samehade Strength"
			icon_state = "SamehadePassive"
			var/price =  "By using Samehade Throw, affects Throw's damage and attack range."
			var/maxprice = 3
			Click()
				if(usr.Clan == "Hoshigaki")
					alert(usr, "Lets the Hoshigaki throw their Samehade for more damage.\
					How to train : [price]  [usr.samehadeThrowingStrength] / [maxprice]")

		/////////////////
		SharpSkin
			name="Sharp Skin"
			icon_state="SharpSkin"
			var/price="Automatically when you're a Hoshigaki."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Hoshigaki"||usr.Clan2=="Hoshigaki")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Any physical damage delt by the Hoshigaki through\
				close-up combat will result in the target getting\
				 damaged(Such as punching, kicking.) How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		WaterHealing
			name="Water Healing"
			icon_state="WaterHealing"
			var/price="Automatically when you're a Hoshigaki."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Hoshigaki"||usr.Clan2=="Hoshigaki")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "While Guarding on water your vitality will heal by 10 points each second. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		HydroBuff
			name="Hydro Buff"
			icon_state="HydroBuff"
			var/price="Automatically when you're a Hoshigaki."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Hoshigaki"||usr.Clan2=="Hoshigaki")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "While Fighting on water, Power slowly increases. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		SamehadeAbsorbtion
			name="Samehade Absorbtion"
			icon_state="SamehadeAbsorbtion"
			var/price="Increases the more you use your Samehade."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The Samehade has the ability to absorb an\
				 opponent's maximum chakra with each strike. It increases by range for \
				each point. How to Train it: [price] [usr.SamehadeAbsorbtion]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		SamehadeReturn
			name="Samehade Return"
			icon_state="SamehadeReturn"
			Click()
				usr<<sound('SFX/click1.wav',0)
				usr.LearnJutsu("Samehade Return",0,"SamehadeReturn","A technique which allows the Hoshigaki to return the Samehade \
				to their hand. The sword being very loyal, if any time they want it to automatically hit their left or right hand they\
				 can use this technique.","Ninjutsu")


		QuickSilver
			name="Quicksilver"
			icon_state="QuickSilver"
			var/price="Automatically when you're a Hoshigaki."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Hoshigaki"||usr.Clan2=="Hoshigaki")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "As long as you are on water, you'll be running no matter what. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Dive
			name="Dive"
			icon_state="Dive"

		SamehadePartnership
			name="Samehade Partnershipe"
			icon_state="SamehadePartnership"

		SamehadeRepel
			name="Samehade Repel"
			icon_state="SamehadeRepel"

		AttackFirstTalkLater
			name="Attack First Talk Later"
			icon_state="AttackFirstTalkLater"
			var/price="By attacking quickly after targetting."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "When attacking someone IMMEDIATELY after targetting \
				them, you gain a partial boost in damage for that attack if it is \
				delt with the Samehade by +10 static damage.. How to Train it: [price] [usr.AttackFirstTalkLater]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)


/////////////////////////////
		WeaponMaster
			name="Weapon Master"
			icon_state="WeaponMaster"
			var/price="Increases the more you use Weapons."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Ninja are more proficiant with weapons and can adapt to weapons faster\
				 being able to use all of their capabilities with them, adding 1% more Damage to the weapon they wield for each point. How to Train it: [price] [usr.WeaponMaster]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		ChakraControl
			name="Chakra Control"
			icon_state="ChakraControl"
			var/price="Increases the more you perfect Chakra within Chakra Intensity."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Ninja are more proficiant with their chakra\
				 being able to reach a higher level of natural chakra control. How to Train it: [price] [usr.ChakraControl]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Genius
			name="Genius"
			icon_state="Genius"
			var/price="Automatically when you're a Fuuma."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Being great geniuses, they have the strength of a genius, increasing their stats by +5 in one stat. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Stealth
			name="Stealth"
			icon_state="Stealth"
			var/price="Automatically when you're a Fuuma."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Ninja are the staple for real ninja. They can go invisable after standing still for 30 seconds. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Survivability
			name="Survivability"
			icon_state="Survivability"
			var/price="Increases the more you're placed into Death situations."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Clan ninja have a really lucky trait that allows them to survive. \
				Because of this, everytime forced into a death situation teaches you to survive more. \
				Thus, when failing to struggle you have chance of getting back up even when not in time. Raises by 3%. How to Train it: [price] [usr.Survivability]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Awareness
			name="Awareness"
			icon_state="Awareness"
			var/price="Increases the more you're put into Genjutsu techniques."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The Fuuma Clan is successful in all types of jutsu, but their excellent chakra control makes their own Chakra harder to manipulate to the average Genjutsuist.\
				[src] increases the chance to resist the effects of Genjutsu. Raises by 5% for each point%. How to Train it: [price][usr.Awareness]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		JutsuIdealist
			name="Jutsu Idealist"
			icon_state="JutsuIdealist"
			var/price="Automatically when you're a Fuuma."
			var/maxprice=1
			var/maxprice2=1
			Click()
				if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Clan members are renowned Geniuses and can learn at a much faster pace than the average ninja, thus gaining a partial boost\
				 in learning techniques. This allows them to learn techniques at a faster rate, giving\
				  a moderate EXP boost. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Reaction
			name="Reaction"
			icon_state="Reaction"
			var/price="Hidden Requirement"
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Clan ninja are exceptional taijutsu users. They have a better chance \
				to land Weapons if they are facing or not facing their opponet increases by 5% for each point. How to Train it: [price] [usr.Reaction]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		RapidUse
			name="Rapid Use"
			icon_state="RapidUse"
			var/price="Automatically when you're a Fuuma."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "This will allow Cool Downs for Non-Elemental Ninjutsu uses to become quicker dividing the time by 2. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		Versatile
			name="Versatile"
			icon_state="Versatile"
			var/price="Automatically when you're a Fuuma."
			var/maxprice=1
			var/maxprice2=0
			Click()
				if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
					maxprice2=1
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Fuuma Ninja are effortful. They are able to shrug off Status Affects faster than the Average Ninja. How to Train it: [price] [maxprice2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
/////////////////////////////
//Iwazuka
/////////////////////////////
		ExplosiveMastery
			name="Explosive Mastery"
			icon_state="ExplosiveMastery"
			var/price="Increases the more you use Katsu."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Explosive Mastery is a passive that allows you to learn more techniques ranging around the explosion art. How to Train it: [price] [usr.ExplosiveMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		ClayMastery
			name="Art Mastery"
			icon_state="ClayMastery"
			var/price="Increases the more you create beautiful creations."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Art Mastery is a passive that allows you to learn more Clay-based techniques. How to Train it: [price] [usr.ClayMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		ClayDrain
			name="Clay Drain"
			icon_state="Versatile"
			var/price="Increases the more you use up your clay."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "Clay Drain is a passive that allows you to lower the amount of Clay to use advanced Clay Techniques. How to Train it: [price] [usr.ClayDrain]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

/////////////////////////////
//Satou
/////////////////////////////
		Drunk
			name="Drunk"
			icon_state="Reaction"
			var/price="Drinking"
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "The Satou ninja are highly resistant to Sake, because of this when drinking it they go into the daze effect but they have a chance to convert damage done to vital organs to their stamina instead. This percentage increases their daze. How to Train it: [price] [usr.Drunk]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Suiken
			name="Suiken"
			icon_state="Awareness"
			var/price="Drinking."
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "When drinking Sake, the smallest bit can turn you into a taijutsu monster. Because of the Drunken Fist style naturally known to all Satou, after drinking Sake you will dodge all hand-to-hand combat techniques thrown at you. How to Train it: [price]","[src.name]")//,,,,0,"400x150",,style)

		LostBuzz
			name="Lost-Buzz"
			icon_state="Awareness"
			var/price="Increases with drinking."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "As long as you're Drunk, there's a chance the screen won't spin increasing by 10% for each effect. How to Train it: [price] [usr.LostBuzz]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		EffectsofDrinking
			name="Effects of Drinking"
			icon_state="Awareness"
			var/price="Drinking."
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "When drunk a Satou ninja is automatically max-speed no matter what and can't be forced to walk. How to Train it: [price]","[src.name]")//,,,,0,"400x150",,style)
		Shield
			name="Shield"
			icon_state="Versatile"
			var/price="Blocking with armor on."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "When blocking with armor on, your Endurance increases much more dramatically than normal. Each point increasing the amount. How to Train it: [price] [usr.Shield]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

//TaijutsuPassives
turf
	Skilltree/Passives/TaijutsuPassives
		layer = MOB_LAYER+97
		icon='Icons/Jutsus/Skilltree.dmi'
		TaijutsuKnowledge
			name ="TaijutsuKnowledge"
			icon_state="TaijutsuKnowledge2"
			var/price="By performing taijutsu techniques."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases your range of Taijutsu you are able to master. How to Train it: [price] [usr.TaijutsuKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Swift
			name="Swift"
			icon_state="Swift"
			var/price="By attacking."
			var/maxprice=6
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.TaijutsuKnowledge<50)
					usr.Swift=0;alert(usr,"This passive is unavailable to you at this time. You need 50 Taijutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] is a passive that allows you to increase your attack speed drastically. How to Train it: [price] [usr.Swift]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Swift>=8)
								usr<<"You can't take this passive any further!";usr.clicking=0;return
							if(usr.TaijutsuKnowledge<75*(usr.Swift+1))
								usr<<"You need [75*(usr.Swift+1)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Swift++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Rush
			name="Rush"
			icon_state="Rush"
			var/price="By punching a log or tree."
			var/maxprice=20
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.Swift<1)
					usr.Rush=0;alert(usr,"This passive is unavailable to you at this time. You need 1 Swift before you can view this passive.")
					return
				alert(usr, "[src] makes each consecutive attack perform more damage than the last. The limit is equal to the level of the skill. How to Train it: [price] [usr.Rush]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<100*(usr.Rush+1))
								usr<<"You need [100*(usr.Rush+1)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Rush++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		DoubleStrike
			name="Double Strike"
			icon_state="DoubleStrike"
			var/price="Performing combos."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.Swift<1)
					usr.DoubleStrike=0;alert(usr,"This passive is unavailable to you at this time. You need 1 Swift before you can view this passive.")
					return
				alert(usr, "Double Strike allows the user to strike two times in one attack. How to Train it: [price] [usr.DoubleStrike]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<100*(usr.DoubleStrike+1))
								usr<<"You need [100*(usr.DoubleStrike+1)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DoubleStrike++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Reflex
			name="Reflex"
			icon_state="Reflex"
			var/price="Every time doding is succesful, it can increase."
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.TaijutsuMastery<1)
					alert(usr,"This passive is unavailable to you at this time. You need 1 Taijutsu Mastery before you can view this passive.")
					return
				alert(usr, "[src] is a skill that gives you a better ability at dodging an opponent's taijutsu technique, along with giving you a better chance of landing one. It is rumored that an old man near Tea Village knows the secrets of reflex [usr.reflexNew]/3","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&usr.reflexNew<3)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<300*(usr.reflexNew+1))
								usr<<"You need [300*(usr.reflexNew+1)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.reflexNew++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Buff
			name="Buff"
			icon_state="Buff"
			var/price="Every time hit by a critical attack it has a chance of increasing."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.Impenetrable<1)
					usr.Buff=0;alert(usr,"This passive is unavailable to you at this time. You need 1 Impenetrable before you can view this passive.")
					return
				alert(usr, "[src] decreases the chance of getting a critical hit. How to Train it: [price] [usr.Buff]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.Buff+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Impenetrable
			name="Impenetrable"
			icon_state="Impenetrable"
			var/price="Just by guarding."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.TaijutsuKnowledge<50)
					usr.Impenetrable=0;alert(usr,"This passive is unavailable to you at this time. You need 50 Taijutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] increases guard strength and defence. How to Train it: [price] [usr.Impenetrable]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.Impenetrable<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.Impenetrable++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Focus
			name="Focus"
			icon_state="Focus"
			var/price="Every time you perform a critical attack it has a chance of increasing. When you get hit it also has a chance of increasing."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.TaijutsuMastery<1)
					usr.Focus=0;alert(usr,"This passive is unavailable to you at this time. You need 1 Taijutsu Mastery before you can view this passive.")
					return
				alert(usr, "[src] increases the chance of getting a critical hit. It also increases the user's Focus against other attacks, helping in other things. How to Train it: [price] [usr.Focus]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.Focus+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		InitialGate
			name="Initial Gate"
			icon_state="InitialGate"
			var/maxprice="1"
			Click()
				if(usr.Acceleration<1)
					alert(usr,"This passive is unavailable to you at this time. You need 1 / 10 Acceleration before you can obtain this skill passive.")
					return
				switch(alert("This is the first gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.InitialGate)
						//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
						//		color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<100)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<11)
								usr<<"Your physical body is not able to handle this gate.";return
							usr.LearnJutsu("Initial Gate",0,"Initial Gate","","Taijutsu")

		HealGate
			name="Heal Gate"
			icon_state="HealGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the second gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.HealGate)
						//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
								color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<240)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<16)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("Heal Gate",0,"Heal Gate","","Taijutsu")

		LifeGate
			name="Life Gate"
			icon_state="LifeGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the third gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.LifeGate)
						//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
								color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);return
						else
							if(usr.TaijutsuKnowledge<320)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<21)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("Life Gate",0,"Life Gate","","Taijutsu")
		WoundGate
			name="Wound Gate"
			icon_state="WoundGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the fourth gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.WoundGate)
						//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
						//		color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<480)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<26)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("Wound Gate",0,"Wound Gate","","Taijutsu")

		LimitGate
			name="Limit Gate"
			icon_state="LimitGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the fifth gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.LimitGate)
					//		var/style = "<style>BODY {margin:0;font:arial;background:black;\
					//			color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<560)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<29)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("Limit Gate",0,"Limit Gate","","Taijutsu")
		ViewGate
			name="View Gate"
			icon_state="ViewGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the sixth gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.ViewGate)
					//		var/style = "<style>BODY {margin:0;font:arial;background:black;\
					//			color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<630)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<32)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("View Gate",0,"View Gate","","Taijutsu")
		WonderGate
			name="Wonder Gate"
			icon_state="WonderGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the seventh gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						if(usr.WonderGate)
					//		var/style = "<style>BODY {margin:0;font:arial;background:black;\
					//			color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<550)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<34)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("Wonder Gate",0,"Wonder Gate","","Taijutsu")
		DeathGate
			name="Death Gate"
			icon_state="DeathGate"
			var/maxprice="1"
			Click()
				switch(alert("This is the final gate, the death gate would you like to learn it?","[src]","Get","Information"))
					if("Information")
	//					alert("[src] .","[src]")
						return
					if("Get")
						return
						if(usr.DeathGate)
					//		var/style = "<style>BODY {margin:0;font:arial;background:black;\
					//			color:white;}</style>"
							alert(usr, "You already know this technique!","[src.name]")//,,,,0,"400x150",,style);
							return
						else
							if(usr.TaijutsuKnowledge<700)
								usr<<"You need more Taijutsu Knowledge.";return
							if(usr.TaiSkill<35)
								usr<<"You're physical capacity is not able to handle this gate.";return
							usr.LearnJutsu("Death Gate",0,"Death Gate","","Taijutsu")
		TaijutsuMastery
			name="Taijutsu Mastery"
			icon_state="TaijutsuMastery"
			var/price="By performing taijutsu techniques."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.TaijutsuKnowledge<50)
					usr.TaijutsuMastery=0;alert(usr,"This passive is unavailable to you at this time. You need 50 Taijutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] decreases the delay of Taijutsu techniques. How to Train it: [price] [usr.TaijutsuMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.TaijutsuMastery<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.TaijutsuKnowledge<100*(usr.TaijutsuMastery+1))
								usr<<"You need [100*(usr.TaijutsuMastery+1)] Taijutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.TaijutsuMastery++;usr.StartingPoints--
					usr.clicking=0
//Ninjutsu Passives
turf
	Skilltree/Passives/NinjutsuPassives
		layer = MOB_LAYER+97
		ChakraArmor
			name ="Chakra Armor"
			icon_state="ChakraArmor"
	//FuuinjutsuStuffPls
		FuuinjutsuKnowledge
			name="Fuuinjutsu Knowledge"
			icon_state="FuuinjutsuKnowledge"
			var/price="By performing Fuuinjutsu and landing them on other Active ninja"
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases your range of Fuuinjutsu you are able to master and utilize. How to Train it: [price] [usr.FuuinjutsuKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		WeaponMaster2
			name ="Weapon Master"
			icon_state="NinjutsuKnowledge"
			var/price="By raising it with your leftover Starting Points."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases your knowledge of Weapons and equipment, allowing you to purchase things to aid with weapons. How to Train it: [price] [usr.WeaponMaster2]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.WeaponMaster2<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.WeaponMaster2++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		NinjutsuKnowledge
			name ="Ninjutsu Knowledge"
			icon_state="ChakraUsage"//"NinjutsuKnowledge"
			var/price="By performing ninjutsu techniques."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases your range of Ninjutsu you are able to master. How to Train it: [price] [usr.NinjutsuKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)


		PoisonKnowledge
			name = "Poison Knowledge"
			icon_state="PoisonKnowledge"
			var/price="By using Poisons."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases your range of Poisons you are able to utilize. How to Train it: [price] [usr.PoisonKnowledge]/[maxprice]","[src.name]")

		PoisonExpert
			name ="Poison Expert"
			icon_state="PoisonExpert"
			var/price="By raising it with your leftover Starting Points."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.PoisonKnowledge<30)
					alert(usr,"This passive is unavailable to you at this time. You need 30 Poison Knowledge before you can view this passive.")
					return
				alert(usr, "[src] increases the duration of Poisons and decreases the amount of time for poisons to be set onto weapons. How to Train it: [price] [usr.PoisonExpert]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.PoisonExpert<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.PoisonKnowledge<50*(usr.PoisonExpert+1))
								usr<<"You need [50*(usr.PoisonExpert+1)] Poison Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.PoisonExpert++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0

		NinjutsuMastery
			name ="Ninjutsu Mastery"
			icon_state="NinjutsuMastery"
			var/price="By performing ninjutsu techniques."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.NinjutsuKnowledge<50)
					usr.NinjutsuMastery=0;alert(usr,"This passive is unavailable to you at this time. You need 50 Ninjutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] decreases the delay of Ninjutsu techniques. How to Train it: [price] [usr.NinjutsuMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.NinjutsuMastery<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.NinjutsuMastery++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0

		Refill
			name="Chakra Refill"
			icon_state="Refill"
/*			var/price="By performing successful handseals."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] refills the user's chakra resevoir slowly as long as they are remaining stationary. How to Train it: [price] [usr.HandsealSpeed]/[maxprice]","[src.name]",,,,0,"400x150",,style)
*/
		ChakraSensor
			name="Chakra Sensor"
			icon_state="ChakraSensor"
/*			var/price="By performing successful handseals."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] allows the user to sense nearby Chakra and their Chakra Identification. How to Train it: [price] [usr.HandsealSpeed]/[maxprice]","[src.name]",,,,0,"400x150",,style)
*/

		HandsealMastery
			name="Handseal Mastery"
			icon_state="HandsealsMastery"
			var/price="By performing successful handseals."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.NinjutsuKnowledge<10)
					usr.HandsealsMastery=0;alert(usr,"This passive is unavailable to you at this time. You need 10 Ninjutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] the chance of performing accurate handseals. How to Train it: [price] [usr.HandsealsMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.HandsealsMastery<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.HandsealsMastery++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		RealChakraControl
			name ="Chakra Control"
			icon_state="NinjutsuMastery"
			var/price="By using Chakra Intensity or Walking On Water"
			var/maxprice=100
			Click()
				maxprice=100
				if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
					maxprice=160
				usr<<sound('SFX/click1.wav',0)
				if(usr.NinjutsuKnowledge<50||usr.WaterWalkingMastery!=10)
					if(usr.NinjutsuKnowledge<50)
						alert(usr,"This passive is unavailable to you at this time. You need 50 Ninjutsu Knowledge before you can view this passive.")
						return
					if(usr.WaterWalkingMastery<10)
						alert(usr,"This passive is unavailable to you at this time. You need 10 Water Walking Mastery before you can view this passive.")
						return
				alert(usr, "[src] increases your chakra conversion efficiency, thus reducing the drain from jutsus. It also increases the amount of Chakra You gain upon holding down Z while charging Chakra. How to Train it: [price] ([usr.ChakraC]% Efficiency).","[src.name]")//,,,,0,"400x150",,style)

		HandsealSpeed
			name="Handseal Speed"
			icon_state="HandsealSpeed"
			var/price="By performing successful handseals."
			var/maxprice=30
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.HandsealsMastery<3)
					usr.HandsealSpeed=0;alert(usr,"This passive is unavailable to you at this time. You need 3 Handseal Mastery before you can view this passive.")
					return
				alert(usr, "[src] increases the speed of handseals. How to Train it: [price][usr.HandsealSpeed]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		/*		if(usr.StartingPoints>0&&!usr.clicking)
					if(usr.Trait=="Speady"&&usr.HandsealSpeed>=40)
						return
					if(usr.Trait!="Speedy"&&usr.HandsealSpeed>=maxprice)
						return
				else
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.NinjutsuKnowledge<50*(usr.HandsealSpeed+1))
								usr<<"You need [50*(usr.HandsealSpeed+1)] Ninjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.HandsealSpeed+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0*/
		HandsealAgility
			name="Handseal Agility"
			icon_state="HandsealAgility"
			var/price="By raising it with your leftover Starting Points."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.HandsealsMastery<3)
					usr.HandsealAgility=0;alert(usr,"This passive is unavailable to you at this time. You need 3 Handseal Mastery before you can view this passive.")
					return
				alert(usr, "[src] allows the user to run while performing handseals. How to Train it: [price] [usr.HandsealAgility]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.HandsealAgility<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.NinjutsuKnowledge<100*(usr.HandsealAgility+1))
								usr<<"You need [100*(usr.HandsealAgility+1)] Ninjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.HandsealAgility++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		HandsealsActivation
			name="Handseals Activation"
			icon_state="HandsealsActivation"
/*			var/price="By raising it with your leftover Starting Points."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] increases the chance of the user being able to perform a well-known jutsu with over 200 uses automatically without handseals by 5% for each point. How to Train it: [price] [usr.HandsealSpeed]/[maxprice]","[src.name]",,,,0,"400x150",,style)
*/
		OneHandedHandseal
			name="One-Handed Handseal"
			icon_state="OneHandedHandseal"
			var/price="By raising it with your leftover Starting Points."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.HandsealsMastery<3)
					usr.OneHandedSeals=0;alert(usr,"This passive is unavailable to you at this time. You need 3 Handseal Mastery before you can view this passive.")
					return
				alert(usr, "[src] gives the user the ability to perform one-handed handseals. This allows them to perform handseals in even the most dastardly situations for a jutsu in most cases where they'd be disabled How to Train it: [price] [usr.OneHandedSeals]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.OneHandedSeals<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.NinjutsuKnowledge<75*(usr.OneHandedSeals+1))
								usr<<"You need [75*(usr.OneHandedSeals+1)] Ninjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.OneHandedSeals++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		WaterWalkingMastery
			name="Water Walking Mastery"
			icon_state="WaterWalkingMastery"
			var/price="By walking on water."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.NinjutsuKnowledge<50)
					usr.WaterWalkingMastery=0;alert(usr,"This passive is unavailable to you at this time. You need 50 Ninjutsu Knowledge before you can view this passive.")
					return
				alert(usr, "[src] reduces the amount of chakra used while walking on water. How to Train it: [price] [usr.WaterWalkingMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.WaterWalkingMastery<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.NinjutsuKnowledge<10*(usr.WaterWalkingMastery+1))
								usr<<"You need [10*(usr.WaterWalkingMastery+1)] Ninjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.WaterWalkingMastery++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
//Genjutsu Passives
turf
	Skilltree/Passives/GenjutsuPassives
		layer=MOB_LAYER+97
		GenjutsuKai
			name="Genjutsu Kai"
			icon_state="GenjutsuKai"
			var/price=10
			var/maxprice=1
			Click()
				src<<sound('SFX/click1.wav',0)
				alert(usr, "[src] allows the user to counter genjutsu techniques simply by blocking. If the user blocks at the right time of the genjutsu, the genjutsu is canceled. If the user is already frozen, the genjutsu break will no longer work. Cost: [price]</br>[usr.GenjutsuKai]/[maxprice]")
				if("Learn")
					usr<<sound('SFX/click1.wav',0)
					if(usr.GenjutsuKai)
						alert(usr, "You already know this technique!","[src.name]")
						return
					if(usr.JutsuDelay>0)
						usr<<"You need to wait to learn another jutsu!";return
					if(usr.JutsuInLearning!="")
						usr<<"You're already trying to learn something."
						return
					else
						usr.JutsuEXPCost=0;usr.JutsuMEXPCost=10000;usr.JutsuInLearning="Genjutsu Kai";usr.TypeLearning="Genjutsu";return
		GenjutsuSight
			name="Genjutsu Sight"
			icon_state="GenjutsuSight"
			var/price="By canceling out Genjutsu."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases the user's chance by 10% to know when to perform genjutsu kai within a genjutsu. How to Train it: [price] [usr.GenjutsuSight]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.GenjutsuSight<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.GenjutsuSight++;usr.StartingPoints--
					usr.clicking=0
		GenjutsuKnowledge
			name ="GenjutsuKnowledge"
			icon_state="GenjutsuKnowledge2"
			var/price="By performing genjutsu techniques."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				alert(usr, "[src] increases your range of Genjutsu you are able to master. How to Train it: [price] [usr.GenjutsuKnowledge]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
		Mentality
			name="Mentality"
			icon_state="Mentality"
			var/price="By succumbing to the effects of Genjutsu."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the user's Endurance to the mental damage Genjutsu causes, decreasing the Stamina damage for each point. How to Train it: [price] [usr.Mentality]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)

		MentalDamage
			name="Mental Damage"
			icon_state="MentalDamage"
			var/price="By using Genjutsu"
			var/maxprice=10
			Click()
				alert(usr, "[src] increases the user's Mental Damage they inflict on an opponent when they use Genjutsu, increasing the Stamina damage for each point. How to Train it: [price] [usr.MentalDamage]/[maxprice]","[src.name]")

		ChakraManipulator
			name="Chakra Manipulation Master"
			icon_state="GenjutsuGold"
			var/price="By raising it with leftover Starting Points."
			var/maxprice=3
			Click()
				alert(usr,"[src] You learn faster when it comes to manipulating others Chakra and working with Genjutsu. Each point in this passive increases the chance of learning how to use Genjutsu much more proficiently and much quicker. How to Train it: [price] [usr.ChakraManipulator]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.ChakraManipulator<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.GenjutsuKnowledge<75*(usr.ChakraManipulator+1))
								usr<<"You need [75*(usr.ChakraManipulator+1)] Genjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.ChakraManipulator++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0

		Overthought
			name="Overthought"
			icon_state="EvilGen"
			var/price="Hidden Requirements"
			var/maxprice=1
			Click()
				alert(usr, "[src] is given to one that masters the art of Chakra Manipulation torwards using Genjutsu. This allows them to go beyond the normal limit on a Ninjas chakra in releasing for Area Over Effect Genjutsus, increasing the range. How to Train it: [price] [usr.Overthought]/[maxprice]")
		ChakraRadiator
			name="Chakra Radiator"
			icon_state="GenjutsuKo"
			var/price="By Raising with your Elemental Points"
			var/maxprice=3
			Click()
				if(usr.GenjutsuKnowledge<=150)
					usr<<"Get more GenjutsuKnowledge first....";return
				if(usr.ChakraManipulator<=0)
					usr<<"You can't Manipulate chakra well enough to use this...";return
				alert(usr,"[src] You are able to make your chakra stronger when using it as Area Over Effect, increasing the strength of it, causing it to take affect much quicker and increasing the affects that the genjutsu deal. How to Train it: [price] [usr.ChakraRadiator]/[maxprice]")
				if(usr.ElementalPoints>=3&&!usr.clicking&&usr.ChakraRadiator<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your Elemental Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.GenjutsuKnowledge<200*(usr.ChakraRadiator+1))
								usr<<"You need [200*(usr.ChakraRadiator+1)] Genjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.ChakraRadiator++;usr.ElementalPoints-=3;usr.clicking=0
					usr.clicking=0



//Weapon Passives
turf
	Skilltree/Passives/WeaponPassives
		layer=MOB_LAYER+97
		Bow
			name="Archery"
			icon_state="BowMastery"
			var/price="By using the Bow"
			var/maxprice=100
			Click()
				maxprice=100
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the proficiency and a user's knowledege of Bows. How to Train it: [price] [usr.ArcherMastery]/[maxprice]","[src.name]")

		Kenjutsu
			name="Kenjutsu"
			icon_state="Kenjutsu"
			var/price="By using the sword."
			var/maxprice=100
			Click()
				maxprice=100
				if(usr.Clan=="Yotsuki"||usr.Clan2=="Yotsuki")
					maxprice=125
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the proficiency and a user's knowledge of Swords. How to Train it: [price] [usr.Kenjutsu]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.Kenjutsu<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.Kenjutsu+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Bojutsu
			name="Bojutsu"
			icon_state="Bojutsu"
			var/price="By using the Bo-Staff."
			var/maxprice=100
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the proficiency and a user's knowledge of Bo-Staffs. How to Train it: [price] [usr.Bojutsu]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.Bojutsu<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.Bojutsu+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		HeavySlam
			name="Heavy Slam"
			icon_state="Bojutsu"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.Bojutsu<10)
					usr.HeavySlam=0;alert(usr,"This passive is unavailable to you at this time. You need 10 Bojutsu before you can view this passive.")
					return
				alert(usr, "[src] increases the user's chance to severely cripple the opponent by slamming them hard with a Bo, also causing severe stamina damage. Chance increases by 5% for each point. How to Train it: [price] [usr.HeavySlam]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&5>=usr.HeavySlam)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Bojutsu<20*(usr.HeavySlam+1))
								usr<<"You need [20*(usr.HeavySlam+1)] Bojutsu before you can raise this passive further.";usr.clicking=0;return
							usr.HeavySlam++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		SpeedSlice
			name="Speed Dice"
			icon_state="SpeedSlice"
			var/price="The more you slice."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.Kenjutsu<5&&usr.Bojutsu<5)
					usr.SpeedDice=0;alert(usr,"This passive is unavailable to you at this time. You need 5 Kenjutsu or 5 Bojutsu skill before you can view this passive.")
					return
				alert(usr, "[src] increases the speed of sword slashing attacks. How to Train it: [price] [usr.SpeedDice]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.SpeedDice<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Kenjutsu<5*(usr.SpeedDice+1))
								usr<<"You need [5*(usr.SpeedDice+1)] Kenjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.SpeedDice++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		DisarmingSlash
			name="Disarming Slash"
			icon_state="Deflection"
			var/price="By raising with leftover Skillpoints."
			var/maxprice=1
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.Kenjutsu<20)
				//	usr.DeflectionZ=0
					alert(usr,"This passive is unavailable to you at this time. You need 20 kenjutsu before you can view this passive.")
					return
				alert(usr, "[src] allows you to automatically deflect slash-based attacks if you have a weapon equipped. How to Train it: [price] [usr.DisarmingSlash]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.DisarmingSlash<1)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Kenjutsu<20*(usr.DisarmingSlash+1))
								usr<<"You need [20*(usr.DisarmingSlash+1)] Kenjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DisarmingSlash++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Deflection
			name="Deflection"
			icon_state="Deflection"
			var/price="By deflecting weapons."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SpeedDice<1)
			//		usr.DeflectionZ=0;
					alert(usr,"This passive is unavailable to you at this time. You need 1 Speed Dice skill before you can view this passive.")
					return
				alert(usr, "[src] allows you to automatically deflect slash-based attacks if you have a weapon equipped. How to Train it: [price] [usr.DeflectionZ]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.DeflectionZ<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Kenjutsu<10*(usr.DeflectionZ+1))
								usr<<"You need [10*(usr.DeflectionZ+1)] Kenjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.DeflectionZ++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		SlashStrength
			name="Slash Strength"
			icon_state="SlashStrength"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.DeflectionZ<1)
			//		usr.SlashStrength=0;
					alert(usr,"This passive is unavailable to you at this time. You need 1 Deflection skill before you can view this passive.")
					return
				alert(usr, "[src] allows the user to go over the cap of their current Sword, increasing the cap by 10 damage for each point.How to Train it: [price] [usr.SlashStrength]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.SlashStrength<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Kenjutsu<5*(usr.SlashStrength+0))
								usr<<"You need [5*(usr.SlashStrength+0)] Kenjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.SlashStrength++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Gash
			name="Gash"
			icon_state="Gash"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SpeedDice<2)
				//	usr.Gash=0;
					alert(usr,"This passive is unavailable to you at this time. You need 2 Speed Dice before you can view this passive.")
					return
				alert(usr, "[src] gives you a chance to cause a deep cut in the opponent's body with a sword, causing them to bleed for a time. Each point in this passive increases the chance by 10%. How to Train it: [price] [usr.Gash]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.Gash<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Kenjutsu<10*(usr.Gash+1))
								usr<<"You need [10*(usr.Gash+1)] Kenjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.Gash++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		VitalSlash
			name="Vital Slash"
			icon_state="VitalSlash"
			var/price="By raising it with your leftover Stat Points."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				if(usr.SpeedDice<1)
					usr.VitalSlash=0;alert(usr,"This passive is unavailable to you at this time. You need 1 Speed Dice before you can view this passive.")
					return
				alert(usr, "[src] increases the user's chance to hit a vital organ when slashing with combos taking an immediate 500 Vitality damage and forcing the opponent to walk. Chance increases by 0.5% for each point. How to Train it: [price] [usr.VitalSlash]/[maxprice]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.VitalSlash<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.Kenjutsu<20*(usr.VitalSlash+1))
								usr<<"You need [25*(usr.VitalSlash+1)] Kenjutsu Knowledge before you can raise this passive further.";usr.clicking=0;return
							usr.VitalSlash++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		ShurikenMastery
			name="Shuriken Mastery"
			icon_state="ShurikenMastery"
			var/price="By throwing Shuriken."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the proficiency and a user's knowledge of shuriken. How to Train it: [price] [usr.ShurikenMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.ShurikenMastery+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		KunaiMastery
			name="Kunai Mastery"
			icon_state="KunaiMastery"
			var/price="By throwing Kunai."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the proficiency and a user's knowledge of kunai. How to Train it: [price] [usr.KunaiMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.KunaiMastery+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		SenbonMastery
			name="Senbon Mastery"
			icon_state="SenbonMastery"

			var/price="By throwing Senbons."
			var/maxprice="No Limit"
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the proficiency and a user's knowledge of Senbons. How to Train it: [price] [usr.SenbonMastery]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							usr.SenbonMastery+=10;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		SenbonImpale
			name="Acupuncture"
			icon_state="Acupuncture"
			var/price="By raising with Starting Points."
			var/maxprice=3
			Click()
				usr<<sound('SFX/click1.wav',0)
				//var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] increases the chance to directly hit the enemy in a direct place where you're looking, causing enhanced Accuracy. How to Train it: [price] [usr.SenbonImpale]/[maxprice]","[src.name]")//,,,,0,"400x150",,style)
				if(usr.StartingPoints>=1&&!usr.clicking)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Starting Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.SenbonImpale==3)
								usr<<"You can't raise this passive any further";usr.clicking=0;return
							if(usr.SenbonMastery<30*(usr.SenbonImpale+1))
								usr<<"You need [30*(usr.SenbonImpale+1)] Weapon Mastery before you can raise this passive further.";usr.clicking=0;return
							usr.SenbonImpale++;usr.StartingPoints-=1;usr.clicking=0
					usr.clicking=0
		NeedleTreatment
			name="Needle Treatment"
			icon_state="NeedleTreatment"
/*
			var/price="By throwing Senbons."
			var/maxprice=50
			Click()
				usr<<sound('SFX/click1.wav',0)
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"
				alert(usr, "[src] gives the user the chance to have a Needle stick inside of an opponent's body, which they'd have to take out. Increases by 1% for each point. How to Train it: [price] [usr.KunaiMastery]/[maxprice]","[src.name]",,,,0,"400x150",,style)
*/
		ThrowingStrength
			name="Throwing Strength"
			icon_state="ThrowingStrength"
			var/price="By throwing weapons."
			var/maxprice=5
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the speed of thrown weapons. How to Train it: [price] [usr.ThrowingStrength]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.ThrowingStrength<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.KunaiMastery+usr.ShurikenMastery<30*(usr.ThrowingStrength+1))
								usr<<"You need [30*(usr.ThrowingStrength+1)] Weapon Mastery before you can raise this passive further.";usr.clicking=0;return
							usr.ThrowingStrength++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0
		Percision
			name="Percision"
			icon_state="Percision"
			var/price="By hitting direct targets with your kunai."
			var/maxprice=10
			Click()
				usr<<sound('SFX/click1.wav',0)
				alert(usr, "[src] increases the accuracy of thrown weapons, so they may perform critical damage! How to Train it: [price] [usr.Percision]/[maxprice]","[src.name]")
				if(usr.StartingPoints>=1&&!usr.clicking&&usr.Percision<maxprice)
					usr.clicking=1
					switch(input(usr,"Would you like to raise this passive using your left over Stat Points?") in list ("No","Yes"))
						if("Yes")
							if(usr.KunaiMastery+usr.ShurikenMastery<30*(usr.ThrowingStrength+1))
								usr<<"You need [30*(usr.ThrowingStrength+1)] Weapon Mastery before you can raise this passive further.";usr.clicking=0;return
							usr.Percision++;usr.StartingPoints--;usr.clicking=0
					usr.clicking=0