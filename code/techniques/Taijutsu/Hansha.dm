//This is a new Taijutsu Style that I'm going to be working on that is solely based on Counter Attacking and Blocking the opponent's taijutsu and weapons (possibly weapons?)
mob/var/tmp
	CalmedMind=0
	CalmedMindTime=0
	SoothingSlam=0
	SoothingCounter=0
	ReactionAbove=0
	ReactionAboveCounter=0
	ReactionBelow=0
	ReactionBelowCounter=0
	BrokenArms=0
	BrokenArmsTime=0
	BrokenLegs=0
	BrokenLegsTime=0
mob/var
	HanshaDefence=0
//Jutsus

// Calm Mind - A meditative State that grants a bonus torwards countering taijutsu by the Ninja standing still and Focusing for a few seconds
mob
	proc
		CalmingMind()
			var/MeditateTime=0
			var/PreparingCalmedMind=0
			var/StageOfCalmMind=0
			if(src.firing||src.Frozen||src.knockedout)
				return
			if(src.stamina<src.maxstamina*0.10)
				src<<"Your body is too weak to go into the meditative state.";return
			src.Frozen=1;src.firing=1
			src<<"You begin to relax every muscle in your body."
			sleep(15)
			src<<"You begin to concentrate on the enemies arm and leg movements as you enter the meditative State."
			MeditateTime=1
			src.icon_state="handseal"
			while(MeditateTime==1&&src.icon_state=="handseal")
				PreparingCalmedMind++
				if(PreparingCalmedMind>=6)
					src<<"You have analyzed the Opponents arm and leg movements, your ability to counter their taijutsu has increased."
					StageOfCalmMind=2
					MeditateTime=0
					src.Frozen=0;src.firing=0
				sleep(10)
			if(StageOfCalmMind==2)
				src.CalmedMind=1
				src.CalmedMindTime=(src.TaijutsuKnowledge/50)+rand(10,15)
			while(src.CalmedMind==1)
				src.CalmedMindTime--
				if(src.CalmedMindTime<=0)
					src.CalmedMind=0
					src<<"You stop concentrating so intently on analyzing the Opponents movements.";return
				if(src.knockedout)
					src.CalmedMind=0
					src<<"As you become unconcious you lose the intense concentration.";return
				sleep(10)
			src<<"You failed to go into the meditative State."
			src.firing=0
			src.Frozen=0
			return

// Soothing Slam - Chance to counter Moves that involve the opponent grabbing you Ex: Choke
		SoothingSlam(Uses)
			var/StaminaDrain=0
			StaminaDrain=120-src.tai
			if(src.firing||src.Frozen||src.knockedout)
				return
			if(src.stamina<src.maxstamina*0.10)
				src<<"Your body is too tired to try and counter.";return
			src.StaminaDrain(StaminaDrain)
			src<<"You prepare for any grapples the opponent may attempt on you."
			src.SoothingSlam=1
			if(src.TaijutsuKnowledge>1250)
				if(prob(10+(Uses/50)))
					src.SoothingCounter=1
			spawn(30)
				src.SoothingSlam=0
				src.SoothingCounter=0
				src<<"You stop preparing and let down your guard.";return

// Cautionary Reaction Above - Chance to counter moves that involve the opponent Punching you
		CautionaryReactionAbove(Uses)
			var/StaminaDrain=0
			StaminaDrain=120-src.tai
			if(src.firing||src.Frozen||src.knockedout)
				return
			if(src.stamina<src.maxstamina*0.10)
				src<<"Your body is too tired to try and counter.";return
			src.StaminaDrain(StaminaDrain)
			src<<"You prepare for any harmful taijutsu that utilize arms that the opponent may attempt on you."
			if(src.TaijutsuKnowledge>1250)
				if(prob(10+(Uses/50)))
					src.ReactionAboveCounter=1
			src.ReactionAbove=1
			spawn(30)
				src.ReactionAbove=0
				src.ReactionAboveCounter=0
				src<<"You stop preparing and let down your guard.";return

// Cautionary Reaction Below - ^ but for Kicks
		CautionaryReactionBelow(Uses)
			var/StaminaDrain=0
			StaminaDrain=120-src.tai
			if(src.firing||src.Frozen||src.knockedout)
				return
			if(src.stamina<src.maxstamina*0.10)
				src<<"Your body is too tired to try and counter.";return
			src.StaminaDrain(StaminaDrain)
			src<<"You prepare for any harmful taijutsu that utilize Legs that the opponent may attempt on you."
			if(src.TaijutsuKnowledge>1250)
				if(prob(10+(Uses/50)))
					src.ReactionBelowCounter=1
			src.ReactionBelow=1
			spawn(30)
				src.ReactionBelow=0
				src.ReactionBelowCounter=0
				src<<"You stop preparing and let down your guard.";return


//Things that Determine Counter Ability
/*
1.	When reversing ASD(basics) the drain and damage is based on your opponents phy. If your opponent charges more you will do less returning damage and returning it will drain more calories/stamina.

2.	When reversing techs it’s the calorie drain/stamina of the initial technique x2 when reversed the stronger the technique the more drain, however the oppone
however the opponent receives even more damage.

4.	Velocity of attacks should also effect damage, if they’re chained faster they should do less damage upon return but provide more drain.

5.	Physique vs. Physique. Low physique players will have very very high drains from reversing high phys techniques but do the same damage of course if not more depending on how far you want to go.

6.	High phy
physique players will take more reversed damage while low physique ones, or gentler styles such as uchiha style and quick fist will take less.
*/
mob/proc/DizzyProc(Time)
	while(src&&Time>=0)
		if(!src.knockedout)
			var/randz=rand(1,4)
			if(randz>=4)
				src.client:dir=NORTH
			if(randz==3)
				src.client:dir=SOUTH
			if(randz==2)
				src.client:dir=WEST
			if(randz==1)
				src.client:dir=EAST
		sleep(5)