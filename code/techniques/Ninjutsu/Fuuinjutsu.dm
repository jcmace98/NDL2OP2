

//It's true...These are severely underrated =_=...SHOULD WORK ON!

//Fuuinjutsu: Handseal
////////////////
mob/var/tmp/FuuinjutsuHandseal=0
mob/var/tmp/FuuinjutsuHellsent=0
mob/var/tmp/InHellSent=0
mob/proc/FuuinjutsuHandseal()
	usr.Target()
	if(usr.ntarget)
		return
	else
		src.Handseals(15-src.HandsealSpeed)
		if(src.HandsSlipped) return
		var/ChakraLoss=500
		src.chakra-=ChakraLoss
		var/mob/M =src.target
		if(prob(10))
			src.FuuinjutsuKnowledge+=pick(0.1,0.5,0.6,1)
		var/Distance=(src.gen/15)+(src.ChakraC/20)//var/Distance=(src.gen/10)+(src.ChakraC/10)
		if(get_dist(M,src)<=Distance)
			src<<"You generate your chakra over [M]! It'll take 5 seconds to seal them!"
			src.Frozen=1
			M<<"You feel a slight tightening on your hands."
			sleep(50)
			src.Frozen=0
			if(get_dist(M,src)<=Distance)
				src.icon_state="handseal"
				src<<"Press Z to release the Fuuinjutsu, as long as it's being held they will be unable to form handseals."
				M<<"The chakra around your hands are disturbed and sealed, making it impossible to form handseals!"
				while(M&&src.icon_state=="handseal")
					M.FuuinjutsuHandseal=1
					src.chakra-=pick(5,10)
					sleep(11)
				src<<"You release the Fuuinjutsu."
				M.FuuinjutsuHandseal=0
			else
				src<<"The target went out of reach.";return
		else
			src<<"They're too far for your chakra to reach them!"
/////////////////////////////
//Fuuinjutsu: Chakra
////////////////
mob/proc/FuuinjutsuChakra()
	var/ChakraLoss=500//var/ChakraLoss=1000
	var/UsingLocation=0
	src.chakra-=ChakraLoss
	src.Handseals(1-src.HandsealSpeed)
	if(src.HandsSlipped) return
	if(prob(30))
		src.FuuinjutsuKnowledge+=pick(0.5,0.6,1)
	for(var/mob/M in get_step(src,src.dir))
		if(M.knockedout)
			src<<"Trying to use it on a knocked out person? Pathetic.";src.health-=1000;return
		src<<"You generate your chakra over [M]! It'll take 7 seconds to seal them!"
		src.Frozen=1
		M<<"You feel as if your chakra is being restrained!"
		sleep(70)
		if(M in get_step(src,src.dir))
			src.Frozen=0
			src.icon_state="handseal"
			UsingLocation=src.loc
			src<<"Press Z to release the Fuuinjutsu, as long as it's being held their chakra will be constantly sealed."
			M<<"Your chakra circulatory system has been put to a massive slow down, stop?"
			while(M&&src.icon_state=="handseal"&&UsingLocation==src.loc)
				if(M.chakra>0)
					M.chakra=0
				src.chakra-=10
				sleep(11)
			src<<"You release the Fuuinjutsu."
		else
			src<<"The target moved.";return


mob/proc/FuuinjutsuControl()
//	mob/var/tmp/Time=0
	var/SettingUpLocation=0
	src.Handseals(35-src.HandsealSpeed)
	src.ChakraDrain(45000)
	if(src.HandsSlipped) return
	src.Frozen=1
	src.icon_state="handseal"
	SettingUpLocation=src.loc
	src<<"Don't move while you prepare the fuuinjutsu"
	if(src.icon_state!="handseal"||src.knockedout||SettingUpLocation!=src.loc)
		src<<"Your concentration was broke preparing for the fuuinjutsu!"
		return
	spawn(70)
		if(prob(30))
			src.FuuinjutsuKnowledge+=pick(0.5,0.6,1)
		src.Frozen=0
		src.FuuinControl=1
		src<<"Your hands currently yield a Fuuinjutsu! Punch the opponent to lay it on them!"
		spawn(100)
			if(src.FuuinControl)
				src.FuuinControl=0
				src<<"The Fuuinjutsu dissipitates."

mob/proc/FuuinjutsuHellSentRestoration()
//	mob/var/tmp/Time=0
	var/SettingUpLocation=0
	src.Handseals(35-src.HandsealSpeed)
	src.ChakraDrain(40000)
	if(src.HandsSlipped) return
	src.Frozen=1
	src.icon_state="handseal"
	SettingUpLocation=src.loc
	src<<"Don't move while you prepare the fuuinjutsu"
	if(prob(45))
		src.FuuinjutsuKnowledge+=pick(0.5,0.6,1)
	if(src.icon_state!="handseal"||src.knockedout||SettingUpLocation!=src.loc)
		src<<"Your concentration was broke preparing for the fuuinjutsu!"
		return
	spawn(100)
		src.Frozen=0
		src.FuuinjutsuHellsent=1
		src<<"Your hands currently yield a Fuuinjutsu! Punch the opponent to lay it on them!"
		spawn(100)
			if(src.FuuinjutsuHellsent)
				src.FuuinjutsuHellsent=0
				src<<"The Fuuinjutsu dissipitates."

mob/proc/FuuinjutsuFiveElementSeal()
	src.Handseals(45-src.HandsealSpeed)
	src.ChakraDrain(95000)
	if(src.HandsSlipped) return
	src.Frozen=1
	src.icon_state="handseal"
	src<<"Don't move while you prepare the fuuinjutsu"
	if(prob(40))
		src.FuuinjutsuKnowledge+=pick(0.5,0.6,1)
	if(src.icon_state!="handseal"||src.knockedout)
		src<<"Your concentration was broke preparing for the fuuinjutsu!"
	spawn(90)
		src.Frozen=0
		src.FiveElementSeal=1
		src<<"Your hands currently yield a Fuuinjutsu! Punch the opponent to lay it on them!"
		spawn(400)
			if(src.FiveElementSeal)
				src.FiveElementSeal=0
				src<<"The Fuuinjutsu dissipitates."
mob/var/tmp/CurseSealParalysis=0
mob/var/tmp/CursedSealParalysis=0
mob/var/tmp/LandedCurseSealParalysis=0
mob/var/tmp/FiveElementSealed=0
mob/var/tmp/RemovedUpperCloathing=0
mob/var/ReverseFourSymbolsPlaced=0
mob/proc/RemoveUpperCloathing()
	if(!src.ReverseFourSymbolsPlaced)
		src<<"You don't have the Fuuinjutsu placed on you so there's no need to remove your cloathing!"
		for(var/obj/SkillCards/UpperCloathingRemoval/P in src.LearnedJutsus)
			del(P)
		return
	view()<<"[src] takes off their cloathes on the upper half of their body!"
	for(var/obj/Clothes/Y in src.contents)
		if(Y:bodyarea=="TorsoTop"||Y:bodyarea=="Torso")
			if(Y:worn==1)
				Y.Wear()
				src.RemovedUpperCloathing=1
	for(var/obj/SkillCards/UpperCloathingRemoval/C in src.LearnedJutsus)
		del(C)
obj/Jutsu/Fuuinjutsu/FourSymbolsConsume
	icon='Icons/Jutsus/FourSeal.dmi'
	icon_state="Consume"
	density=0
	layer=1
	New()
		..()
		spawn(1)
			var/mob/O = src.Owner
			while(src&&src.Owner)
				sleep(1)
				for(var/mob/M in src.loc)
					if(!M.knockedout&&M.client&&M!=O)
						M.health-=2500
						M.Death(M)
		spawn(300)
			del(src)
mob/proc/ReverseFourSymbolsTechnique()
	var/AttachTime=100
	var/Placing=0
	switch(input(usr,"Would you like to set the Fuuinjutsu on your own body?", "Reverse Four Symbols Technique") in list ("Yes","No"))
		if("No")
			return
		if("Yes")
			if(src.ReverseFourSymbolsPlaced)
				src<<"You already have the Fuuinjutsu set on your body!";return
		//	src.Frozen=1
			for(var/obj/Clothes/Y in src.contents)
				if(Y:bodyarea=="TorsoTop"||Y:bodyarea=="Torso")
					if(Y:worn==1)
						Y.Wear()
			src<<"You begin to place the Fuuinjutsu on your Body, wait, as this could take a while."
			Placing=1
			while(Placing==1&&AttachTime>0)
				if(src.knockedout)
					src<<"You were knocked out, ending the placement.";return
				AttachTime--
				sleep(2)
			src.LearnedJutsus += new/obj/SkillCards/UpperCloathingRemoval
			src<<"You placed the Fuuinjutsu on your Body. Before you die remove your cloathing with the Remove Upper Cloathing Skillcard and this Fuuinjutsu will set off upon your death!"
			src.ReverseFourSymbolsPlaced=1



mob/proc/CurseSealOfParalysis()
	var/SettingUpLocation=0
	src.Handseals(35-src.HandsealSpeed)
	src.ChakraDrain(75000)
	if(src.HandsSlipped) return
	src.Frozen=1
	src.icon_state="handseal"
	SettingUpLocation=src.loc
	src<<"Don't move while you prepare the fuuinjutsu"
	if(src.icon_state!="handseal"||src.knockedout||SettingUpLocation!=src.loc)
		src<<"Your concentration was broke preparing for the fuuinjutsu!"
		return
	spawn(100)
		if(prob(35))
			src.FuuinjutsuKnowledge+=pick(0.1,0.5,0.6,1)
		src.Frozen=0
		src.CurseSealParalysis=1
		src<<"Your hands currently yield a dangerous Fuuinjutsu once used by Shimura, Danzo! Punch the opponent to lay it on them!"
		spawn(100)
			if(src.CurseSealParalysis==1)
				src.CurseSealParalysis=0
				src<<"The Fuuinjutsu dissipitates."

mob/proc/CurseSealParalysis(mob/A)
	var/JuuinjutsuActivated=0
	var/JuuinjutsuActivated2=0
	var/JuuinjutsuTimer1=0
	var/JuuinjutsuTimer2=0
	src.CursedSealParalysis=0
	A.FrozenBind="Danzo Jutsu"
	A.icon_state="handseal"
	src<<"Your body begins to slow down and lose it's senses..."
	sleep(20)
	src<<"You can't move anymore..."
	src.FrozenBind="Danzo Jutsu"
	sleep(20)
	src<<"Your body has become completely paralyzed...What's going on...!?"
	view()<<"<font size=1><font face=verdana><b><font color=red>[A]<font color=white> Says: This is my Juuinjutsu....Cursed Seal Of Paralysis....Let it consume you..</font>"
	sleep(30)
	JuuinjutsuActivated=1
	src<<"Fight off the Juuinjutsu! Tap Spacebar enough times to release Chakra from your body releasing the Juuinjutsu!"
	while(JuuinjutsuActivated==1&&JuuinjutsuTimer1<=40)
		if(A.knockedout)
			src.overlays-='Icons/Jutsus/DanzoFuuin.dmi';src.overlays-='Icons/Jutsus/DanzoFuuin2.dmi'
			src.FrozenBind=""
			return
		src.health-=3
		src.stamina-=pick(3,5)
		JuuinjutsuTimer1+=2
		sleep(5)
	src.overlays-='Icons/Jutsus/DanzoFuuin.dmi'
	src.overlays+='Icons/Jutsus/DanzoFuuin.dmi'
	view()<<"<font size=1><font face=verdana><b><font color=red>[A]<font color=white> Says: Stop fighting it...You can't break out of it...It's hopeless...</font>"
	sleep(30)
	src.Struggle=0
	src<<"Keep Tapping the SpaceBar!"
	JuuinjutsuActivated2=1
	var/ChanceToEscape=100
	while(JuuinjutsuActivated2==1&&JuuinjutsuTimer2<=40)
		if((src.Struggle+(src.deathcount*50))>ChanceToEscape)
			src.chakra-=1000
			src<<"You force enough chakra out of your body to escape the Juuinjutsu!"
			A<<"[src] released themselves from your Juuinjutsu!"
			src.overlays-='Icons/Jutsus/DanzoFuuin.dmi';
			src.overlays-='Icons/Jutsus/DanzoFuuin2.dmi'
			src.FrozenBind=""
			A.FrozenBind="";A.icon_state=""
			return
		if(A.knockedout)
			src<<"[A] knocking out resulted in the Juuinjutsu releasing!"
			src.overlays-='Icons/Jutsus/DanzoFuuin.dmi';
			src.overlays-='Icons/Jutsus/DanzoFuuin2.dmi'
			src.FrozenBind=""
			return
		src.health-=3
		src.stamina-=pick(3,5)
		JuuinjutsuTimer2+=2
		sleep(5)
	view()<<"<font size=1><font face=verdana><b><font color=red>[A]<font color=white> Says: I told you it was hopeless....It's useless to continue fighting anymore...You're through..</font>"
	sleep(17)
	src.overlays+='Icons/Jutsus/DanzoFuuin2.dmi'
	sleep(20)
	view()<<"<font size=1><font face=verdana><b><font color=red>[A]<font color=white> Says: Now.....Die!</font>"
	sleep(10)
	src.Quake_Effect_Self(src,3,2)
	sleep(10)
	src.DamageProc(2000,"Health",A)
	src.overlays-='Icons/Jutsus/DanzoFuuin.dmi';
	src.overlays-='Icons/Jutsus/DanzoFuuin2.dmi'
	src.FrozenBind=""
	A.FrozenBind="";
	A.icon_state=""
	return



































	/*



	/*
	This unnamed Fuuinjutsu is used by Danzou. After touching the skin of his target with the palm of his hand, Danzou will secretly place a seal on their body. This seal can then be activated a short time later. When activated, the seal will expand to spead over the target's body and bind them in place. With them bound, Danzou can attack at leisure. The seal can be overcome with a powerful enough chakra like a manifestation of Susanoo.
	*/
////Fuinjutsu Knowledge: Increases as the user preforms sealing tehniques, allowing them to create a wide array of seals. 0/10 (Increases by .1 naturally)

Center:

1. Fuinjutsu Resistance: Lessen the duration of Fuinjutsu while blocking. 0/1 (Increased with sps)

2. Seal Removal (Jutsu): This technique is a counter seal which releases the previous fuinjutsu.

3. Limit Release Seal (Jutsu): Allows its users to place a seal on themselves granting a temporary boost in their overall chakra as well as stats depending on their seal strength and duration.

Left:

1. Fuinjutsu Duration: Increases the time in which the users sealing jutsu lasts. (0/3 Increases .01 each point allows 10 seconds on top of the static duration fuinjutsu already have.)

2. Seal Artisan: Doubles the duration of your seals 0/1 (Increased by sps.)

Right:

1. Fuinjutsu Strength: Enhances the effects of your Fuinjutsu sometimes doubling or tripling their power. 0/3 (Increased by sps)

2. Fuinjutsu Agility: Halves the time it takes to prepare a seal and allows the user to walk while preparing them. As a side effect the user takes 25% less time to seal bijuus. 0/1 (Increased by sps)

Possible additional seals:

Digestive Seal: Increases the targets overall calorie drain and rapidly induces hunger.

Synapse Seal: Causes the brain and nerve screw effects/has a short duration without passives.

Super Crazy Idea Spectacular:

Immature Dead Demon Consuming Seal: Requires all fuinjutsu passives maxed and a minimum of 20-25 starter points worth of control. This suicide seal has a single tile and use when activated with the same CD of tajuu kage bunshin. If you miss you've got to wait quite some time. When hit by said seal the sealer and the target are both frozen and the targets willpower is steadily drained while the sealers vitality is siphoned. When the sealer is either out of vitality or releases the jutsu both players are knocked out. The sealer is guaranteed to die while the opponent still has a chance to get up if their willpower is high enough to warrant a struggle.
			*/