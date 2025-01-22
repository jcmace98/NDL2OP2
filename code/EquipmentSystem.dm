mob/proc/UpdateEquipment()
	for(var/obj/Clothes/O in src.contents)
		if(O.worn)
			if(O.bodyarea)
				if(O.bodyarea=="Feet")
					var/image/EQUIP/I=image(O.icon,locate(8,131,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
					var/image/EQUIP/M=image(O.icon,locate(12,131,1))
					M.name=O.name
					M.icon_state=O.icon_state
					src << M
				if(O.bodyarea=="Eyes")
					var/image/EQUIP/I=image(O.icon,locate(13,140,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
					var/image/EQUIP/R=image(O.icon,locate(7,140,1))
					R.name=O.name
					R.icon_state=O.icon_state
					src << R
				if(O.bodyarea=="Legs")
					var/image/EQUIP/I=image(O.icon,locate(10,134,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="LArms")
					var/image/EQUIP/I=image(O.icon,locate(9,137,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="RArms")
					var/image/EQUIP/I=image(O.icon,locate(11,137,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="LHands")
					var/image/EQUIP/I=image(O.icon,locate(8,137,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="RHands")
					var/image/EQUIP/I=image(O.icon,locate(12,137,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="TorsoBottom")
					var/image/EQUIP/I=image(O.icon,locate(10,138,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="Torso")
					var/image/EQUIP/I=image(O.icon,locate(10,137,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="TorsoTop")
					var/image/EQUIP/I=image(O.icon,locate(10,136,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="Neck")
					var/image/EQUIP/I=image(O.icon,locate(10,139,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="Neck1")
					var/image/EQUIP/I=image(O.icon,locate(8,135,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="Neck2")
					var/image/EQUIP/I=image(O.icon,locate(12,135,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="Face")
					var/image/EQUIP/I=image(O.icon,locate(10,140,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="FaceTop")
					var/image/EQUIP/I=image(O.icon,locate(10,142,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="FaceTop2")
					var/image/EQUIP/I=image(O.icon,locate(13,142,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="FaceTop3")
					var/image/EQUIP/I=image(O.icon,locate(7,142,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I
				if(O.bodyarea=="Special")
					var/image/EQUIP/I=image(O.icon,locate(10,137,1))
					I.icon_state=O.icon_state;I.name=O.name;src << I

mob/proc/DelUpdateEquipment()
	src.client.images=list()


image/EQUIP
	icon='Icons/Hud/Equipment.dmi'





mob/var/tmp/EquipmentTree=0

mob/GainedAfterLogIn/verb
	Equipment()
		set hidden=1
		if(usr.EquipmentTree)
			usr<<sound('SFX/click2.wav',0)
			client.perspective=MOB_PERSPECTIVE
			client.eye=usr
			usr.EquipmentTree=0
			usr.DelUpdateEquipment()
			return
		else
			usr<<"Your view has changed, but you are still in the same spot."
			usr<<sound('SFX/click1.wav',0)
			usr.EquipmentTree=1
			client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			client.eye=locate(8,137,1)
			usr.UpdateEquipment()
			return
turf
	Skilltree/Equipment
		layer=OBJ_LAYER
		icon='Icons/Hud/Equipment.dmi'
		Arrow1
			icon_state="1"
		Arrow2
			icon_state="2"
		Arrow3
			icon_state="3"
		Arrow4
			icon_state="4"
		Equipment0
			icon_state="Equipment0"
		Equipment1
			icon_state="Equipment1"
		Equipment2
			icon_state="Equipment2"
		Equipment3
			icon_state="Equipment3"
		Equipment4
			icon_state="Equipment4"
		Equipment5
			icon_state="Equipment5"
		Equipment6
			icon_state="Equipment6"
		Equipment7
			icon_state="Equipment7"
		Equipment8
			icon_state="Equipment8"
		Equipment9
			icon_state="Equipment9"
		Equipment10
			icon_state="Equipment10"
		Equipment11
			icon_state="Equipment11"
		Equipment12
			icon_state="Equipment12"
		Equipment13
			icon_state="Equipment13"
		Equipment14
			icon_state="Equipment14"
		Equipment15
			icon_state="Equipment15"
		Equipment16
			icon_state="Equipment16"
		Equipment17
			icon_state="Equipment17"
		Equipment18
			icon_state="Equipment18"
		Equipment19
			icon_state="Equipment19"
		Equipment20
			icon_state="Equipment20"
		Equipment21
			icon_state="Equipment21"
		Equipment22
			icon_state="Equipment22"
		Equipment23
			icon_state="Equipment23"
		Equipment24
			icon_state="Equipment24"
		Equipment25
			icon_state="Equipment25"
		Equipment26
			icon_state="Equipment26"
		Equipment27
			icon_state="Equipment27"
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



/*mob/proc/ArmorCheck(ArmorChecking)
	var/obj/Clothes/ArmorCheck=ArmorChecking
	if(ArmorCheck:Durability<=0&&ArmorCheck:worn)
		usr<<"Your armor has been damaged too badly to be worn anymore."
		ArmorCheck:worn = 0
		usr.overlays -= ArmorCheck:icon
//		del(ArmorCheck)
		return
*/

obj/Clothes
	var
		colored=0
		EquipmentType=""
		EquipmentsOverlay=""
		ArmorAddOn=0
		Broken=0
		Durability=0//This is used for Armor
		DurabilityCap=0
		ReserverdDurability=0//This is eh...idk qq
		ReservedArmorAddOn=0
		ArmorMastery=0
		DurabilityAddOn=0
		BroilResistance=0//These are some of the Bonuses for Armor Upgrading ;o
		ShockResistance=0
		RegenerativeCloaking=0

		shirtred=0
		shirtgreen=0
		shirtblue=0

		have = 0
		bodyarea=""
		worn=0
	proc
		ArmorCheck(mob/M)
			if(src.Durability<=0&&src.worn)
				M<<"Your armor has been damaged too badly to be worn anymore. Take it to someone who might be able to repair it!"
				src.worn = 0
				M.overlays-=src.icon//usr.overlays -= src.icon
				src.Broken=1
		//		del(src)
				return
			else
				return
	verb
		Wear()
			if(src.Broken==1)
				usr<<"The [src] is broken as it's been worn out too much. Take it to someone who might be able to repair it!"
				return
			if(!src.worn)
				for(var/obj/Clothes/O in usr.contents)
					if(O.bodyarea==src.bodyarea)
						if(O.worn)
							usr << "You need to remove the [O] before you put this on!"
							return
				if(src.Durability<=0&&src.EquipmentType=="Armor")
					usr<<"You can't equip the [src] because it's too badly damaged!"
					return
				src.worn=1
				if(!src.colored)
					src.icon+=rgb(src.shirtred,src.shirtgreen,src.shirtblue)
					src.colored=1
				usr.overlays -= src.icon
				usr.overlays += src.icon
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
				if(usr.Doujutsu=="Sharingan")
					if(src.bodyarea=="LeftEye"&&usr.shari)
						spawn(1) usr.OneSharingan()
				if(usr.DoujutsuR=="Sharingan Right")
					if(src.bodyarea=="RightEye"&&usr.shari)
						spawn(1) usr.OneSharingan()
				if(src.bodyarea=="Eyes"&&usr.shari)
					spawn(1) usr.OneSharingan()
				if(usr.Doujutsu=="Byakugan")
					if(src.bodyarea=="LeftEye"&&usr.bya)
						spawn(1) usr.ByaOn()
				if(usr.DoujutsuR=="Byakugan Right")
					if(src.bodyarea=="RightEye"&&usr.bya)
						spawn(1) usr.ByaOn()
//				if(usr.Doujutsu=="Rinnegan")
//					if(src.bodyarea=="LeftEye"&&usr.shari)
//						spawn(1) usr.OneSharingan()
				if(src.bodyarea=="Eyes"&&usr.bya)
					spawn(1) usr.ByaOn()

			else
				src:worn = 0
				usr.overlays -= src.icon
				usr << "You remove the [src.name]."
				if(src.bodyarea=="LeftEye"&&usr.Doujutsu=="Sharingan")
					usr.OneSharingan()
				if(src.bodyarea=="RightEye"&&usr.DoujutsuR=="Sharingan Right")
					usr.OneSharingan()
				if(src.bodyarea=="Eyes"&&usr.Doujutsu=="Sharingan")
					usr.OneSharingan()
				if(src.bodyarea=="LeftEye"&&usr.Doujutsu=="Byakugan")
					usr.ByaOn()
				if(src.bodyarea=="Eyes"&&usr.Doujutsu=="Byakugan")
					usr.ByaOn()
				if(src.bodyarea=="RightEye"&&usr.DoujutsuR=="Byakugan Right")
					usr.ByaOn()
				if(src.bodyarea == "Special")
					usr<<"[src] fades away."
					del(src)
				src.suffix = ""
		Drop()
			if(src:worn == 1)
				usr << "Not while its being worn."
			if(src:worn == 0)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				usr.SaveK()
		Get()
			set src in oview(1)
			src.loc = usr
			usr<<"You picked up the [src]"

//Membershop Clothing
obj/Clothes
	WitchHat
		name="Witch Hat"
		bodyarea="FaceTop2"
		icon='Icons/New Base/Clothing/Member Shop Clothing/TopHat.dmi'
		layer=MOB_LAYER+1
		worn=0
	TopHat
		name="Top Hat"
		bodyarea="FaceTop2"
		icon='Icons/New Base/Clothing/Member Shop Clothing/TopHat2.dmi'
		layer=MOB_LAYER+1
		worn=0
	TimeskipSasukeSuit
		name="Timeskip-Sasuke Suit"
		bodyarea="TorsoTop"
		icon='Icons/New Base/Clothing/Member Shop Clothing/TimeskipSasukeSuit.dmi'
		layer=MOB_LAYER+1
		worn=0
	IchigoMask
		name="Ichigo Mask"
		bodyarea="FaceTop"
		icon='Icons/New Base/Clothing/Member Shop Clothing/IchigoMask.dmi'
		layer=MOB_LAYER+1
		worn=0
	IchigoMask2
		name="Ichigo Mask"
		bodyarea="FaceTop"
		icon='Icons/New Base/Clothing/Member Shop Clothing/IchigoMask2.dmi'
		layer=MOB_LAYER+1
		worn=0
	HurricaneSuit
		name="Hurricane Suit"
		bodyarea="Torso"
		icon='Icons/New Base/Clothing/Member Shop Clothing/HurricaneSuit.dmi'
		layer=MOB_LAYER+1
		worn=0
	SageMode
		name="Sage Jacket"
		bodyarea="TorsoTop"
		icon='Icons/New Base/Clothing/Member Shop Clothing/SageCloak.dmi'
		layer=MOB_LAYER+1
		worn=0
	Zetsu
		name="Zetsu"
		bodyarea="Neck1"
		icon='Icons/New Base/Clothing/Member Shop Clothing/Zetsu.dmi'
		layer=MOB_LAYER+1
		ArmorAddOn=10
		worn=0
	DrStein
		name="Life-O-Meter"
		bodyarea="FaceTop"
		icon='Icons/New Base/Clothing/Member Shop Clothing/DrStein.dmi'
		layer=MOB_LAYER+1
		ArmorAddOn=1
		worn=0
/////////


obj/Clothes
	Shoes
		name = "Shoes"
		icon = 'Icons/New Base/Clothing/Cloths.dmi'//dont have a base icon so cant make weights icon!lol
		bodyarea="Feet"
		worn = 0
	SoundBeltPurple
		name="Sound Belt"
		icon='Icons/New Base/Clothing/Official Clothing/SoundBeltPurple.dmi'
		bodyarea="Belt"
		worn=0
	SoundBeltBlack
		name="Sound Belt"
		icon='Icons/New Base/Clothing/Official Clothing/SoundBeltBlack.dmi'
		bodyarea="Belt"
		worn=0
	SoundBeltWhite
		name="Sound Belt"
		icon='Icons/New Base/Clothing/Official Clothing/SoundBeltWhite.dmi'
		bodyarea="Belt"
		worn=0
obj/Clothes
	SoundOutfit
		name = "Sound Organization Outfit"
		icon = 'Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
		bodyarea="Torso"
		worn = 0
obj/Clothes
	Shorts
		name = "Shorts"
		bodyarea="Legs"
		icon='Icons/New Base/Clothing/Shorts.dmi'
		worn = 0
	Pants
		name = "Pants"
		bodyarea="Legs"
		icon = 'Icons/New Base/Clothing/pants.dmi'
		worn = 0
	BaggyPants
		name="Baggy Pants"
		bodyarea="Legs"
		icon='Icons/New Base/Clothing/BaggyPants.dmi'
		worn=0
obj/Clothes
	Headband
		name = "Head Band"
		bodyarea="FaceTop"
		var/Style="Normal"
		worn = 0
		icon = 'Icons/New Base/Clothing/Headbands/headband.dmi'
		ArmorAddOn=1
		var/ColorHeadBand=""
		var/firsttime=0
		Wear()
			if(!firsttime)
				if(src.ColorHeadBand=="")
					switch(input(usr,"What color would you like your Headband? (This can not be changed)","Headband style picker")in list("Blue","Red","Brown","White","Black","Green"))
						if("Blue")
							ColorHeadBand="Blue"
						if("Red")
							ColorHeadBand="Red"
						if("Brown")
							ColorHeadBand="Brown"
						if("White")
							ColorHeadBand="White"
						if("Black")
							ColorHeadBand="Black"
						if("Green")
							ColorHeadBand="Green"

				var/icon/A
				switch(input(usr,"What head band style would you like?","Headband style picker")in list("Regular","Top Covering Style","Bandaged Style","Head Armor Style","Waist Style","Neji Style","Turned Style","Bandana Style","Neck Style","Leg Style","Slash Style"/*,"Exclusive Style"*/))
					if("Regular")
						A = icon('Icons/New Base/Clothing/Headbands/headband.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="FaceTop"
					if("Exclusive Style")
						A = icon('Icons/New Base/Clothing/Headbands/HeadbandExclusive.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="FaceTop"
					if("Top Covering Style")
						A = icon('Icons/New Base/Clothing/Headbands/KisameHeadband.dmi')
						usr<<"You wear the [src.name]."
						src.suffix="Equipped"
						bodyarea="FaceTop"
					if("Head Armor Style")
						A = icon('Icons/New Base/Clothing/Headbands/YamatoHeadband.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="FaceTop"
					if("Waist Style")
						A = icon('Icons/New Base/Clothing/Headbands/leetype.dmi')
						usr<<"You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="Waist"
					if("Neji Style")
						A = icon('Icons/New Base/Clothing/Headbands/NejiHB.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="FaceTop"
					if("Turned Style")
						A = icon('Icons/New Base/Clothing/Headbands/ZabuzaHeadband.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="FaceTop"
					if("Bandana Style")
						A = icon('Icons/New Base/Clothing/Headbands/Bheadband.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						src.Style="HairCover"
						bodyarea="FaceTop"
					if("Bandaged Style")
						A = icon('Icons/New Base/Clothing/Headbands/BandagedHeadband.dmi')
						usr<<"You wear the [src.name]."
						src.suffix = "Equipped"
						src.Style="HairCover2"
						bodyarea="Eyes"
						if(usr.shari) usr.OneSharingan()
					if("Neck Style")
						A = icon('Icons/New Base/Clothing/Headbands/HeadbandNeck.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="Neck"
					if("Slash Style")
						A = icon('Icons/New Base/Clothing/Headbands/KakashiHeadband.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="LeftEye" //Can be used to stop chakra drain on one eyed doujutsus later on.
						if(usr.shari) usr.OneSharingan()
					if("Leg Style")
						A = icon('Icons/New Base/Clothing/Headbands/HeadbandLeg.dmi')
						usr << "You wear the [src.name]."
						src.suffix = "Equipped"
						bodyarea="LLeg"
				if(ColorHeadBand=="Blue")
					A.SwapColor(rgb(77,77,77),rgb(7,51,223)) //black
					A.SwapColor(rgb(42,42,42),rgb(5,19,143))
					A.SwapColor(rgb(0,0,0),rgb(3,5,107))
					A.SwapColor(rgb(15,15,15),rgb(0,10,125))
					A.SwapColor(rgb(35,35,35),rgb(5,15,138))
					A.SwapColor(rgb(50,50,50),rgb(10,25,150))
					A.SwapColor(rgb(70,70,70),rgb(20,42,170))
					A.SwapColor(rgb(79,79,79),rgb(25,48,179))
					A.SwapColor(rgb(39,39,78),rgb(10,22,171))
					A.SwapColor(rgb(16,18,3),rgb(2,14,109)) //Kakashi headband
					A.SwapColor(rgb(37,49,63),rgb(8,20,144))
					A.SwapColor(rgb(39,54,73),rgb(9,24,149))
					A.SwapColor(rgb(34,47,64),rgb(8,22,145))
					A.SwapColor(rgb(59,59,55),rgb(15,31,160)) //lee headband
					A.SwapColor(rgb(0,0,70),rgb(0,0,100)) //Zabuzaheadband its really blue but its on a black headband
				if(ColorHeadBand=="Black") //most headbands are already black so not much work..
					A.SwapColor(rgb(0,0,83),rgb(10,10,10))   //blue //BandagedHeadband
					A.SwapColor(rgb(0,0,102),rgb(24,24,24))
					A.SwapColor(rgb(0,0,136),rgb(42,42,42))
					A.SwapColor(rgb(0,0,151),rgb(70,70,70))
					A.SwapColor(rgb(0,0,153),rgb(77,77,77))
					A.SwapColor(rgb(0,0,174),rgb(85,85,85))
					A.SwapColor(rgb(0,0,66),rgb(0,0,0))//KisameHeadband
					A.SwapColor(rgb(0,0,111),rgb(36,36,36))
					A.SwapColor(rgb(0,0,138),rgb(50,50,50))
				if(ColorHeadBand=="Brown")
					A.SwapColor(rgb(77,77,77),rgb(111,77,38)) //black
					A.SwapColor(rgb(42,42,42),rgb(90,62,31))
					A.SwapColor(rgb(0,0,0),rgb(55,38,19))
					A.SwapColor(rgb(15,15,15),rgb(69,48,24))
					A.SwapColor(rgb(35,35,35),rgb(77,55,28))
					A.SwapColor(rgb(50,50,50),rgb(100,72,36))
					A.SwapColor(rgb(70,70,70),rgb(115,82,41))
					A.SwapColor(rgb(79,79,79),rgb(120,86,43))
					A.SwapColor(rgb(39,39,78),rgb(80,57,29))
					A.SwapColor(rgb(16,18,3),rgb(70,50,25)) //Kakashi headband
					A.SwapColor(rgb(37,49,63),rgb(80,60,30))
					A.SwapColor(rgb(39,54,73),rgb(83,60,45))
					A.SwapColor(rgb(34,47,64),rgb(77,55,28))
					A.SwapColor(rgb(59,59,55),rgb(108,77,39)) //lee headband
					A.SwapColor(rgb(0,0,70),rgb(55,38,19))//Zabuzaheadband its really blue but its on a black headband
					A.SwapColor(rgb(0,0,83),rgb(69,48,24))   //blue
					A.SwapColor(rgb(0,0,102),rgb(77,55,28))
					A.SwapColor(rgb(0,0,136),rgb(90,62,31))
					A.SwapColor(rgb(0,0,151),rgb(111,77,38))
					A.SwapColor(rgb(0,0,153),rgb(115,82,41))
					A.SwapColor(rgb(0,0,174),rgb(125,86,43))
					A.SwapColor(rgb(0,0,66),rgb(50,32,11))
					A.SwapColor(rgb(0,0,111),rgb(77,55,28))
					A.SwapColor(rgb(0,0,138),rgb(90,62,31))
				if(ColorHeadBand=="Red")
					A.SwapColor(rgb(77,77,77),rgb(140,0,0)) //black
					A.SwapColor(rgb(42,42,42),rgb(110,0,0))
					A.SwapColor(rgb(0,0,0),rgb(90,0,0))
					A.SwapColor(rgb(15,15,15),rgb(98,0,0))
					A.SwapColor(rgb(35,35,35),rgb(105,0,0))
					A.SwapColor(rgb(50,50,50),rgb(118,20,24))
					A.SwapColor(rgb(70,70,70),rgb(135,14,19))
					A.SwapColor(rgb(79,79,79),rgb(142,16,22))
					A.SwapColor(rgb(39,39,78),rgb(109,10,0))
					A.SwapColor(rgb(16,18,3),rgb(100,5,2)) //Kakashi headband
					A.SwapColor(rgb(37,49,63),rgb(107,6,8))
					A.SwapColor(rgb(39,54,73),rgb(110,7,10))
					A.SwapColor(rgb(34,47,64),rgb(112,5,8))
					A.SwapColor(rgb(59,59,55),rgb(125,7,9)) //lee headband
					A.SwapColor(rgb(0,0,70),rgb(70,0,4))//Zabuzaheadband its really blue but its on a black headband
					A.SwapColor(rgb(0,0,83),rgb(83,4,4))   //blue
					A.SwapColor(rgb(0,0,102),rgb(102,5,8))
					A.SwapColor(rgb(0,0,136),rgb(136,6,10))
					A.SwapColor(rgb(0,0,151),rgb(151,10,15))
					A.SwapColor(rgb(0,0,153),rgb(153,14,19))
					A.SwapColor(rgb(0,0,174),rgb(174,22,28))
					A.SwapColor(rgb(0,0,66),rgb(66,0,1))
					A.SwapColor(rgb(0,0,111),rgb(111,5,11))
					A.SwapColor(rgb(0,0,138),rgb(138,6,10))
				if(ColorHeadBand=="White")
					A.SwapColor(rgb(77,77,77),rgb(240,240,240)) //black
					A.SwapColor(rgb(42,42,42),rgb(210,210,210))
					A.SwapColor(rgb(0,0,0),rgb(165,165,165))
					A.SwapColor(rgb(15,15,15),rgb(175,175,179))
					A.SwapColor(rgb(35,35,35),rgb(190,190,197))
					A.SwapColor(rgb(50,50,50),rgb(216,216,219))
					A.SwapColor(rgb(70,70,70),rgb(230,230,235))
					A.SwapColor(rgb(79,79,79),rgb(242,242,246))
					A.SwapColor(rgb(39,39,78),rgb(200,200,207))
					A.SwapColor(rgb(16,18,3),rgb(180,180,182)) //Kakashi headband
					A.SwapColor(rgb(37,49,63),rgb(205,206,216))
					A.SwapColor(rgb(39,54,73),rgb(207,207,210))
					A.SwapColor(rgb(34,47,64),rgb(212,205,218))
					A.SwapColor(rgb(59,59,55),rgb(219,220,229)) //lee headband
					A.SwapColor(rgb(0,0,70),rgb(170,170,170))//Zabuzaheadband its really blue but its on a black headband
					A.SwapColor(rgb(0,0,83),rgb(183,183,183))   //blue
					A.SwapColor(rgb(0,0,102),rgb(202,205,208))
					A.SwapColor(rgb(0,0,136),rgb(226,226,230))
					A.SwapColor(rgb(0,0,151),rgb(234,236,240))
					A.SwapColor(rgb(0,0,153),rgb(240,238,239))
					A.SwapColor(rgb(0,0,174),rgb(255,249,252))
					A.SwapColor(rgb(0,0,66),rgb(166,166,170))
					A.SwapColor(rgb(0,0,111),rgb(189,189,195))
					A.SwapColor(rgb(0,0,138),rgb(230,236,239))
				if(ColorHeadBand=="Green")
					A.SwapColor(rgb(77,77,77),rgb(46,139,87)) //black
					A.SwapColor(rgb(42,42,42),rgb(46,139,87))
					A.SwapColor(rgb(0,0,0),rgb(46,139,87))
					A.SwapColor(rgb(15,15,15),rgb(46,139,87))
					A.SwapColor(rgb(35,35,35),rgb(46,139,87))
					A.SwapColor(rgb(50,50,50),rgb(46,139,87))
					A.SwapColor(rgb(70,70,70),rgb(46,139,87))
					A.SwapColor(rgb(79,79,79),rgb(46,139,87))
					A.SwapColor(rgb(39,39,78),rgb(46,139,87))
					A.SwapColor(rgb(16,18,3),rgb(146,139,87)) //Kakashi headband
					A.SwapColor(rgb(37,49,63),rgb(46,139,87))
					A.SwapColor(rgb(39,54,73),rgb(46,139,87))
					A.SwapColor(rgb(34,47,64),rgb(46,139,87))
					A.SwapColor(rgb(59,59,55),rgb(46,139,87)) //lee headband
					A.SwapColor(rgb(0,0,70),rgb(46,139,87))//Zabuzaheadband its really blue but its on a black headband
					A.SwapColor(rgb(0,0,83),rgb(46,139,87))   //blue
					A.SwapColor(rgb(0,0,102),rgb(46,139,87))
					A.SwapColor(rgb(0,0,136),rgb(46,139,87))
					A.SwapColor(rgb(0,0,151),rgb(46,139,87))
					A.SwapColor(rgb(0,0,153),rgb(46,139,87))
					A.SwapColor(rgb(0,0,174),rgb(46,139,87))
					A.SwapColor(rgb(0,0,66),rgb(46,139,87))
					A.SwapColor(rgb(0,0,111),rgb(46,139,87))
					A.SwapColor(rgb(0,0,138),rgb(46,139,87))
				src.icon=A
				src.firsttime=1
			if(src.worn == 1)
				src:worn = 0
				if(!usr.shari&&src.bodyarea=="LeftEye"&&usr.Doujutsu=="Sharingan")
					spawn(1) usr.OneSharingan()
				if(!usr.Akametsuki&&src.bodyarea=="LeftEye"&&usr.Doujutsu=="Akametsuki")
					spawn(1) usr.OneEyeAkametsuki()
				usr.overlays-=src.icon
				if(usr.hair&&src.Style!="Normal")
					var/icon/I
					if(src.Style=="HairCover")
						I = icon(usr.hair);I.Crop(1,23,32,1)
					else if(src.Style=="HairCover2")
						I = icon(usr.hair);I.Crop(1,21,32,1)
					if(I)
						usr.overlays-=I;usr.overlays+=usr.hair
				usr << "You remove the [src.name]."
				src.suffix = ""
				//bodyarea="FaceTop"
				usr.mouse_over_pointer=null
			else
				for(var/obj/Clothes/O in usr.contents)
					if(O.bodyarea==src.bodyarea)
						if(O.worn)
							usr << "You need to remove the [O] before you put this on!"
							return
				usr.overlays+=src.icon
				if(usr.hair&&src.Style!="Normal")
					var/icon/I
					if(src.Style=="HairCover")
						I = icon(usr.hair);I.Crop(1,23,32,1)
					else if(src.Style=="HairCover2")
						I = icon(usr.hair);I.Crop(1,21,32,1)
					if(I)
						usr.overlays+=I;usr.overlays-=usr.hair
				src.worn=1
				if(usr.Village=="Leaf")
					usr.mouse_over_pointer='Icons/Hud/SymbolLeaf.dmi'
				if(usr.Village=="Rain")
					usr.mouse_over_pointer='Icons/Hud/SymbolRain.dmi'
				if(usr.Village=="Rock")
					usr.mouse_over_pointer='Icons/Hud/SymbolRock.dmi'
				if(usr.Village=="Sound")
					usr.mouse_over_pointer='Icons/Hud/SymbolSound.dmi'
				if(usr.Clan=="Senju")
					usr.mouse_over_pointer='Icons/Hud/SymbolTerra.dmi'
mob/var/tmp/delivered=0
mob/var/tmp/pickedup=0
mob/player/var
	altername
	alterlastname
	alterV = "Missing"
	alterC = "Basic"
	alterR = "Genin"
	OriginalVillage = ""
	Orank = ""
	OClan = ""
obj/Clothing/TobiMask
	icon='Tobi.dmi'
	layer=5
obj
	MaskT
		name = "Tobi Mask"
		icon = 'Tobi.dmi'
		var/worn=0
		verb
			Wear()
				var/obj/Clothing/TobiMask/O = new()
				O.icon=src.icon;O.layer=5
				if(src.worn == 1)
					src:worn = 0
					usr.name = usr.oname
					usr.Clan = usr:OClan
					usr.rank = usr:Orank
					usr.Village = usr:OriginalVillage
					usr.overlays -= O
					usr.overlays -= O
					usr << "You remove the [src.name]."
					src.suffix = ""
				else
					src:worn = 1
					usr.oname = usr.name
					usr:OClan = usr.Clan
					usr:Orank = usr.rank
					usr:OriginalVillage = usr.Village
					if(usr:alterlastname!=""&&usr:alterlastname!=null)
						usr.name = "[usr:alterlastname], [usr:altername]"
					else
						usr.name = usr:altername
					usr.rank = usr:alterR
					usr.Clan = usr:alterC
					usr.Village = usr:alterV
					usr.overlays += O
					usr << "You wear the [src.name]."
					src.suffix = "Equipped"
			ChangeAlterIdentity()
				usr:altername = input(usr,"What do you want your alter identity to be?","First Name","???") as text
				usr:alterlastname = input(usr,"What do you want your alter last name to be? If you don't want one leave this blank.","Last Name","") as text
				usr:alterV = input(usr,"What do you want your alter village to be?","Alter Identity","Missing") as text
				//usr:alterC = input(usr,"What do you want your alter clan to be; Note this really doesnt change your clan just makes it appear so.?","Alter Identity","Basic") as text
				usr:alterR = input(usr,"What do you want your alter rank to be?","Alter Identity","Jounin") as text
				usr<<"You alter identity when you wear your mask is now [usr:altername] a [usr:alterV] ninja."
			Drop()
				if(src:worn == 1)
					usr << "Not while its being worn."
				if(src:worn == 0)
					src.loc=locate(0,0,0)
					usr.SaveK()
					usr<<"The mask vanishes..."
					del(src)
			Get()
				set src in oview(1)
				src.loc = usr
				usr<<"You picked up a [src]"

obj/Clothes
	HunterNinMask
		name="Hunter-Nin Mask"
		icon='Icons/New Base/Clothing/Official Clothing/Hunter-NinMask.dmi'
		bodyarea="FaceTop"
		layer = MOB_LAYER + 1
		worn = 0

		Wear()
			if(!usr.HunterNinMember||usr.Village!="Rain")
				if(!usr.HunterNinMember)
					usr<<"It's a damn shame you're not a Hunter Nin. *Mask Cracks*"
					del(src)
					usr.SaveK()
				if(usr.Village!="Rain")
					usr<<"It's a damn shame you're not in Rain. *Mask Cracks*"
					del(src)
					usr.SaveK()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/Hunter-NinMask.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "Hunter-Nin"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/Hunter-NinMask.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
	HunterNinMask2
		name="Hunter-Nin Mask"
		icon='Icons/New Base/Clothing/Official Clothing/Hunter-NinMask2.dmi'
		bodyarea="FaceTop"
		layer = MOB_LAYER + 1
		worn = 0

		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/Hunter-NinMask2.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "Hunter-Nin"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/Hunter-NinMask2.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
	HunterNinMask3
		name="Hunter-Nin Mask"
		icon='Icons/New Base/Clothing/Official Clothing/Hunter-NinMask3.dmi'
		bodyarea="FaceTop"
		layer = MOB_LAYER + 1
		worn = 0

		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/Hunter-NinMask3.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "Hunter-Nin"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/Hunter-NinMask3.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
	KonohaMilitaryCap
		name="Konoha Military Cap"
		bodyarea="Head"
		icon='Icons/New Base/Clothing/Official Clothing/MilitaryCaps.dmi'
		layer=MOB_LAYER+1
		worn=0
	SoundOrganizationSuit
		name="Sound Organization Suit"
		bodyarea="Torso"
		icon='Icons/New Base/Clothing/Official Clothing/SOSuit.dmi'
		layer=MOB_LAYER+1
		worn=0
	Ranbu
		name = "Bunny ANBU mask"
		bodyarea="FaceTop"
		icon='Icons/New Base/Clothing/Official Clothing/ANBUMask2.dmi'//dont have a base icon so cant make weights icon!lol
		layer = MOB_LAYER + 1
		worn = 0

		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/ANBUMask2.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "ANBU"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/ANBUMask2.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
	Isane_Mask
		name = "Insane Mask"
		bodyarea="FaceTop"
		icon='Icons/New Base/Clothing/Member Shop Clothing/IchigoMask2.dmi'//dont have a base icon so cant make weights icon!lol
		layer = MOB_LAYER + 1
		worn = 0

		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Member Shop Clothing/IchigoMask2.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "Insane Prisoner"
				usr.overlays += 'Icons/New Base/Clothing/Member Shop Clothing/IchigoMask2.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
		verb
			Tp()
				switch(input("Where do you want to go?")in list("Base","Leaf","Rain","Rock","Sound"))
					if("Base")
						usr.Move(locate(180,30,30))
					if("Leaf")
						usr.Move(locate(155,94,11))
					if("Rain")
						usr.Move(locate(82,77,6))
					if("Rock")
						usr.Move(locate(116,61,14))
					if("Sound")
						usr.Move(locate(52,18,4))
	Turban
		name="Turban"
		bodyarea="FaceTop"
		icon = 'Icons/New Base/Clothing/Turban.dmi'
		worn = 0
	Ganbu
		name = "Green Cat ANBU mask"
		bodyarea="FaceTop"
		icon = 'Icons/New Base/Clothing/Official Clothing/Ganbu.dmi'
		worn = 0

		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/Ganbu.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "ANBU"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/Ganbu.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
	Banbu
		name = "Blue Cat ANBU mask"
		bodyarea="FaceTop"
		icon = 'Icons/New Base/Clothing/Official Clothing/Banbu.dmi'//dont have a base icon so cant make weights icon!lol
		worn = 0
		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/Banbu.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "ANBU"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/Banbu.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
	FoxAnbu
		name = "Kyuubi ANBU mask"
		bodyarea="FaceTop"
		icon = 'Icons/New Base/Clothing/Official Clothing/ANBUMask.dmi'//dont have a base icon so cant make weights icon!lol
		layer = MOB_LAYER + 1
		worn = 0
		Wear()
			if(src.worn == 1)
				src:worn = 0
				usr.name = usr.oname
				usr.overlays -= 'Icons/New Base/Clothing/Official Clothing/ANBUMask.dmi'//temp icon
				usr << "You remove the [src.name]."
				src.suffix = ""
			else
				src:worn = 1
				usr.oname = usr.name
				usr.name = "ANBU"
				usr.overlays += 'Icons/New Base/Clothing/Official Clothing/ANBUMask.dmi'
				usr << "You wear the [src.name]."
				src.suffix = "Equipped"
obj/Clothes
	Gourd
		name = "Gourd"
		bodyarea="TorsoTop"
//		icon = 'Icons/New Base/Clothing/Gord.dmi'//dont have a base icon so cant make weights icon!lol
		worn = 0
obj/Clothes
	ArmWR
		name = "Right-Handed Arm Wrappings"
		bodyarea="RArms"
		icon='Icons/New Base/Clothing/bandagesR.dmi'
		worn=0
	ArmWL
		name = "Left-Handed Arm Wrappings"
		bodyarea="LArms"
		icon = 'Icons/New Base/Clothing/bandagesL.dmi'
		worn=0


obj/Clothes
	Gloves
		name = "Right-Handed Gloves"
		bodyarea="RHands"
		icon = 'Icons/New Base/Clothing/gloves.dmi'
		worn = 0
obj/Clothes
	Sleeves
		name = "Sleeves"
		bodyarea="RHands"
		icon = 'Icons/New Base/Clothing/Sleeves.dmi'
		worn = 0
obj/Clothes
	Uchiha_Crest
		icon='Icons/New Base/Clothing/Uchiha Crest.dmi'
		worn = 0
		layer = MOB_LAYER
		Wear()
			if(src.worn==1)
				src:worn = 0
				usr.overlays -= 'Uchiha Crest.dmi'//temp icon
				usr << "You remove the [src.name] symbol."
				src.suffix = ""
			else
				src:worn = 1
				usr.overlays += 'Uchiha Crest.dmi'
				usr << "You wear the [src.name] symbol."
				src.suffix = "Equipped"
	InuzukaMarks
		name="Inuzuka Markings"
		icon='Icons/New Base/Clothing/InuzukaMarks.dmi'
		worn = 0
		layer = MOB_LAYER
		Wear()
			if(src.worn==1)
				src:worn = 0
				usr.overlays -= 'Icons/New Base/Clothing/InuzukaMarks.dmi'//temp icon
				usr << "You remove the [src.name] symbol."
				src.suffix = ""
			else
				src:worn = 1
				usr.overlays += 'Icons/New Base/Clothing/InuzukaMarks.dmi'
				usr << "You wear the [src.name] symbol."
				src.suffix = "Equipped"


obj/Clothes
	NewHat
		name = "Ninja Hat"
		bodyarea="FaceTop"
		icon = 'Icons/New Base/Clothing/NinjaHat.dmi'
		worn = 0
		layer = MOB_LAYER + 1
		Wear()
			if(!usr.hair)
				if(src.worn == 1)
					src:worn = 0;usr.overlays -= 'Icons/New Base/Clothing/NinjaHat.dmi'
					usr << "You remove the [src.name].";src.suffix = ""
				else
					src:worn = 1;usr.overlays += 'Icons/New Base/Clothing/NinjaHat.dmi'
					usr << "You wear the [src.name].";src.suffix = "Equipped"
			else
				var/icon/I = icon(usr.hair);I.Crop(1,24,32,1)
				if(src.worn == 1)
					src:worn = 0
					usr.overlays -= I;usr.overlays -= 'Icons/New Base/Clothing/NinjaHat.dmi';usr.overlays += usr.hair
					usr << "You remove the [src.name].";src.suffix = ""
				else
					src:worn = 1
					usr.overlays -= usr.hair;usr.overlays += I;usr.overlays += 'Icons/New Base/Clothing/NinjaHat.dmi'
					usr << "You wear the [src.name].";src.suffix = "Equipped"
//Eyes
obj/Clothes
	LeftEyepatch
		name="Left-Eyepatch"
		bodyarea="LeftEye"
		icon='Icons/New Base/Clothing/LEyePatch.dmi'
		worn=0
	RightEyepatch
		name="Right-Eyepatch"
		bodyarea="RightEye"
		icon='Icons/New Base/Clothing/REyePatch.dmi'
		worn=0
	SunGlasses
		name = "Sunglasses"
		bodyarea="Eyes"
		icon='Icons/New Base/Clothing/glasses.dmi'
		worn=0
		Wear()
			if(!src.worn)
				var/obj/Mshar/MM=new()
				MM.screen_loc = "1,1 to 19,19"
				usr.client.screen+=MM
				MM.icon_state="weak"
				..()
			else
				src.worn=0
				usr.overlays-=src
				usr<<"You remove the [src]"
				src.suffix=""
				for(var/obj/Mshar/P in usr.client.screen)
					del(P)

	C00LSunGlasses
		name = "c00l Sunglasses"
		bodyarea="Eyes"
		icon='Icons/New Base/Clothing/shades.dmi'
		worn=0
	GogglesOrange
		name="Goggles"
		bodyarea="Eyes"
		icon='Icons/New Base/Clothing/GogglesOrange.dmi'
		worn=0
	GogglesBlue
		name="Goggles"
		bodyarea="Eyes"
		icon='Icons/New Base/Clothing/GogglesBlue.dmi'
		worn=0
	RangeExtender
		name = "Range Extender"
		bodyarea="Eyes"
		icon='Icons/New Base/Clothing/rangeextend.dmi'
		worn=0
		Wear()
			if(!(usr.key in Subscribers))
				usr<<"You aren't a subscriber!"
				del(src)
				return
			if(src.worn)
				src.worn=0
				usr.overlays-=src
				usr<<"You remove the [src]"
				src.suffix=""
				for(var/obj/SkillCards/RangeExtend/P in usr.LearnedJutsus)
					del(P)
				usr.UpdateInv()
			else
				if(!(locate(/obj/SkillCards/RangeExtend) in usr.LearnedJutsus))
					usr.LearnedJutsus+=new/obj/SkillCards/RangeExtend
				usr.UpdateInv()
				..()
//Face
obj/Clothes
	FaceMask
		name = "Face Mask"
		bodyarea="Face"
		icon='Icons/New Base/Clothing/kakashi mask.dmi'
		worn=0
	FaceW2
		name = "Face Wrappings"
		bodyarea="Face"
		icon = 'Icons/New Base/Clothing/facewrap.dmi'//dont have a base icon so cant make weights icon!lol
		worn = 0
	MouthBreather
		name = "Ventilation Mask"
		bodyarea="Face"
		icon = 'Icons/New Base/Clothing/HanzouMask.dmi'
		worn = 0
	EyeScope
		name = "Eye Scope"
		bodyarea = "LeftEye"
		icon = 'Icons/New Base/Clothing/EyeScope.dmi'
		worn =0
//TorsoBottom
	Shirt
		name = "Shirt"
		bodyarea="TorsoBottom"
		icon='Icons/New Base/Clothing/Shirt.dmi'
		worn=0

//Gaara's Gourd
	Gourd
		name = "Gourd"
		bodyarea="Torso"
		icon='Icons/New Base/Weapons/SabakuGourd (1).dmi'
		worn=0
//Torso
	LJouninsuit
		name = "Leaf Jounin suit"
		bodyarea="Torso"
		icon = 'Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
		worn = 0
	RJouninsuit
		name = "Rock Jounin suit"
		bodyarea="Torso"
		icon = 'Icons/New Base/Clothing/Official Clothing/RockJouninS.dmi'
		worn = 0
	RaJouninsuit
		name = "Rain Jounin suit"
		bodyarea="Torso"
		icon = 'Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
		worn = 0
	SJouninsuit
		name = "Sound Jounin suit"
		bodyarea="Torso"
		icon = 'Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
		worn = 0
	SasukeShirt
		name = "Neck-Band Shirt"
		icon = 'Icons/New Base/Clothing/SasukeShirt.dmi'
		bodyarea="Torso"
		worn=0
	SleevelessShirt
		name = "Sleeveless Shirt"
		bodyarea="Torso"
		icon='Icons/New Base/Clothing/Sleeveless Shirt.dmi'
		worn = 0
//TorsoTop
	SJouninsuit2
		name = "Sound Jounin suit"
		bodyarea="Torso"
		icon = 'Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
		EquipmentType="Armor"
		worn=0
		Durability=60
		DurabilityCap=100
		bodyarea="TorsoTop"
		ArmorAddOn=30

	ANBUArmor
		name="ANBU Armor"
		icon='Icons/New Base/Clothing/Official Clothing/ANBUArmor.dmi'
		EquipmentType="Armor"
		worn=0
		Durability=6000
		DurabilityCap=6000
		bodyarea="TorsoTop"
		ArmorAddOn=20
		Wear()
			if(!usr.Anbu)
				usr<<"You're not an ANBU..."
				del(src)
			else
				..()
	RootUniform
		name = "ANBU Root"
		bodyarea="TorsoTop"
		Durability=6000
		DurabilityCap=6000
		ArmorAddOn=20
		icon = 'Icons/New Base/Clothing/Official Clothing/AnbuRoot.dmi'
		EquipmentType="Armor"
		worn = 0
		Wear()
			if(!usr.AnbuCaptain)
				usr<<"You're not in Root..."
				del(src)
			else
				..()
	LightArmor
		name="Light Armor"
		icon='Icons/New Base/Clothing/Official Clothing/LightGrayArmor.dmi'
		var/ArmorType
		worn=0
		EquipmentType="Armor"
		Durability=3000
		DurabilityCap=3000
		bodyarea="TorsoTop"
		PlacementWeight=0
		ArmorAddOn=10
		shirtred=0
		shirtgreen=0
		shirtblue=0
		Drop()
			if(src:worn == 1)
				usr << "Not while its being worn."
			if(src:worn == 0)
				usr<<"You drop the Armor."
				del(src)
				usr.SaveK()
	BalancedArmor
		name="Armor"
		icon='Icons/New Base/Clothing/Official Clothing/TobiramaArmor.dmi'
		var/ArmorType
		worn=0
		EquipmentType="Armor"
		Durability=3500
		DurabilityCap=3500
		bodyarea="TorsoTop"
		PlacementWeight=0
		ArmorAddOn=15
		shirtred=0
		shirtgreen=0
		shirtblue=0
		Drop()
			if(src:worn == 1)
				usr << "Not while its being worn."
			if(src:worn == 0)
				usr<<"You drop the Armor."
				del(src)
				usr.SaveK()
	HeavyArmor
		name="Heavy Armor"
		icon='Icons/New Base/Clothing/Official Clothing/NinjaArmor.dmi'
		var/ArmorType
		worn=0
		EquipmentType="Armor"
		Durability=4000
		DurabilityCap=4000
		bodyarea="TorsoTop"
		PlacementWeight=0
		ArmorAddOn=25
		shirtred=0
		shirtgreen=0
		shirtblue=0
		Drop()
			if(src:worn == 1)
				usr << "Not while its being worn."
			if(src:worn == 0)
				usr<<"You drop the Armor."
				del(src)
				usr.SaveK()
	ANBUHandGuards
		name="ANBU Hand Guards"
		icon='Icons/New Base/Clothing/Official Clothing/ANBUHandGuards.dmi'
		worn=0
		EquipmentType="Armor"
		Durability=5000
		DurabilityCap=5000
		bodyarea="Arms"
		ArmorAddOn=5
		Wear()
			if(!usr.Anbu)
				usr<<"You're not an ANBU..."
				del(src)
			else
				..()
	HunterNinClothing
		name="Hunter-Nin Cloth"
		icon='Icons/New Base/Clothing/Official Clothing/Hunter-NinClothing.dmi'
		worn=0
		bodyarea="TorsoTop"
	Chuunin_Vest
		icon='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
		worn=0
		bodyarea="TorsoTop"
		EquipmentType="Armor"
		Durability=300
		DurabilityCap=350
		ArmorAddOn=20
		Wear()
			var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
			if(usr.Village=="Leaf")
				A='Icons/New Base/Clothing/Official Clothing/LeafChuuninSuit.dmi'
//			if(usr.Village=="Terra")
//				A+=rgb(158,138,75)
			if(usr.Village=="Rock")
				A+=rgb(101,071,37)
			if(usr.Village=="Mist")
				A+=rgb(0,121,121)
			if(usr.Village=="Cloud")
				A+=rgb(157,122,0)
			if(usr.Village=="Grass")
				A+=rgb(61,130,60)
			if(usr.Village=="Rain")
				A+=rgb(55,41,122)
			if(usr.Village=="Sound")
				A+=rgb(25,25,25)
			if(!src.worn)
				for(var/obj/Clothes/O in usr.contents)
					if(O.bodyarea==src.bodyarea)
						if(O.worn)
							usr << "You need to remove the [O] before you put this on!"
							return
				usr<<"You wear the [src]"
				src.worn=1
				usr.overlays-=A
				usr.overlays+=A
				src.suffix="Equipped"
			else
				src.worn=0
				usr.overlays-=A
				usr<<"You remove the [src]"
				src.suffix=""
		Click()
			if(src in usr)
				switch(input(usr,"What would you like to do?") in list("Drop","Look","Cancel"))
					if("Drop")
						if(!src.worn)
							src.loc=locate(usr.x,usr.y-1,usr.z)
							return
						else
							usr<<"Not while its being worn."
					if("Look")
						usr<<"Its a Chuunin Vest"
					if("Cancel")
						return
			if(src in oview(1))
				switch(input(usr,"Would you like to pick up [src]") in list("Yes","No"))
					if("Yes")
						src.loc=usr
						usr<<"You picked up a [src]"
					if("No")
						return
					else
						..()
	NewCloak//Ninja Cloak
		name = "Ninja Cloak"
		bodyarea="TorsoTop"
		icon = 'Icons/New Base/Clothing/cloak3.dmi'
		worn = 0
	HokageSuit
		name = "Hokage Suit"
		bodyarea="TorsoTop"
		EquipmentType="Armor"
		Durability=4500
		DurabilityCap=4500
		ArmorAddOn=35
		icon = 'Icons/New Base/Clothing/Official Clothing/KagesuitL.dmi'
		worn = 0
	AmekouteiSuit
		name = "Amekoutei Suit"
		bodyarea="TorsoTop"
		EquipmentType="Armor"
		Durability=4500
		DurabilityCap=4500
		ArmorAddOn=35
		icon = 'Icons/New Base/Clothing/Official Clothing/Amekoutei.dmi'
		worn = 0
	TsuchikageSuit
		name = "Tsuchikage Suit"
		bodyarea="TorsoTop"
		EquipmentType="Armor"
		Durability=4500
		DurabilityCap=4500
		ArmorAddOn=35
		icon = 'Icons/New Base/Clothing/Official Clothing/KagesuitR.dmi'
		worn = 0
	OtokamiSuit
		name = "Otokami Suit"
		bodyarea="TorsoTop"
		Durability=4500
		DurabilityCap=4500
		ArmorAddOn=35
		icon = 'Icons/New Base/Clothing/Official Clothing/KagesuitS.dmi'
		worn = 0
//Neck1
	Scarf
		name = "Scarf"
		bodyarea="Neck1"
		icon = 'Icons/New Base/Clothing/Scarf.dmi'
		worn = 0
//Neck2
	Cape
		name = "Cape"
		bodyarea="Neck2"
		icon = 'Icons/New Base/Clothing/Cloak.dmi'
		worn = 0
		Wear()
			if(!(usr.key in Subscribers))
				usr<<"You aren't a subscriber!"
				del(src)
				return
			..()
	KoronaShadowBlack
		name="Korona's Shadow Black"
		bodyarea="Special"
		icon = 'Icons/New Base/Clothing/KoronaShadowBlack.dmi'
		worn = 0
	KoronaShadowWhite
		name="Korona's Shadow White"
		bodyarea="Special"
		icon = 'Icons/New Base/Clothing/KoronaShadowWhite.dmi'
		worn = 0