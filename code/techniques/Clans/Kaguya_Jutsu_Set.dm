mob/var/tmp
	KagDance=""
	TessenkaOut=0
	usingA=0
	BoneMembrane=0
mob/proc/DanceMoveCheck()
	if(src.KagDance=="")
		src.overlays-='Icons/Jutsus/KagYanagi.dmi'
		src.overlays-='Icons/Jutsus/KagTsubaki.dmi'
		src.overlays-='Icons/Jutsus/KagTessenka.dmi'
		src.overlays-='Icons/Jutsus/Armbone.dmi'
	if(src.KagDance=="Yanagi")
		src.overlays-='Icons/Jutsus/KagYanagi.dmi'
		src.overlays-='Icons/Jutsus/KagTsubaki.dmi'
		src.overlays-='Icons/Jutsus/KagTessenka.dmi'
		src.overlays-='Icons/Jutsus/Armbone.dmi'
		src.overlays+='Icons/Jutsus/KagYanagi.dmi'
	if(src.KagDance=="Tsubaki")
		src.overlays-='Icons/Jutsus/KagYanagi.dmi'
		src.overlays-='Icons/Jutsus/KagTsubaki.dmi'
		src.overlays-='Icons/Jutsus/KagTessenka.dmi'
		src.overlays-='Icons/Jutsus/Armbone.dmi'
		src.overlays+='Icons/Jutsus/KagTsubaki.dmi'
	if(src.KagDance=="Karamatsu")
		src.overlays-='Icons/Jutsus/KagYanagi.dmi'
		src.overlays-='Icons/Jutsus/KagTsubaki.dmi'
		src.overlays+='Icons/Jutsus/KagTessenka.dmi'
		src.overlays-='Icons/Jutsus/Armbone.dmi'
//		src.overlays+='KagTessenka.dmi'
	if(src.KagDance=="Tessenka")
		src.overlays-='Icons/Jutsus/KagYanagi.dmi'
		src.overlays-='Icons/Jutsus/KagTsubaki.dmi'
		src.overlays-='Icons/Jutsus/KagTessenka.dmi'
		src.overlays-='Icons/Jutsus/Armbone.dmi'
		src.overlays-='Icons/Jutsus/KagTessenka.dmi'
obj/Jutsu/Kaguya
	icon='Icons/Jutsus/KaguyaTechniques.dmi'
	TeshiSendan
		icon_state = "Bullets"
		density=1
		New()
			..()
			spawn(45)
				del(src)
		Bump(A)
			..()
			if(ismob(A))
				var/mob/M=A;var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				if(M.Deflection)
					viewers(M)<<sound('SFX/SwordClash.wav',0);M.Deflection=0
					if(prob(1))
						M.DeflectionZ+=pick(0.1,0.3);if(M.DeflectionZ>5) M.DeflectionZ=5
					spawn() AttackEfx4(M.x,M.y,M.z,M.dir);AttackEfx4(src.x,src.y,src.z,src.dir)
					viewers(src)<<sound('SFX/SwordClash.wav',0);src.dir=turn(src.dir,45);walk(src,src.dir);flick("clang",src);sleep(5);return
				var/damage=rand(M.maxhealth*0.04,M.maxhealth*0.06)
				if(src.icon_state=="Ibara")
					damage+=damage
				M.DamageProc(damage,"Health",O)
				if(src.icon_state=="Ibara") view(M)<<output("[M] was hit by Bone Spears!([damage])","Attack")
				else view(M)<<output("[M] was hit by Bone Bullets!([damage])","Attack")
				spawn() M.SoundEngine('SFX/Slice.wav',10);M.Bloody()
				if(src.icon_state=="Ibara")
					src.loc=M.loc;M.StunAdd(10);src.layer=MOB_LAYER+1;src.icon_state="IbaraInside";walk(src,0)
				if(src.icon_state=="IbaraInside") sleep(11)
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
				del(src)
	TessenkaW2
		icon = 'Icons/Jutsus/tessenka.dmi'
		icon_state = "whip2"
		density=1
		Move_Delay=0
		var
			Head=0;MoveDistance=0;MaxLength=7
		New()
			..()
			spawn(35)
				del(src)
		Move()
			src.MoveDistance++
			if(src.MoveDistance>=src.MaxLength&&src.Head)
				return
			if(src.Head)
				var/obj/Jutsu/Kaguya/TessenkaW2/L=new()
				L.loc=src.loc;L.Owner = src.Owner;L.dir=src.dir
				..()
			for(var/obj/Jutsu/Kaguya/TessenkaW2/A in src.loc)
				if(A!=src)
					del(A)
	//		for(var/mob/player/M in view(0,src))
	//			if(src.Owner==M&&src.MoveDistance>1)
	//				M.Frozen=0;M.TessenkaOut=0
		Bump(A)
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
				if(M.Kaiten||M.sphere)
					return
				var/damage=M.maxhealth*(rand(15,23)*0.01);view(M)<<output("[M] was slashed and whipped!([damage])","Attack");M.DamageProc(damage,"Health",O)
				M.HitBack(3,src.dir);spawn() M.SoundEngine('SFX/Slice.wav',10);M.Bloody()
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density)
					del(src)
			if(istype(A,/obj/))
	//			if(istype(A,/obj/TessenkaW2))
	//				if(A.Owner==src.Owner)
	//					del(A)
	//			else
				var/obj/T = A
				if(T.density)
					del(src)
	SawaOverlay
		icon='Icons/Jutsus/KaguyaTechniques2.dmi'
		pixel_y=32
		layer=MOB_LAYER+1
		density=0
	Sawarabi
		icon='Icons/Jutsus/KaguyaTechniques2.dmi'
		icon_state="1"
		density=1
		layer=MOB_LAYER+1
		New()
			..()
			var/DeleteTime=rand(300,600)
			var/iconstatevalue=pick(1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31);src.icon_state="[iconstatevalue]"
			var/obj/Jutsu/Kaguya/SawaOverlay/AC=new();var/iconstatevalue2=iconstatevalue+1
			AC.icon_state="[iconstatevalue2]";src.overlays+=AC
			spawn()
				spawn()
					src.SoundEngine('SFX/BoneRise.wav',10,55)
				spawn()
					src.CreateCrator()
				flick("rise[iconstatevalue]",src)
				var/mob/O=src.Owner
				for(var/mob/M in src.loc)
					if(M==O)
						return
					if(prob(5))
						O.DanceMastery+=pick(0.5,0.7)
					var/damage=M.maxhealth*(rand(50,65)*0.01)
					view()<<"[M] has taken [damage] damage from [usr]'s Sawarabi No Ma"
					M.SoundEngine('SFX/Slice.wav',10);M.DamageProc(damage,"Health",O)
					spawn()
						M.Bloody();M.Bloody();M.Bloody()
			spawn(DeleteTime)
				src.CreateSmoke("Light")
				del(src)
		Click()
			if(usr==src.Owner)
				if(usr.Stun>=1||usr.FrozenBind||usr.Frozen||usr.z==1)
					return
				usr.loc=src.loc;usr.chakra-=50
	SawarabiControl
		icon='Icons/Jutsus/KaguyaTechniques2.dmi'
		icon_state="1"
		density=1
		layer=MOB_LAYER+1
		New()
			..()
			var/DeleteTime=rand(300,600)
			var/iconstatevalue=pick(1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31);src.icon_state="[iconstatevalue]"
			var/obj/Jutsu/Kaguya/SawaOverlay/AC=new();var/iconstatevalue2=iconstatevalue+1
			AC.icon_state="[iconstatevalue2]";src.overlays+=AC
			spawn()
				spawn()
					src.SoundEngine('SFX/BoneRise.wav',10,50)
				spawn()
					src.CreateCrator()
				flick("rise[iconstatevalue]",src)
				var/mob/O=src.Owner
				for(var/mob/M in src.loc)
					if(M==O)
						return
					if(prob(5))
						O.DanceMastery+=pick(0.5,0.7)
					var/damage=M.maxhealth*(rand(15,22)*0.01)
					view()<<"[M] has taken [damage] damage from [usr]'s Sawarabi No Ma"
					M.SoundEngine('SFX/Slice.wav',10);M.DamageProc(damage,"Health",O)
					spawn()
						M.Bloody();M.Bloody();M.Bloody()
			spawn(DeleteTime)
				src.CreateSmoke("Light")
				del(src)
/*		Click()
			if(usr==src.Owner)
				if(usr.Stun>=1||usr.FrozenBind||usr.Frozen||usr.z==1)
					return
*///				usr.loc=src.loc;usr.chakra-=50
mob/proc
	Kochou()
		src.ChakraDrain(35000)
		if(src.Kochou)
			src.Kochou=0
			src<<"You let your bones go back to their normal density."
			if(src.Swift!=src.BaseSwift)
				src.Swift=src.BaseSwift
			src.Swift=src.BaseSwift
			src.SaveK()
		if(src.ingat||src.intank||src.Kaiten||src.firing||src.Frozen||src.sphere)
			if(src.Swift!=src.BaseSwift&&src.Kochou)
				src.Swift=src.BaseSwift
			return
		if(src.knockedout)
			if(src.BaseSwift==0)
				return
			else
				src.Kochou=0
				src<<"You lose the ability to manipulate your bones as you fall unconcious. Your bones turn back to their normal density."
				src.Swift=src.BaseSwift
				if(src.Swift!=src.BaseSwift&&src.Kochou)
					src.Swift=src.BaseSwift
					return
		else
			src.Swift=src.BaseSwift
			src.Kochou=1
			src<<"You use your chakra to manipulate your bones into a less dense substance, making you able to punch and slash much swifter!"
			src.Swift=src.BaseSwift
			src.SaveK()
			src.Swift+=2
	TenshiSendanAttack()
		if(src.ingat|src.intank|src.Kaiten|src.firing)
			return
		else
			if(prob(5))
				src.DanceMastery+=pick(0.5,0.7)
			if(src.target)
				src.dir=get_dir(src,src.target)
			src.chakra-=50;flick("Attack1",src);var/obj/Jutsu/Kaguya/TeshiSendan/K=new();K.loc=src.loc;K.Move_Delay=0;K.name="[src]";K.Owner=src;K.dir=src.dir;walk(K,K.dir);sleep(1);A--
	Ibara()
		src.chakra-=50;src.stamina-=50;src.health-=10
		src.icon_state="Power"
		spawn(10)
			src.icon_state=""
		var/obj/Jutsu/Kaguya/TeshiSendan/A=new();A.loc=src.loc;A.Move_Delay=0;A.name="[src]";A.Owner=src;walk(A,NORTH);A.icon_state="Ibara";var/obj/Jutsu/Kaguya/TeshiSendan/B=new();B.loc=src.loc;B.Move_Delay=0;B.name="[src]";B.Owner=src;walk(B,SOUTH);B.icon_state="Ibara"
		var/obj/Jutsu/Kaguya/TeshiSendan/C=new();C.loc=src.loc;C.Move_Delay=0;C.name="[src]";C.Owner=src;walk(C,WEST);C.icon_state="Ibara";var/obj/Jutsu/Kaguya/TeshiSendan/D=new();D.loc=src.loc;D.Move_Delay=0;D.name="[src]";D.Owner=src;walk(D,EAST);D.icon_state="Ibara"

		if(src.BoneMastery>=75)
			var/obj/Jutsu/Kaguya/TeshiSendan/E=new();E.loc=src.loc;E.Move_Delay=0;E.name="[src]";E.Owner=src;walk(E,NORTHWEST);E.icon_state="Ibara";var/obj/Jutsu/Kaguya/TeshiSendan/F=new();F.loc=src.loc;F.Move_Delay=0;F.name="[src]";F.Owner=src;walk(F,SOUTHEAST);F.icon_state="Ibara"
			var/obj/Jutsu/Kaguya/TeshiSendan/G=new();G.loc=src.loc;G.Move_Delay=0;G.name="[src]";G.Owner=src;walk(G,SOUTHWEST);G.icon_state="Ibara";var/obj/Jutsu/Kaguya/TeshiSendan/K=new();K.loc=src.loc;K.Move_Delay=0;K.name="[src]";K.Owner=src;walk(K,NORTHEAST);K.icon_state="Ibara"
	BoneMembrane()
		src.BoneMembrane=1;src<<"You increase the density of bone under your skin."
		var/X=src.BoneArmor
		var/Y=48000
		while(src.BoneMembrane)
			sleep(50)
			src.Endurance=100000
			if(src.knockedout)
				src.BoneMembrane=0
			src.ChakraDrain((Y)/(X+1))
			spawn(300)
				if(src.BoneMembrane)
					src<<"Your bones instinctively go back to their natural density."
					src.BoneMembrane=0
					for(var/obj/SkillCards/BoneMembrane/A in src.LearnedJutsus)
						A.DelayIt(650,src,"Tai")
		for(var/obj/SkillCards/BoneMembrane/A in src.LearnedJutsus)
			A.DelayIt(300,src,"Tai")
	YanagiZ()
		if(src.firing)
			return
		if(src.KagDance=="Yanagi")
			src<<"You retract the bone swords into your arms."
			src.WeaponInLeftHand="";src.LeftHandSheath=0
			src.WeaponInRightHand="";src.RightHandSheath=0
			src.KagDance=""
			src.DanceMoveCheck()
			return
		else
			var/obj/WEAPONS/Yanagi/Y=new();src.KagDance="Yanagi";src.DanceMoveCheck()
			src.WeaponInLeftHand=Y;src.LeftHandSheath=1;src.WeaponInRightHand=Y;src.RightHandSheath=1
			while(src.KagDance=="Yanagi")
				src.WeaponInLeftHand=Y;src.LeftHandSheath=1
				src.WeaponInRightHand=Y;src.RightHandSheath=1
				if(src.chakra<=0&&src.DanceMastery<30)
					src<<"You could not hold the bone swords any longer.";src.KagDance="";src.DanceMoveCheck()
				else if(src.DanceMastery<30) src.chakra-=10
				sleep(11)
			src.WeaponInLeftHand="";src.LeftHandSheath=0;src.WeaponInRightHand="";src.RightHandSheath=0
	TsubakiZ()
		if(src.firing)
			return
		if(src.KagDance=="Tsubaki")
			src<<"You retract the bone sword into your arm.";src.WeaponInRightHand="";src.RightHandSheath=0;src.KagDance="";src.DanceMoveCheck();return
		else
			src.KagDance="Tsubaki";src.DanceMoveCheck()
			var/obj/WEAPONS/Tsubaki/T=new();src.WeaponInRightHand=T;src.RightHandSheath=1
			while(src.KagDance=="Tsubaki")
				src.WeaponInRightHand=T;src.RightHandSheath=1
				if(src.chakra<=0&&src.DanceMastery<30)
					src<<"You could not hold the bone sword any longer.";src.KagDance="";src.DanceMoveCheck()
				else
					if(src.DanceMastery<30)	src.chakra-=15
				sleep(11)
			src.WeaponInRightHand="";src.RightHandSheath=0
	KaramatsuNoMai()
		if(src.KagDance=="Karamatsu")
			src<<"You retract the bone armor.";src.KagDance="";src.DanceMoveCheck()
			return
		else
			src.KagDance="Karamatsu";src.DanceMoveCheck()
			while(src.KagDance=="Karamatsu")
				if(src.chakra<=0)
					src<<"You could not sustain the bone harden any longer!";src.KagDance="";src.DanceMoveCheck()
				else
					var/Cdrain=1000;src.ChakraDrain(Cdrain)
					if(src.DanceMastery>29)
						sleep(11)
					sleep(15)
	TessenkaNoMai()//dance 4
		if(src.firing)
			return
		if(src.KagDance=="Tessenka")
			src<<"You retract the bones back.";src.KagDance="";src.DanceMoveCheck();return
		else
			src.KagDance="Tessenka";src.DanceMoveCheck()
			while(src.KagDance=="Tessenka")
				if(src.chakra<=0)
					src<<"You could not hold the dance any longer.";src.KagDance="";src.DanceMoveCheck()
				else
					var/Cdrain=25;src.chakra-=Cdrain
					if(src.DanceMastery>29)
						sleep(50)
					sleep(11)
	ArmB()
		if(src.firing||usr.Kaiten == 1||usr.usingA)
			return
		else
			src<< "You structure your bones around your arm!";src.chakra-=1500
			view() << "[src] creates an piercing structure of bones around their arm!";src.usingA=1
			src.overlays -='Icons/Jutsus/Armbone.dmi';src.underlays -= 'Icons/Jutsus/Armbone2.dmi';src.overlays += 'Icons/Jutsus/Armbone.dmi';src.underlays += 'Icons/Jutsus/Armbone2.dmi'
			walk(src,src.dir)
			spawn(2+(src.BoneMastery/13))
				walk(src,0);src.usingA=0;src<<"Your bones retract.";src.overlays -='Icons/Jutsus/Armbone.dmi';src.underlays -= 'Icons/Jutsus/Armbone2.dmi'
	Sawarabi(Control)
		var/Check=Control
		if(Check==0)
			if(src.firing) // If the mob's firing var is one...
				return
			src.chakra-=2500;src.Frozen=1;src.firing=1;src.icon_state="Block";src<<"Release X to stop the Bones!";var/SawaOn=1
			while(src.icon_state=="Block")
				src.deathcount+=(0.2-(src.SawaMaster*0.01))
				if(src.SawaMaster<=1)
					if(SawaOn>=3)
						src.icon_state=""
				if(src.SawaMaster<=2)
					if(SawaOn>=5)
						src.icon_state=""
				if(src.SawaMaster<=4)
					if(SawaOn>=8)
						src.icon_state=""
				else
					if(SawaOn>=10)
						src.icon_state=""
				if(SawaOn==1)
					for(var/turf/T in oview(1,src))
						var/obj/Jutsu/Kaguya/Sawarabi/S=new();S.Owner=usr;S.loc=T
				else
					for(var/turf/T in oview(SawaOn,src))
						if(!(T in oview(SawaOn-1,src))&&!T.density)
							var/obj/Jutsu/Kaguya/Sawarabi/S=new();S.Owner=usr;S.loc=T
				SawaOn++;sleep(5)
			src.Frozen=0;src.firing=0
		if(Check==1)
			if(src.ControllingSawa==1)
				src<<"You stop controlling your Sawa."
				src.ControllingSawa=0
			src<<"You are able to form Sawa anywhere on the field! Double Click to place Sawa!"
			src.ControllingSawa=1
			while(src.ControllingSawa==1)
				src.ChakraDrain(10000)
				if(src.knockedout)
					src.ControllingSawa=0
					src<<"You stop controlling your Sawa."
					return
				sleep(20)

	TsubakiSlash(Direction,RangeMin=0.02,RangeMax=0.035,Critical=20)
		flick("weaponslash",src)
		for(var/mob/M in get_step(src,Direction))
			if(M.Clan=="Yotsuki"&&prob((M.DeflectionZ+M.Buffet+M.Teamwork+M.SpeedDice)*1.5))
				if(M.LeftHandSheath||M.RightHandSheath)
					M<<output("Your weapons deflect each other!","Attack");src<<output("Your weapons deflect each other!","Attack");viewers()<<sound('SFX/SwordClash.wav',0);M.Deflection=0;src.Deflection=0
					spawn() AttackEfx4(M.x,M.y,M.z,M.dir);AttackEfx4(src.x,src.y,src.z,src.dir)
					if(prob(1))
						M.DeflectionZ+=pick(0.1,0.3);if(M.DeflectionZ>5) M.DeflectionZ=5
					return
			else if(M.Deflection||M.WeaponMaster>6&&M.LeftHandSheath||M.WeaponMaster>6&&M.RightHandSheath)
				M<<output("Your weapons deflect each other!","Attack");src<<output("Your weapons deflect each other!","Attack");viewers()<<sound('SFX/SwordClash.wav',0);M.Deflection=0;src.Deflection=0
				spawn() AttackEfx4(M.x,M.y,M.z,M.dir);AttackEfx4(src.x,src.y,src.z,src.dir)
				if(prob(1))
					M.DeflectionZ+=pick(0.1,0.3);if(M.DeflectionZ>5) M.DeflectionZ=5
				return
			else
				if(prob(2))
					src.DanceMastery+=pick(0.5,0.7)
			/////////////////////////////////////////////////////
			/////////////////////////////////////////////////////
			if(!M.Mogu&&!M.sphere&&!M.Kaiten&&!M.ingat&&!M.intank)
				src.ChakraDrain(750)
				src<<"You slash [M] with your bone sword!"
				var/damage=round(rand(M.maxhealth*RangeMin,M.maxhealth*RangeMax))
				if(src.Trait=="Old Powerful") damage+=(src.DanceMastery)
				if(src.Trait=="Speedy"||src.Trait=="Tough") damage+=(src.TaijutsuMastery*2)
				if(prob(Critical)&&damage>0)
					damage=damage*2
					src<<"Critical hit!"
				M.DamageProc(damage,"Health",src)
				spawn()M.Bloody()
			else
				return