mob/var
	TailState=0
	Bijuu=""
	BijuuMastery=0
	JinchuurikiControl=0
	TailedBeastMode=0
mob/proc/KyuubiChakraMode(Control=0,Speed=0)
	if(Control)
		if(src.knockedout)
			return
		src.BijuuTransforming=1
		src<<"You begin to concentrate for the chakra flow! Don't move at all!"
		if(!Speed)
			src.icon_state="handseal"
			var/X=rand(5,10)
			while(X>0)
				src.chakra+=100
				if(src.icon_state!="handseal")
					src<<"You drop concentration!";X=0;src.BijuuTransforming=0;return
				X--
				sleep(17)
			src.icon_state=""
		src.overlays-='New Icons(Con4)/KyuubiChakraMode1.dmi'
		src.overlays-='New Icons(Con4)/ChakraModeAura.dmi'
		src.overlays+='New Icons(Con4)/KyuubiChakraMode1.dmi'
		src.overlays+='New Icons(Con4)/ChakraModeAura.dmi'
		src.BijuuTransforming=0
		src<<"You have reached complete balance with your bijuu, switching from your chakra to the Kyuubi's"
		src.chakra=src.MaxChakraPool*2
		spawn(20)
			src<<"You feel your vitals heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.35
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.10
		src.TailState=0.1
		src.FTG_Mode=1
		var/WearOffTime=420
		src.<<"It will last for [WearOffTime/60] minutes."
		src.tai=src.Mtai*2;src.nin=src.Mnin*2;src.gen=src.Mgen*2
		while(src.TailState==0.1&&WearOffTime>0)
			if((locate(/obj/SkillCards/Rasengan) in src.LearnedJutsus))
				if(!(locate(/obj/SkillCards/Planetary_Rasengan) in src.LearnedJutsus))
					var/obj/SkillCards/Planetary_Rasengan/A=new();A.NonKeepable=1;src.LearnedJutsus+=A;A.Uses=100
			src.tai=src.Mtai*2;src.nin=src.Mnin*2;src.gen=src.Mgen*2
			src.chakra+=100
			WearOffTime--
			while(src.TailState==0.1)
				if(src.chakra>src.MaxChakraPool)
					src.chakra=src.MaxChakraPool
				sleep(11)
			sleep(15)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		src.FTG_Mode=0
		src.overlays-='New Icons(Con4)/KyuubiChakraMode1.dmi'
		src.overlays-='New Icons(Con4)/ChakraModeAura.dmi'
mob/proc/KuramaLink(Control=0,Speed=0,)
	if(Control)
		if(src.knockedout)
			return
		src.BijuuTransforming=1
		src<<"You begin to concentrate for the chakra flow! Don't move at all!"
		if(!Speed)
			src.icon_state="handseal"
			var/X=rand(5,10)
			while(X>0)
				src.chakra+=100
				if(src.icon_state!="handseal")
					src<<"You drop concentration!";X=0;src.BijuuTransforming=0;return
				X--
				sleep(17)
			src.icon_state=""
		src.overlays-='New Icons(Con4)/KyuubiChakraMode1.dmi'
		src.overlays-='New Icons(Con4)/KuramaLinkMode.dmi'
		src.overlays+='New Icons(Con4)/KuramaLinkMode.dmi'
		src.BijuuTransforming=0
		src<<"You've completely linked your chakra reserves with that of the Kyuubi. You feel highley empowered."
		src.chakra=src.MaxChakraPool*3
		spawn(20)
			src<<"You feel your vitals heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.65
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.45
		src.TailState=0.2
		src.FTG_Mode=1
		var/WearOffTime=600+src.BijuuMastery
		src.<<"It will last for [WearOffTime/60] minutes."
		src.tai=src.Mtai*2.5;src.nin=src.Mnin*2.5;src.gen=src.Mgen*2.5
		while(src.TailState==0.2&&WearOffTime>0)
			if((locate(/obj/SkillCards/Rasengan) in src.LearnedJutsus))
				if(!(locate(/obj/SkillCards/Planetary_Rasengan) in src.LearnedJutsus))
					var/obj/SkillCards/Planetary_Rasengan/A=new();A.NonKeepable=1;src.LearnedJutsus+=A;A.Uses=100
			src.tai=src.Mtai*2.5;src.nin=src.Mnin*2.5;src.gen=src.Mgen*2.5
			src.chakra+=150
			if(src.health<src.maxhealth)
				src.health+=65;src.chakra-=400
			if(src.stamina<src.maxstamina)
				src.stamina+=(src.maxstamina/25);src.chakra-=200
			WearOffTime--
			while(src.TailState==0.2)
				if(src.chakra>src.MaxChakraPool*1.5)
					src.chakra=src.MaxChakraPool*1.5
				sleep(11)
			sleep(15)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		src.FTG_Mode=0
		src.overlays-='New Icons(Con4)/KyuubiChakraMode1.dmi'
		src.overlays-='New Icons(Con4)/KuramaLinkMode.dmi'

mob/proc/ReleaseJuubi(Control=0,Speed=0)
	if(Control)
		if(src.knockedout)
			return
		src.BijuuTransforming=1
		src<<"You begin to harness the tailed beast's chakra inside."
		if(!Speed)
			src.icon_state="Power"
			var/X=rand(5,10)
			while(X>0)
				src.chakra+=100
				if(src.icon_state!="Power")
					src<<"You drop concentration!";X=0;src.BijuuTransforming=0;return
				X--
				sleep(17)
			src.icon_state=""
//		usr.BaseR=156;usr.BaseG=156;usr.BaseB=156;usr.FixMyIcon()
		src.overlays-='New Icons(Con4)/JuubiMode.dmi'
		src.overlays-='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		src.overlays+='New Icons(Con4)/JuubiMode.dmi'
		//src.overlays+='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		src.BijuuTransforming=0
		src<<"You release the power of the Juubi!"
		src.chakra=src.MaxChakraPool*2
		src.deathcount--
		spawn(20)
			src<<"You feel your vitals heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.35
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.10
			for(var/obj/truthorbs/S in usr.truthorbs) if(S)
				if(S.Owner==usr) del(S)
			var/obj/truthorbs/Orb1/S1=new()
			var/obj/truthorbs/Orb2/S2=new()
			var/obj/truthorbs/Orb3/S3=new()
			var/obj/truthorbs/Orb4/S4=new()
			var/obj/truthorbs/Orb5/S5=new()
			var/obj/truthorbs/Orb6/S6=new()
			var/obj/truthorbs/Orb7/S7=new()
			var/obj/truthorbs/Orb8/S8=new()
			usr.truthorbs.Add(S1)
			usr.truthorbs.Add(S2)
			usr.truthorbs.Add(S3)
			usr.truthorbs.Add(S4)
			usr.truthorbs.Add(S5)
			usr.truthorbs.Add(S6)
			usr.truthorbs.Add(S7)
			usr.truthorbs.Add(S8)
			S1.loc=usr.loc
			S2.loc=usr.loc
			S3.loc=usr.loc
			S4.loc=usr.loc
			S5.loc=usr.loc
			S6.loc=usr.loc
			S7.loc=usr.loc
			S8.loc=usr.loc
			S1.Owner=usr
			S2.Owner=usr
			S3.Owner=usr
			S4.Owner=usr
			S5.Owner=usr
			S6.Owner=usr
			S7.Owner=usr
			S8.Owner=usr
			usr.truthorbsout=1
		src.TailState=0.1
		src.tai=src.Mtai*3.2;src.nin=src.Mnin*3.2;src.gen=src.Mgen*3.2
		while(src.TailState>=0.1)
			src.EnduranceAddOn=200
			src.chakra+=200
			if(src.chakra>src.MaxChakraPool*2.5)
				src.chakra=src.MaxChakraPool*2.5
			if(!(locate(/obj/SkillCards/TailedBeastBomb) in src.LearnedJutsus))
				var/obj/SkillCards/TailedBeastBomb/A=new();A.NonKeepable=1;src.LearnedJutsus+=A
			src.tai=src.Mtai*3.2;src.nin=src.Mnin*3.2;src.gen=src.Mgen*3.2
			if(!src.knockedout&&!src.Dead&&src.ChakraPool>0)
				if(src.health<src.maxhealth)
					src.health+=65;src.chakra-=150
				if(src.stamina<src.maxstamina)
					src.stamina+=(src.maxstamina/25);src.chakra-=150
				if(src.chakra<1000)
					src.chakra+=500;src.ChakraPool-=250
				sleep(11)
			sleep(15)

	src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
	src.TailState=0
	src.overlays-='New Icons(Con4)/JuubiMode.dmi'
	src.overlays-='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
	src.doingorb=0
	for(var/obj/truthorbs/S in usr.truthorbs) if(S)
		if(S.Owner==usr) del(S)

obj/truthorbs
	density=0
	layer=MOB_LAYER+1
	var/
	Owner
	Orb1
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="1"
	Orb2
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="2"
	Orb3
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="3"
	Orb4
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="4"
	Orb5
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="5"
	Orb6
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="6"
	Orb7
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="7"
	Orb8
		icon='New Icons(Con4)/Rikudou Truth Seeking Orbs.dmi'
		icon_state="8"
//	Del()
//		var/obj/truthorbs/O=src.Owner
//		O.truthorbs.Remove(src)
//		..()
	Bump(A)
		if(!src.Owner) del(src)
		if(istype(A,/mob/Kibaku/))
			var/mob/Kibaku/M=A;M.Defused=1
		if(ismob(A))
			var/mob/M=A
			var/mob/O=src.Owner
			var/damage=20//Was - 2
			if(damage<10) damage=10
			damage=round((damage)*((O.LightningChakra+O.WaterChakra+O.FireChakra+O.EarthChakra+O.WindChakra)/10));var/Chakraz=M.ChakraArmor*0.01;damage=damage-(Chakraz*damage)
			if(damage>1000) damage=1000
			if(M==O)
				return
			M.DamageProc(damage,"Health",O,"Truth Seeking Orb","grey")
			spawn() M.Bloody()
			M.HitBack(4,src.dir)
			if(M==O)
				src.loc=locate(M.x,M.y,M.z)
				if(!O.firingorb)
					src.fired=0
					src.density=0
					walk(src,0)
				return

		if(istype(A,/obj/Jutsu/Elemental/))
			if(istype(A,/obj/Jutsu/Elemental/))
				del(A)

////////////////////////////////////////////
//Tailed Beast Icons
obj/TailedBeast/Ichibi
	density=1
	icon='New Icons(Con4)/Ichibi(Shukaku).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="I1"
		pixel_x = -32
		pixel_y = -32
	B
		icon_state="I2"
		pixel_y = -32
	C
		icon_state="I3"
		pixel_x = 32
		pixel_y = -32
	D
		icon_state="I4"
		pixel_x = -32
	E
		icon_state="I5"
	F
		icon_state="I6"
		pixel_x = 32
	G
		icon_state="I7"
		pixel_x = -32
		pixel_y = 32
	H
		icon_state="I8"
		pixel_y = 32
	I
		icon_state="I9"
		pixel_x = 32
		pixel_y = 32
obj/TailedBeast/Nibi
	density=1
	icon='New Icons(Con4)/Matatabi (Nibi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="N1"
		pixel_x = -29
		pixel_y = -32
	B
		icon_state="N2"
		pixel_x = 3
		pixel_y = -32
	C
		icon_state="N3"
		pixel_x = 35
		pixel_y = -32
	D
		icon_state="N4"
		pixel_x = -29
	E
		icon_state="N5"
		pixel_x = 3
	F
		icon_state="N6"
		pixel_x = 35
	G
		icon_state="N7"
		pixel_x = -29
		pixel_y = 32
	H
		icon_state="N8"
		pixel_x = 3
		pixel_y = 32
	I
		icon_state="N9"
		pixel_x = 35
		pixel_y = 32
	J
		icon_state="N11"
		pixel_x = -29
		pixel_y = 64
	K
		icon_state="N12"
		pixel_x = 3
		pixel_y = 64
	L
		icon_state="N13"
		pixel_x = 35
		pixel_y = 64
obj/TailedBeast/Sanbi
	density=1
	icon='New Icons(Con4)/Isobuu (Sanbi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="S1"
		pixel_x = -32
		pixel_y = -32
	B
		icon_state="S2"
		pixel_y = -32
	C
		icon_state="S3"
		pixel_x = 32
		pixel_y = -32
	D
		icon_state="S4"
		pixel_x = -32

	E
		icon_state="S5"

	F
		icon_state="S6"
		pixel_x = 32
	G
		icon_state="S7"
		pixel_x = -32
		pixel_y = 32
	H
		icon_state="S8"
		pixel_y = 32
	I
		icon_state="S9"
		pixel_x = 32
		pixel_y = 32
	J
		icon_state="S11"
		pixel_x = -32
		pixel_y = 64
	K
		icon_state="S12"
		pixel_y = 64
	L
		icon_state="S13"
		pixel_x = 32
		pixel_y = 64
obj/TailedBeast/Yonbi
	density=1
	icon='New Icons(Con4)/Son Goku (Yonbi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="G1"
		pixel_x = -47
		pixel_y = -32

	B
		icon_state="G2"
		pixel_x = -15
		pixel_y = -32

	C
		icon_state="G3"
		pixel_x = 17
		pixel_y = -32

	D
		icon_state="G4"
		pixel_x = 49
		pixel_y = -32

	E
		icon_state="G5"
		pixel_x = 81
		pixel_y = -32

	//
	F
		icon_state="G11"
		pixel_x = -47

	G
		icon_state="G12"
		pixel_x = -15

	H
		icon_state="G13"
		pixel_x = 17

	I
		icon_state="G14"
		pixel_x = 49

	J
		icon_state="G15"
		pixel_x = 81

	//
	K
		icon_state="G21"
		pixel_x = -47
		pixel_y = 32
	L
		icon_state="G22"
		pixel_x = -15
		pixel_y = 32
	M
		icon_state="G23"
		pixel_x = 17
		pixel_y = 32
	N
		icon_state="G24"
		pixel_x = 49
		pixel_y = 32
	O
		icon_state="G25"
		pixel_x = 81
		pixel_y = 32
	//
	P
		icon_state="G31"
		pixel_x = -47
		pixel_y = 64
	Q
		icon_state="G32"
		pixel_x = -15
		pixel_y = 64
	R
		icon_state="G33"
		pixel_x = 17
		pixel_y = 64
	S
		icon_state="G34"
		pixel_x = 49
		pixel_y = 64
	T
		icon_state="G35"
		pixel_x = 81
		pixel_y = 64
	//
	U
		icon_state="G41"
		pixel_x = -47
		pixel_y = 96
	V
		icon_state="G42"
		pixel_x = -15
		pixel_y = 96
	W
		icon_state="G43"
		pixel_x = 17
		pixel_y = 96
	X
		icon_state="G44"
		pixel_x = 49
		pixel_y = 96
	Y
		icon_state="G45"
		pixel_x = 81
		pixel_y = 96
obj/TailedBeast/Gobi
	density=1
	icon='New Icons(Con4)/Kokou (Gobi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="K1"
		pixel_x = -41
		pixel_y = -32
	B
		icon_state="K2"
		pixel_x = -9
		pixel_y = -32
	C
		icon_state="K3"
		pixel_x = 23
		pixel_y = -32
	D
		icon_state="K4"
		pixel_x = 55
		pixel_y = -32
	//
	E
		icon_state="K11"
		pixel_x = -41
	F
		icon_state="K12"
		pixel_x = -9
	G
		icon_state="K13"
		pixel_x = 23
	H
		icon_state="K14"
		pixel_x = 55
	//
	I
		icon_state="K21"
		pixel_x = -41
		pixel_y = 32
	J
		icon_state="K22"
		pixel_x = -9
		pixel_y = 32
	K
		icon_state="K23"
		pixel_x = 23
		pixel_y = 32
	L
		icon_state="K34"
		pixel_x = 55
		pixel_y = 32
	//
	M
		icon_state="K31"
		pixel_x = -41
		pixel_y = 64
	N
		icon_state="K32"
		pixel_x = -9
		pixel_y = 64
	O
		icon_state="K33"
		pixel_x = 23
		pixel_y = 64
	P
		icon_state="K34"
		pixel_x = 55
		pixel_y = 64
obj/TailedBeast/Rokubi
	density=1
	icon='New Icons(Con4)/Saiken (Rokubi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="R1"
		pixel_x = -37
		pixel_y = -8
	B
		icon_state="R2"
		pixel_x = -5
		pixel_y = -8
	C
		icon_state="R3"
		pixel_x = 27
		pixel_y = -8
	D
		icon_state="R4"
		pixel_x = 59
		pixel_y = -8
	//
	E
		icon_state="R11"
		pixel_x = -37
		pixel_y = 24
	F
		icon_state="R12"
		pixel_x = -5
		pixel_y = 24

	G
		icon_state="R13"
		pixel_x = 27
		pixel_y = 24
	H
		icon_state="R14"
		pixel_x = 59
		pixel_y = 24
	//
	I
		icon_state="R21"
		pixel_x = -37
		pixel_y = 56
	J
		icon_state="R22"
		pixel_x = -5
		pixel_y = 56
	K
		icon_state="R23"
		pixel_x = 27
		pixel_y = 56
	L
		icon_state="R24"
		pixel_x = 59
		pixel_y = 56
obj/TailedBeast/Shichibi
	density=1
	icon='New Icons(Con4)/Chomei (Shichibi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="C1"
		pixel_x = -54
		pixel_y = -32
	B
		icon_state="C2"
		pixel_x = -22
		pixel_y = -32
	C
		icon_state="C3"
		pixel_x = 10
		pixel_y = -32
	D
		icon_state="C4"
		pixel_x = 42
		pixel_y = -32
	E
		icon_state="C5"
		pixel_x = 74
		pixel_y = -32
	//
	F
		icon_state="C11"
		pixel_x = -54
	G
		icon_state="C12"
		pixel_x = -22
	H
		icon_state="C13"
		pixel_x = 10
	I
		icon_state="C14"
		pixel_x = 42
	J
		icon_state="C15"
		pixel_x = 74
	//
	K
		icon_state="C21"
		pixel_x = -54
		pixel_y = 32
	L
		icon_state="C22"
		pixel_x = -22
		pixel_y = 32
	M
		icon_state="C23"
		pixel_x = 10
		pixel_y = 32
	N
		icon_state="C24"
		pixel_x = 42
		pixel_y = 32
	O
		icon_state="C25"
		pixel_x = 74
		pixel_y = 32
	//
	P
		icon_state="C31"
		pixel_x = -54
		pixel_y = 64
	Q
		icon_state="C32"
		pixel_x = -22
		pixel_y = 64
	R
		icon_state="C33"
		pixel_x = 10
		pixel_y = 64
	S
		icon_state="C34"
		pixel_x = 42
		pixel_y = 64
	T
		icon_state="C35"
		pixel_x = 74
		pixel_y = 64
	//
	U
		icon_state="C41"
		pixel_x = -54
		pixel_y = 96
	V
		icon_state="C42"
		pixel_x = -22
		pixel_y = 96
	W
		icon_state="C43"
		pixel_x = 10
		pixel_y = 96
	X
		icon_state="C44"
		pixel_x = 42
		pixel_y = 96
	Y
		icon_state="C45"
		pixel_x = 74
		pixel_y = 96
obj/TailedBeast/Hachibi
	density=1
	icon='New Icons(Con4)/Gyuki (Hachibi).dmi'
	layer=MOB_LAYER+1
	A
		icon_state="H1"
		pixel_x = -98
		pixel_y = -32
	B
		icon_state="H2"
		pixel_x = -66
		pixel_y = -32
	C
		icon_state="H3"
		pixel_x = -34
		pixel_y = -32
	D
		icon_state="H4"
		pixel_x = -2
		pixel_y = -32
	E
		icon_state="H5"
		pixel_x = 30
		pixel_y = -32
	F
		icon_state="H6"
		pixel_x = 62
		pixel_y = -32
	G
		icon_state="H7"
		pixel_x = 94
		pixel_y = -32
	//
	H
		icon_state="H11"
		pixel_x = -98
	I
		icon_state="H12"
		pixel_x = -66
	J
		icon_state="H13"
		pixel_x = -34
	K
		icon_state="H14"
		pixel_x = -2
	L
		icon_state="H15"
		pixel_x = 30
	M
		icon_state="H16"
		pixel_x = 62
	N
		icon_state="H17"
		pixel_x = 94
	//
	O
		icon_state="H21"
		pixel_x = -98
		pixel_y = 32
	P
		icon_state="H22"
		pixel_x = -66
		pixel_y = 32
	Q
		icon_state="H23"
		pixel_x = -34
		pixel_y = 32
	R
		icon_state="H24"
		pixel_x = -2
		pixel_y = 32
	S
		icon_state="H25"
		pixel_x = 30
		pixel_y = 32
	T
		icon_state="H26"
		pixel_x = 62
		pixel_y = 32
	U
		icon_state="H27"
		pixel_x = 94
		pixel_y = 32
	//
	V
		icon_state="H31"
		pixel_x = -98
		pixel_y = 64
	W
		icon_state="H32"
		pixel_x = -66
		pixel_y = 64
	X
		icon_state="H33"
		pixel_x = -34
		pixel_y = 64
	Y
		icon_state="H34"
		pixel_x = -2
		pixel_y = 64
	Z
		icon_state="H35"
		pixel_x = 30
		pixel_y = 64
	Z1
		icon_state="H36"
		pixel_x = 62
		pixel_y = 64
	Z2
		icon_state="H37"
		pixel_x = 94
		pixel_y = 64
	//
	A1
		icon_state="H41"
		pixel_x = -98
		pixel_y = 96
	A2
		icon_state="H42"
		pixel_x = -66
		pixel_y = 96
	A3
		icon_state="H43"
		pixel_x = -34
		pixel_y = 96
	A4
		icon_state="H44"
		pixel_x = -2
		pixel_y = 96
	A5
		icon_state="H45"
		pixel_x = 30
		pixel_y = 96
	A6
		icon_state="H46"
		pixel_x = 62
		pixel_y = 96
	A7
		icon_state="H47"
		pixel_x = 94
		pixel_y = 96
////////////////Tailed Beast Mode
////////////////////////////////////////////////
mob/proc/TailedBeastMode(Control=0,Speed=0,TailedBeastMode=0)
	if(src.knockedout)
		return
	src.BijuuTransforming=1
	src<<"You begin to transform into the [src.Bijuu]."
	if(!Speed)
		src.icon_state="Power"
		var/X=rand(7,18)
		while(X>0)
			src.chakra+=100
			if(src.icon_state!="Power")
				src<<"You drop concentration!";X=0;src.BijuuTransforming=0;return
			X--
			sleep(17)
		src.icon_state=""
	spawn()
		if(src.Bijuu=="Ichibi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Ichibi(Shukaku).dmi'
			src.overlays+=/obj/TailedBeast/Ichibi/A;src.overlays+=/obj/TailedBeast/Ichibi/B;src.overlays+=/obj/TailedBeast/Ichibi/C
			src.overlays+=/obj/TailedBeast/Ichibi/D;src.overlays+=/obj/TailedBeast/Ichibi/E;src.overlays+=/obj/TailedBeast/Ichibi/F
			src.overlays+=/obj/TailedBeast/Ichibi/G;src.overlays+=/obj/TailedBeast/Ichibi/H;src.overlays+=/obj/TailedBeast/Ichibi/I
		if(src.Bijuu=="Nibi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Matatabi (Nibi).dmi'
			src.overlays+=/obj/TailedBeast/Nibi/A;src.overlays+=/obj/TailedBeast/Nibi/B;src.overlays+=/obj/TailedBeast/Nibi/C
			src.overlays+=/obj/TailedBeast/Nibi/D;src.overlays+=/obj/TailedBeast/Nibi/E;src.overlays+=/obj/TailedBeast/Nibi/F
			src.overlays+=/obj/TailedBeast/Nibi/G;src.overlays+=/obj/TailedBeast/Nibi/H;src.overlays+=/obj/TailedBeast/Nibi/I
			src.overlays+=/obj/TailedBeast/Nibi/J;src.overlays+=/obj/TailedBeast/Nibi/K;src.overlays+=/obj/TailedBeast/Nibi/L
		if(src.Bijuu=="Sanbi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Isobuu (Sanbi).dmi'
			src.overlays+=/obj/TailedBeast/Sanbi/A;src.overlays+=/obj/TailedBeast/Sanbi/B;src.overlays+=/obj/TailedBeast/Sanbi/C
			src.overlays+=/obj/TailedBeast/Sanbi/D;src.overlays+=/obj/TailedBeast/Sanbi/E;src.overlays+=/obj/TailedBeast/Sanbi/F
			src.overlays+=/obj/TailedBeast/Sanbi/G;src.overlays+=/obj/TailedBeast/Sanbi/H;src.overlays+=/obj/TailedBeast/Sanbi/I
			src.overlays+=/obj/TailedBeast/Sanbi/J;src.overlays+=/obj/TailedBeast/Sanbi/K;src.overlays+=/obj/TailedBeast/Sanbi/L
		if(src.Bijuu=="Yonbi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Son Goku (Yonbi).dmi'
			src.overlays+=/obj/TailedBeast/Yonbi/A;src.overlays+=/obj/TailedBeast/Yonbi/B;src.overlays+=/obj/TailedBeast/Yonbi/C
			src.overlays+=/obj/TailedBeast/Yonbi/D;src.overlays+=/obj/TailedBeast/Yonbi/E;src.overlays+=/obj/TailedBeast/Yonbi/F
			src.overlays+=/obj/TailedBeast/Yonbi/G;src.overlays+=/obj/TailedBeast/Yonbi/H;src.overlays+=/obj/TailedBeast/Yonbi/I
			src.overlays+=/obj/TailedBeast/Yonbi/J;src.overlays+=/obj/TailedBeast/Yonbi/K;src.overlays+=/obj/TailedBeast/Yonbi/L
			src.overlays+=/obj/TailedBeast/Yonbi/M;src.overlays+=/obj/TailedBeast/Yonbi/N;src.overlays+=/obj/TailedBeast/Yonbi/O
			src.overlays+=/obj/TailedBeast/Yonbi/P;src.overlays+=/obj/TailedBeast/Yonbi/Q;src.overlays+=/obj/TailedBeast/Yonbi/R
			src.overlays+=/obj/TailedBeast/Yonbi/S;src.overlays+=/obj/TailedBeast/Yonbi/T;src.overlays+=/obj/TailedBeast/Yonbi/U
			src.overlays+=/obj/TailedBeast/Yonbi/V;src.overlays+=/obj/TailedBeast/Yonbi/W;src.overlays+=/obj/TailedBeast/Yonbi/Y;src.overlays+=/obj/TailedBeast/Yonbi/Y
		if(src.Bijuu=="Gobi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Kokou (Gobi).dmi'
			src.overlays+=/obj/TailedBeast/Gobi/A;src.overlays+=/obj/TailedBeast/Gobi/B;src.overlays+=/obj/TailedBeast/Gobi/C
			src.overlays+=/obj/TailedBeast/Gobi/D;src.overlays+=/obj/TailedBeast/Gobi/E;src.overlays+=/obj/TailedBeast/Gobi/F
			src.overlays+=/obj/TailedBeast/Gobi/G;src.overlays+=/obj/TailedBeast/Gobi/H;src.overlays+=/obj/TailedBeast/Gobi/I
			src.overlays+=/obj/TailedBeast/Gobi/J;src.overlays+=/obj/TailedBeast/Gobi/K;src.overlays+=/obj/TailedBeast/Gobi/L
			src.overlays+=/obj/TailedBeast/Gobi/M;src.overlays+=/obj/TailedBeast/Gobi/N;src.overlays+=/obj/TailedBeast/Gobi/O
			src.overlays+=/obj/TailedBeast/Gobi/P
		if(src.Bijuu=="Rokubi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Saiken (Rokubi).dmi'
			src.overlays+=/obj/TailedBeast/Rokubi/A;src.overlays+=/obj/TailedBeast/Rokubi/B;src.overlays+=/obj/TailedBeast/Rokubi/C
			src.overlays+=/obj/TailedBeast/Rokubi/D;src.overlays+=/obj/TailedBeast/Rokubi/E;src.overlays+=/obj/TailedBeast/Rokubi/F
			src.overlays+=/obj/TailedBeast/Rokubi/G;src.overlays+=/obj/TailedBeast/Rokubi/H;src.overlays+=/obj/TailedBeast/Rokubi/I
			src.overlays+=/obj/TailedBeast/Rokubi/J;src.overlays+=/obj/TailedBeast/Rokubi/K;src.overlays+=/obj/TailedBeast/Rokubi/L
		if(src.Bijuu=="Shichibi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Chomei (Shichibi).dmi'
			src.overlays+=/obj/TailedBeast/Shichibi/A;src.overlays+=/obj/TailedBeast/Shichibi/B;src.overlays+=/obj/TailedBeast/Shichibi/C
			src.overlays+=/obj/TailedBeast/Shichibi/D;src.overlays+=/obj/TailedBeast/Shichibi/E;src.overlays+=/obj/TailedBeast/Shichibi/F
			src.overlays+=/obj/TailedBeast/Shichibi/G;src.overlays+=/obj/TailedBeast/Shichibi/H;src.overlays+=/obj/TailedBeast/Shichibi/I
			src.overlays+=/obj/TailedBeast/Shichibi/J;src.overlays+=/obj/TailedBeast/Shichibi/K;src.overlays+=/obj/TailedBeast/Shichibi/L
			src.overlays+=/obj/TailedBeast/Shichibi/M;src.overlays+=/obj/TailedBeast/Shichibi/N;src.overlays+=/obj/TailedBeast/Shichibi/O
			src.overlays+=/obj/TailedBeast/Shichibi/P;src.overlays+=/obj/TailedBeast/Shichibi/Q;src.overlays+=/obj/TailedBeast/Shichibi/R
			src.overlays+=/obj/TailedBeast/Shichibi/S;src.overlays+=/obj/TailedBeast/Shichibi/T;src.overlays+=/obj/TailedBeast/Shichibi/U
			src.overlays+=/obj/TailedBeast/Shichibi/V;src.overlays+=/obj/TailedBeast/Shichibi/W;src.overlays+=/obj/TailedBeast/Shichibi/Y
		if(src.Bijuu=="Hachibi"&&src.TailedBeastMode)
			src.overlays+='New Icons(Con4)/Ichibi(Shukaku).dmi'
			src.overlays+=/obj/TailedBeast/Hachibi/A;src.overlays+=/obj/TailedBeast/Hachibi/B;src.overlays+=/obj/TailedBeast/Hachibi/C
			src.overlays+=/obj/TailedBeast/Hachibi/D;src.overlays+=/obj/TailedBeast/Hachibi/E;src.overlays+=/obj/TailedBeast/Hachibi/F
			src.overlays+=/obj/TailedBeast/Hachibi/G;src.overlays+=/obj/TailedBeast/Hachibi/H;src.overlays+=/obj/TailedBeast/Hachibi/I
			src.overlays+=/obj/TailedBeast/Hachibi/J;src.overlays+=/obj/TailedBeast/Hachibi/K;src.overlays+=/obj/TailedBeast/Hachibi/L
			src.overlays+=/obj/TailedBeast/Hachibi/M;src.overlays+=/obj/TailedBeast/Hachibi/N;src.overlays+=/obj/TailedBeast/Hachibi/O
			src.overlays+=/obj/TailedBeast/Hachibi/P;src.overlays+=/obj/TailedBeast/Hachibi/Q;src.overlays+=/obj/TailedBeast/Hachibi/R
			src.overlays+=/obj/TailedBeast/Hachibi/S;src.overlays+=/obj/TailedBeast/Hachibi/T;src.overlays+=/obj/TailedBeast/Hachibi/U
			src.overlays+=/obj/TailedBeast/Hachibi/V;src.overlays+=/obj/TailedBeast/Hachibi/W;src.overlays+=/obj/TailedBeast/Hachibi/X
			src.overlays+=/obj/TailedBeast/Hachibi/Y;src.overlays+=/obj/TailedBeast/Hachibi/Z;src.overlays+=/obj/TailedBeast/Hachibi/Z1
			src.overlays+=/obj/TailedBeast/Hachibi/Z2;src.overlays+=/obj/TailedBeast/Hachibi/A1;src.overlays+=/obj/TailedBeast/Hachibi/A2
			src.overlays+=/obj/TailedBeast/Hachibi/A3;src.overlays+=/obj/TailedBeast/Hachibi/A4;src.overlays+=/obj/TailedBeast/Hachibi/A5
			src.overlays+=/obj/TailedBeast/Hachibi/A6;src.overlays+=/obj/TailedBeast/Hachibi/A7
	src.TailedBeastMode=1
	src.BijuuTransforming=0
	src<<"You've completely linked your chakra reserves with that of the [src.Bijuu], completely taking it's form!"
	src.chakra=src.MaxChakraPool*2
	spawn(20)
		src<<"You feel your vitals heal and your stamina regenerate!"
		if(src.stamina<=src.maxstamina)
			src.stamina+=src.maxstamina*1.25
		if(src.health<=src.maxhealth)
			src.health+=src.maxhealth*0.85
	src.tai=src.Mtai*2.5;src.nin=src.Mnin*2.5;src.gen=src.Mgen*2.5
	while(src.TailedBeastMode)
		src.tai=src.Mtai*2.5;src.nin=src.Mnin*2.5;src.gen=src.Mgen*2.5
		src.chakra+=50
		src.Endurance=600
		while(src.TailedBeastMode)
			if(src.chakra>src.MaxChakraPool/1.5)
				src.chakra=src.MaxChakraPool/1.5
			sleep(11)
		sleep(15)
	src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
	src.TailedBeastMode=0
mob/proc/ReleaseNibi(Control=0,Speed=0)
	if(Control)
		if(src.knockedout)
			return
		src<<"You begin to slip a bit of chakra from the Nibi!"
		if(!Speed)
			src.icon_state="Power"
			var/X=rand(5,10)
			while(X>0)
				src.chakra+=25
				if(src.icon_state!="Power")
					src<<"You drop concentration!";X=0
				X--
				sleep(11)
			src.icon_state=""
		src.overlays-='Icons/New Base/cataura.dmi'
		src.overlays+='Icons/New Base/cataura.dmi'
		src.BijuuMastery+=(rand(1,4)*0.1)
		src<<"The power of the Two Tailed Cat flows out from you!"
		spawn(20)
			src<<"You feel your wounds heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.25
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.25
		src.TailState=0.5
		var/WearOffTime=90
		if(Speed)
			WearOffTime+=60
		src.tai=src.Mtai*1.1;src.nin=src.Mnin*1.3;src.gen=src.Mgen*1
		while(src.TailState==0.5&&WearOffTime>0)
			src.tai=src.Mtai*1.1;src.nin=src.Mnin*1.3;src.gen=src.Mgen*1
			src.chakra+=15
			WearOffTime--
			sleep(11)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		src.overlays-='Icons/New Base/cataura.dmi'
	else
		if(!src.Dead)
			return
		src<<"You feel an overwhelming amount of hatred amassing inside of you..."
		sleep(100)
		src.deathcount=0
		src.knockedout=0
		src.FrozenBind=""
		src.Dead=0
		src.BijuuMastery++
		src.overlays-='Icons/New Base/cataura.dmi'
		src.overlays+='Icons/New Base/cataura.dmi'
		src<<"The power of the Two Tailed Cat seeps out from you!"
		spawn(20)
			src<<"You feel your wounds heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.25
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.25
		src.ImmuneToDeath=1
		spawn(100)
			src.ImmuneToDeath=0
		src.TailState=0.5
		var/WearOffTime=90
		src.tai=src.Mtai*1.5;src.nin=src.Mnin*1.5;src.gen=src.Mgen*1
		while(src.TailState==0.5&&WearOffTime>0)
			src.tai=src.Mtai*1.5;src.nin=src.Mnin*1.5;src.gen=src.Mgen*1
			src.chakra+=100
			if(!Control)
				src.health-=15
				src.stamina-=15
			WearOffTime--
			sleep(11)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		src.overlays-='Icons/New Base/cataura.dmi'
		if(!(locate(/obj/SkillCards/Nibi) in src.LearnedJutsus))
			if(src.BijuuMastery>=10)
				src.LearnedJutsus+=new /obj/SkillCards/Nibi
				src<<"You feel like you can harness the power of the Two Tailed Cat to an extent now.."


mob/proc/ReleaseRehiam(Control=0,Speed=0)
	if(Control)
		if(src.knockedout)
			return
		src<<"You begin to slip a bit of chakra from Rehiam!"
		if(!Speed)
			src.icon_state="Power"
			var/X=rand(5,10)
			while(X>0)
				src.chakra+=25
				if(src.icon_state!="Power")
					src<<"You drop concentration!";X=0
				X--
				sleep(11)
			src.icon_state=""
		src.overlays-='Icons/Jutsus/Bijuu/Rehiam.dmi'
		src.overlays+='Icons/Jutsus/Bijuu/Rehiam.dmi'
		src.BijuuMastery+=(rand(1,4)*0.1)
		src<<"The power of Rehiam flows out from you!"
		spawn(20)
			src<<"You feel your wounds heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.45

			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.45
		src.TailState=1
		var/WearOffTime=90
		if(Speed)
			WearOffTime+=60
		src.tai=src.Mtai*2;src.nin=src.Mnin*1.5;src.gen=src.Mgen*2
		while(src.TailState==0.5&&WearOffTime>0)
			src.tai=src.Mtai*2;src.nin=src.Mnin*1.5;src.gen=src.Mgen*2
			src.chakra+=100
			WearOffTime--
			sleep(11)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		src.overlays-='Icons/Jutsus/Bijuu/Rehiam.dmi'
	else
		if(!src.Dead)
			return
		src<<"You feel an overwhelming amount of hatred amassing inside of you..."
		sleep(100)
		src.deathcount=0
		src.knockedout=0
		src.FrozenBind=""
		src.Dead=0
		src.BijuuMastery++
		src.overlays-='Icons/Jutsus/Bijuu/Rehiam.dmi'
		src.overlays+='Icons/Jutsus/Bijuu/Rehiam.dmi'
		src<<"The power of Rehiam bursts out from you!"
		spawn(20)
			src<<"You feel your wounds heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.75
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.75
		src.ImmuneToDeath=1
		spawn(100)
			src.ImmuneToDeath=0
		src.TailState=1
		var/WearOffTime=90
		src.tai=src.Mtai*2;src.nin=src.Mnin*1.5;src.gen=src.Mgen*2
		while(src.TailState==0.5&&WearOffTime>0)
			src.tai=src.Mtai*2;src.nin=src.Mnin*1.5;src.gen=src.Mgen*2
			src.chakra+=100
			if(!Control)
				src.health-=15
				src.stamina-=15
			WearOffTime--
			sleep(11)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		src.overlays-='Rehiam.dmi'
		if(!(locate(/obj/SkillCards/Rehiam) in src.LearnedJutsus))
			if(src.BijuuMastery>=10)
				src.LearnedJutsus+=new /obj/SkillCards/Rehiam
				src<<"You feel like you can harness the power of Rehiam to an extent now.."
/////////////////////////////////////
mob/var/tmp
			truthorbsout=0
			orbnum=1
mob/var
		doingorb=0
		firingorb=0
obj/var
		fired=0
mob/var/list/truthorbs=list()

mob/proc/Gudou()
	if(usr.doingorb) return
	if(usr.Bijuu=="Juubi"&&usr.TailState>0)
		if(usr.truthorbsout)
			var
				count1=0
				count2=0
				count3=0
				count4=0
				count5=0
				count6=0
				count7=0
				count8=0
			for(var/obj/truthorbs/L in usr.truthorbs) if(L&&!L.fired&&L.invisibility!=5)
				if(istype(L,/obj/truthorbs/Orb1)) count1=1
				if(istype(L,/obj/truthorbs/Orb2)) count2=1
				if(istype(L,/obj/truthorbs/Orb3)) count3=1
				if(istype(L,/obj/truthorbs/Orb4)) count4=1
				if(istype(L,/obj/truthorbs/Orb5)) count5=1
				if(istype(L,/obj/truthorbs/Orb6)) count6=1
				if(istype(L,/obj/truthorbs/Orb7)) count7=1
				if(istype(L,/obj/truthorbs/Orb8)) count8=1
			if(usr.orbnum==1&&!count1) usr.orbnum=2
			if(usr.orbnum==2&&!count2) usr.orbnum=3
			if(usr.orbnum==3&&!count3) usr.orbnum=4
			if(usr.orbnum==4&&!count4) usr.orbnum=5
			if(usr.orbnum==5&&!count5) usr.orbnum=6
			if(usr.orbnum==6&&!count6) usr.orbnum=7
			if(usr.orbnum==7&&!count7) usr.orbnum=8
			if(usr.orbnum==8&&!count8) usr.orbnum=1
			usr.doingorb=1
			spawn((12)) if(usr) usr.doingorb=0
			switch(usr.orbnum)
				if(1)
					for(var/obj/truthorbs/Orb1/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=2
				if(2)
					for(var/obj/truthorbs/Orb2/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=3
				if(3)
					for(var/obj/truthorbs/Orb3/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=4
				if(4)
					for(var/obj/truthorbs/Orb4/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=5
				if(5)
					for(var/obj/truthorbs/Orb5/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=6
				if(6)
					for(var/obj/truthorbs/Orb6/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=7
				if(7)
					for(var/obj/truthorbs/Orb7/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=8
				if(8)
					for(var/obj/truthorbs/Orb8/L in usr.truthorbs) if(L)
						if(!L.Owner) del(L)
						if(L.Owner==usr)
							L.density=1
							L.fired=1
							flick("Attack",usr)
							if(L&&usr) walk(L,usr.dir)
							usr.firingorb=1
							spawn(7) if(usr&&L)
								usr.firingorb=0
								if(L&&usr) walk_towards(L,usr)
								spawn(7) if(L&&usr)
									L.loc=locate(usr.x,usr.y,usr.z)
									L.fired=0
									L.density=0
									if(L) walk(L,0)
					usr.doingorb=1
					spawn((12)) if(usr) usr.doingorb=0
					usr.orbnum=1



