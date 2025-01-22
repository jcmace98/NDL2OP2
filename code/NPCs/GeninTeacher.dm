mob/var/tmp/alreadytalkingtohim=0
//Leaf
mob/NPC/RandomNPCs/LeafVillagers/Academy
	Principle
		name="Principle(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Hair/SpikeyH.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
		//		var/style = "<style>BODY {margin:0;font:arial;background:black;\
		//			color:white;}</style>"
				if(usr.TimeToAttack<20)
					sd_Alert(usr, "I see you're learning well.","[src]")//,,,,0,"400x150",,style);return
				else
					sd_Alert(usr, "If you're ready to become a Genin you should take the exam!","[src]")//,,,,0,"400x150",,style)
					return

	GymTeacher1
		name="Gym Teacher: Kado(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
			//	var/style = "<style>BODY {margin:0;font:arial;background:black;\
			//		color:white;}</style>"
				if(usr.TimeToAttack==0)
					sd_Alert(usr, "Ah fresh meat! I love seeing them! How about you punch for me. You can punch by either pressing A or S. If you press A you will punch with your left hand while if you press S you will punch with your right hand!","[src]")//,,,,0,"400x150",,style)
					usr.client.screen+=new/obj/Effects/ASMash
					usr.TimeToAttack=1;return
				if(usr.TimeToAttack==1)
					sd_Alert(usr, "C'mon! It's not that hard, I'm sure you can punch!","[src]")//,,,,0,"400x150",,style);return
				if(usr.TimeToAttack==2)
					sd_Alert(usr, "Good! That was a pretty strong punch!","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Alright now I need you to kick!","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Kicking is as simple as Punching. Merely use the D macro and you will kick.","[src]")//,,,,0,"400x150",,style)
					usr.client.screen+=new/obj/Effects/DMash
					usr.TimeToAttack=3;return
				if(usr.TimeToAttack==3)
					sd_Alert(usr, "Having troubles?","[src]")//,,,,0,"400x150",,style);return
				if(usr.TimeToAttack==4)
					sd_Alert(usr, "Ah good! The three combat buttons are used in forms of taijutsu. You can even combo string them if you're good enough at taijutsu. Different taijutsu styles promote different attack functions for these and they can even be utilized with jutsu.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Now we need to move onto Running. Running in NFF is also another simple thing to do. All you have to do is press Running below on the interface. If you keep walking, don't fret, you'll slowly begin to increase in speed. Talk to me again once you reach maximum speed.","[src]")//,,,,0,"400x150",,style)
					usr.TimeToAttack=5;return
				if(usr.TimeToAttack==5)
					sd_Alert(usr, "You seem rather slow. Please don't tell me you're running.","[src]")//,,,,0,"400x150",,style);return
				if(usr.TimeToAttack==6)
					sd_Alert(usr, "Ah good. Now let's slow down a bit for something a bit more! Let's try out something more defensive! Show me your guarding stance!","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Guarding is done by holding down X. When you release X you stop guarding. Guarding can also be used to effectively dodge a target, by quickly releasing it you will dodge a hand-to-hand combat attack instantly. When guarding it reduces the damage of physical based attacks.","[src]")//,,,,0,"400x150",,style);usr.client.screen+=new/obj/Effects/XMash
					usr.TimeToAttack=7;return
				if(usr.TimeToAttack==7)
					sd_Alert(usr, "Well? Where is that guarding?","[src]")//,,,,0,"400x150",,style);return
				if(usr.TimeToAttack==8)
					sd_Alert(usr, "That's some good posing right there. I hope your chakra is as fierce too, show me what you got!","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "You can charge chakra by holding down Z.","[src]")//,,,,0,"400x150",,style)
					usr.client.screen+=new/obj/Effects/ZMash
					usr.TimeToAttack=9;return
				if(usr.TimeToAttack==9)
					sd_Alert(usr, "Well? Chakra?","[src]")//,,,,0,"400x150",,style);
					return
				if(usr.TimeToAttack>=10)
					sd_Alert(usr, "Great job! I love seeing really good novices!","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "I suggest you look around some bit if you want to learn some things. You may want to learn about Jutsu and how they work before moving on.","[src]")//,,,,0,"400x150",,style);
					return
	GymTeacher2
		name="Teacher: Kaylo(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Hair/leeH.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"

				if(usr.TimeToAttack>=10)
					sd_Alert(usr, "Hey there! Yo yo! I'm here to teach you about jutsu!","[src]",,,,0,"400x150",,style)
					var/list/buttons = list("What are Jutsu?","What is a Shape Transformation?","What is a Nature Transformation?","What are the Chakra Natures?","How do I get Chakra Natures?","Can I learn more than one Chakra Nature?","Cancel")
					var/A = sd_Alert(usr, "What would you like to know?","[src]", buttons, pick(buttons),0,0,"600x200",,style,4,2)
					if(A=="What are Jutsu?")
						sd_Alert(usr, "Jutsu are Ninja Discipline techniques. There are 3 main kind of jutsu: Taijutsu, Ninjutsu and Genjutsu.","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "Taijutsu techniques are hand-to-hand combat techniques. They utilized basically martial arts-based techniques where the user would utilize physical combat in harming the enemy. They're pretty much close-ranged but there are exceptions for everything! They're commonly based on your Physique.","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "Ninjutsu techniques are practically like chakra. They utilize chakra to create attacks and techniques such as Blowing fire. They're long ranged techniques. Their damage is normally based off of the Intensity of chakra in your body or as we call it your Capacity.","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "Genjutsu techniques is something a little different. These techniques are illusion techniques that affect the opponent's mind. They work by corrupting the opponent's chakra flow with your own chakra flow and corrupting what they see allowing for easy assassination but a horrible strategy when fighting alone. They're based off of your Control to utilize the Genjutsu..","[src]")//,,,,0,"400x150",,style)

					else if(A=="What is a Shape Transformation?")
						sd_Alert(usr, "Shape Transformation is an advanced form of chakra control primarily used for creating new jutsu and techniques. It changes the shape and movement of the chakra determining the size, range and purpose of the jutsu. Shape Manipulation is different from Nature Manipulation as Nature Manipulation actually changes the Nature of the chakra to create more advanced jutsu. Some ninja can utilize both Shape and Nature Manipulation to make really interesting techniques.","[src]")//,,,,0,"400x150",,style)

					else if(A=="What is a Nature Transformation?")
						sd_Alert(usr, "Nature Transformation applies an element to the chakra allowing the user to actually change the nature of a chakra, altering it's properties and characteristics..","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "There are 5 kind of Basic Nature Transformations noticed as the 5 Chakra Natures. These 5 types are the foundation of all Element jutsu.","[src]")//,,,,0,"400x150",,style)

					else if(A=="What are the Chakra Natures?")
						sd_Alert(usr, "The Chakra Natures are Earth Release(Doton), Fire Release(Katon), Wind Release(Fuuton), Lightning Release(Raiton) and Water Release(Suiton). Each chakra nature has a weakness toward other chakra nature and a strength to another making them equally powerful and purposeful for each use..","[src]")//,,,,0,"400x150",,style)

						sd_Alert(usr, "Earth Release techniques are strong against Water release techniques as it sucks up all the water but it is weak by the penetrating attacks of Lightning. Earth Release is considered one of the strongest defense and their techniques are not entirely great for offensive but great for defensive and supplementary techniques.","[src]")//,,,,0,"400x150",,style)

						sd_Alert(usr, "Water Release techniques are strong against Fire Release techniques as the water puts out the flames but it is weak against Earth Release techniques considering the earth sucks up the water. Water Release techniques is a pretty strong chakra nature considering it's versatile uses allowing the user to make pretty much anything with it considering the easy shape manipulation with water, but it primarily hits physically..","[src]")//,,,,0,"400x150",,style)

						sd_Alert(usr, "Fire Release techniques are strong against Wind Release Techniques as Wind fuems the flames of Fire but it is weak against Water Release Techniques considering the water puts it out. Fire Release are primarily the same in all forms, releasing flames from the user's mouth or some other parts of the body for even more advanced uses but they normally come from the user's mouth. Fire Release techniques are both dangerous to one's stamina and vitality as it burns and it can cause serious wounds.","[src]")//,,,,0,"400x150",,style)

						sd_Alert(usr, "Wind Release Techniques are strong against Lightning Release Techniques as the wind disperses the charges but it is weak against Fire Release techniques considering it boosts the strength of the Fire. Wind Release Techniques are considered the strongest, offensive chakra nature because Wind can be shaped to be as sharp and thin as possible, like a blade. They normally hit one's vitality but in a lot of cases Wind Release Techniques can hit stamina because of it being mere Chakra pressure..","[src]")//,,,,0,"400x150",,style)

						sd_Alert(usr, "Lightning Release Techniques are strong against Earth Release Techniques since the Lightning penetrates the earth but it is weak against Wind Release techniques since Wind disperses the charges. Lightning Release increases the high frequency vibrations of the user's chakra creating lightning. They're fast moving techniques that even allow piercing effects that hit straight to one's vitality, or even causing paralyzation through stunning. It is commonly infused into weapons to allow stronger sharpness through vibration..","[src]")//,,,,0,"400x150",,style)

					else if(A=="How do I get Chakra Natures?")
						sd_Alert(usr, "Everyone has an affinity towards one chakra nature. This characteristic is genetic, considering some Clans can be born with a certain type of Chakra nature, for example: Uchiha being born with Fire Release..","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "If you want to find out your Affinity you'll have to place your chakra into Chakra Paper. The Chakra Paper will respond based off of your Base Affinity.","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "If the paper burns, you have Fire Chakra. If the paper gets wet, you have Water Chakra. If the paper crumbles up, you have Lightning Chakra. If the paper turns to dirt, you have Earth Chakra. And if the Paper rips into two, you have Wind Chakra.","[src]")//,,,,0,"400x150",,style)
						sd_Alert(usr, "Mastering a chakra natures takes time to master even if your base affinity is that chakra nature..","[src]")//,,,,0,"400x150",,style)
					else if(A=="Can I learn more than one Chakra Nature?")
						sd_Alert(usr, "Yes, for most people you can learn more than one Chakra Nature although there are some cases where it's just impossible. Most Shinobi are capable of mastering at least Two Chakra natures and even three if they're an elite brand of Shinobi. Everyone is born with a natural amount of chakra natures you can learn simply because it's just so difficult. If you reach the maximum amount of chakra natures you can learn you just won't be able to learn anymore..","[src]")//,,,,0,"400x150",,style)

						sd_Alert(usr, "You can't begin to learn another Chakra Nature until you master your first Chakra nature, which is when your Elemental Knowledge reaches 1000..","[src]")//,,,,0,"400x150",,style)



				else
					sd_Alert(usr, "You should talk to the other gym teacher first! Haha.","[src]")//,,,,0,"400x150",,style)
					return
	GymTeacher3
		name="Gym Teacher: Radon(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Hair/MadaraH.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
		//		var/style = "<style>BODY {margin:0;font:arial;background:black;\
		//			color:white;}</style>"
				if(usr.TimeToAttack==10)
					sd_Alert(usr, "Hey there, I'm here to teach you about weapons.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Weapons are easy to utilize, trust me they are! First you'd start off by equipping a weapon to your Left Hand or Right Hand. I've given you a Kunai, check your Inventory by clicking Inventory at the bottom right and then equip it to either hands to move on with this excercise.","[src]")//,,,,0,"400x150",,style)
					var/counter=0
					for(var/obj/WEAPONS/Kunai/O in usr.contents)
						counter+=1
					if(counter<=0)
						var/obj/WEAPONS/Kunai/B=new()
						B.loc = usr
						B.ammount=1
						B.name= "[B.name] ([B.ammount])"
					usr.TimeToAttack=11
					return
				if(usr.TimeToAttack==11)
					sd_Alert(usr, "C'mon equip it to your hand! Don't worry it's not dangerous..","[src]")//,,,,0,"400x150",,style);return
				if(usr.TimeToAttack==12)
					sd_Alert(usr, "Good. Now you need to unsheath it. Unsheathing a weapon is done with Q and W. Q unsheaths the left weapon while W unsheaths the right weapon. Unsheathing a weapon allows you to utilize that weapon in combat, so you can sheath a weapon and do your physical combat then unsheath it to utilize it.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Unsheath the weapon.","[src]")//,,,,0,"400x150",,style)
					usr.TimeToAttack=13
					return
				if(usr.TimeToAttack==13)
					sd_Alert(usr, "C'mon you won't hurt yourself. Unsheath the weapon with Q or E..","[src]")//,,,,0,"400x150",,style);return

				if(usr.TimeToAttack==14)
					sd_Alert(usr, "Good. Now to try out the weapon I want you to throw it at that log over there. It's really easy. To throw the weapon press the button it corresponds to. If you equipped it to your right use the Right attack button. If you equipped it to your left use the Left Attack button. Try it out!","[src]")//,,,,0,"400x150",,style)
					usr.TimeToAttack=15
					return
				if(usr.TimeToAttack==15)
					sd_Alert(usr, "C'mon it's easy. Use the left or right attack buttons.","[src]")//,,,,0,"400x150",,style);return

				if(usr.TimeToAttack==16)
					sd_Alert(usr, "Great job. Looks like you understand how to utilize weapons. When it comes to throwing weapons using these buttons will throw the weapons but when it comes to actual close-ranged weapons, like katana, they'll primarily still have the same system.","[src]")//,,,,0,"400x150",,style)
					usr.TimeToAttack=17
					return

				sd_Alert(usr, "Good job. Keep learning everything, you're doing well!","[src]")//,,,,0,"400x150",,style)
	GymTeacher4
		name="Teacher: Statis(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Hair/JiraiyaH2.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"

				sd_Alert(usr, "Hey I'm here to teach you about your stats and how they affect combat?","[src]")//,,,,0,"400x150",,style)
				var/list/buttons = list("What is my Vitality?","What is my Chakra?","What is Stamina?","What are Calories?","How do I deal with Damage?","I'm Hungry/Thirsty, what do I do?","How do I increase my Health/Chakra/Stamina?","How do I level up?","What is a Passive?","How do I increase my passives?","Cancel")
				var/A = sd_Alert(usr, "What would you like to know?","[src]", buttons, pick(buttons),0,0,"600x200",,style,4,2)
				if(A=="What is Vitality?")
					sd_Alert(usr, "Vitality is your Health. If this reaches 0 you are knocked out. When your Stamina is full your Vitality will restore though, on the bright side.","[src]")//,,,,0,"400x150",,style)
				else if(A=="What is Chakra?")
					sd_Alert(usr, "Your Chakra is your energy source that allows to create Ninjutsu techniques and even genjutsu techniques. If you try to use a technique without any chakra normally it'll overstress it and pull straight from your stamina.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Don't fret though. Even without chakra you can still get it back by charging with Z. Charging your chakra takes straight from your Chakra Resevoir. Your chakra Resevoirs are basically like tanks allowing you to refill your chakra out from this resevoir. To replenish your resevoir you can eat or rest.","[src]")//,,,,0,"400x150",,style)
				else if(A=="What is Stamina?")
					sd_Alert(usr, "Stamina is your basic energy. Your stamina is required to do simple tasks and is primarily used for attacking. When hit with physical attacks normally they hit Stamina first. Once your Stamina reaches 0 it'll begin to hurt your Vitality directly so try to keep that in mind. Your stamina recovers on your own as long as you have calories.","[src]")//,,,,0,"400x150",,style)
				else if(A=="What are Calories?")
					sd_Alert(usr, "Calories are a source of energy utilized for Stamina. Normally all actions will take up Stamina but if you have calories they'll take up Calories first. Also without any calories you won't be able to regenerate. Eating and Drinking is a big part of keeping healthy and normally healthy foods consists of tons of healthy calories. Try to keep a moderate amount of calories at least, remember to occassionally eat because you can't see them so you can't be sure.","[src]")//,,,,0,"400x150",,style)

				else if(A=="How do I deal with Damage?")
					sd_Alert(usr, "<b>Part of being a ninja is understand you can get hurt.</b> No one is invincible, but some others are better at things than others. A lot of these things are pure genes. Everyone is born with a maximum of 1500 Vitality, while others are born with Chakra levels ranging from 1,000 to 10,000 and Stamina levels ranging from 1,000 to 7,000. But as you grow your Stamina increases along with your Chakra until you reach your decline age, which is normally 60.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "You won't be able to know how much of a stat you have but you can know how much of a percentage of that stat is left.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "With that you must understand which techniques would attack what Stat. It's very basic. Physical attacks would hit Stamina first, as Physical attacks can be endured but if deadly enough it can hit your Vitals..","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Attacks that are meant to hit the vitals or organs directly, such as Lightning or Sharp Objects would hit Vitality first. In most cases of Vitality hitting objects, they're all percentile based. No matter who you are, unless you have a jutsu guarding you against it, if I cut you with a knife you will take damage.","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Things like Lightning or Fire will hit towards vitality but at different damaging effects. Fire and Lightning damage is normally random between the attacks in damage. <b>Things that are hurting you through sharp features will normally be percentile based.</b>.","[src]")//,,,,0,"400x150",,style)

				else if(A=="I'm Hungry/Thirsty, what do I do?")
					sd_Alert(usr, "You eat or drink. The purpose of eating is for not only filling up your stomach but also to increase your calories allowing for more actions. Since you can't see calories you just have to assume you have enough based off of whether or not you're recovering nicely. ","[src]")//,,,,0,"400x150",,style)
					sd_Alert(usr, "Try not to overeat. It's bad for you and you can vomit from it. ","[src]")//,,,,0,"400x150",,style)

				else if(A=="How do I increase my Health/Chakra/Stamina?")
					sd_Alert(usr, "As you increase with age, your Chakra and Stamina will just naturally get better. Your Vitality will never change, it'll always be 1500. In worst case scenario the vitality number can actually even drop. This is essentially not so different considering you'll still die to the same amount of slashes but attacks like Lightning would kill you faster. When getting strong things still look out for their cost. ","[src]")//,,,,0,"400x150",,style)

				else if(A=="How do I level up?")
					sd_Alert(usr, "Level up? Ninja don't level up or have humans. This game is a passive based game and skill-based. If anything it's far from levels because that can take a lot away from skills. A strong ninja is just a ninja that is really skillful. Imagine it like everyone with the same things, slightly except with different perks in different fields that allow them to have advantages. Every ninja is different and self-improvement is done in terms of passives. ","[src]")//,,,,0,"400x150",,style)

				else if(A=="What is a Passive?")
					sd_Alert(usr, "A Passive is your skill in a certain thing. Having a passive maxed shows you are essentially good at it and it also allows you to be good at things passively. This game doesn't require levels but instead you train your passives to get better. One of the most basic Passives are Reflex and Swift. Reflex for example would make you dodge more while Swift would increase your punching speed. ","[src]")//,,,,0,"400x150",,style)

				else if(A=="How do I increase my passives?")
					sd_Alert(usr, "You increase your passives by training them. To figure out how to train a passive you'd access your Passive Tree and look into them. It normally explains how to train a passive within those fields. ","[src]")//,,,,0,"400x150",,style)
	GymTeacher5
		name="Teacher: Juto(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Hair/ShikamaruH.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"

				sd_Alert(usr, "Hey I'm here to teach you about jutsu and learning them!","[src]",,,,0,"400x150",,style)
				var/list/buttons = list("How do I learn Jutsu?","Help me Learn my First Jutsu?","Why does my Jutsu keep failing?","Where can I learn more jutsu?","Cancel")
				var/A = sd_Alert(usr, "What would you like to know?","[src]", buttons, pick(buttons),0,0,"600x200",,style,4,2)
				if(A=="How do I learn Jutsu?")
					sd_Alert(usr, "Learning Jutsu is easy. All you have to do is go and find a way to hear or learn about the jutsu to begin with and once you do train in that certain field until you reach the maximum exp. For example, if you're learning Clone Jutsu then you train until you reach the maximum EXP and then bam you have the jutsu!","[src]",,,,0,"400x150",,style)

					sd_Alert(usr, "Unless the Jutsu came to you automatically, after learning a Jutsu you will go through a delay which is equivalent to the time it took to learn the jutsu in seconds. Other things can affect the cooldown delay to make it go down faster. <b>Use this time to master your jutsu or any passives instead of sitting there waiting to learn more.</b>","[src]",,,,0,"400x150",,style)

				else if(A=="Help me Learn my First Jutsu?")
					sd_Alert(usr, "I'm generous, why not! I'll help you learn your first jutsu. Clone Jutsu.","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "When about to be taught a technique a box will come in asking you if you'd like to learn the technique with the description and EXP available. You can't learn a jutsu you already know twice of course.","[src]",,,,0,"400x150",,style)

					usr.LearnJutsu("Bunshin No Jutsu",200,"BunshinJutsu","Bunshin No Jutsu is a basic clone technique that creates an image of yourself. It is not real but can be used for distraction purposes.","Ninjutsu")

				else if(A=="Why does my Jutsu keep failing?")
					sd_Alert(usr, "In order to stop your jutsu from failing you have to master it! This is difficult but basically mastering a jutsu would be about 100 uses of the technique. The more you sue a technique the higher chance you have at using it correctly but failing doesn't incoporate a delay at all it just increases annoyance when trying to click the Skillcard.","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "Another factor is that Jutsu require a certain thing to be on or working to work. Handseal Mastery for example is a passive that makes it so your hands don't slip when performing a jutsu. This is something you want to master and it's relatively fast. Remember some jutsu evolve the more you use them so using them is a good thing to do.","[src]",,,,0,"400x150",,style)

				else if(A=="Where can I learn more jutsu?")
					sd_Alert(usr, "Woaaah, calm down there Tiger! First you'll have to learn your Basic jutsu. Clone Jutsu, Transformation Jutsu and Subsitution Jutsu to pass the academy.","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "But to answer your questions, people teach you jutsu. You can learn from NPC Teachers roaming around your village or even around the world that teach techniques. You can also learn a jutsu from a scroll or universal basic ninja skills can be learnable through the Passive Tree in the Jutsu section.","[src]",,,,0,"400x150",,style)
	GymTeacher6
		name="Teacher: Choordo(NPC)"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Hair/ShikamaruH.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
				var/style = "<style>BODY {margin:0;font:arial;background:black;\
					color:white;}</style>"

				if(usr.TimeToAttack==17)
					sd_Alert(usr, "I'll teach you the basics of coordinations!","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "Basically, for us Ninja we seperate coordinations into two simple things.","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "There's an X coordination and a Y coordination. Whever you're located on the map is where exactly the coordination leads to.","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "So imagine a map as a giant graph and divide in into squares. Let's say you're on that first square, that's 1x and 1y.","[src]",,,,0,"400x150",,style)
					sd_Alert(usr, "Now let's say you move to the right, now you're on x2 and y1. But not you move up one and you're on x2 and y2. It's simple really!","[src]",,,,0,"400x150",,style)
				if(usr.TimeToAttack==18)
					sd_Alert(usr, "Now that you've understand I feel like I've fully gotten to my students! Such a beautiful moment, remember me!","[src]",,,,0,"400x150",,style)
					return
				else
					sd_Alert(usr, "You should talk to the other teachers first!","[src]",,,,0,"400x150",,style)

obj/Exams
	icon = 'Test.dmi'
	var
		PointsRequiredToPass=10
	GeninExam
		dir=SOUTH
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(src in get_step(usr,usr.dir))
				var/HaveClone=0
				var/HaveSubsitution=0
				var/HaveTransformation=0
				for(var/obj/SkillCards/BunshinJutsu/A in usr.LearnedJutsus)
					HaveClone=1
				for(var/obj/SkillCards/Kawarimi/A in usr.LearnedJutsus)
					HaveSubsitution=1
				for(var/obj/SkillCards/Henge/A in usr.LearnedJutsus)
					HaveTransformation=1
					usr<<"You aren't even able to navigate. You should learn how to do this before you take the test!";return
				if(!HaveTransformation)
					usr<<"You need to learn Transformation Jutsu first!";return
				if(!HaveSubsitution)
					usr<<"You need to learn Subsitution Jutsu first!";return
				if(!HaveClone)
					usr<<"You need to learn Clone Jutsu first!";return
				if(usr.Genintest)
					return
				if(usr.rank!="Student")
					usr<<"You've already done the test!";return
				usr.Frozen=1
				usr.Genintest=1
				usr.score=1
				switch(input(usr,"What is Taijutsu?","Test",) in list("Illusion","Long-Ranged Combat","Hand-To-Hand Combat"))
					if("Hand-To-Hand Combat")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What is Ninjutsu?","Test",) in list("Hand-To-Hand Combat","Illusion","Long-Ranged Combat"))
					if("Long-Ranged Combat")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What is Genjutsu?","Test",) in list("Long-Ranged Combat","Hand-To-Hand Combat","Illusion"))
					if("Illusion")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What is the X Coordinate?","Test",) in list("Left and Right","Up and Down","Diagonals","None Of The Above"))
					if("Left and Right")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How do you learn Jutsu?","Test",) in list("Gaining EXP","Killing People","Going on Quests"))
					if("Gaining EXP")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What are passives?","Test",) in list("A person's skills","A person's techniques","A person's soul!!!"))
					if("A person's skills")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"Which weapon would logically hit percentile based?","Test",) in list("Bo-Staff","Katana","Nunchuks","All Of The Above","Niether"))
					if("Katana")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How much damage would a Kunai do?","Test",) in list("Percentile","100 Damage always","Depends on the Ninja's Capacity","Depends on the Ninja's Physique","Depends on the Ninja's Control"))
					if("Percentile")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What is required in making Ninjutsu techniques?","Test",) in list("Shape Manipulation","Nature Manipulation","Chakra","Determination","All of the Above"))
					if("All of the Above")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How long do you have to wait for a Learning Cooldown?","Test",) in list("1 Day","1 Age","16 Minutes","Depends on the Jutsu","35 Minutes"))
					if("Depends on the Jutsu")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"Which one of these is considered Nature Manipulation?","Test",) in list("Katon Jutsu","Genjutsu","Taijutsu","Kenjutsu"))
					if("Katon Jutsu")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How many Chakra Natures does an average ninja is able to utilize?","Test",) in list("1","2","3","4","5","6"))
					if("2")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"Why does Wind Release beat Lightning Release?","Test",) in list("It breaks the lightning in two","It disrupts the chakra","It seperates the eletrical charges","It just does"))
					if("It seperates the eletrical charges")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How does someone utilize Lightning Release?","Test",) in list("By Vibrating their chakra at high frequencies","By turning their chakra white and sparky","By making their chakra random and unpredictable"))
					if("By Vibrating their chakra at high frequencies")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How would you throw a weapon?","Test",) in list("Double Click it","Equip it to a hand, unseath it then attack","You don't","By pressing G"))
					if("Equip it to a hand, unseath it then attack.")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What passive determines your ability to perform handseals correctly?","Test",) in list("Handseal Skill","Handseal Mastery","Handseal Proficiency","Handseal Speed"))
					if("Handseal Mastery")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"How can someone be casted under a Genjutsu?","Test",) in list("By making them smell bad smells","By corrupting their chakra with their own chakra","By using psychological tricks"))
					if("By corrupting their chakra with their own chakra")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"A ninja can have a maximum of how many chakra natures?","Test",) in list("1","2","3","4","5","Depends on The Ninja"))
					if("Depends on The Ninja")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"What reduces damage of Physical attacks?","Test",) in list("Guarding","Passives","All Of The Above","Nothing"))
					if("Guarding")
						usr.score+=1
					else
						usr.score+=0
				switch(input(usr,"Are you ready to become a Genin and start the game?","Test",) in list("Yes","No!!!"))
					if("Yes")
						usr.score+=1
					else
						usr.score-=10
				var/Score=0
				if(usr.score!=0)
					Score=(usr.score/20)*100
				usr<<"You've finished your test with a [Score]!!!."
				usr.Frozen=0
				if(Score>=70)
					usr<<"<font size=2><b><font color=yellow>Congratulations you have passed the Genin Exam with [Score] Points!"
					for(var/mob/M in world)
						if(M.Village==usr.Village)
							M<<"<font color = #BB0EDA>Village Information:</font> [usr] has passed the Genin Exam and has become apart of the village!"
					usr.rank ="Genin"
					usr.Genintest=0
					usr.score=0
					var/obj/Clothes/Headband/B=new();B.loc=usr
					usr<<"You were given a couple of items to start your Genin career."
					if(usr.Clan=="Uchiha")
						var/obj/Clothes/Uchiha_Crest/C = new()
						C.loc = usr
						usr.gottenuchihacrest=1
						usr<<"You've been given an Uchiha Crest Symbol to place on your clothing and show your clan pride."
					var/obj/WEAPONS/Kunai/A=new();A.ammount=10;A.loc=usr
					var/obj/WEAPONS/Shuriken/C=new();C.ammount=10;C.loc=usr
					usr.Yen+=1000
					usr.move=0
	//Leaf
					if(usr.Clan=="Aburame")
						usr.loc=locate(21,36,11)
					if(usr.Clan=="Akimichi")
						usr.loc=locate(61,22,11)
					if(usr.Clan=="Fuuma")
						usr.loc=locate(144,170,6)
					if(usr.Clan=="Hoshigaki")
						usr.loc=locate(152,125,6)
					if(usr.Clan=="Hyuuga")
						usr.loc=locate(174,40,11)
					if(usr.Clan=="Nara")
						usr.loc=locate(25,69,11)
					if(usr.Clan=="Kusakin")
						usr.loc=locate(93,143,12)
	//Sound
					if(usr.Clan=="Uchiha")
						usr.loc=locate(150,52,4)
					if(usr.Clan=="Kumojin")
						usr.loc=locate(151,184,4)
					if(usr.Clan=="Kaguya")
						usr.loc=locate(172,43,5)
					else
						if(usr.Village=="Terra")
							if(prob(50))
								usr.loc=locate(65,57,11)
							else
								usr.loc=locate(46,172,14)
						if(usr.Village=="Leaf")
							usr.loc=locate(65,57,11)
						if(usr.Village=="Rain")
							usr.loc=locate(111,170,6)
						if(usr.Village=="Sound")
							usr.loc=locate(119,130,4)
						if(usr.Village=="Rock")
							usr.loc=locate(46,172,14)
				else
					usr<<"You've failed the Genin Exam!"
					usr<<"You'll be able to take the test again in 5 minutes!"
					spawn(3000)
						usr.Genintest=0

//Sound
mob/var/TalkedToIntroductionTeacher=0
mob/var/tmp/TakingTest=0
obj/TestBook
	name="Math State"
	icon = 'Map/Turfs/Landscapes.dmi'
	icon_state="Book"
	verb/Command()
		set src in oview(1)
		set name="Command"
		set hidden=1
		if(src in get_step(usr,usr.dir))
			if(src in get_step(usr,usr.dir))
				if(usr.alreadytalkingtohim)
					return
				else
					usr.alreadytalkingtohim=1
					switch(input(usr,"Are you going to take the test? It costs 20 yen just to start it, but you can end up gaining more money! Maybe even experience and special items!", text) in list ("Yes","No"))
						if("Yes")
							if(usr.Yen>20)
								usr.TakingTest=1
								usr.Yen-=20
								var/Questionnumber=0
								TestTake
									var/X=rand(1,100)
									var/Z=rand(1,100)
									var/Answer=X-Z
									Questionnumber+=1
									var/Question=input(usr,"Question Number [Questionnumber]! What is [X]-[Z]?","Answer?") as num
									if(Question==Answer)
										var/YenGain=2*Questionnumber
										if(YenGain>100) YenGain=100-rand(-15,15)
										usr<<"Correct! [YenGain] Yen!"
										usr.Yen+=YenGain
										if(Questionnumber>35)
											var/EXPGain=5*Questionnumber
											if(EXPGain>250) EXPGain=250-rand(-25,25)
											usr<<"You gain an EXP Bonus of [EXPGain]!"
											usr.exp+=EXPGain
										goto TestTake
									else
										usr<<"Incorrect! Sorry, you lose!";usr.alreadytalkingtohim=0;return
							else
								usr<<"You don't have enough money!";usr.alreadytalkingtohim=0;return
						if("No")
							usr.alreadytalkingtohim=0









obj
	StudentBook
		name = "Student Guide 101"
		icon = 'Map/Turfs/Landscapes.dmi'
		icon_state="Book"
		verb
			Readzzz()
				set src in oview(1)
				set name="Read Book"
				set category="Book"
				var/tmp
					html
				if(usr.HaveToReadBook)
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
						<title>Student 101 Guide</title>
						</head>
						<body bgcolor=#f5f5f5 text=#000000>
						<center><h2>Page 200</h2></center><hr>
						<br>	The world of ninja is a vast world that all Ninja must understand, but the first thing you must understand as a ninja is that they are not invincibile. A ninja can easily die to anything, which is what the purpose of Ninjutsu is. There are a lot of jutsu in this world, but it is divided into 3 categories. Ninjutsu, Taijutsu and Genjutsu. Ninjutsu is the prime of Shinobi, where as you can kill an enemy from a far distance with a powerful attack and keep yourself unharmed. Next there is Taijutsu, which is more dangerous than Ninjutsu to the user, normally. Taijutsu is close, hand-to-hand combat. Different ninja have different variant of taijutsu, and like Ninjutsu a lot of Taijutsu exist in the world. Genjutsu on the other hand is rather different, Genjutsu is more widespread and harder to handle considering it is an Illusion technique. It puts a test on a Ninja's reality, and they have to figure out how to counter the technique before they can have some serious damage on them. There aren't as many Genjutsu in the world as there are Ninjutsu, though.
						<br>
						<br>	There are also more complicated arts that can't be discussed in the Academy, of course you can always read the Libraries to understand even more. We shall explain the situation of being a ninja.
						<br>
						<center><h2>Page 201</h2></center><hr>
						<br>	Techniques ranging around the Ninja world differ, but a Ninja must understand themselves before they can understand the enemy. A ninja has three vital stats, these stats are Vitality, Stamina and Chakra. These stats are all important, and if ignored can lead to a ninja's demise. The first stat to worry about is Vitality. Vitality is your health stat and probably the most important. If this reaches zero, you die, except for some special occasions. After that, there is Chakra. Chakra is what is used to make up techniques. Since Chakra can't be used in incredible ressecion without you having to charge it back, it's dangerous what kind of techniques you use because they may deplete your chakra which can be very dangerous for you. Stamina on the other hand is your energy and you need it for a variant of things, but it's good you keep your stamina up, for if your stamina is ever lowered down, you'll be too slow for anything and you can immediately be killed by an enemy.
						<br>
						<br>	After that, there is Chakra Control. Every Ninja needs Chakra Control so they can easily control the Chakra around their body. Without it, they'd be doomed. The amount of Chakra you charge back, you gain based off of your Chakra Control, so having a lot makes it better for you if you have low chakra.
						<br>
						<br>	A ninja's supplies are also very important. Weapons are a vital part of a ninja, for there are certain things a Ninja can not defend from without techniques. Weapons such as Kunai, Shurikens or even Swords all do percentile damage upon a ninja. Along with things like explosions, so both the user and enemy must realize this if they want to go out in the world to fight. Because they do percentile based damage directly onto the Vitality, they are rather dangerous and can exterminate an enemy immediately. While Physical attacks can be more useful if you're strong enough to land a Clean Blow and powerful one. Because these are Physical, it is based purely on the user's stats, so if they are a strong person they can end the match right there and then. Physical Attacks branch into two categories. They either attack Vitality directly, or they attack Stamina directly. Sometimes they can attack both! If your stamina is depleted, don't forget, it'll start hurting your health. Sometimes you may even be stunned by the damage you gain from an attack, so be very careful, a simple attack can be your last.
						<br>
						<br>	In order to buy supplies, a Ninja must always have money too. They need to be fully fed, and fully hydrated otherwise they will never be at their best. If they are not fully hydrated or fully nourished, they may die in battle even. To get money, a Ninja usually has to do missions and tasks for others to gain money. They can sell things to others or even gain money from the hefty task of Bounties. It's a big world, find out the best way to get money.
						<br>
						<br>	It's adviced for ninja to be ready for any event. Always keep weapons on you at all times, because it is expected other ninja will have weapon too. And after keeping weapons on you, be sure to always train yourself in case these weapons don't work. Think out of the box and learn your jutsu as if it was a part of your body, master it and you have nothing to worry about. Just make sure you don't ever get over your head and never unestimate your enemy, they may be fooling you.
						<center><h2>Page 202</h2></center><hr>
						<br>	As we reach the final page, there is something else that must be discussed. Every Ninja is different in every single way, in skills and arts. Some Ninja are <i>more</i> different than others, but that's something you must understand as a person. When you are born, each ninja has different potential and different stat growth that can't be controlled. Of course you can always still train yourself in certain arts so you grow the way you like, but there are certain things you can not pass by.
						<br>
						<br>	All Ninja must understand that as their limitations, but also their strength. In learning techniques, there is also something else. The Passive Tree and the Skill Tree. The Passive Tree is a tree that allows you to advance in your passives. Passives are things that allow you to enhance your Ninja Skills and help better things easier, such as Punching faster or releasing the Cooldown in between Ninjutsu Techniques. After that there is the Jutsu Tree, which allows you learn Basic Ninjutsu Techniques such as Kawarimi that everyone can learn. The Passive Tree will be a lot more useful, but primarily to learn any technique you must go out in the world and find out about it yourself from either a Teacher, a Book or even learning/creating it on your own.
						<br>
						<br>	In order to buy a Passive or Jutsu, you require Skill Points. Everytime you level up you gain at least 1 Skill Point. People are different, so they may get different amount of Skill Points. In order to level up, though, you must have your EXP equal to your Max EXP. It gets harder to level up, so by theory you can learn every jutsu in the world but it'll get difficult. It is best you concentrate on one thing instead of trying to learn everything, for not even Geniuses can concentrate on all. Sometimes, learning a Jutsu will prohibit you from learning another, also. Teachers are human too, so they may also be ignorant and not teach you merely because of your Clan or even to a simple thing such as Level.
						<br>
						<br>	Everytime you level you up, you gain a Level Point. You can use this Level Point to add onto your skills further, by adding to things that affect your initial growth. This is very helpful is building your character.
						<br>
						<br>	This is where the Guide Ends. I hope you learned a lot, this guide doesn't explain everything about the game though but it does explain some of the reading tactics. You won't have to read on forever though, it ends here.
						</body>
						</html>
						"}
					usr << browse("[Stuffz][html]","size=576x576,window=Student Info Guide 101")
					usr.ReadBook=1
					usr.HaveToReadBook=0
				else
					alert("You already read it! You don't want to read it again!","[src]")
					return






//////////////////////////////////////////
mob/Teachers/AcademyTeacher
	LeafAcad1
		name = "Jigetsu, Amano"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/narutoH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,100,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb
			Speak()
				set src in oview(1)
				set category="NPC"
				switch(alert("Welcome to the academy, I am the Teacher here. Is this your first time here?","[src]","Yes","No"))
					if("Yes")
						if(!usr.rank=="Student")
							alert("But you are a Genin? You're not a student!","[src]")
						else
							if(usr.LearnedAcademy)
								alert("Didn't I tell you head to the teacher to begin your first lesson?","[src]")
							else
								alert("Well welcome to the academy! To begin, first we must begin teaching you all we can! Head up to the teacher in the first classroom on the left so we may begin.","[src]")
								usr.LearnedAcademy=1
	LeafAcad2
		name="Hakudou, Kujo"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/shikaH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb
			Speak()
				set src in oview(1)
				set category="NPC"
				if(usr.rank=="Student")
					if(usr.ReadBook)
						alert("Good! Now head to Romanji over there so he can teach you about Ninja fighting! He's in the room to the right of me.","[src]")
						if(usr.TimeToLearnNinjutsu>=2)
							alert("Oh, you already talked to him? Then take the test after you reach the appropriate level!","[src]");return
						usr.TimeToLearnNinjutsu=1;return
					if(usr.HaveToReadBook)
						alert("You didn't read it yet! I'm watching you! Go there and read it or you'll never become a Genin!","[src]")
						return
					if(usr.LearnedAcademy&&!usr.HaveToReadBook&&!usr.ReadBook)
						switch(alert("Did Amano send you?","[src]","Yes","No"))
							if("Yes")
								alert("Let's begin. First I want you to open your books to page 200 and read to page 202. It'll be a quick read. After that come back to me.","[src]")
								usr.HaveToReadBook=1
								return
					else
						alert("You should go talk to the ninja down there.","[src]")
						return
				else
					alert("It's always great to see students all grown up.","[src]")
					return
	LeafAcad3
		name="Romanji"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,100)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb
			Speak()
				set src in oview(1)
				set category="NPC"
				if(usr.alreadytalkingtohim)
					return
				usr.alreadytalkingtohim=1
				if(usr.rank=="Student")
					if(usr.TimeToLearnNinjutsu==1)
						if(usr.TimeToAttack2)
							if(usr.TimeToAttack)
								alert("What are you waiting for? Are you a Pacifist?","[src]")
								usr.alreadytalkingtohim=0
								return
							else
								alert("Good! You should know, A is left hand attack, S is right hand attack, and D is to kick. You can equip items to either of your hands and use them accordingly. Now it's time for a little counter tactics. To Counter, click C.","[src]")
								usr.TimeToCounter2=1
								usr.TimeToAttack2=0
								usr.alreadytalkingtohim=0
								return
						if(usr.TimeToCounter2)
							if(usr.TimeToCounter)
								alert("What are you waiting for? Are you a Pacifist?","[src]")
								usr.alreadytalkingtohim=0
								return
							else
								alert("Good! Now it may not look like it had done anything, but if you were hit by that time you would have Evaded into another direction. It's a sure fire way of dodging attacks. Now Guarding is a attack that resists you from Stamina based attacks by increasing your Endurance. To Guard, click X..","[src]")
								usr.TimeToCounter2=0
								usr.TimeToGuard2=1
								usr.alreadytalkingtohim=0
								return
						if(usr.TimeToGuard2)
							if(usr.TimeToGuard)
								alert("What are you waiting for? Are you a Pacifist?","[src]")
								usr.alreadytalkingtohim=0
								return
							else
								alert("Good! Now one final thing. By holding down Z, you will charge chakra! You charge Chakra based off of your Chakra Control, and it's the way to gain Chakra back! It also gives EXP! Go ahead, try it!","[src]")
								usr.TimeToGuard2=0
								usr.TimeToCharge2=1
								usr.alreadytalkingtohim=0
								return
						if(usr.TimeToCharge2)
							if(usr.TimeToCharge)
								alert("What are you waiting for? Are you a Pacifist?","[src]")
								usr.alreadytalkingtohim=0
								return
							else
								alert("Good! Now I think you need more time in experience as a student. I think you should go flex the muscles, but first I will give you 3 Skill Points. What I want you to do is learn Bunshin No Jutsu, Kawarimi No Jutsu and Henge No Jutsu. You can't learn any other techniques without it.","[src]")
								usr.TimeToCharge2=0
								usr.TimeToLearnNinjutsu=2
								usr.alreadytalkingtohim=0
								return
						alert("Ah yes! I always enjoy seeing new Students here and there! Anyways, let's begin! First we must teach you how to fight!","[src]")
						alert("The first aspect of fighting is attacking of course! Punching, Kicking, all that good stuff. Try it, Click A, S or D and you should attack!","[src]")
						usr.TimeToAttack2=1
						usr.TimeToAttack=1
						usr.alreadytalkingtohim=0
						return
					else
						alert("Hope you tried out some training tactics!","[src]")
						usr.alreadytalkingtohim=0
						return
				else
					alert("Haha! So you're a [usr.rank], eh?! Great, I'm a Teacher!","[src]")
					return
	LeafAcad4
		name="Hito, Jigui"
		icon='Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon2"
		CNNPC=1
		Village="Leaf"
		health = 9999999999999999999999999999999999999999999999
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='ThreadsH.dmi'
				Base+=rgb(111,55,0)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb
			Speak()
				set src in oview(1)
				set category="NPC"
				if(usr.rank=="Student")
					alert("Hope you know the ways you can train! I prefer training on logs, but many train by wasting their chakra and charging it back! You can train by Sparring, everytime you hit someone you gain EXP based off of the damage you did sometimes! You can gain EXP from reading, even! But Reading sounds really boring.","[src]")
					alert("I suggest Sparring, experience is the best way to train!","[src]")
					return
				else
					alert("So you surely know how to train, right?","[src]")
					return