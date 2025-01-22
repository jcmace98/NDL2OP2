mob/var/tmp
	feasting=0
	Banpaia=0
	KetsuekiDrain=0
	BeingKetsuekiDrained=0
	BloodPartner
	BloodLink=0
	UsingSixthseal=0
	UsingSealOne=0
mob/proc
	BloodDrain()
		if(src.firing||src.feasting)
			return
		for(var/mob/M in get_step(usr,usr.dir))
			if(src.client.address==M.client.address)
				src<<"You can not suck the blood of yourself!";return
			if(!M.knockedout)
				src<<"They need to be knocked out first!";return
			else
				src<<"You begin to suck [M]'s blood."
				if(prob(5)&&BloodFeast<10)
					src.BloodFeast+=pick(0.25,0.5,0.75,1)
					if(src.BloodFeast>10){src.BloodFeast=10}
				src.firing=1;src.Frozen=1;src.feasting=1
				spawn(50)
					if(src.feasting)
						src.firing=0;src.feasting=0;M.firing=0;src.Frozen=0;src<<"You finish sucking [M]'s blood."
				while(src.feasting&&M)
					if(M.knockedout)
						src.thirst-=10
						if(src.thirst<0)
							src.thirst=0
							if(M.client)
								if(src.stamina<src.maxstamina*1.5){src.stamina+=rand(100,250)}
								src.exp+=((src.BloodFeast+M.Age))
								if(src.Subscriber)
									src.exp+=(((src.BloodFeast+M.Age))/2)
							src.calories+=10
					else
						src<<"[M] woke up, stopping you from sucking their blood!";src.feasting=0
					sleep(1)
				src.firing=0;M.firing=0;src.Frozen=0

	FirstSeal()
	//	var/CurrentHealth=0
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src<<"You convert energy in the blood all throughout your body, which slowly rejuvanates your chakra...."
		src<<"Any noticable change in conciousness will turn this off.."
	//	CurrentHealth=src.health
		src.UsingSealOne=1
		while(src.UsingSealOne&&!src.knockedout)
			src.chakra+=rand(5,12)
			if(prob(1))
				src.BloodManipulation+=0.5;if(src.BloodManipulation>100) src.BloodManipulation=100
	//		M.ChakraPool+=M.MaxChakraPool*0.01
			if(src.chakra>=src.Mchakra)
				src.chakra=src.Mchakra
				src.UsingSealOne=0
			sleep(5)
		for(var/obj/SkillCards/FirstSeal/P in src.LearnedJutsus)
			if(P.TurnedOn)
				P.TurnedOn=0
				P.DelayIt(600,src,"Clan")
				src<<"The Seal Deactivates..."
		src.deathcount+=0.15
		src.UsingSealOne=0
		return
	/*
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src<<"You convert energy in the blood all through your body, rejuvanating your chakra completely!"
		var/BloodCost=((src.Mchakra-src.chakra)/200)
		src.chakra=src.Mchakra
		src.deathcount+=0.25
		if(prob(1))
			src.BloodManipulation+=0.1;if(src.BloodManipulation>100) src.BloodManipulation=100
		spawn(100)
			src.deathcount+=0.15
			src<<"The seal has made you tired, taking up a lot of your blood supply.";src.thirst+=BloodCost*0.5
			src.SealMastery+=1;if(src.SealMastery>100) src.SealMastery=100
			*/
	SecondSeal()
		var/ChakraLost=350-src.BloodManipulation
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(src.thirst>=80)
			src<<"You attempt to open the second seal, but you're too thirsty.."
			return
		src.chakra-=ChakraLost;src<<"You open the second seal on your body, and generate chakra all through your body, relaxing your muscles!";src.Banpaia=1
		if(prob(1))
			src.BloodManipulation+=0.5;if(src.BloodManipulation>100) src.BloodManipulation=100
		spawn(200+(src.SealMastery*2))
			src.Banpaia=0
	ThirdSeal()
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		src<<"You open the 3rd seal and release a torrent of blood everywhere!";src.thirst+=(40-round(src.BloodFeast*2));var/count=0
		for(var/turf/T in oview(6))
			if(prob(25))
				count+=1;var/obj/undereffect/x=new/obj/undereffect(locate(T.x,T.y,T.z))
				spawn(9)
					if(!x)return
					x.icon='Blood.dmi';var/v=rand(1,7);x.icon_state="l[v]";x.Owner=src
					spawn(900)
						del(x)
			src.health-=2
			if(prob(1))
				src.BloodManipulation+=0.5;if(src.BloodManipulation>100) src.BloodManipulation=100
	FourthSeal()
		var/mob/M=src.target
		if(!M.client||M.client.address==src.client.address)
			src<<"The 4th seal refuses to open."
			return
		if(src.Banpaia)
			src<<"You try to open the 4th seal, but it failed?!"
			sleep(20)
			src<<"Try closing the second seal first.."
			return
		if(src.KetsuekiDrain) return
		else
			src.Handseals(50-src.HandsealSpeed);if(src.HandsSlipped) return
			spawn(600)
				if(M&&M.BeingKetsuekiDrained)
					M.BeingKetsuekiDrained=0
				src.KetsuekiDrain=0
			M.BeingKetsuekiDrained=1;src.KetsuekiDrain=1
			if(prob(1))
				src.BloodManipulation+=0.5;if(src.BloodManipulation>100) src.BloodManipulation=100
			M<<"Your blood is being drained by [usr]!";src<<"You begin draining your target's blood!"
			while(src.KetsuekiDrain)
				for(M in oview(1,src))
					if(M.BeingKetsuekiDrained&&!M.knockedout)
						M.health-=M.maxhealth*0.01
						src.ChakraPool-=src.MaxChakraPool*0.0045
						if(src.ChakraPool>0)
							if(src.health<src.maxhealth)
								src.health+=M.maxhealth*0.005
						else
							src.chakra+=src.ChakraPool
							src.ChakraPool=0
				sleep(5)
	FifthSeal()
		var/ChakraLost=900-src.BloodManipulation
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped||usr.ntarget)
			return
		src.chakra-=ChakraLost
		var/mob/M=src.target
		if(!M.client)
			return
		if(M.Clan=="Ketsueki"||M.Clan2=="Ketsueki")
			src.BloodPartner=M
			src<<"You have labeled [M.name] as your blood partner."
		else
			src<<"You can not label [M.name] as your blood partner as they must be of the Ketsueki Clan."
	SixthSeal()
		var/ChakraLost=(350-(src.BloodManipulation/5))*2
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped)
			return
		src.chakra-=ChakraLost
		if(src.thirst>=80)
			src<<"You attempt to open the Sixth seal, but you're too thirsty.."
			return
		if(UsingSixthseal==0)
			src<<"You begin to link with your blood partner! All damage done to you will be done to him instead!"
			UsingSixthseal=1
			var/mob/M=src.BloodPartner
			while(M&&M.health>0&&UsingSixthseal)
				for(src.BloodPartner in view(10,src))
					src.BloodLink=1
					src.chakra-=pick(0,1)
				sleep(30)
		if(UsingSixthseal==1||src.knockedout||src.thirst>=80)
			UsingSixthseal=0
			src.BloodLink=0
			src.BloodPartner=""
			src<<"You stop using the seal."

	SeventhSeal() //Actually is the Eighth Seal....
		var/ChakraLost=(350-src.BloodManipulation)*8
		src.Handseals(1-src.HandsealSpeed)
		if(src.HandsSlipped)
			return
		src.chakra-=ChakraLost
		if(src.thirst>=57)
			src<<"You attempt to open the Seventh seal, but you're too thirsty.."
			return
		src<<"Your muscles begin to relax and blood begins rushing through you."
		src<<"Press Z to release the seal"
		var/EighthSeal=1
		var/Time=120//How long the seal lastes
		var/TT=0
		src.nin=src.Mnin*1.3
		while(EighthSeal==1&&Time>0)
			src.Banpaia=1
			src.stamina+=50
			src.health+=10
			if(src.health>src.maxhealth) src.health=src.maxhealth
			if(TT==4)
				src.thirst+=1
				if(src.thirst>=100)
					src.thirst=100
					EighthSeal=0
					src<<"Your thirst has caused you to release the seal."
				TT=0
			if(icon_state=="handseal")
				EighthSeal=0
			TT++
			Time--
			sleep(5)
		src.nin=src.Mnin


	KetsuekiBunshin()
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(prob(1))
			src.BloodManipulation+=0.5;if(src.BloodManipulation>100) src.BloodManipulation=100
		src<<"You generate chakra, turning every blood left on the ground into clones!"
		var/count=0
		for(var/obj/A in oview())
			if(A.icon=='Blood.dmi')
				if(prob(25)&&count<50)
					var/mob/Clones/Clone/K=new();K.CloneType="TKageBunshin"
					count++
					K.loc=A.loc;K.Owner=src;K.tai=src.Mtai;K.Endurance=0;K.health=src.health/100;src.chakra-=src.chakra/10
					for(var/V in src.vars)
						var/list/BAD = list("locs","cansave","GateIn","InDeathGate","key","ckey","client","type","parent_type","verbs","vars","group","x","y","z","loc","contents","alterV","alterC","alterR","OriginalVillage","Orank","OClan","ImmuneToDeath","Owner")
						if(!BAD.Find(V))
							K.vars[V] = usr.vars[V]
					if(K)
						K.health=1;K.stamina=0;K.icon=src.icon;K.overlays+=src.overlays;K.name="[src.name]";K.Clone=1;K.Running=1
				del(A)
			sleep(1)