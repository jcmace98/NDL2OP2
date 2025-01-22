/* sd_Alert library
	by Shadowdarke (shadowdarke@byond.com)

	sd_Alert() is a powerful and flexible alternative to the built in BYOND
	alert() proc. sd_Alert offers timed popups, unlimited buttons, custom
	appearance, and even the option to popup without stealing keyboard focus
	from the map or command line.

	Please see demo.dm for detailed examples.

FORMAT
	sd_Alert(who, message, title, buttons, default, duration, unfocus, \
		size, table, style, tag, select, flags)

ARGUMENTS
	who			- the client or mob to display the alert to.
	message		- text message to display
	title		- title of the alert boxf
	buttons		- list of buttons
					Default Value: list("Ok")
	default		- default button selestion
					Default Value: the first button in the list
	duration	- the number of ticks before this alert expires. If not
					set, the alert lasts until a button is clicked.
					Default Value: 0 (unlimited)
	unfocus		- if this value is set, the popup will not steal keyboard
					focus from the map or command line.
					Default Value: 1 (do not take focus)
	size		- size of the popup window in px
					Default Value: "300x200"
	table		- optional parameters for the HTML table in the alert
					Default Value: "width=100% height=100%" (fill the window)
	style		- optional style sheet information
	tag			- lets you specify a certain tag for this sd_Alert so you may manipulate it
					externally. (i.e. force the alert to close, change options and redisplay,
					reuse the same window, etc.)
	select		- if set, the buttons will be replaced with a selection box with a number of
					lines displayed equal to this value.
					Default value: 0 (use buttons)
	flags		- optional flags effecting the alert display. These flags may be ORed (|)
					together for multiple effects.
						SD_ALERT_SCROLL			= display a scrollbar
						SD_ALERT_SELECT_MULTI	= forces selection box display (instead of
													buttons) allows the user to select multiple
													choices.
						SD_ALERT_LINKS			= display each choice as a plain text link.
													Any selection box style overrides this flag.
						SD_ALERT_NOVALIDATE		= don't validate responses
					Default value: SD_ALERT_SCROLL
						(button display with f bar, validate responses)
RETURNS
	The text of the selected button, or null if the alert duration expired
	without a button click.

Version 1 changes (from version 0):
* Added the tag, select, and flags arguments, thanks to several suggestions from Foomer.
* Split the sd_Alert/Alert() proc into New(), Display(), and Response() to allow more
	customization by developers. Primarily developers would want to use Display() to change
	the display of active tagged windows

*/


#define SD_ALERT_SCROLL			1
#define SD_ALERT_SELECT_MULTI	2
#define SD_ALERT_LINKS			4
#define SD_ALERT_NOVALIDATE		8

proc/sd_Alert(client/who, message, title, buttons = list("Ok"),\
	default, duration = 0, unfocus = 1, size = "300x200", \
	table = "width=100% height=100%", style, tag, select, flags = SD_ALERT_SCROLL)

	if(ismob(who))
		var/mob/M = who
		who = M.client
	if(!istype(who)) CRASH("sd_Alert: Invalid target:[who] (\ref[who])")

	var/sd_alert/T = locate(tag)
	if(T)
		if(istype(T)) del(T)
		else CRASH("sd_Alert: tag \"[tag]\" is already in use by datum '[T]' (type: [T.type])")
	T = new(who, tag)
	if(duration)
		spawn(duration)
			if(T) del(T)
			return
	T.Display(message,title,buttons,default,unfocus,size,table,style,select,flags)
	. = T.Response()

sd_alert
	var
		client/target
		response
		list/validation

	Del()
		target << browse(null,"window=\ref[src]")
		..()

	New(who, tag)
		..()
		target = who
		src.tag = tag

	Topic(href,params[])
		if(usr.client != target) return
		response = params["clk"]

	proc/Display(message,title,list/buttons,default,unfocus,size,table,style,select,flags)
		if(unfocus) spawn() target << browse(null,null)
		if(istext(buttons)) buttons = list(buttons)
		if(!default) default = buttons[1]
		if(!(flags & SD_ALERT_NOVALIDATE)) validation = buttons.Copy()

		var/html = {"<head><title>[title]</title>[style]<script>\
		function c(x) {document.location.href='BYOND://?src=\ref[src];'+x;}\
		</script></head><body onLoad="fcs.focus();"\
		[(flags&SD_ALERT_SCROLL)?"":" scroll=no"]><table [table]><tr>\
		<td>[message]</td></tr><tr><th>"}

		if(select || (flags & SD_ALERT_SELECT_MULTI))	// select style choices
			html += {"<FORM ID=fcs ACTION='BYOND://?' METHOD=GET>\
				<INPUT TYPE=HIDDEN NAME=src VALUE='\ref[src]'>
				<SELECT NAME=clk SIZE=[select]\
				[(flags & SD_ALERT_SELECT_MULTI)?" MULTIPLE":""]>"}
			for(var/b in buttons)
				html += "<OPTION[(b == default)?" SELECTED":""]>\
					[html_encode(b)]</OPTION>"
			html += "</SELECT><BR><INPUT TYPE=SUBMIT VALUE=Submit></FORM>"
		else if(flags & SD_ALERT_LINKS)		// text link style
			for(var/b in buttons)
				var/list/L = list()
				L["clk"] = b
				var/html_string=list2params(L)
				var/focus
				if(b == default) focus = " ID=fcs"
				html += "<A[focus] href=# onClick=\"c('[html_string]')\">[html_encode(b)]</A>\
					<BR>"
		else	// button style choices
			for(var/b in buttons)
				var/list/L = list()
				L["clk"] = b
				var/html_string=list2params(L)
				var/focus
				if(b == default) focus = " ID=fcs"
				html += "<INPUT[focus] TYPE=button VALUE='[html_encode(b)]' \
					onClick=\"c('[html_string]')\"> "

		html += "</th></tr></table></body>"

		target << browse(html,"window=\ref[src];size=[size];can_close=0")

	proc/Response()
		var/validated
		while(!validated)
			while(target && !response)	// wait for a response
				sleep(2)

			if(response && validation)
				if(istype(response, /list))
					var/list/L = response - validation
					if(L.len) response = null
					else validated = 1
				else if(response in validation) validated = 1
				else response=null
			else validated = 1
		spawn(2) del(src)
		return response
///////////////////////////////////////////////////////////////////////////////////////////
mob/Teachers/
	Leaf_Katon_Teacher
		name = "Shi Armaketti"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
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
			usr<<"Hello, I am one of the strongest Fire-Natured Jounin in all of the village. But I also take my time to teach ninja techniques."
			sleep(3)
			if(usr.FireE)
				var/katonknow = input("Tell me what Katon technique you would you like to learn?","Katon Technique")
				if(findtext(katonknow,"hikibou",1,0))
					usr.LearnJutsu("Katon Hikibou No Jutsu",0,"Hikibou","Katon Hikibou No Jutsu is a technique where the user heats the air around the target. After heating the air, that region will combust in flames. It is very useless at the beginning, but the more you use it the stronger it gets.","Katon")
				if(findtext(katonknow,"goukakyuu",1,0)||findtext(katonknow,"fireball",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Your rank is too low to learn this technique.";return
					usr.LearnJutsu("Katon Goukakyuu No Jutsu",0,"Goukakyuu","Katon Goukakyuu No jutsu is a field ranged jutsu that releases fire from the mouth. It covers a small radius, that can improve, so it can be very useful in combat.","Katon")
				if(findtext(katonknow,"housenka",1,0)||findtext(katonknow,"phoenix flower",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Housenka No Jutsu",0,"Housenka","Katon Housenka No Jutsu is a jutsu that shoots multiple fire balls from the mouth that explode in fire on contact of a target.","Katon")
				if(findtext(katonknow,"ryuuka",1,0)&&findtextEx(katonknow,"Gouryuuka",1,0)==0||findtext(katonknow,"dragon fire",1,0))
					if(usr.KatonKnowledge<75)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Ryuuka No Jutsu",0,"Ryuuka","Katon Ryuuka No Jutsu is a concentrated form of Karyuu Endan that shoots a concentrated blast that explodes on contact of a physical object.","Katon")
			//	if(findtext(katonknow,"ka no senbon",1,0)||findtext(katonknow,"fire needles",1,0))
			//		usr.LearnJutsu("Katon; Ka No Senbon",15,"KnowKaNoSenbon","Katon Ka No Senbon is a jutsu where the user releases a small torrent of weak, but highly flammable stream of needles from their mouth that make things catch on fire. It continuasly goes until the user decides to stop.","Katon")
				if(findtext(katonknow,"karyuu endan",1,0)||findtext(katonknow,"dragon flame projectile",1,0))
					if(usr.KatonKnowledge<500)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Karyuu Endan",0,"KaryuuEndan","Katon Karyuu Endan shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio.","Katon")
				if(findtext(katonknow,"katon houka",1,0))
					if(usr.KatonKnowledge<550)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					var/found=0
					for(var/obj/SkillCards/Housenka/P in usr.LearnedJutsus)
						if(P.type == /obj/SkillCards/Housenka) found=1
					if(!found)
						usr<<"You need to know Katon Housenka No Jutsu first!";return
					usr.LearnJutsu("Katon Houka",0,"KatonHouka","Katon Houka is a powerful fireball technique that can be considered an enhancement to Housenka. It works by shooting a giant fireball that explodes on contact or through time to an even bigger flame.","Katon")
				if(findtext(katonknow,"chou houka",1,0))
					if(usr.KatonKnowledge<550)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					var/found=0
					for(var/obj/SkillCards/KatonHouka/P in usr.LearnedJutsus)
						if(P.type == /obj/SkillCards/KatonHouka) found=1
					if(!found)
						usr<<"You need to know Katon Houka No Jutsu first!";return
					usr.LearnJutsu("Katon Chou Houka",0,"ChouHouka","Katon Chou Houka is a powerful fireball and the new enhancement to Houka! This jutsu is typically the same as Houka except less concentrated and less powerful, shooting multiple fireballs in all directions.","Katon")
				if(findtextEx(katonknow,"Gouryuuka",1,0)||findtextEx(katonknow,"Grand Dragon Fire",1,0))
					if(usr.KatonKnowledge<700)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					if(usr.ElementalCapacity>2)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Katon Gouryuuka",0,"Gouryuuka","Gouryuuka is a powerful firey dragon head expelled from the mouth of the user. It incinerates all in its path.")
				if(findtextEx(katonknow,"Fire Furry",1,0)||findtextEx(katonknow,"Fire Furry",1,0))
					if(usr.Magma==0)
						usr<<"You don't have magma with Katon to learn this technique.";return
					if(usr.ElementalCapacity>5)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Fire Furry",0,"DragonFury","Fire Fist is a powerful firey dragon head expelled from the mouth of the user. It incinerates all in its path.")
///////
				if(findtextEx(katonknow,"Katon Armor",1,0)||findtextEx(katonknow,"Katon Armor",1,0))
					if(usr.Magma==0)
						usr<<"You don't have magma with Katon to learn this technique.";return
					if(usr.ElementalCapacity>5)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Katon Armor",0,"KatonArmor","Katon Armor is a powerful firey dragon head expelled from the mouth of the user. It incinerates all in its path.")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Katon?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0)
					usr<<"You need to use chakra paper to gain your first element. Go buy some!";return
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Katon? Get some more Knowledge with Suiton!";return
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Katon? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Katon? Get some more Knowledge with Doton!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Katon? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
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
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Fire Chakra",AmountofExp,"FireChakra","The Fire Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform fire techniques. These techniques primarily hit health and stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think your capable of mastering another element."
					return
	LeafJounin2
		name = "Uzumaki, Haruno"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(250,0,140)
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
			var/list/A=usr.LearnedJutsus
			usr<<"Hello, I am the famous jutsu idealist of Leaf! How would you like to learn a technique?"
			sleep(3)
			if(usr.Village=="Leaf")
				if(usr.VMorale<10)
					usr<<"You are not committed enough to this village!";return
				var/found=0
				for(var/obj/SkillCards/Haruno/P in A)
					if(P.type == /obj/SkillCards/Haruno) found=1
				if(found)
					usr<<"So how's that technique I taught you?";return
				else
					usr<<"Report this to Korona"
					return

				/*
					var/list/buttons = list("Yes", \
							"No", "Cancel")
					sd_Alert(src, "How would you like to learn a technique? It's called Hand of Nature! It's a special time offer, and hey I'm only teaching Leaf Villagers!","Haruno Jutsu", buttons, pick(buttons),0,0,"300x300",,\
						"<STYLE>TH {text-align:left} A{color:black} A{text-decoration:none} A:hover{background:red}\
						</STYLE>",,,SD_ALERT_LINKS)
					if("Yes")
						if(usr.NinjutsuKnowledge<35)
							usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
						usr.LearnJutsu("Haruno No Jutsu",10000,"Haruno","Haruno Jutsu is a jutsu which covers the enemy within leaves, binding them and then pressuring them with damage.","Ninjutsu")
					if("No")
						return
			else
				usr<<"Oh, I thought you were a Leaf Ninja for a second."*/

	LeafJounin4
		name = "Maito Yurai"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/leeH.dmi'
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
			usr<<"To be youthful is something not that many ninja can do! Only some can be as strong as us! Haha!"
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Village!="Leaf")
				usr<<"Unfortunately I have an honor to this village, and I cannot spread the power of youth to our enemies!"
				sleep(3)
				usr<<"HEEYA! *Maito Yurai strikes a gay pose*!"
				return
			if(usr.TaijutsuStyle=="Basic")
				if(usr.TaiSkill>=usr.NinSkill&&usr.GenSkill)
					usr<<"Hm, it seems like I can teach you in that fighting style!"
					switch(input(usr,"To convert to the Gouken Ryuu fighting style, it requires 10 Skill points. Do you want to learn it?", "Gouken Ryuu") in list ("Yes","No"))
						if("Yes")
							usr.LearnJutsu("Gouken Ryu",0,"Gouken","Gouken Ryu is a taijutsu style that works on bone-crushing powerful attacks.","Taijutsu")
						else
							return
				else
					usr<<"Well, you do seem a bit weak! But still, be youthful!";return
			if(usr.TaijutsuStyle=="Gouken")
				switch(input(usr,"Would you like to learn some techniques?", "Gouken Ryuu") in list ("Kage Buyou","Konoha Reppu","Konoha Senpuu","Konoha Dai Senkou","Konoha Gouriki Senpuu","Konoha Dai Senpuu","Konoha Shofuu","Omote Renge","Cancel"))
					if("Konoha Reppu")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.TaijutsuKnowledge<15)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Konoha Reppu",0,"KonohaReppu","Konoha Reppu is a small, but useful taijutsu attack where the user spins around in a kicking formation tripping everyone and sending them off.","Taijutsu");return
					if("Konoha Senpuu")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.TaijutsuKnowledge<20)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Konoha Senpuu",0,"KonohaSenpuu","Konoha Senpuu is a stronger taijutsu attack composed of spinning round-house kicks to send out the enemy in spinning directions.","Taijutsu");return
					if("Konoha Gouriki Senpuu")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						var/found=0
						for(var/obj/SkillCards/KonohaSenpuu/P in A)
							if(P.type == /obj/SkillCards/KonohaSenpuu) found=1
						if(!found)
							usr<<"You need to know Konoha Senpuu first!";return

						if(usr.TaijutsuKnowledge<100)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Konoha Gouriki Senpuu",0,"KonohaGenkurikiSenpuu","Konoha Gouriki Senpuu is a straightforward, round-house taijutsu technique. It is the powerhouse of all Senpuu's.","Taijutsu");return
					if("Konoha Dai Senpuu")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						var/found=0
						for(var/obj/SkillCards/KonohaSenpuu/P in A)
							if(P.type == /obj/SkillCards/KonohaSenpuu) found=1
						if(!found)
							usr<<"You need to know Konoha Senpuu first!";return

						if(usr.TaijutsuKnowledge<35)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Konoha Dai Senpuu",0,"KonohaDaiSenpuu","Konoha Dai Senpuu is a technique that rapidly kicks the target multiple times in the same region, dealing repeated damage unless the target moves.","Taijutsu");return
					if("Konoha Dai Senkou")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.TaijutsuKnowledge<100)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Leaf Great Light Rotation",0,"KonohaDaiSenkou","Leaf Great Light Rotation is a taijutsu technique that strikes the opponent with a combo of powerful kicks.","Taijutsu");return
					if("Konoha Shofuu")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.TaijutsuKnowledge<50)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Konoha Shofuu",0,"KonohaShofuu","Konoha Shofuu is a taijutsu technique that strikes the opponent with an upward kick. This kick may even disarm the opponent's weapon!","Taijutsu");return
					if("Omote Renge")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.TaijutsuKnowledge<450)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Front Lotus",0,"PrimaryLotus","Omote Renge is a high speed forbidden taijutsu technique that requires the initial gate to use. The user launches their target into the air at blinding speed then pile drives them into the ground.","Taijutsu");return
					if("Kage Buyou")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.TaijutsuKnowledge<35)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Kage Buyo",0,"KageBuyo","Kage Buyou is a quick technique that allows you to transport behind a target!","Taijutsu");return
			else
				usr<<"Too bad you don't know my fighting style! Haha!"
	LeafJounin5
		name = "Takaharu"
		dir=EAST
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SasukeH.dmi'
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
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hey, I'm one of the fuuton users within the Leaf village. I am currently developing a technique on how to convert your chakra into the blades!"
			if(usr.Village=="Leaf")
				if(usr.WindE)
					usr<<"Hey, come talk to me when I'm done! I want to teach people how to do it also!"
					return
	Karasu
		name = "Karasu"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
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
				src.overlays+='Cloak.dmi'
				src.overlays+='Icons/New Base/Hair/RyuzakiH.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"..."
			sleep(3)
			switch(input(usr,"I can teach you a technique, for those who wish to camoufladge better. It's a murder of crows.", "Sanzengarasu no Jutsu") in list ("Yes","No"))
				if("Yes")
					if(usr.NinjutsuKnowledge<35)
						usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
					usr.LearnJutsu("Sanzengarasu no Jutsu",0,"MurderCrows","Sanzengarasu no Jutsu is a jutsu which summons a murder of crows, which can be used to camoufladge or even distract the opponent. They disperse after a while.","Ninjutsu");return
	KuramaNPC
		name = "Kurama, Boom"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Shirt+=rgb(61,100,60)
				src.icon=Base
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Cloak.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(usr.Clan!="Kurama")
				return
			switch(input(usr,"I can teach you a technique, an OP technique. But only if you my buddy. K? K", "Mind Displace and Illusionary Clones") in list ("Illusionary Clones","Mind Displace","Nothing"))
				if("Mind Displace")
					usr.LearnJutsu("Mind Displace",0,"MindDisplace"," Mind Displace is OP. k? k.","Ninjutsu");return
				if("Illusionary Clones")
					usr.LearnJutsu("Illusionary Clones",0,"IllusionaryClones"," Illusionary Clones are OP. k? k.","Genjutsu");return
	LeafJounin6
		name = "Uzumaki, Arashi"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/RyuzakiH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,0)
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
			usr<<"The Uzumaki Clan, we are! We're very famous in the Leaf Village, that is."
			sleep(3)
			if(usr.Village!="Leaf")
				return
			switch(input(usr,"Would you like to learn some techniques?", "Uzumaki Clan") in list ("Kage Bunshin No Jutsu","Tajuu Kage Bunshin No Jutsu","Bakuretsu Bunshin No Jutsu","Kage Shuriken No Jutsu","Rasengan","Cancel"))
				if("Kage Bunshin No Jutsu")
					if(usr.VMorale<10)
						usr<<"You are not committed enough to this village!";return
					if(usr.NinjutsuKnowledge<10)
						usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Kage Bunshin: Your class is too low for this technique.";return
					usr.LearnJutsu("Kage Bunshin No Jutsu",0,"KageBunshin","Kage Bunshin No Jutsu is a technique which creates a real clone that can attack the target. This jutsu allows you to control the clone as it has half of your chakra. They disperse after one hit.","Ninjutsu");return
				if("Tajuu Kage Bunshin No Jutsu")
					if(usr.VMorale<15)
						usr<<"You are not committed enough to this village!";return
					if(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus)
						if(usr.NinjutsuKnowledge<50)
							usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
						usr.LearnJutsu("Tajuu Kage Bunshin No Jutsu",0,"TKageBunshin","Tajuu Kage Bunshin No Jutsu is a strong version of Tajuu Kage Bunshin No Jutsu which summons tons of clones to fight!","Ninjutsu");return
					else
						usr<<"You need to learn Kage Bunshin first!";return
				if("Bakuretsu Bunshin No Jutsu")
					if(usr.VMorale<30)
						usr<<"You are not committed enough to this village!";return
					if(usr.blevel=="D"||usr.blevel=="E")
						usr<<"Shadow Clone Explosion: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus)
						if(usr.NinjutsuKnowledge<75)
							usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
						usr.LearnJutsu("Bakuretsu Bunshin No Jutsu",0,"BakuretsuBunshin","Bakuretsu Bunshin No Jutsu is a technique that explodes all the clones the user has created!","Ninjutsu");return
					else
						usr<<"You need to learn Kage Bunshin first!";return
				if("Kage Shuriken No Jutsu")
					if(usr.VMorale<30)
						usr<<"You are not committed enough to this village!";return
					if(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus)
						if(usr.NinjutsuKnowledge<75)
							usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
						usr.LearnJutsu("Kage Shuriken No Jutsu",0,"KageShuriken","Kage Shuriken No Jutsu is a jutsu which clones a thrown shuriken so it can duplicate its damage.","Ninjutsu");return
					else
						usr<<"You need to learn Kage Bunshin first!";return
				if("Rasengan")
					if(usr.VMorale<40)
						usr<<"You are not committed enough to this village!";return
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C")
						usr<<"Rasengan: Your class is too low for this technique.";return
					if(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus)
						if(usr.NinjutsuKnowledge<250)
							usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
						usr.LearnJutsu("Rasengan",0,"Rasengan","Rasengan is an incredibly powerful technique that generates a ball of chakra within the user's hand that can impact incredible damage!","Ninjutsu");return
					else
						usr<<"You need to learn Kage Bunshin first!";return
/*	HaitenmaDoTeacher
		name = "Nikola, NPC"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Shirt+=rgb(61,100,60)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"What,,,."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Haitenma-Do")
				return
			switch(input(usr,"Would you like to learn some techniques?", "Haitenma-Do Clan") in list ("Flying Thunder God","Cancel"))
				if("Flying Thunder God")
					if(usr.NinjutsuKnowledge<10)
						usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
					usr.LearnJutsu("Flying Thunder God",0,"FlyingThunderGod","Kage Bunshin No Jutsu is a technique which creates a real clone that can attack the target. This jutsu allows you to control the clone as it has half of your chakra. They disperse after one hit.","Ninjutsu");return*/
	LeafJounin7
		name = "Akimichi, Chou"
		icon_state="NPC1"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(150,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/FemaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
				src.overlays-='Icons/New Base/Clothing/Headbands/headband.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hm, I'm hungry."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Akimichi"||usr.Clan2=="Akimichi")
				usr<<"Ah, I see you're an Akimichi ninja! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Akimichi Clan") in list ("Baika No Jutsu","Nikudan Sensha","Bubun Baika No Jutsu(Fists)","AkimachiSlam","Butterfly","Cancel"))
					if("Baika No Jutsu")
						usr.LearnJutsu("Baika No Jutsu",0,"Baika","Baika No Jutsu is a jutsu that allows you to expand your size to greater sizes and mass.","Ninjutsu");return
					if("Nikudan Sensha")
						var/found=0
						for(var/obj/SkillCards/Baika/P in A)
							if(P.type == /obj/SkillCards/Baika) found=1
						if(!found)
							usr<<"You need to learn Baika No Jutsu first!";return

						usr.LearnJutsu("Nikudan Sensha",0,"Nikudan","Nikudan Sensha is a powerful technique utilizing Baika No Jutsu to roll into a ball to roll over and damage people tremendously.","Taijutsu");return
					if("Bubun Baika No Jutsu(Fists)")
						var/found=0
						for(var/obj/SkillCards/Baika/P in A)
							if(P.type == /obj/SkillCards/Baika) found=1
						if(!found)
							usr<<"You need to learn Baika No Jutsu first!";return

						if(usr.SizeMastery<35)
							usr<<"You need more Size Mastery to learn this jutsu.";return
						usr.LearnJutsu("Bubun Baika No Jutsu",0,"BubunBaika","Bubun Baika No Jutsu is a technique that partially increases one part of your body. This grants you mastery over increasing the size of your fists to increase punching damage.","Taijutsu");return
					if("AkimachiSlam")
						usr.LearnJutsu("Akimichi Slam",0,"AkimachiSlam","A powerful jutsu utilized by the akimichi clan, slamming their fists on the ground, truly damaging anyone around them.","Taijutsu");return
					if("Butterfly")
						var/found=0
						for(var/obj/SkillCards/Baika/P in A)
							if(P.type == /obj/SkillCards/Baika) found=1
						if(!found)
							usr<<"You need to learn Baika";return
						usr.LearnJutsu("Butterfly",0,"Butterfly","A powerful jutsu utilized by the akimichi clan, converting their calories into chakra and emiting wings of a butterfly that greatly enhances their physical strength.","Taijutsu");return

	LeafJounin8
		name = "Hyuuga, Shiyu"
		icon_state="NPC1"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/Jutsus/BEyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+=Hair
				src.overlays+='NejiHB.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			var/list/A=usr.LearnedJutsus
			usr<<"The Hyuuga Clan is a very respectful clan."
			sleep(3)
			if(usr.Clan=="Hyuuga")
				usr<<"Ah, I see you're an Hyuuga! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Hyuuga Clan") in list ("Kaiten","Hakke Rokujonyonshou","Hakke Hyakunijuuhachishou","Kuushou","Hakke Kuushou","Palm Thrust","Kaiten-Kizu","Cancel"))
					if("Kaiten")
						usr.LearnJutsu("Kaiten",0,"Kaiten","Kaiten is a jutsu where the user rotates to throw off the enemy's attacks with an almost absolute defence.","Taijutsu");return
					if("Hakke Rokujonyonshou")
						if(usr.StanceMastery<35)
							usr<<"You need more Stance Mastery!";return
						if(usr.ByakuganMastery<25)
							usr<<"You need more Byakugan Mastery!";return
						usr.LearnJutsu("Hakke Rokujonyonshou",0,"Rokujuu","Hakke Rokujonyonshou is a powerful clan technique where the Hyuuga ninja strikes the tenketsu coils of the ninja 64 times, shutting out their chakra.","Taijutsu");return
					if("Hakke Hyakunijuuhachishou")
						var/found=0
						for(var/obj/SkillCards/Rokujuu/P in A)
							if(P.type == /obj/SkillCards/Rokujuu) found=1
						if(!found)
							usr<<"You need to learn Rokujonyonshou first!";return

						if(usr.StanceMastery<75)
							usr<<"You need more Stance Mastery!";return
						if(usr.ByakuganMastery<25)
							usr<<"You need more Byakugan Mastery!";return
						usr.LearnJutsu("Hakke Hyakunijuuhachishou",0,"Hyakuni","Hakke Hyakunijuuhachishou is a powerful clan technique where the Hyuuga ninja strikes the tenketsu coils of the ninja 120 times, shutting out their chakra.","Taijutsu");return
					if("Hakke SanHyakuRokujo")
						var/found=0
						for(var/obj/SkillCards/Hyakuni/P in A)
							if(P.type == /obj/SkillCards/Hyakuni) found=1
						if(!found)
							usr<<"You need to learn Hyakunijuuhachishou first!";return

						if(usr.StanceMastery<75)
							usr<<"You need more Stance Mastery!";return
						if(usr.ByakuganMastery<500)
							usr<<"You need more Byakugan Mastery!";return
						if(usr.blevel=="D"||usr.blevel=="E")
							usr<<"I don't think you're quite ready for this. Come back when you're stronger.";return
						if(src.HyuugaClanBranch=="Main-Branch")
							usr<<"A main brancher! Uhh-Umm. Clearly you w-wouldn't want to learn such a lowly technique over the famed Main Branch's Twin Lion Palms!";return
						usr.LearnJutsu("Hakke SanHyakuRokujo",0,"HakkeSanHyaku","Hakke SanHyakuRokujo is the most deadly clan technique where the Hyuuga ninja strikes the tenketsu coils of the ninja - 360 times in total -, shutting out their chakra completely.","Taijutsu");return
					if("Kaiten-Kizu")
						var/found=0
						for(var/obj/SkillCards/Kaiten/P in A)
							if(P.type == /obj/SkillCards/Kaiten) found=1
						if(!found)
							usr<<"You need to learn Kaiten first!";return

						if(usr.StanceMastery<50)
							usr<<"You need more Stance Mastery!";return
						usr.LearnJutsu("Kaiten",0,"KaitenKizu","Kaiten Kizu is a powerful form of rotation where as instead of the user spinning clockwise, the user spins counter-clockwise, thus bringing in things. Because of this, this also slashes targets rapidly who are brought in.","Taijutsu");return
					if("Kuushou")
						if(usr.StanceMastery<50)
							usr<<"You need more Stance Mastery!";return
						if(usr.ByakuganMastery<50)
							usr<<"You need more Byakugan Mastery!";return
						usr.LearnJutsu("Kuushou",0,"Kuusho","Kuushou is a air palm type technique that shoots chakra from the user's fist invisible to everyone except those who can see chakra. This attack can have great range and hit people unsuspectingly!","Taijutsu");return
					if("Hakke Kuushou")
						if(usr.StanceMastery<60)
							usr<<"You need more Stance Mastery!";return
						if(usr.ByakuganMastery<100)
							usr<<"You need more Byakugan Mastery!";return
						usr.LearnJutsu("Hakke Kuushou",0,"Kuusho2","Hakke Kuushou is the upgraded forme of Kuusho, stronger and more deadly to the chakra network.","Taijutsu");return
					if("Palm Thrust")
						if(usr.StanceMastery<30)
							usr<<"You need more Stance Mastery!";return
						if(usr.ByakuganMastery<75)
							usr<<"You need more Byakugan Mastery!";return
						usr.LearnJutsu("Palm Thrust",0,"PalmThrust","Palm Thrust is a Taijutsu utilizing the Fighting Style Jyuuken, allowing a Hyuuga to push someone back with just their palms, sending them flying.","Taijutsu");return
	LeafJounin8x
		name = "Hyuuga, Kero"
		icon_state="NPC1"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/HinaH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/FemaleEyes.dmi'
				src.overlays+='Icons/Jutsus/BEyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+=Hair
				src.overlays+='NejiHB.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			var/list/A=usr.LearnedJutsus
			usr<<"Chah, I need something to do."
			sleep(3)
			if(usr.Clan=="Hyuuga")
				usr<<"The Hyuuga Clan is very supportive when it comes to the Medical arts. Did you know that?"
				var/found=0
				for(var/obj/SkillCards/Shousen/P in A)
					if(P.type == /obj/SkillCards/Shousen) found=1
				if(found)
					switch(input(usr,"Ah, so you're a medic? How would you like to learn some techniques within those ranges then?", "Hyuuga Clan") in list ("Tenketsu Hagemi","Gentle Step: Twin Lion Fist","Cancel"))
						if("Tenketsu Hagemi")
							if(usr.ByakuganMastery<25)
								usr<<"You need more Byakugan Mastery!";return
							usr.LearnJutsu("Tenketsu Hagemi",0,"TenketsuHagemi","This technique is like a reverse of Jyuken striking a tenketsu out, to where as the Hyuuga uses it more as a support technique. This technique strikes one of the ninja's tenketsu, forcing their chakra circulation on making it easier to gather chakra and use it.","Taijutsu");return
						if("Gentle Step: Twin Lion Fist")
							if(usr.StanceMastery<50)
								usr<<"You need more Stance Mastery!";return
							if(usr.ByakuganMastery<500)
								usr<<"I don't think you're quite ready for this. Mature your Byakugan then come back.";return
							if(usr.blevel=="D"||usr.blevel=="E")
								usr<<"I don't think you're quite ready for this. Come back when you're stronger.";return
							if(src.HyuugaClanBranch!="Main-Branch")
								usr<<"You low scum! You're not apart of the Hyuuga's Main branch! Get out of my sight!";return
							if(usr.ChakraC<100)
								usr<<"You need more Chakra control.)";return
							if(usr.TenketsuAccuracy<20)
								usr<<"You need to max all the Hyuuga clan passives before atempting to learn this technique.";return
							if(usr.ChakraPercision<5)
								usr<<"You need to max all the Hyuuga clan passives before atempting to learn this technique.";return
							usr.LearnJutsu("Twin Lion Fist",0,"LionPalm","This is a secret technique taught only to the Main Branch of the Hyuuga Clan. It is a deadly technique that enhances the user's Jyuken to new heights, blowing through a targets chakra with ease.","Taijutsu");return
	LeafJounin9
		name = "Nara, Rukiri"
		icon_state="NPC1"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/shikaH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+=Hair
				src.overlays+='leetype.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Lazy? No, we're full of geniuses."
			sleep(3)
			if(usr.Clan=="Nara"||usr.Clan2=="Nara")
				usr<<"Ah, I see you're a Nara! Well what would you like to learn?"
				var/list/A=usr.LearnedJutsus
				switch(input(usr,"Would you like to learn some techniques?", "Nara Clan") in list ("Shadow Possession Jutsu","Shadow Neck-Bind Jutsu","Shadow Sewing Jutsu","Shadow-Field Jutsu","KageNuiField","ForrbiddenShadowArtMassiveNuiOnslaught","Cancel"))
					if("Shadow Possession Jutsu")
						usr.LearnJutsu("Shadow Possession Jutsu",0,"KageShibari","Shadow Possession Jutsu is a powerful technique that allows you to control a shadow length to bind someone caught.","Ninjutsu");return
					if("Shadow Neck-Bind Jutsu")
						var/found=0
						for(var/obj/SkillCards/KageShibari/P in A)
							if(P.type == /obj/SkillCards/KageShibari) found=1
						if(!found)
							usr<<"You need to learn Shadow Possession Jutsu first!";return

						if(usr.ShadowManipulation<35)
							usr<<"You need more Shadow Manipulation!";return
						usr.LearnJutsu("Shadow Neck-Bind Jutsu",0,"KageKubiShibari","Shadow Neck-Bind Jutsu is a technique which allows all who are binded to be choked to death.","Ninjutsu");return
					if("Shadow Sewing Jutsu")
						var/found=0
						for(var/obj/SkillCards/KageShibari/P in A)
							if(P.type == /obj/SkillCards/KageShibari) found=1
						if(!found)
							usr<<"You need to learn Shadow Possession Jutsu first!";return

						var/found2=0
						for(var/obj/SkillCards/KageKubiShibari/P in A)
							if(P.type == /obj/SkillCards/KageKubiShibari) found2=1
						if(!found2)
							usr<<"You need to learn Shadow Neck-Bind Jutsu first!";return


						if(usr.ShadowManipulation<70)
							usr<<"You need more Shadow Manipulation!";return
						usr.LearnJutsu("Shadow Sewing Jutsu",0,"KageNui","Shadow Sewing Jutsu is a jutsu sending a torrent of tendrils at the enemy from the user's Shadow.","Ninjutsu");return
					if("Shadow-Field Jutsu")
						var/found=0
						for(var/obj/SkillCards/KageShibari/P in A)
							if(P.type == /obj/SkillCards/KageShibari) found=1
						if(!found)
							usr<<"You need to learn Shadow Possession Jutsu first!";return

						var/found2=0
						for(var/obj/SkillCards/KageKubiShibari/P in A)
							if(P.type == /obj/SkillCards/KageKubiShibari) found2=1
						if(!found2)
							usr<<"You need to learn Shadow Neck-Bind Jutsu first!";return

						var/found3=0
						for(var/obj/SkillCards/KageNui/P in A)
							if(P.type == /obj/SkillCards/KageNui) found3=1
						if(!found3)
							usr<<"You need to learn Shadow Sewing Jutsu first!";return

						if(usr.ShadowManipulation<70)
							usr<<"You need more Shadow Manipulation!";return
						usr.LearnJutsu("Shadow-Field Jutsu",0,"KageHara","Shadow-Field Jutsu is a technique rotated on Kage Nui where the user has a shadow underneath them as an absolute defence.","Ninjutsu");return
					if("KageNuiField")
						if(usr.ShadowManipulation<70)
							usr<<"You need more shadow manipulation!";return
						usr.LearnJutsu("Shadow Field Nui Style",0,"KageNuiField","An advanced form of Nui, however much stronger and a lot more deadly.","Ninjutsu");return
					if("ForrbiddenShadowArtMassiveNuiOnslaught")
						if(usr.ShadowManipulation<80)
							usr<<"You need more shadow manipulation!";return
						usr.LearnJutsu("Shadow Onslaught",0,"ForrbiddenShadowArtMassiveNuiOnslaught","One of the most strongest Nara jutsus ever known, large amoutns of shadows appear form the user, piercing the opponent, painfully..and slowly.","Ninjutsu");return

	LeafJounin10
		name = "Inuzuka, Rufus"
		icon_state="NPC1"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='SpikeyH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(0,0,0)
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
			usr<<"Hm I smell something."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Inuzuka"||usr.Clan2=="Inuzuka")
				usr<<"Ah, I see you're a Inuzuka! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Inuzuka Clan") in list ("Four Legged Jutsu","Man-Beast Claws","Man-Beast Clone","Exploding Puppy","Piercing Fang","Dual Piercing Fang","Double-Headed Wolf","Wolf Piercing Fang","Cancel"))
					if("Four Legged Jutsu")
						usr.LearnJutsu("Four Legged Jutsu",0,"Shikyaku","Four Legged Jutsu is a technique that allows the Inuzuka to go into beast-like trance, mimicing that of a Dog or Animal, improving a lot of senses.","Taijutsu");return
					if("Man-Beast Claws")
						usr.LearnJutsu("Man-Beast Claws",0,"BeastClaws","Man-Beast Claws is a Inuzuka Technique which replicates the actions of the dog, sharpening your nails through sending chakra to them. After sharpening the nails they can be used for a sharper offensive tactic.","Taijutsu");return
					if("Man-Beast Clone")
						var/found=0
						for(var/obj/SkillCards/Shikyaku/P in A)
							if(P.type == /obj/SkillCards/Shikyaku) found=1
						if(!found)
							usr<<"You need to learn Shikyaku first!";return

						if(usr.Training<20)
							usr<<"You need more Training Passive!";return
						usr.LearnJutsu("Man-Beast Clone",0,"JuujinBunshin","Man-Beast Clone is a jutsu which allows the user to clone their pet into them, allowing a lot of new jutsu and techniques.","Ninjutsu");return
					if("Exploding Puppy")
						usr.LearnJutsu("Exploding Puppy",0,"ExplodingPuppy","Exploding Puppy is a Inuzuka technique in which you take back your dog but before doing so you detonate it, releasing a torrent of Kunai.","Ninjutsu");return
					if("Piercing Fang")
						var/found=0
						for(var/obj/SkillCards/Shikyaku/P in A)
							if(P.type == /obj/SkillCards/Shikyaku) found=1
						if(!found)
							usr<<"You need to learn Shikyaku first!";return

						if(usr.Training<30)
							usr<<"You need more Training Passive!";return
						if(usr.Canine<5)
							usr<<"You need more Canine Passive!";return
						usr.LearnJutsu("Piercing Fang",0,"Tsuuga","Piercing Fang is a technique which allows the user to spin alone in a controlled pattern to attack their enemies roughly.","Taijutsu");return

					if("Dual Piercing Fang")
						var/found=0
						for(var/obj/SkillCards/JuujinBunshin/P in A)
							if(P.type == /obj/SkillCards/JuujinBunshin) found=1
						if(!found)
							usr<<"You need to learn Juujin Bunshin first!";return

						if(usr.Training<35)
							usr<<"You need more Training Passive!";return
						if(usr.Canine<10)
							usr<<"You need more Canine Passive!";return
						usr.LearnJutsu("Dual Piercing Fang",0,"Gatsuuga","Dual Piercing Fang is a technique which allows the user to spin along with their pet in a uncontrolled pattern to attack their enemies incredibly.","Taijutsu");return
					if("Double-Headed Wolf")
						var/found=0
						for(var/obj/SkillCards/JuujinBunshin/P in A)
							if(P.type == /obj/SkillCards/JuujinBunshin) found=1
						if(!found)
							usr<<"You need to learn Juujin Bunshin first!";return

						if(usr.Training<35)
							usr<<"You need more Training Passive!";return
						if(usr.Canine<50)
							usr<<"You need more Canine Passive!";return
						usr.LearnJutsu("Double-Headed Wolf",0,"DoubleHeadedWolf","Double-Headed Wolf is the ultimate Inuzuka Clan Jutsu, allowing you to fuse together with your dog to create a two-headed beast!","Taijutsu");return
					if("Wolf Piercing Fang")
						var/found=0
						for(var/obj/SkillCards/DoubleHeadedWolf/P in A)
							if(P.type == /obj/SkillCards/DoubleHeadedWolf) found=1
						if(!found)
							usr<<"You need to learn Double-Headed Wolf first!";return

						if(usr.Training<35)
							usr<<"You need more Training Passive!";return
						if(usr.Canine<50)
							usr<<"You need more Canine Passive!";return
						usr.LearnJutsu("Wolf Piercing Fang",0,"Garouga","Wolf Piercing Fang creates a destructive spinning technique that devastates anything in its path!","Taijutsu");return

	LeafJounin11
		name = "Aburame, Shibuki"
		icon_state="NPC1"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='SpikeyH.dmi'
				var/Shirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(200,200,200)
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
			usr<<"The Aburame clan has been on going for some time. Do you know of us"
			sleep(3)
			if(usr.Clan=="Aburame"||usr.Clan2=="Aburame")
				usr<<"So you are an Aburame?"
				switch(input(usr,"Would you like to learn some techniques?", "Aburame Clan") in list ("Insect Clone Jutsu","Kikaichuu Sheild","Insect Sphere","Insect Storm","Cancel"))
					if("Kikaichuu Sheild")
						if(usr.BugMastery<25)
							usr<<"You need more Bug Mastery.";return
						usr.LearnJutsu("Kikaichuu Sheild",0,"KekkaiSheild","Kikaichuu Sheild is a technique that creates a barrier around the user of bugs. It keeps the user pretty open on the inside but creates a pretty dense defence!","Ninjutsu");return
					if("Insect Clone Jutsu")
						if(usr.BugMastery<15)
							usr<<"You need more Bug Mastery.";return
						usr.LearnJutsu("Insect Clone Jutsu",0,"KekkaiKonchuuBunshin","Insect Clone Jutsu is a strategic Aburame technique that transforms a bug into a clone.","Ninjutsu");return
					if("Insect Sphere")
						if(usr.BugKeeper<15)
							usr<<"You need more Bug Keeper.";return
						usr.LearnJutsu("Insect Sphere",0,"MushiDama","Insect Sphere is a technique where the Aburame ninja sends off a sphere of bugs to attack the target, causing them to drain a sufficient rate of chakra from them!","Ninjutsu");return

					if("Insect Storm")
						if(usr.BugKeeper<50)
							usr<<"You need more Bug Keeper.";return
						usr.LearnJutsu("Insect Storm",0,"KekkaiArashi","Insect Storm is an Aburame technique at its utmost prime, summoning thousands of bugs to use to create and control a torrent storm that can drain a ninja rather harmfully!","Ninjutsu");return
			if(usr.Canlearnnanobugs==1)
				if((locate(/obj/SkillCards/KekkaiSheild) in usr.LearnedJutsus))
					if((locate(/obj/SkillCards/KekkaiKonchuuBunshin) in usr.LearnedJutsus))
						if((locate(/obj/SkillCards/MushiDama) in usr.LearnedJutsus))
							if((locate(/obj/SkillCards/KekkaiArashi) in usr.LearnedJutsus))
								usr<<"You have been selected as one of the few...but these jutsus come at a cost. The more nano mites you accept into your body, the more your vitality will decrease. You've been warned."
								switch(input(usr,"You have been choosen by the Nano Bugs..","Nano Bugs") in list ("NanoMite Burst","NanoMite Swarm","NanoMite Gathering","NanoMite Omni Burst","NanoMite Medic Swarm","Cancel"))
									if("NanoMite Burst")
										usr.LearnJutsu("NanoMite Burst",0,"NanoMite1","NanoMite Burst is a technique that sends a swarm of Nano Bugs in a straight line from the user!","Ninjutsu");return
									if("NanoMite Swarm")
										usr.LearnJutsu("NanoMite Swarm",0,"NanoMite2","NanoMite Swarm is a technique that sends a large swarm of Nano Bugs forward from the user!","Ninjutsu");return
									if("NanoMite Gathering")
										usr.LearnJutsu("NanoMite Gathering",0,"NanoMite3","NanoMite Gathering is a technique where Nano Bugs surrond you that can be used as a shield and to attack the opponet!","Ninjutsu");return
									if("NanoMite Omni Burst")
										usr.LearnJutsu("NanoMite Omni Burst",0,"NanoMite4","NanoMite Omni Burst is a Nano Bug technique that sends a blast of Nano Bugs out from the user!","Ninjutsu");return
									if("NanoMite Medic Swarm")
										usr.LearnJutsu("NanoMite Medic Swarm",0,"NanoMite5","NanoMite Medic Swarm is a Nano Bug technique that heals anyone who they touch!","Ninjutsu");return


	Leaf_Doton_Teacher
		name = "Tushe"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
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
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Boulders? There needs to be more earth chakra natured Jounin within the village. "
			sleep(3)
			if(usr.EarthE)
				var/katonknow = input("Tell me what Earth technique you would you like to learn?","Earth Technique")
				if(findtext(katonknow,"doryo dango",1,0))
					usr.LearnJutsu("Doton Doryo Dango",0,"DoryoDango","Doton Doryo Dango is a technique in which the user uses their strength to pull a boulder from the ground and throw it with great force.","Doton")
				if(findtext(katonknow,"move stopper",1,0))
					if(usr.DotonKnowledge<50)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Move Stopper",0,"MoveStopper","Move Stopper is a earth technique that creates a barrier around the opponent trapping them from moving. A good catching technique.","Doton")

				if(findtext(katonknow,"doruki gaeshi",1,0))
					usr.LearnJutsu("Doton; Doruki Gaeshi",0,"DorukiGaeshi","Doton; Doruki Gaeshi is a jutsu which places a earth wall of defence in front of you to protect you.","Doton")

				if(findtext(katonknow,"tsuchi wana",1,0))
					if(usr.DotonKnowledge<50)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Tsuchi Wana",0,"TsuchiWana","Doton; Tsuchi Wana is a technique that creates a field of rocks around the target, binding them.","Doton")

//					if(findtext(katonknow,"dochu eigyo",1,0))
//						usr.LearnJutsu("Doton; Dochu Eigyo No Jutsu",15,"Dochu Eigyo","Doton; Dochu Eigyo No Jutsu is a technique that allows the user to move freely underground.","Doton")

				if(findtext(katonknow,"taiga",1,0)||findtext(katonknow,"earth flow river",1,0))
					if(usr.DotonKnowledge<100)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryu Taiga",0,"Taiga","Doton; Doryuu Taiga is a technique which creates a flow of river made out of mud, pushing the target away.","Doton")

				if(findtext(katonknow,"doryuuheki",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuuheki No Jutsu",0,"Doryuuheki","Doton; Doryuuheki is a jutsu that creates a strong wall of defence in front of you to block techniques.","Doton")

				if(findtext(katonknow,"Dorou Domu",1,0))
					if(usr.DotonKnowledge<200)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton: Dorou Domu",0,"DorouDomu","Doton: Dorou Domu is a defensive earth sphere. It surrounds you and prevents almost any attack from penetrating. Unfortunately it is difficult to master and while in use you are unable to see outside.","Doton")

				if(findtext(katonknow,"doryuudan",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuudan No Jutsu",0,"Doryuudan","Doton; Doryuudan No Jutsu is a strong jutsu that summons a dragon that shoots spikes from its mouth.","Doton")

				if(findtext(katonknow,"yomi numa",1,0))
					if(usr.DotonKnowledge<500)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Yomi Numa No Jutsu",0,"YomiNuma","Doton; Yomi Numa produces a strong swamp that captures all who are within it.","Doton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Doton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0)
					usr<<"You need to use chakra paper to gain your first element. Go buy some!";return
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
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
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Earth Chakra",AmountofExp,"EarthChakra","The Earth Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform earth-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Leaf_Fuuton_Teacher
		name = "Kazeyao"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='ExclusiveH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(50,0,0)
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
			usr<<"Swish!"
			sleep(3)
			if(usr.WindE)
				var/katonknow = input("Tell me what Wind technique you would you like to learn?","Fuuton Technique")
				if(findtext(katonknow,"daitoppa",1,0)||findtext(katonknow,"great breakthrough",1,0))
					if(usr.FuutonKnowledge<50)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Fuuton Daitoppa No Jutsu",0,"Daitoppa","Fuuton Daitoppa No jutsu is a technique that fires a gust of wind that shoots targets back. It can be used for combustion.","Fuuton")

				if(findtext(katonknow,"reppushou",1,0)||findtext(katonknow,"gale wind palm",1,0))
					usr.LearnJutsu("Fuuton Reppushou No Jutsu",0,"Reppushou","Fuuton Reppushou No Jutsu is a jutsu that shoots a wave of wind that can shoot back the enemy or speed up things.","Fuuton")

				if(findtext(katonknow,"spinning wind",1,0)||findtext(katonknow,"spinning",1,0))
					usr.LearnJutsu("Spinning Wind",0,"SpinningWind","Spinning Wind is a technique that emits a small gust that leaves the target within a spinning wind for a small amount of time.","Fuuton")

				if(findtext(katonknow,"wind trick",1,0)||findtext(katonknow,"trick",1,0))
					usr.LearnJutsu("Wind Trick",0,"WindTrick","Wind Trick is a jutsu utilizing wind currents. It produces a strong turrent of wind that pushes back nearby targets and possible attackers, the wind current increase in size the more mastery of it.","Fuuton")

				if(findtext(katonknow,"kaze dangan",1,0))
					usr.LearnJutsu("Kaze Dangan No Jutsu",0,"KazeDangan","Fuuton Kaze Dangan No Jutsu is a technique that shoots a fast paced bullet that hits the opponent with incredible force and pressure.","Fuuton")

				if(findtext(katonknow,"renkuudan",1,0)||findtext(katonknow,"drilling air projectile",1,0))
					if(usr.FuutonKnowledge<150)
						usr<<"You need more Fuuton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Fuuton Renkuudan No Jutsu",0,"Renkuudan","Fuuton Renkuudan No Jutsu is a strong, powerful blast of wind that explodes on contact with the enemy!","Fuuton")
				if(findtext(katonknow,"vacuum sphere",1,0))
					if(usr.FuutonKnowledge<200)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Vacuum Sphere",0,"VacuumSphere","Wind Release: Vacuum Sphere is a technique that shoots many bullet size wind projectile that have the capabilities of piercing an enemy. It shoots incredibly fast making it very lethal.","Fuuton")
				if(findtext(katonknow,"kazekiri",1,0))
					if(usr.FuutonKnowledge<150)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Kaze Kiri No Jutsu",0,"KazeKiri","Kaze Kiri No Jutsu is a technique that's very easily dodgable but incredibly powerful. It shoots a blade of wind that literally goes through the target, which can deal a lot of damage and go to each target.","Fuuton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Fuuton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0)
					usr<<"You need to use chakra paper to gain your first element. Go buy some!";return
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Fuuton? Get some more Knowledge with Suiton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Fuuton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Fuuton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Fuuton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Wind Chakra",AmountofExp,"WindChakra","The Wind Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Wind-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Leaf_Suiton_Teacher
		name = "Zora"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/itachiH.dmi'
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
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Have you noticed that all the guards seem to be mentally retarded. In my opinion, it's the teachings."
			sleep(3)
			if(usr.WaterE)
				var/katonknow = input("Tell me what Suiton technique you would you like to learn?","Suiton Technique")
				if(findtext(katonknow,"mizurappa",1,0))
					usr.LearnJutsu("Suiton Mizurappa No Jutsu",0,"Mizurappa","Suiton Mizurappa No Jutsu is a beam-water technique that shoots water out from the user's mouth with great force and pressure.","Suiton")
				if(findtext(katonknow,"Suijinheki",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suijinheki No Jutsu",0,"Suijinheki","Suiton Suijinheki No Jutsu is a jutsu that creates a quick block infront of the user to block incoming techniques.","Suiton")

				if(findtext(katonknow,"suiryuudan",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suiryuudan No Jutsu",0,"Suiryuudan","Suiton Suiryuudan No Jutsu is a jutsu which summons a dragon made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"suikoudan",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suikoudan No Jutsu",0,"Suikoudan","Suiton Suikoudan No Jutsu is a jutsu whcih summons a shark made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"mizuame nabara",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Mizuame Nabara No Jutsu",0,"MizuameNabara","Mizuame Nabara No Jutsu is a jutsu that creates sticky syrup around the user making those stuck in it immobile.","Suiton")

				if(findtext(katonknow,"daibakufu",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Daibakufu No Jutsu",0,"Daibakufu","Suiton Daibakufu No Jutsu is a jutsu which shoots a large torrent which keeps the enemy in repetive damage.","Suiton")

				if(findtext(katonknow,"baku suishou",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Baku Suishouha No Jutsu",0,"BakuSuishouha","Suiton Baku Suishou No jutsu is a technique that shoots a large torrent wave that covers the field with water that can be used to the user's advantage.","Suiton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Suiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0)
					usr<<"You need to use chakra paper to gain your first element. Go buy some!";return
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Suiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Suiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Suiton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Suiton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					usr.LearnJutsu("Water Chakra",AmountofExp,"WaterChakra","The Water Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Water-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Leaf_Raiton_Teacher
		name = "Runo, Red"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
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
			usr<<"Why is my name wierd? Why are you so rude?"
			sleep(3)
			if(usr.LightningE)
				var/katonknow = input("Tell me what Lightning technique you would you like to learn?","Lightning Technique")
				if(findtext(katonknow,"raikyuu",1,0))
					usr.LearnJutsu("Raiton; Raikyuu No Jutsu",0,"Raikyuu","Raiton; Raikyuu No Jutsu is a technique where the user charges chakra within their hands and shoot it off.","Raiton")

				if(findtext(katonknow,"rairyuu no tatsumaki",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rairyuu no Tatsumaki",0,"Tatsumaki","Raiton; Rairyuu No Tatsumaki is a jutsu where the user creates a strong dragon that is controllable in movement and damage.","Raiton")

				if(findtext(katonknow,"ikazuchi no kiba",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Ikazuchi No Kiba",0,"IkazuchiKiba","Raiton; Ikazuchi No Kiba is a powerful Raiton technique which shoots bolts of lightning on all side of the user!","Raiton")

				if(findtext(katonknow,"garou",1,0))
					if(usr.RaitonKnowledge<35)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rai no Garou",0,"RairyuuGarou","Raiton; Rai no Garou is a technique where the user spins rapidly in a fierce tornado, attracting static energy which they can rip the opponent to shreds.","Raiton")

				if(findtext(katonknow,"gian",1,0))
					if(usr.RaitonKnowledge<500)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Raiton; Gian",0,"Gian","Raiton; Gian is an incredibly powerful technique which shoots a line of lightning from the user which zaps the target powerfully!","Raiton")

				if(findtext(katonknow,"raigeki",1,0))
					if(usr.RaitonKnowledge<45)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Raigeki No Yoroi",0,"Yoroi","Raiton; Raigeki No Yoroi is a powerful technique that absorbs all Raiton techniques shot at the user!","Raiton")

				if(findtext(katonknow,"jibashi",1,0))
					if(usr.RaitonKnowledge<125)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Jibashi",0,"Jibashi","Raiton; Jibashi is a jutsu where eletrical pulses are shot at the designated target, shocking and stunning them!","Raiton")
				if(findtext(katonknow,"lightning cutter",1,0)||findtext(katonknow,"hinoko",1,0))
					if(usr.RaitonKnowledge<400)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.Village!="Leaf"&&prob(95))
						usr<<"Hm... I don't think I should teach you that technique.";return
					usr.LearnJutsu("Raiton; Hinoko",0,"Hinoko","Raiton; Hinoko is a fast electrical jutsu that utilizes shape and nature manipulation to form a vibrating blade of lightning that travels quickly and deals heavy damage to its targets, as well as temporarily numbing their bodies!","Raiton")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Raiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Raiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Raiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Raiton? Get some more Knowledge with Katon!";return
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Raiton? Get some more Knowledge with Suiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Lightning Chakra",AmountofExp,"LightningChakra","The Lightning Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Lightning-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	LeafJounin16
		name = "Horuke"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/LeafChuuninSuit.dmi'
				A+=rgb(0,0,0)
				Base+=rgb(128,064,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/LeafJounin.dmi'
				src.overlays+=A
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.icon_state="rest"
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Omn. Ommnn. Ommnnn."
			sleep(11)
			if(usr.Village=="Leaf"&&usr.BeginningVillage=="Leaf")
				switch(input(usr,"I hold the concentration for Leaf Village's teleportation jutsu. It's developed as a defence for our ninja and can be used anytime. I can teach you the technique?", "Uzumaki Teleporation") in list ("Yes","No"))
					if("Yes")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						if(usr.NinjutsuKnowledge<50)
							usr<<"You need more Ninjutsu Knowledge.";return
						usr.LearnJutsu("Uzumaki Teleportation",0,"UzumakiTeleportation","Uzumaki Teleportation is a jutsu where the user concentrates for a couple of seconds and then teleports to the designated location in Leaf. Could be used for defence or other means.","Ninjutsu");return

	LeafJounin17
		name = "Uzumaki, Hitsugaya(NPC)"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MinatoH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,0)
				var/Shirt='Icons/New Base/Clothing/Official Clothing/LeafChuuninSuit.dmi'
				Shirt+=rgb(0,0,0)
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
			usr<<"Of course, I come out with tons of new Attacks all the time! Har har har!"
			sleep(3)
			if(usr.Village!="Leaf")
				return
			switch(input(usr,"Would you like to learn some techniques?", "Uzumaki Clan") in list ("Shadow Clone Attack","Windmill Clone Attack","Shadow Clone Punch","Double Rasengan","Giant Rasengan","Rasengan Barrage","Fuuton: RasenShuriken","Cancel"))
				if("Shadow Clone Attack")
					if(usr.VMorale<40)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus))
						usr<<"You need to learn Kage Bunshin first!";return
					if(usr.NinjutsuKnowledge<10)
						usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
					usr.LearnJutsu("Shadow Clone Attack",0,"KageBunshinAttack","Shadow Clone Attack is a technique that allows the user to send their Clones as human missiles at a target!","Ninjutsu");return
				if("Windmill Clone Attack")
					if(usr.VMorale<30)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus))
						usr<<"You need to learn Kage Bunshin first!";return
					if(usr.NinjutsuKnowledge<10)
						usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
					usr.LearnJutsu("Windmill Clone Attack",0,"WindmillCloneAttack","Windmill Clone Attack is an attack that shoots the clone in the shape of a windmill shuriken to decieve the enemy for a capture.","Ninjutsu");return
				if("Shadow Clone Punch")
					if(usr.VMorale<30)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/KageBunshin) in usr.LearnedJutsus))
						usr<<"You need to learn Kage Bunshin first!";return
					if(usr.NinjutsuKnowledge<10)
						usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
					usr.LearnJutsu("Shadow Clone Punch",0,"ShadowClonePunch","Shadow Clone Punch is a technique that creates a clone quickly just to shoot it forward for a punching attack!","Ninjutsu");return
				if("Double Rasengan")
					if(usr.VMorale<50)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/Rasengan) in usr.LearnedJutsus))
						usr<<"You need to learn Rasengan First!";return
					if(usr.NinjutsuKnowledge<350)
						usr<<"You don't have enough knowledge with Ninjutsu Techniques!";return
					usr.LearnJutsu("Double Rasengan",0,"Double_Rasengan","Double Rasengan is utilizing a technique, applying the same rules as Rasengan but more adept to being able to apply the Chakra Molding and Creation to both Hands to make the Rasengan in both Hands!","Ninjutsu");return

				if("Rasengan Barrage")
					if(usr.VMorale<60)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/Double_Rasengan) in usr.LearnedJutsus))
						usr<<"You need to know Double Rasengan first!";return
					if(usr.NinjutsuKnowledge<1000)
						usr<<"You need more Ninjutsu Knowledge!";return
					usr.LearnJutsu("Rasengan Barrage",0,"RasenganBarrage","Rasengan Barrage is a technique utilizing Shadow Clones and Rasengan. The Clones will Hold the Rasengans as the user controls where to aim them.","Ninjutsu");return
				if("Giant Rasengan")
					if(usr.VMorale<60)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/RasenganBarrage) in usr.LearnedJutsus))
						usr<<"You need to learn Rasengan Barrage first!";return
					if(usr.Mchakra<8500)
						usr<<"You don't have enough chakra to leran this.";return
					usr.LearnJutsu("Giant Rasengan",0,"Giant_Rasengan","Giant Rasengan is a powerful technique doubling the size of the Rasengan to make it lethal!","Ninjutsu");return
				if("Fuuton: RasenShuriken")
					if(usr.VMorale<75)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/Rasengan) in usr.LearnedJutsus))
						usr<<"You need to learn Rasengan first!";return
					if(usr.Mchakra<10000)
						usr<<"You don't have enough chakra to leran this.";return
					if(usr.WindE<1)
						usr.<<"You must first master the wind element.";return
					if(usr.FuutonKnowledge<2000)
						usr.<<"You don't have enough knowledge with Fuuton to learn this!";return
					if(!(locate(/obj/SkillCards/FuutonRasengan) in usr.LearnedJutsus))
						usr.<<"You have not yet learned to combine your wind chakra nature with your Rasengan.";return
					if(usr.blevel=="D"||usr.blevel=="E"||usr.blevel=="C"||usr.blevel=="B")
						usr<<"RasenShuriken: Your class is too low for this technique.";return
					usr.LearnJutsu("Rasenshuriken",0,"Rasenshuriken","Rasenshuriken is a powerful technique adding fuuton chakra to Rasengan and making it form a Shuriken to make it highly lethal!","Ninjutsu");return
				if("Planetary Rasengan")
					if(usr.VMorale<75)
						usr<<"You are not committed enough to this village!";return
					if(!(locate(/obj/SkillCards/Rasengan) in usr.LearnedJutsus))
						usr<<"You need to learn Rasenan first!";return
					if(usr.Mchakra<8500)
						usr<<"You don't have enough chakra to leran this.";return
					usr.LearnJutsu("Planetary Rasengan",0,"Planetary_Rasengan","Planetary Rasengan is a powerful technique Tripleing the size of the Rasengan to make it highly lethal!","Ninjutsu");return





//MedicalNPC
	MedicalNPC1
		name = "Yakushi Ryusuke"
		Village="Sound"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/YannisH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am the Medical ninja of Sound village. I primarily teach the Sound ninja our medical techniques."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Village=="Sound")
				var/found=0
				var/Axx=0
				for(var/obj/SkillCards/Shousen/P in A)
					Axx=P.Uses
					if(P.type == /obj/SkillCards/Shousen) found=1
				if(found)
					usr<<"So you are a Medic, right?"
					sleep(5)
					usr<<"Would you like to learn a technique?"
					switch(input(usr,"What technique would you like to learn?","Medic") in list ("Chakra No Mesu","Chikatsu Saisei no Jutsu","Leg Slice","Muscle Slice","Neck Slice","Ranshinshou","Oukashou","Cancel"))
						if("Chakra No Mesu")
							if(Axx<70)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need to master the art of healing first!","Style Sheet",,,,0,"400x150",,style);return
							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Chakra No Mesu",0,"ChakraNoMesu","Chakra No Mesu is scapeling technique that allow Medics to rip open bodies for surgery. It can be used for offensive tactics also, though.","Ninjutsu")

						if("Chikatsu Saisei no Jutsu")
							if(Axx<70)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need to master the art of healing first!","Style Sheet",,,,0,"400x150",,style);return
							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Chikatsu Saisei no Jutsu",0,"Chikatsu","Chikatsu Saisei no Jutsu is a technique that heals people in range of your technique. The better you are at healing, the further the range.","Ninjutsu")
						if("Leg Slice")
							var/found2=0
							for(var/obj/SkillCards/ChakraNoMesu/P in A)
								if(P.type == /obj/SkillCards/ChakraNoMesu) found2=1
							if(!found2)
								usr<<"You need to learn Chakra No Mesu to use this jutsu!";return

							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Leg Slice",0,"Leg_Slice","Medics must be very careful with percision.","Ninjutsu")

						if("Muscle Slice")
							var/found2=0
							for(var/obj/SkillCards/ChakraNoMesu/P in A)
								if(P.type == /obj/SkillCards/ChakraNoMesu) found2=1
							if(!found2)
								usr<<"You need to learn Chakra No Mesu to use this jutsu!";return

							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Muscle Slice",0,"Muscle_Slice","Medics must be very careful with percision.","Ninjutsu")

						if("Neck Slice")
							var/found2=0
							for(var/obj/SkillCards/ChakraNoMesu/P in A)
								if(P.type == /obj/SkillCards/ChakraNoMesu) found2=1
							if(!found2)
								usr<<"You need to learn Chakra No Mesu to use this jutsu!";return

							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Neck Slice",0,"Neck_Slice","Medics must be very careful with percision.","Ninjutsu")

						if("Ranshinshou")
							var/found2=0
							for(var/obj/SkillCards/ChakraNoMesu/P in A)
								if(P.type == /obj/SkillCards/ChakraNoMesu) found2=1
							if(!found2)
								usr<<"You need to learn Chakra No Mesu to use this jutsu!";return

							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Ranshinshou",0,"Ranshinshou","Ranshinshou is a highly effective paralyzing technique that is casted on the opponent by sending eletrical pulses through the opponent's body, paralyzing their nerves. Because of this, their movements are switched up and confused.","Ninjutsu")

						if("Oukashou")
							if(usr.NinjutsuKnowledge<75)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							if(usr.TaijutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Taijutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Oukashou",0,"Oukashou","Oukashou is a jutsu that generates chakra into the user hand to release for a strong taijutsu attack!","Taijutsu")

				else
					usr<<"How would you like to become a Medic? Of course you can learn from the books if you'd like, but you can learn right here! The primary point of being a Medic is healing techniques, would you like to learn Shousen No Jutsu?"
					usr.LearnJutsu("Shousen No Jutsu",0,"Shousen","Shousen No Jutsu is a jutsu that allows you to heal fallen comrades by their stamina and health, but you can't heal yourself. The more you use it, the better you get at it. This is a Medical type jutsu and is needed to learn all other Medical techniques.","Ninjutsu")
	MedicalNPC2
		name = "Wandering Kisuke"
		Village="Missing"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
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
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am the wandering Medic. I have gained data of Medical techniques across the continent."
			sleep(3)
			usr.client.perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
			usr.client.eye=locate(43,34,20)
			usr<<"[src]: Advancements in the arts of Medical Ninjutsus? Impressive."
			usr.Frozen=0
			return

			/*
			var/list/A=usr.LearnedJutsus
			var/found=0
			var/Axx
			for(var/obj/SkillCards/Shousen/P in A)
				Axx=P.Uses
				if(P.type == /obj/SkillCards/Shousen) found=1
			if(found)
				usr<<"So you are a Medic, right?"
				sleep(5)
				usr<<"Would you like to learn a technique?"
				switch(input(usr,"What technique would you like to learn?","Medic") in list ("Chakra No Mesu","Chikatsu Saisei no Jutsu","Ranshinshou","Oukashou","Poison Fog","Chakra Absorbtion Technique","Self Regeneration","Cancel"))
					if("Chakra No Mesu")
						if(Axx<400)
							usr<<"You need to master the art of healing first!";return
						if(locate(/obj/SkillCards/ChakraNoMesu) in usr.LearnedJutsus)
							usr<<"You already know this jutsu."
							if(usr.GenSkill>15)
								if(usr.NinjutsuKnowledge>200)
									usr<<"You seem capable of going further with this technique, however.. Would you like to learn a branch jutsu of Chakra Scapels?"
									switch(input(usr,"Learn a new technique for Chakra Scapels?") in list("Leg Slice","Muscle Slice","Neck Slice","No thanks"))
										if("Leg Slice")
											usr.LearnJutsu("Leg Slice",15000,"Leg_Slice","Medics must be very careful with percision.","Ninjutsu")
										if("Muscle Slice")
											usr.LearnJutsu("Muscle Slice",15000,"Muscle_Slice","Medics must be very careful with percision.","Ninjutsu")
										if("Neck Slice")
											usr.LearnJutsu("Neck Slice",15000,"Neck_Slice","Medics must be very careful with percision.","Ninjutsu")

						else if(usr.NinjutsuKnowledge<35)
							usr<<"You need more Ninjutsu Knowledge!";return
						else
							usr.LearnJutsu("Chakra No Mesu",35000,"ChakraNoMesu","Chakra No Mesu is scapeling technique that allow Medics to rip open bodies for surgery. It can be used for offensive tactics also, though.","Ninjutsu")

					if("Chikatsu Saisei no Jutsu")
						if(Axx<700)
							usr<<"You need to master the art of healing first!";return
						if(usr.NinjutsuKnowledge<35)
							var/style = "<style>BODY {margin:0;font:arial;background:black;\
								color:white;}</style>"
							sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
						usr.LearnJutsu("Chikatsu Saisei no Jutsu",45000,"Chikatsu","Chikatsu Saisei no Jutsu is a technique that heals people in range of your technique. The better you are at healing, the further the range.","Ninjutsu")

					if("Ranshinshou")
						var/found2=0
						for(var/obj/SkillCards/ChakraNoMesu/P in A)
							if(P.type == /obj/SkillCards/ChakraNoMesu) found2=1
						if(!found2)
							usr<<"You need to learn Chakra No Mesu to use this jutsu!";return

						if(usr.NinjutsuKnowledge<35)
							var/style = "<style>BODY {margin:0;font:arial;background:black;\
								color:white;}</style>"
							sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
						usr.LearnJutsu("Ranshinshou",15000,"Ranshinshou","Ranshinshou is a highly effective paralyzing technique that is casted on the opponent by sending eletrical pulses through the opponent's body, paralyzing their nerves. Because of this, their movements are switched up and confused.","Ninjutsu")

					if("Oukashou")
						if(usr.NinjutsuKnowledge<75)
							var/style = "<style>BODY {margin:0;font:arial;background:black;\
								color:white;}</style>"
							sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
						if(usr.TaijutsuKnowledge<35)
							var/style = "<style>BODY {margin:0;font:arial;background:black;\
								color:white;}</style>"
							sd_Alert(usr, "You need more Taijutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
						usr.LearnJutsu("Oukashou",50000,"Oukashou","Oukashou is a jutsu that generates chakra into the user hand to release for a strong taijutsu attack!","Taijutsu")
					if("Poison Fog")
						if(usr.GenSkill>19)
							usr.LearnJutsu("Medical Jutsu: Poison Fog",30000,"PoisonFog","Poison Fog is a jutsu that allows the medical ninja to create a poisonous fog, severly poisining anyone caught within it.","Ninjutsu")
						else
							usr<<"Sorry, Looks like you don't have enough control over your chakra to learn this jutsu..."
							return
					if("Chakra Absorbtion Technique")
						if(usr.GenSkill<21)
							usr<<"You don't seem to have enough control to learn this technique. I'm sorry."
							return
						if(usr.NinjutsuKnowledge<200)
							usr<<"You need more Ninjutsu Knowledge!"
							return
						usr.LearnJutsu("Chakra Absorbtion Technique",25000,"ChakraAbsorb","Chakra Absorbtion Technique is a very powerful Jutsu that allows the user to steal the chakra from a living being once they get close enough just by placing their hand upon them.","Ninjutsu")
					if("Self Regeneration")
						if(usr.GenSkill<21)
							usr<<"You don't seem to have enough control to learn this technique. I'm sorry."
							return
						if(usr.NinjutsuKnowledge<150)
							usr<<"You need more Ninjutsu Knowledge!"
							return
						usr.LearnJutsu("Self Regeneration",50000,"SelfHeal","Self Regeneration is a technique known to only the strongest of medical ninja. It allows them to heal themselves by converting their chakra into life force, healing their wounds and vital organs.","Ninjutsu")
			else
				usr<<"How would you like to become a Medic? Of course you can learn from the books if you'd like, but you can learn right here! The primary point of being a Medic is healing techniques, would you like to learn Shousen No Jutsu?"

				usr.LearnJutsu("Shousen No Jutsu",50000,"Shousen","Shousen No Jutsu is a jutsu that allows you to heal fallen comrades by their stamina and health, but you can't heal yourself. The more you use it, the better you get at it. This is a Medical type jutsu and is needed to learn all other Medical techniques.","Ninjutsu")

				*/
	MedicalNPC3
		name = "Yo-Yo"
		Village="Leaf"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/InoH.dmi'
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
			usr<<"Hello, I am the Medical ninja of Leaf Village! They call me Yo-Yo!!!"
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Village=="Leaf")
				var/found=0
				var/Axx=0
				for(var/obj/SkillCards/Shousen/P in A)
					Axx=P.Uses
					if(P.type == /obj/SkillCards/Shousen) found=1
				if(found)
					usr<<"So you are a Medic, right?"
					sleep(5)
					usr<<"Would you like to learn a technique?"
					switch(input(usr,"What technique would you like to learn?","Medic") in list ("Chakra No Mesu","Cancel"))
						if("Chakra No Mesu")
							if(Axx<70)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need to master the art of healing first!","Style Sheet",,,,0,"400x150",,style);return
							if(usr.NinjutsuKnowledge<35)
								var/style = "<style>BODY {margin:0;font:arial;background:black;\
									color:white;}</style>"
								sd_Alert(usr, "You need more Ninjutsu Knowledge!","Style Sheet",,,,0,"400x150",,style);return
							usr.LearnJutsu("Chakra No Mesu",0,"ChakraNoMesu","Chakra No Mesu is scapeling technique that allow Medics to rip open bodies for surgery. It can be used for offensive tactics also, though.","Ninjutsu")
				else
					usr<<"How would you like to become a Medic? Of course you can learn from the books if you'd like, but you can learn right here! The primary point of being a Medic is healing techniques, would you like to learn Shousen No Jutsu?"
					usr.LearnJutsu("Shousen No Jutsu",0,"Shousen","Shousen No Jutsu is a jutsu that allows you to heal fallen comrades by their stamina and health, but you can't heal yourself. The more you use it, the better you get at it. This is a Medical type jutsu and is needed to learn all other Medical techniques.","Ninjutsu")
//Rock Ninja/////////////////////////////////////////////
	RockJounin1
		name = "Mako"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
		//	if(locate(/obj/SkillCards/Meimei) in usr.LearnedJutsus)
		//		if(!(locate(/obj/SkillCards/RockFlurry) in usr.LearnedJutsus))
		//			if(usr.VMorale>150)
		//				usr<<"Let's teach you how Brute Strength can help with certain Ninjutsu..."
		//				usr.LearnJutsu("Rock Flurry Meteor Shower",30000,"RockFlurry","Rock Flurry meteor shower is a jutsu that allows the user to use their raw Physique to lift a large number of rocks into the air that come down upon the battlefield as meteors, inflicting damage to those that they land on.","Ninjutsu");return
		//			else
		//				usr<<"You need more Village Morale!"
			usr<<"When in a mysterious environment, you must learn to blend in."
			sleep(3)
			if(usr.BeginningVillage=="Rock")
				if(/obj/SkillCards/Meimei in usr.LearnedJutsus)
					usr<<"Mmmm?";return
				switch(input(usr,"Would you like to learn a technique that allows you to blend in with your surroundings?","Meisai Gakure No Jutsu") in list ("Yes","No"))
					if("Yes")
						if(usr.VMorale<35)
							usr<<"You are not committed enough to this village!";return
						usr.LearnJutsu("Meisai Gakure No Jutsu",0,"Meimei","Meisai Gakure No Jutsu is a jutsu that makes the user camoufladge with their surroundings.","Ninjutsu");return
	Rock_Meteor_Teacher
		name = "Mex"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(150,150,150)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/FemaleEyes.dmi'
				src.overlays+='Icons/New Base/FemaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, Would you like to learn a Jutsu that works on using Physical Strength and the forces of the earth>"
			sleep(10)
			if(!(locate(/obj/SkillCards/RockFlurry) in usr.LearnedJutsus))
				if(usr.VMorale>150)
					usr<<"Let's teach you how Brute Strength can help with certain Ninjutsu..."
					usr.LearnJutsu("Rock Flurry Meteor Shower",0,"RockFlurry","Rock Flurry meteor shower is a jutsu that allows the user to use their raw Physique to lift a large number of rocks into the air that come down upon the battlefield as meteors, inflicting damage to those that they land on.","Ninjutsu");return
				else
					usr<<"You need more Village Morale!"
	Rock_Doton_Teacher
		name = "Juugo"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(150,150,150)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/FemaleEyes.dmi'
				src.overlays+='Icons/New Base/FemaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am one of the strongest Earth-Natured Ninja in all of the village. But I also take my time to teach ninja techniques."
			sleep(3)
			if(usr.EarthE)
				var/katonknow = input("Tell me what Earth technique you would you like to learn?","Earth Technique")
				if(findtext(katonknow,"doryo dango",1,0))
					usr.LearnJutsu("Doton Doryo Dango",0,"DoryoDango","Doton Doryo Dango is a technique in which the user uses their strength to pull a boulder from the ground and throw it with great force.","Doton")

				if(findtext(katonknow,"doruki gaeshi",1,0))
					usr.LearnJutsu("Doton; Doruki Gaeshi",0,"DorukiGaeshi","Doton; Doruki Gaeshi is a jutsu which places a earth wall of defence in front of you to protect you.","Doton")
				if(findtext(katonknow,"move stopper",1,0))
					if(usr.DotonKnowledge<50)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Move Stopper",0,"MoveStopper","Move Stopper is a earth technique that creates a barrier around the opponent trapping them from moving. A good catching technique.","Doton")

				if(findtext(katonknow,"tsuchi wana",1,0))
					if(usr.DotonKnowledge<50)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Tsuchi Wana",0,"TsuchiWana","Doton; Tsuchi Wana is a technique that creates a field of rocks around the target, binding them.","Doton")

//					if(findtext(katonknow,"dochu eigyo",1,0))
//						usr.LearnJutsu("Doton; Dochu Eigyo No Jutsu",15,"Dochu Eigyo","Doton; Dochu Eigyo No Jutsu is a technique that allows the user to move freely underground.","Doton")

				if(findtext(katonknow,"taiga",1,0)||findtext(katonknow,"earth flow river",1,0))
					if(usr.DotonKnowledge<100)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryu Taiga",0,"Taiga","Doton; Doryuu Taiga is a technique which creates a flow of river made out of mud, pushing the target away.","Doton")

				if(findtext(katonknow,"doryuuheki",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuuheki No Jutsu",0,"Doryuuheki","Doton; Doryuuheki is a jutsu that creates a strong wall of defence in front of you to block techniques.","Doton")

				if(findtext(katonknow,"Dorou Domu",1,0))
					if(usr.DotonKnowledge<200)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton: Dorou Domu",0,"DorouDomu","Doton: Dorou Domu is a defensive earth sphere. It surrounds you and prevents almost any attack from penetrating. Unfortunately it is difficult to master and while in use you are unable to see outside.","Doton")

				if(findtext(katonknow,"doryuudan",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuudan No Jutsu",0,"Doryuudan","Doton; Doryuudan No Jutsu is a strong jutsu that summons a dragon that shoots spikes from its mouth.","Doton")

				if(findtext(katonknow,"domu",1,0)||findtext(katonknow,"crush",1,0))
					if(usr.DotonKnowledge<350)
						usr<<"You need more Doton Knowledge.";return
					if(usr.ElementalCapacity>2)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Doton; Earth Crush Jutsu",0,"DorouDomuCrush","Doton; Earth Crush Jutsu is a strong jutsu that covers the enemy with a barrier of Earth that can crush over them for a killing blow.","Doton")

				if(findtext(katonknow,"yomi numa",1,0))
					if(usr.DotonKnowledge<500)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Yomi Numa No Jutsu",0,"YomiNuma","Doton; Yomi Numa produces a strong swamp that captures all who are within it.","Doton")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Doton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
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
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Earth Chakra",AmountofExp,"EarthChakra","The Earth Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform earth-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	RockJounin3
		name = "Juukiriko"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/InoH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(150,150,150)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/FemaleEyes.dmi'
				src.overlays+='Icons/New Base/FemaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Dig, dig, dig dig!!!"
			sleep(3)
			if(usr.Village=="Rock")
				if(usr.NinjutsuKnowledge<15)
					usr<<"You need more Ninjutsu Knowledge.";return
				if(!usr.EarthE)
					usr<<"What's that? Your element isn't earth!";return
				usr.LearnJutsu("Doton: Moguragakure No Jutsu",0,"Moguragakure","Doton: Moguragakure No Jutsu is a jutsu where the user remains hidden deep underground which they can use to their advantage for a couple of other things they need.","Doton");return

	RockJounin4
		name = "Sabaku, Rune"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/narutoH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(75,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"I forgot what happened to the old village of Sand. But I hear it was pretty bad."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Sabaku"||usr.Bijuu=="Ichibi"||usr.Clan2=="Sabaku")
				usr<<"Ah, I see you're a Sabaku Ninja! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Sabaku Clan") in list ("Sand Eye","Sand Manipulation","Desert Coffin","Desert Funeral","Quicksand Waterfall Current","Desert Imperial Funeral","Sand Shuriken","Sand Clone","Sand Arm","SunaWhip","Sand Sphere","SabakuSandField","SabakuSandFieldBurial","Cancel"))
					if("Sand Eye")
						usr.LearnJutsu("Sandeye",0,"Sandeye","Sand eye is a simple technique allowing the Sabaku Clan user to see whenever they are blinded.");return

					if("Sand Manipulation")
						if(usr.SandMastery<25)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Manipulation",0,"SunaSoujou","Sand Manipulation is a powerful technique that allows the user to control a large quanity of Sand to attack their enemies with.","Ninjutsu");return

					if("Desert Coffin")
						if(usr.SandMastery<60)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Coffin",0,"SabakuKyuu","Sand Coffin is a technique that captures a target in a torrent of sand using Shield of Sand, to bind them successfully.","Ninjutsu");return

					if("Desert Funeral")
						var/found=0
						for(var/obj/SkillCards/SabakuKyuu/P in A)
							if(P.type == /obj/SkillCards/SabakuKyuu) found=1
						if(!found)
							usr<<"You need to learn Sand Coffin to use this jutsu!";return

						if(usr.SandMastery<60)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Burial",0,"SabakuSousou","Sand Burial is the finisher to Sand Coffin, making it so that you may crush the sand as soon as you capture them.","Ninjutsu");return

					if("Quicksand Waterfall Current")
						var/found=0
						for(var/obj/SkillCards/SabakuKyuu/P in A)
							if(P.type == /obj/SkillCards/SabakuKyuu) found=1
						if(!found)
							usr<<"You need to learn Sand Burial to use this jutsu!";return

						if(usr.SandMastery<90)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Quicksand Waterfall Current",0,"BakuryuRyusa","Quicksand Waterfall Current shoots off a sea of sand that captures tons of targets!","Ninjutsu");return

					if("Desert Imperial Funeral")
						if(usr.SandMastery<100)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Desert Imperial Funeral",0,"SabakuTaisou","Desert Imperial Funeral is the finisher to Bakuryu Ryusa, collasping all the sand destroying all the captured targets inside.","Ninjutsu");return

					if("Sand Shuriken")
						if(usr.SandMastery<5)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Shuriken",0,"SunaShuriken","Sand Shuriken is a technique creating dense shurikens out of sand that can dice an enemy into bits.","Ninjutsu");return

					if("SunaWhip")
						if(usr.SandMastery<50)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Whip",0,"SunaWhip","Description Coming soon.","Ninjutsu");return

					if("Sand Clone")
						if(usr.SandMastery<15)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Clone",0,"SunaBunshin","Sand Clone is a technique that transforms the shield of sand into a clone, letting it work as an offensive attack.","Ninjutsu");return

					if("Sand Arm")
						if(usr.SandMastery<35)
							usr<<"You need more Sand Mastery.";return
						if(!usr.Shukaku)
							usr<<"You need a certain passive.";return
						usr.LearnJutsu("Sand Arm",0,"SandArm","Sand Arm is a jutsu similiar to the arm of the Shukaku. The user creates a hand of sand and stretches it out to attack the enemy with great force.","Ninjutsu");return

					if("Sand Sphere")
						if(usr.SandMastery<40)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sand Sphere",0,"SandSphere","Sand Sphere is a powerful defence guarding you from your enemy's attacks.","Ninjutsu");return

					if("SabakuSandField")
						if(usr.SandMastery<100)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sabaku Sand Field",0,"SabakuSandField","Sand Field is a devastating jutsu, allowing the user to create a wave of sand around them, engulfing anyone around it.","Ninjutsu");return

					if("SabakuSandFieldBurial")
						if(usr.SandMastery<100)
							usr<<"You need more Sand Mastery.";return
						usr.LearnJutsu("Sabaku Sand Field Burial",0,"SabakuSandFieldBurial","A continuation of the Deadly jutsu Sabaku Sand Field, this is the final blow, crushing anyone within it.","Ninjutsu");return

	RockJounin5
		name = "Kiro Rian"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/WindH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(50,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+='KubirikiHouchou.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Shoot for the winds, never the stars."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Kiro"||usr.Clan2=="Kiro")
				usr<<"Ah, I see you're a Kiro Ninja! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Kiro Clan") in list ("Shuriken Control Jutsu","Chakra Shuriken","Shuriken Smithy Jutsu","Spiral Star","Spiraling Projectile","Shuriken Shield", "Void Star","Cancel"))
					if("Shuriken Control Jutsu")
						usr.LearnJutsu("Shuriken Control Jutsu",0,"ShurikenSoujuu","Shuriken Control Jutsu is a jutsu that allows you to control Shuriken within a given area to your will.");return

					if("Chakra Shuriken")
						if(usr.ShurikenMastery<15)
							usr<<"You need more Shuriken Mastery.";return
						usr.LearnJutsu("Chakra Shuriken",0,"ChakraShuriken","Chakra Shuriken is the Kiro Clan's most famous technique, allowing them the masterpiece of creating a chakra-filled shuriken. Because of the way it works, since it is made out of chakra it causes vitality damage while being invisible. It can be done no matter what bind.","Ninjutsu");return
					if("Spiral Star")
						var/found2=0
						for(var/obj/SkillCards/ChakraShuriken/P in A)
							if(P.type == /obj/SkillCards/ChakraShuriken)
								found2=1
						if(!found2)
							usr<<"You need to learn Chakra Shuriken to use this jutsu!";return
						usr.LearnJutsu("Spiral Star",0,"SpiralStar","Spiral Star is a technique created by the Kiro Ninja to form a star in front of them. This shuriken like star moves at rotating speed and is made out of pure-chakra, because of this it slashes anything nearby and blocks things while remaining invisible to anyone who can't see chakra.","Ninjutsu");return
					if("Spiraling Projectile")
						var/found2=0
						for(var/obj/SkillCards/SpiralStar/P in A)
							if(P.type == /obj/SkillCards/SpiralStar)
								found2=1
						if(!found2)
							usr<<"You need to learn Spiral Star to use this jutsu!";return
						usr.LearnJutsu("Spiraling Projectile",0,"SpiralStarProjectile","Spiraling Projectile is the second part of the Kiro Clan's famous Spiraling Star technique, allowing them to project the chakra made infront of them allowing it to run across the air alone.","Ninjutsu");return
					if("Shuriken Shield")
						var/found4=0
						for(var/obj/SkillCards/ShurikenSmithyJutsu/P in A)
							if(P.type == /obj/SkillCards/ShurikenSmithyJutsu)
								found4=1
						if(!found4)
							usr<<"You need to learn Shuriken Smithy in order to learn this jutsu!";return
						usr.LearnJutsu("Shuriken Shield",0,"ChakraShurikenShield","Utilizing the ability you learned with Smithy to create multiple Chakra Shurikens; the user is able to create multiple Shurikens, but in the form of a Defencive Barrier to protect the user, and harm those caught in it.","Ninjutsu");return
					if("Void Star")
						var/found5=0
						for(var/obj/SkillCards/ChakraShurikenShield/P in A)
							if(P.type == /obj/SkillCards/ChakraShurikenShield)
								found5=1
						if(!found5)
							usr<<"You need to learn Chakra Shuriken Shield in order to learn this jutsu!";return
						usr.LearnJutsu("Void Star: Chakra Shuriken Creation",0,"VoidStar","A Kiro Clan Members most powerful technique. The clan member is able to manipulate their chakra to such a rapid and crazy movement, they're able too place a bit of their chakra anywhere on the battlefield they want, creating a deadly shuriken.","Ninjutsu");return
					if("Shuriken Smithy Jutsu")
						var/found2=0
						for(var/obj/SkillCards/ChakraShuriken/P in A)
							if(P.type == /obj/SkillCards/ChakraShuriken)
								found2=1
							if(P.Uses<150)
								usr<<"You haven't mastered Chakra Shuriken yet!";return
						if(!found2)
							usr<<"You need to learn Chakra Shuriken to use this jutsu!";return

						var/found3=0
						for(var/obj/SkillCards/ShurikenSoujuu/P in A)
							if(P.type == /obj/SkillCards/ShurikenSoujuu)
								found3=1
						if(!found3)
							usr<<"You need to learn Shuriken Control to use this jutsu!";return

						usr.LearnJutsu("Shuriken Smithy Jutsu",0,"ShurikenSmithyJutsu","The Kiro Clan's most famous technique, the Shuriken Smithy Technique is the original name of the Chakra Shuriken Jutsu, the user creating a mass amount of Chakra Shurikens through their actual which they can use Shuriken Control to control with vast amounts of chakra control.","Ninjutsu");return

	Rock_Fuuton_Teacher
		name = "Kuroi"
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
			usr<<"Hello, I am one of the strongest Wind-Natured Jounin in all of the village. But I also take my time to teach ninja techniques."
			sleep(3)
			if(usr.WindE)
				var/katonknow = input("Tell me what Wind technique you would you like to learn?","Fuuton Technique")
				if(findtext(katonknow,"daitoppa",1,0)||findtext(katonknow,"great breakthrough",1,0))
					if(usr.FuutonKnowledge<50)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Fuuton Daitoppa No Jutsu",0,"Daitoppa","Fuuton Daitoppa No jutsu is a technique that fires a gust of wind that shoots targets back. It can be used for combustion.","Fuuton")

				if(findtext(katonknow,"reppushou",1,0)||findtext(katonknow,"gale wind palm",1,0))
					usr.LearnJutsu("Fuuton Reppushou No Jutsu",0,"Reppushou","Fuuton Reppushou No Jutsu is a jutsu that shoots a wave of wind that can shoot back the enemy or speed up things.","Fuuton")

				if(findtext(katonknow,"spinning wind",1,0)||findtext(katonknow,"spinning",1,0))
					usr.LearnJutsu("Spinning Wind",0,"SpinningWind","Spinning Wind is a technique that emits a small gust that leaves the target within a spinning wind for a small amount of time.","Fuuton")

				if(findtext(katonknow,"wind trick",1,0)||findtext(katonknow,"trick",1,0))
					usr.LearnJutsu("Wind Trick",0,"WindTrick","Wind Trick is a jutsu utilizing wind currents. It produces a strong turrent of wind that pushes back nearby targets and possible attackers, the wind current increase in size the more mastery of it.","Fuuton")

				if(findtext(katonknow,"kaze dangan",1,0))
					usr.LearnJutsu("Kaze Dangan No Jutsu",0,"KazeDangan","Fuuton Kaze Dangan No Jutsu is a technique that shoots a fast paced bullet that hits the opponent with incredible force and pressure.","Fuuton")

				if(findtext(katonknow,"renkuudan",1,0)||findtext(katonknow,"drilling air projectile",1,0))
					if(usr.FuutonKnowledge<150)
						usr<<"You need more Fuuton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Fuuton Renkuudan No Jutsu",0,"Renkuudan","Fuuton Renkuudan No Jutsu is a strong, powerful blast of wind that explodes on contact with the enemy!","Fuuton")

				if(findtext(katonknow,"kazekiri",1,0))
					if(usr.FuutonKnowledge<150)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Kaze Kiri No Jutsu",0,"KazeKiri","Kaze Kiri No Jutsu is a technique that's very easily dodgable but incredibly powerful. It shoots a blade of wind that literally goes through the target, which can deal a lot of damage and go to each target.","Fuuton")
				if(findtext(katonknow,"vacuum sphere",1,0))
					if(usr.FuutonKnowledge<200)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Vacuum Sphere",0,"VacuumSphere","Wind Release: Vacuum Sphere is a technique that shoots many bullet size wind projectile that have the capabilities of piercing an enemy. It shoots incredibly fast making it very lethal.","Fuuton")
				if(findtext(katonknow,"kaze gai",1,0))
					if(usr.FuutonKnowledge<350)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Kaze Gai No Jutsu",0,"KazeGai","Kaze Gai no jutsu is easily an A rank technique. The edges are sharp yet hold enough brute force to be concentrated as a wind technique, not only pushing the target back but slicing them up as they get pushed making this technique ruthless. It takes up a lot of chakra though.","Fuuton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Fuuton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Fuuton? Get some more Knowledge with Suiton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Fuuton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Fuuton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Fuuton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Wind Chakra",AmountofExp,"WindChakra","The Wind Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Wind-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Rock_Kaze_No_Yaiba_Teacher
		name = "Kasuten"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SasukeTS.dmi'
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(100,0,0)
				Shirt+=rgb(128,064,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The village of sand must always be protected."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Village=="Rock")
				var/found=0
				for(var/obj/SkillCards/Yaiba/P in A)
					if(P.type == /obj/SkillCards/Yaiba) found=1
				if(found)
					usr<<"Is that technique working for you?";return
				else
					if(usr.WindE)
						usr<<"A technique has passed down my family for years and years. It's a blade of wind, Kaze No Yaiba. Nothing can pierce a blade of wind. Would you like to learn it?"
						switch(input(usr,"Do you want to learn Kaze Yaiba?", "Kaze No Yaiba") in list ("Yes","No"))
							if("Yes")
								usr.LearnJutsu("Fuuton Kaze No Yaiba",0,"Yaiba","Fuuton Kaze No Yaiba is a powerful technique that gives the user a wind sword that slices its victim.","Fuuton")
	Rock_Katon_Teacher
		name = "Rokunga"
		icon_state="NPC2"
		CNNPC = 1
		Village="Rock"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SasukeH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(100,100,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The flames are always beautiful."
			sleep(3)
			if(usr.FireE)
				var/katonknow = input("Tell me what Katon technique you would you like to learn?","Katon Technique")
				if(findtext(katonknow,"hikibou",1,0))
					usr.LearnJutsu("Katon Hikibou No Jutsu",0,"Hikibou","Katon Hikibou No Jutsu is a technique where the user heats the air around the target. After heating the air, that region will combust in flames. It is very useless at the beginning, but the more you use it the stronger it gets.","Katon")
				if(findtext(katonknow,"goukakyuu",1,0)||findtext(katonknow,"fireball",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Goukakyuu No Jutsu",0,"Goukakyuu","Katon Goukakyuu No jutsu is a field ranged jutsu that releases fire from the mouth. It covers a small radius, that can improve, so it can be very useful in combat.","Katon")
				if(findtext(katonknow,"housenka",1,0)||findtext(katonknow,"phoenix flower",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Housenka No Jutsu",0,"Housenka","Katon Housenka No Jutsu is a jutsu that shoots multiple fire balls from the mouth that explode in fire on contact of a target.","Katon")
				if(findtext(katonknow,"ryuuka",1,0)||findtext(katonknow,"dragon fire",1,0))
					if(usr.KatonKnowledge<75)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Ryuuka No Jutsu",0,"Ryuuka","Katon Ryuuka No Jutsu is a concentrated form of Karyuu Endan that shoots a concentrated blast that explodes on contact of a physical object.","Katon")
			//	if(findtext(katonknow,"ka no senbon",1,0)||findtext(katonknow,"fire needles",1,0))
			//		usr.LearnJutsu("Katon; Ka No Senbon",15,"KnowKaNoSenbon","Katon Ka No Senbon is a jutsu where the user releases a small torrent of weak, but highly flammable stream of needles from their mouth that make things catch on fire. It continuasly goes until the user decides to stop.","Katon")
				if(findtext(katonknow,"karyuu endan",1,0)||findtext(katonknow,"dragon flame projectile",1,0))
					if(usr.KatonKnowledge<500)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Karyuu Endan",0,"KaryuuEndan","Katon Karyuu Endan shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio.","Katon")
				if(findtext(katonknow,"katon rasengan",1,0)||findtext(katonknow,"fire rasengan",1,0))
					if(usr.KatonKnowledge<1000||usr.ElementalCapacity>1||usr.Mchakra<10000)
						usr<<"You can't learn this technique..";return
					var/found=0
					for(var/obj/SkillCards/Rasengan/P in usr.LearnedJutsus)
						if(P.type == /obj/SkillCards/Rasengan) found=1
					if(!found)
						usr<<"You need to know Rasengan first!";return
					usr.LearnJutsu("Katon Rasengan",0,"KatonRasengan","Katon Rasengan is a rasegan fused with your natural elemental affinity of fire. It deals serious damage along with a high chance to leave a lasting burn on the target.","Katon")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Katon?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Katon? Get some more Knowledge with Suiton!";return
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Katon? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Katon? Get some more Knowledge with Doton!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Katon? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
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
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Fire Chakra",AmountofExp,"FireChakra","The Fire Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform fire techniques. These techniques primarily hit health and stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think your capable of mastering another element."
					return
	Rock_Suiton_Teacher
		name = "Sharko"
		icon = 'Icons/New Base/Base.dmi'
		icon_state="NPC2"
		CNNPC = 1
		Village="Rock"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/narutoH.dmi'
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
			usr<<"I'm a bit parched."
			sleep(3)

			if(usr.WaterE)
				var/katonknow = input("Tell me what Suiton technique you would you like to learn?","Suiton Technique")
				if(findtext(katonknow,"mizurappa",1,0))
					usr.LearnJutsu("Suiton Mizurappa No Jutsu",0,"Mizurappa","Suiton Mizurappa No Jutsu is a beam-water technique that shoots water out from the user's mouth with great force and pressure.","Suiton")

				if(findtext(katonknow,"suiryuudan",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suiryuudan No Jutsu",0,"Suiryuudan","Suiton Suiryuudan No Jutsu is a jutsu which summons a dragon made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"suikoudan",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suikoudan No Jutsu",0,"Suikoudan","Suiton Suikoudan No Jutsu is a jutsu whcih summons a shark made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"mizuame nabara",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Mizuame Nabara No Jutsu",0,"MizuameNabara","Mizuame Nabara No Jutsu is a jutsu that creates sticky syrup around the user making those stuck in it immobile.","Suiton")

				if(findtext(katonknow,"daibakufu",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Daibakufu No Jutsu",0,"Daibakufu","Suiton Daibakufu No Jutsu is a jutsu which shoots a large torrent which keeps the enemy in repetive damage.","Suiton")

				if(findtext(katonknow,"baku suishou",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Baku Suishouha No Jutsu",0,"BakuSuishouha","Suiton Baku Suishou No jutsu is a technique that shoots a large torrent wave that covers the field with water that can be used to the user's advantage.","Suiton")
				if(findtext(katonknow,"teppoudama",1,0))
					if(usr.SuitonKnowledge<450)
						usr<<"You need more Suiton Knowledge.";return
					if(usr.ElementalCapacity>2)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Suiton Teppoudama",0,"Teppoudama","Suiton Teppoudama is a strong and fast water bullet projectile that when it colldies with something bursts with a large shockwave knocking anyone nearby away with great force.","Suiton")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Suiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Suiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Suiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Suiton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Suiton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Water Chakra",AmountofExp,"WaterChakra","The Water Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Water-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Rock_Raiton_Teacher
		name = "Rawlasaurs"
		icon = 'Icons/New Base/Base.dmi'
		icon_state="NPC2"
		CNNPC = 1
		Village="Rock"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/shikaH.dmi'
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
				src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"I feel a static connection with my village."
			sleep(3)
			if(usr.LightningE)
				var/katonknow = input("Tell me what Lightning technique you would you like to learn?","Lightning Technique")
				if(findtext(katonknow,"raikyuu",1,0))
					usr.LearnJutsu("Raiton; Raikyuu No Jutsu",0,"Raikyuu","Raiton; Raikyuu No Jutsu is a technique where the user charges chakra within their hands and shoot it off.","Raiton")

				if(findtext(katonknow,"rairyuu no tatsumaki",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rairyuu no Tatsumaki",0,"Tatsumaki","Raiton; Rairyuu No Tatsumaki is a jutsu where the user creates a strong dragon that is controllable in movement and damage.","Raiton")

				if(findtext(katonknow,"ikazuchi no kiba",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Ikazuchi No Kiba",0,"IkazuchiKiba","Raiton; Ikazuchi No Kiba is a powerful Raiton technique which shoots bolts of lightning on all side of the user!","Raiton")

				if(findtext(katonknow,"garou",1,0))
					if(usr.RaitonKnowledge<35)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rai no Garou",0,"RairyuuGarou","Raiton; Rai no Garou is a technique where the user spins rapidly in a fierce tornado, attracting static energy which they can rip the opponent to shreds.","Raiton")

				if(findtext(katonknow,"gian",1,0))
					if(usr.RaitonKnowledge<500)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Raiton; Gian",0,"Gian","Raiton; Gian is an incredibly powerful technique which shoots a line of lightning from the user which zaps the target powerfully!","Raiton")

				if(findtext(katonknow,"raigeki",1,0))
					if(usr.RaitonKnowledge<45)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Raigeki No Yoroi",0,"Yoroi","Raiton; Raigeki No Yoroi is a powerful technique that absorbs all Raiton techniques shot at the user!","Raiton")

				if(findtext(katonknow,"jibashi",1,0))
					if(usr.RaitonKnowledge<125)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Jibashi",0,"Jibashi","Raiton; Jibashi is a jutsu where eletrical pulses are shot at the designated target, shocking and stunning them!","Raiton")


			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Raiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Raiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Raiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Raiton? Get some more Knowledge with Katon!";return
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Raiton? Get some more Knowledge with Suiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Lightning Chakra",AmountofExp,"LightningChakra","The Lightning Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Lightning-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	RockJounin11
		name = "Iwazuka, Aeon"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KakashiH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(50,50,50)
				Shirt+=rgb(0,75,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Shoot for the winds, never the stars."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Iwazuka"||usr.Clan2=="Iwazuka")
				usr<<"Hello, I am the Iwazuka trainer. Do you wish to learn the ephemeral art of explosions? I can show you that art....is a bang."
				switch(input(usr,"Would you like to learn some techniques?", "Iwazuka") in list ("C1","C2","C3","C4","Clay Carrier","C0","Cancel"))
					if("C1")
						usr.LearnJutsu("C1",0,"C1","C1 is the basic type of explosive, and useful in long range combat.");return

					if("C2")
						var/found2=0
						for(var/obj/SkillCards/C1/P in A)
							if(P.type == /obj/SkillCards/C1)
								found2=1
						if(!found2)
							usr<<"You need to know how to use C1 first!";return
						if(usr.ExplosiveMastery<25)
							usr<<"You need more Explosive Mastery!";return
						usr.LearnJutsu("C2",0,"C2","C2 is a more deadly type of explosive and can create bigger and guided and more deadly explosives.","Ninjutsu");return
					if("C3")
						var/found2=0
						for(var/obj/SkillCards/C2/P in A)
							if(P.type == /obj/SkillCards/C2)
								found2=1
						if(!found2)
							usr<<"You need to learn to use C2 first!";return
						if(usr.ExplosiveMastery<75)
							usr<<"You need more Explosive Mastery!";return
						usr.LearnJutsu("C3",0,"C3","C3 is extremely explosive and dangerous. It is capable of making huge explosives and even bigger explosions. Stay back when you light these off...","Ninjutsu");return
					if("C4")
						var/found2=0
						for(var/obj/SkillCards/C3/P in A)
							if(P.type == /obj/SkillCards/C3)
								found2=1
						if(!found2)
							usr<<"You need to learn to use C3 first!";return
						if(usr.ExplosiveMastery<100)
							usr<<"You need more Explosive Mastery!";return
						usr.LearnJutsu("C4",0,"C4","C4 is extremely lethal explosion that create parasetic explosives that are so small that only chakra viewers could possibly see it!","Ninjutsu");return
					if("Clay Carrier")
						var/found2=0
						for(var/obj/SkillCards/C4/P in A)
							if(P.type == /obj/SkillCards/C4)
								found2=1
						if(!found2)
							usr<<"You need to learn to use C4 first!";return
						if(usr.ExplosiveMastery<100)
							usr<<"You need more Explosive Mastery!";return
						usr.LearnJutsu("Clay_Carrier",0,"Clay_Carrier","Clay Carrier is a mount used to get from one place to another.!","Ninjutsu");return
					if("C0")
						var/found2=0
						for(var/obj/SkillCards/Clay_Carrier/P in A)
							if(P.type == /obj/SkillCards/Clay_Carrier)
								found2=1
						if(!found2)
							usr<<"You need to learn Clay Carrier first!";return
						usr.LearnJutsu("C0",0,"C0","C0 is a suicidal jutsu, which has a very high ratio to kill both of you....use it at your own risk.","Ninjutsu")


	RockJounin12
		name = "Tsuchiruke"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				A+=rgb(0,0,0)
				Base+=rgb(128,064,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=A
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.icon_state="rest"
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Omn. Ommnn. Ommnnn."
			sleep(11)
			if(usr.Village=="Rock"&&usr.BeginningVillage=="Rock")
				switch(input(usr,"I hold the concentration for Rock Village's teleportation jutsu. It's developed as a defence for our ninja and can be used anytime. I can teach you the technique?", "Renden Teleporation") in list ("Yes","No"))
					if("Yes")
						if(usr.NinjutsuKnowledge<50)
							usr<<"You need more Ninjutsu Knowledge.";return
						usr.LearnJutsu("Renden Teleportation",0,"RendenTeleportation","Renden Teleportation is a jutsu where the user concentrates for a couple of seconds and then teleports to the designated location in Rock. Could be used for defence or other means.","Ninjutsu");return
	RockJounin13
		name = "Shojin, Yotohamo"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rock"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MinatoH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(75,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RockJounin.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello stranger, how's it going?"
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Shojin"||usr.Clan2=="Shojin")
				usr<<"Ah, I see you're a Shojin! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Sabaku Clan") in list ("Crystal Needles","Crystal Shurikens","Crystal Armor","Crystal Mirror","Crystal Clone","Crystal Wall","Crystal Prison","Giant Hexagonal Crystal Shuriken","Crystal Lance","Crystal Wheel","Crystal Labyrinth","Crystal Barrier Dome","Crystal Thorn Field","Crystal Dragon Jutsu","Cancel"))
					if("Crystal Needles")
						usr.LearnJutsu("Crystal Needle",0,"CrystalNeedle","Crystal Needle is a technique where the user uses their chakra to create dense crystal spikes and hurled forward.","Shoton");return

					if("Crystal Shurikens")
						if(usr.ShotonKnowledge<10)
							usr<<"You need more Shoton Knowledge.";return
						usr.LearnJutsu("Crystal Shurikens",0,"CrystalShuriken","Crystal Shuriken is a more advanced crystal shape manipulation where the user shapes multiple shurkens of hard Crystalized chakra.","Shoton");return

					if("Crystal Armor")
						if(usr.ShotonKnowledge<25)
							usr<<"You need more Shoton Knowledge.";return
						usr.LearnJutsu("Crystal Armor",0,"KesshoNoYoroi","The user creates a thin layer of hardened Crystal around their immediate body to reduce any outside damage.","Shoton");return

					if("Crystal Mirror")
						if(usr.ShotonKnowledge<40)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<5)
							usr<<"You need more Shoton Mastery.";return
						usr.LearnJutsu("Crystal Mirror",0,"CrystalMirror","Crystal Mirror is a technique where the user creates a simple Mirror made of Crystal.","Shoton");return

					if("Crystal Clone")
						var/found=0
						for(var/obj/SkillCards/CrystalMirror/P in A)
							if(P.type == /obj/SkillCards/CrystalMirror) found=1
						if(!found)
							usr<<"You need to learn Crystal Mirror to use this jutsu!";return

						if(usr.ShotonKnowledge<45)
							usr<<"You need more Shoton Knowledge.";return
						usr.LearnJutsu("Crystal Clone",0,"ShotonNoBunshin","Use your Crystal Mirror to create Crystal Clones of yourself.","Shoton");return

					if("Crystal Wall")
						if(usr.ShotonKnowledge<10)
							usr<<"You need more Shoton Knowledge.";return
						usr.LearnJutsu("Crystal Wall",0,"CrystalEncampment","Crystal Wall is a technique where the user of it creates a thick wall of protective Crystals around the themself.","Shoton");return

					if("Crystal Prison")
						if(usr.ShotonKnowledge<65)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<8)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<5)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Crystal Prison",0,"CrystalPrison","Crystal prison forms a dense wall of Crystals around a target.","Shoton");return

					if("Giant Hexagonal Crystal Shuriken")
						if(usr.ShotonKnowledge<50)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<5)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<5)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Giant Hexagonal Crystal Shuriken",0,"HexagonCrystal","Giant Crystal Shuriken is a technique where the user generates a giant snow-flake shaped Shuriken of Crystal and hurled at a target.","Shoton");return

					if("Crystal Lance")
						if(usr.ShotonKnowledge<65)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<7)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<5)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Crystal Lance",0,"CrystalLance","Crystal Lance forms a Spear of Crystal around the users arm.","Shoton");return

					if("Crystal Wheel")
						if(usr.ShotonKnowledge<75)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<7)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<10)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Crystal Wheel",0,"CrystalWheel","The user creates a ring-shaped wheel out of crystal and has it circle around them.","Shoton");return

					if("Crystal Barrier Dome")
						if(usr.ShotonKnowledge<75)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<7)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<10)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Crystal Dome",0,"CrystalDome","Create a Protective Dome of Crystals that can surround allies to protect them from damage outisde.","Shoton");return

					if("Crystal Labyrinth")
						if(usr.ShotonKnowledge<75)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<9)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<15)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Crystal Labyrinth",0,"CrystahLabyrinth","The user of this technique creates an entrapment of Hard Crystal that will trap them and anyone they see fit inside.","Shoton");return

					if("Crystal Thorn Field")
						if(usr.ShotonKnowledge<75)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<9)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<15)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Crystal Thorn Field",0,"CSawarabi","Growing Crystal Thorn Field creates growing thorn-like crystals that spread over a wide area and stab anyone caught within it. ","Shoton");return
					if("Crystal Dragon Jutsu")
						if(usr.ShotonKnowledge<75)
							usr<<"You need more Shoton Knowledge.";return
						if(usr.ShotonMastery<9)
							usr<<"You need more Shoton Mastery.";return
						if(usr.CrystalChakra<15)
							usr<<"You need more Crystal Chakra.";return
						usr.LearnJutsu("Tearing Crystal Falling Dragon",0,"HashoKoryu"," The user crystallises a material in the area, and then turns it into a dragon. The user then controls it to attack a target.","Shoton");return
//Rain Ninja/////////////////////////////////////////////
	RainJounin1
		name = "Haruke(NPC)"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				A+=rgb(0,0,150)
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=A
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.icon_state="rest"
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Omn. Ommnn. Ommnnn."
			sleep(11)
			if(usr.Village=="Rain"&&usr.BeginningVillage=="Rain")
				switch(input(usr,"I hold the concentration for Rain Village's teleportation jutsu. It's developed as a defence for our ninja and can be used anytime. I can teach you the technique?", "Fuuma Teleporation") in list ("Yes","No"))
					if("Yes")
						if(usr.NinjutsuKnowledge<50)
							usr<<"You need more Ninjutsu Knowledge.";return
						usr.LearnJutsu("Fuuma Teleportation",0,"FuumaTeleportation","Fuuma Teleportation is a jutsu where the user concentrates for a couple of seconds and then teleports to the designated location in Rain. Could be used for defence or other means.","Ninjutsu");return
	RainJounin2
		name = "Jiruke"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52)
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi';A+=rgb(0,0,150)
				var/Hair='Icons/New Base/Hair/InoH.dmi';Hair+=rgb(0,150,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi';src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi';src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi';src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi';src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=A
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi';src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair;src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Rain...Rain...Come again another day."
			sleep(11)
			if(usr.Village=="Rain")
				switch(input(usr,"It hasn't rained forever. Would you like to learn a technique? It makes potential rain.", "Ikusenhari No Hageshii Tosshin") in list ("Yes","No"))
					if("Yes")
						if(usr.NinjutsuKnowledge<50)
							usr<<"You need more Ninjutsu Knowledge.";return
						usr.LearnJutsu("Ikusenhari",0,"Ikusenhari","Ikusenhari No Hageshii Tosshin is a strong technique that summons a torrent of needles that fall from the sky like rain drops and attack all in view. This is a suicidal jutsu, despite its high damage it can do a lot of damage to the user.","Ninjutsu");return
	RainJounin3
		name = "Fuuma Atoke"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/hair='Icons/New Base/Hair/narutoH.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				hair+=rgb(200,200,200)
				A+=rgb(0,0,150)
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=A
				src.overlays+=hair
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The Fuuma Clan is strong. As a Fuuma ninja you can never be pushed around."
			sleep(11)
			if(usr.Clan=="Fuuma"||usr.Clan2=="Fuuma")
				switch(input(usr,"I see, so you are a Fuuma Ninja. I hold a secret weapon of the clan if you are interested?", "Chakra Blade") in list ("Yes","No"))
					if("Yes")
						var/count=0
						for(var/obj/WEAPONS/ChakraKatana/P in usr.contents)
							if(P.type == /obj/WEAPONS/ChakraKatana) count+=1
						if(count==2)
							usr<<"You have more than enough. You don't need any!";return
						if(count==1)
							if(usr.SpeedDice<3)
								usr<<"I don't think your skill with a sword is good enough to double wield with this blade.";return
							var/obj/WEAPONS/ChakraKatana/A=new()
							A.loc=usr
							usr<<"Here you go."
						if(count==0)
							var/obj/WEAPONS/ChakraKatana/A=new()
							A.loc=usr
							usr<<"Here you go."
	RainJounin4
		name = "Tsunami"
		icon_state="NPC1"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/hair='Icons/New Base/Hair/SpikedPonytailH.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				hair+=rgb(200,200,200)
				A+=rgb(0,0,150)
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=A
				src.overlays+=hair
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"I am...The Tsunami! Cause' mist ain't beautiful, without some ami! Oh!!!"
			sleep(3)
			if(usr.Village=="Rain")
				switch(input(usr,"Weather is such a drag without mist,lags,and blood! Wanna learn some stuff?", "Kirigakure No Jutsu") in list ("Teach me Rain","Teach me to Locate","Teach me Mist","Teach me to Poison...","Teach me to Kill...","Teach me to make it Rain Blood...","No"))
					if("Teach me Mist")
						if(usr.VMorale<40)
							usr<<"You are not committed enough to this village!";return
						if(usr.NinjutsuKnowledge<15)
							usr<<"You need more Ninjutsu Knowledge.";return
						if(usr.blevel=="D"||usr.blevel=="E")
							usr<<"Hidden Mist: Your class is too low for this technique.";return
						usr.LearnJutsu("Kirigakure No Jutsu",0,"Kirigakure","Kirigakure No Jutsu is a jutsu that creates a mass torrent of mist that covers the field.","Ninjutsu");return
					if("Teach me Rain")
						if(usr.VMorale<50)
							usr<<"You are not committed enough to this village!";return
						if(usr.NinjutsuKnowledge<150)
							usr<<"You need more Ninjutsu Knowledge.";return
						if(usr.blevel=="D"||usr.blevel=="E")
							usr<<"Draining Rain: Your class is too low for this technique.";return
						usr.LearnJutsu("Kiriame No Jutsu",0,"Kiriame","Kiriame is a jutsu that creates a draining rain that kills off any source of chakra it touches.","Ninjutsu");return
					if("Teach me to Poison...")
						if(usr.VMorale<100)
							usr<<"You are not committed enough to this village!";return
						if(usr.PoisonKnowledge<25)
							usr<<"You don't know enough about poisons to learn this!";return
						if(usr.NinjutsuKnowledge<300)
							usr<<"You need more Ninjutsu Knowledge.";return
				//		usr.LearnJutsu("Poisoning Rain",35000,"PoisonRain","Poisoning Rain is a jutsu that creates a rain of deadly poison that harms people as it soaks them wet...","Ninjutsu");return
					if("Teach me to Locate")
						if(usr.VMorale<125)
							usr<<"You are not committed enough to this village!";return
						if(usr.NinjutsuKnowledge<200)
							usr<<"You need more Ninjutsu Knowledge.";return
				//		usr.LearnJutsu("Raveling Rain",50000,"RavelRain","Raveling Rain is a jutsu that creates a rain enfused with your own chakra and allows you to know if the rain has drenched anyone, allowing you to know if anybody is nearby.","Ninjutsu");return
					if("Teach me to Kill...")
						if(usr.VMorale<100)
							usr<<"You are not committed enough to this village!";return
						if(usr.NinjutsuKnowledge<200&&usr.TaijutsuKnowledge<450)
							usr<<"You need more Ninjutsu Knowledge or Taijutsu Knowledge!";return
						usr.LearnJutsu("Silent Killing: Assassination",0,"SilentKilling","First steps to becoming an Assassin is knowing how to kill Quietly.","Taijutsu");return
					if("Teach me to make it Rain Blood...")
						if(usr.SenbonMastery<30)
							usr<<"You aren't proficient enough with Senbons to learn this technique..";return
						if(usr.VMorale<150)
							usr<<"You are not committed enough to this village!";return
						usr.LearnJutsu("Senbon Rain",0,"Ikusenhari","Ninpou: Ikusenhari No Hageshii Tosshin is a jutsu that is commonly used by Senbon Users of the Hidden Rain Village. The user throws senbons into the air, which then multiplies into several hurling upon the enemy and the user both.","Ninjutsu")


	Rain_Suiton_Teacher
		name = "Hare Shin"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/hair='Icons/New Base/Hair/SasukeTS.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				hair+=rgb(200,200,200)
				A+=rgb(0,0,150)
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=A
				src.overlays+=hair
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am one of the genius Water-Natured Jounin in the village. But I also take my time to teach ninja techniques."
			sleep(3)

			if(usr.WaterE)
				var/katonknow = input("Tell me what Suiton technique you would you like to learn?","Suiton Technique")
				if(findtext(katonknow,"mizurappa",1,0))
					usr.LearnJutsu("Suiton Mizurappa No Jutsu",0,"Mizurappa","Suiton Mizurappa No Jutsu is a beam-water technique that shoots water out from the user's mouth with great force and pressure.","Suiton")
				if(findtext(katonknow,"Suijinheki",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suijinheki No Jutsu",0,"Suijinheki","Suiton Suijinheki No Jutsu is a jutsu that creates a quick block infront of the user to block incoming techniques.","Suiton")


				if(findtext(katonknow,"creation",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Water Creation Jutsu",0,"WaterCreation","Water Creation Jutsu is a jutsu that creates a supply of water allowing players to use.","Suiton")



				if(findtext(katonknow,"suiryuudan",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suiryuudan No Jutsu",0,"Suiryuudan","Suiton Suiryuudan No Jutsu is a jutsu which summons a dragon made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"suikoudan",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suikoudan No Jutsu",0,"Suikoudan","Suiton Suikoudan No Jutsu is a jutsu whcih summons a shark made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"mizuame nabara",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Mizuame Nabara No Jutsu",0,"MizuameNabara","Mizuame Nabara No Jutsu is a jutsu that creates sticky syrup around the user making those stuck in it immobile.","Suiton")

				if(findtext(katonknow,"daibakufu",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Daibakufu No Jutsu",0,"Daibakufu","Suiton Daibakufu No Jutsu is a jutsu which shoots a large torrent which keeps the enemy in repetive damage.","Suiton")

				if(findtext(katonknow,"baku suishou",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Baku Suishouha No Jutsu",0,"BakuSuishouha","Suiton Baku Suishou No jutsu is a technique that shoots a large torrent wave that covers the field with water that can be used to the user's advantage.","Suiton")
/////
				if(findtext(katonknow,"steam gas",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("steam gas",0,"SteamGas","Suiton Baku Suishou No jutsu is a technique that shoots a large torrent wave that covers the field with water that can be used to the user's advantage.","Suiton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Suiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Suiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Suiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Suiton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Suiton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Water Chakra",AmountofExp,"WaterChakra","The Water Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Water-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	RainJounin6
		name = "Shiroi, Haku"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"I think the named the Clan after me. Don't know why they didn't name it after my last name, but I have an astounding ability!"
			sleep(3)
			if(usr.Clan=="Shiroi"||usr.Clan2=="Shiroi")
				var/list/A=usr.LearnedJutsus
				var/found=0
				for(var/obj/SkillCards/IceShard/P in A)
					if(P.type == /obj/SkillCards/IceShard) found=1
				if(found)
					usr<<"You learned from that brute? I can not teach the likes of you!"
				else
					usr<<"Ah, I see you have the same Kekkai Genkai as me? Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Shiroi Clan") in list ("Yuki Shuriken","Sensatsu Suishou","Aisu Sawarabi","Ice Creation","Makyou Hyoushou","Cancel"))
					if("Yuki Shuriken")
						usr.LearnJutsu("Yuki Shuriken",0,"SnowShuriken","Yuki Shuriken is a technique that can be done anywhere, allowing the user to create shurikens of snow to throw at the enemy. Although it may sound weak, the snow is surprisingly real hard.","Hyouton");return

					if("Sensatsu Suishou")
						if(usr.IceRush<15)
							usr<<"You don't have enough Ice Rush.";return
						usr.LearnJutsu("Sensatsu Suishou",0,"SensatsuSuishou","Sensatsu Suishou is a technique which turns water nearby into needles of ice that can easily rip an enemy into pieces.","Hyouton");return

					if("Aisu Sawarabi")
						if(usr.IceRush<45)
							usr<<"You don't have enough Ice Rush.";return
						usr.LearnJutsu("Aisu Sawarabi",0,"ISawarabi","Aisu Sawarabi is a technique utilizing the moist air around you to form ice spikes out of nowhere. It requires no handseals, thus can be done in some of the most dangerous situations.","Hyouton");return
					if("Ice Creation")
						if(usr.IceRush<45)
							usr<<"You don't have enough Ice Rush.";return
						usr.LearnJutsu("Hyouton: Ice Creation",0,"IceField","Ice Creation is a jutsu that allows a user that practices enough to create large bodies of ice upon their created Water.","Hyouton");return

					if("Makyou Hyoushou")
						if(usr.IceRush<50)
							usr<<"You don't have enough Ice Rush.";return
						usr.LearnJutsu("Makyou Hyoushou",0,"MakyouHyoushou","Makyou Hyoushou is a jutsu that allows the user to create crystal mirrors practically unbreakable. After creating them they can move through them at high speeds, having an incredible advantage over their enemy.","Hyouton");return
	SharkTeacher
		name = "Hoshigaki, Kisame"
		icon_state="NPC2"
		CNNPC = 1
		Village="Rain"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/InoH.dmi'
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(150,150,0)
				Shirt+=rgb(55,41,122)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
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
			usr<<"You are a shark, so you should learn this from me!"
			sleep(3)
			if(usr.Clan=="Hoshigaki"||usr.Clan2=="Hoshigaki")
				usr<<"You are a shark, so you should learn this from me!"
			else if(!usr.kills==60)
				usr<<"You are a shark, so you should learn this from me!"
			else switch(input(usr,"Do you want to learn your ancestor's technique?", "Hoshigaki Clan") in list ("Shark Mode","Cancel"))
				if("Shark Mode")
					usr.LearnJutsu("Shark Mode",0,"SharkMode","This technique is like a reverse of Jyuken striking a tenketsu out, to where as the Hyuuga uses it more as a support technique. This technique strikes one of the ninja's tenketsu, forcing their chakra circulation on making it easier to gather chakra and use it.","Taijutsu");return
	Rain_Katon_Teacher
		name = "Shimataro"
		icon_state="NPC2"
		CNNPC = 1
		Village="Rock"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/InoH.dmi'
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(150,150,0)
				Shirt+=rgb(55,41,122)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
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
			usr<<"Burn baby burn..."
			sleep(3)
			if(usr.FireE)
				var/katonknow = input("Tell me what Katon technique you would you like to learn?","Katon Technique")
				if(findtext(katonknow,"hikibou",1,0))
					usr.LearnJutsu("Katon Hikibou No Jutsu",0,"Hikibou","Katon Hikibou No Jutsu is a technique where the user heats the air around the target. After heating the air, that region will combust in flames. It is very useless at the beginning, but the more you use it the stronger it gets.","Katon")
				if(findtext(katonknow,"goukakyuu",1,0)||findtext(katonknow,"fireball",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Goukakyuu No Jutsu",0,"Goukakyuu","Katon Goukakyuu No jutsu is a field ranged jutsu that releases fire from the mouth. It covers a small radius, that can improve, so it can be very useful in combat.","Katon")
				if(findtext(katonknow,"housenka",1,0)||findtext(katonknow,"phoenix flower",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Housenka No Jutsu",0,"Housenka","Katon Housenka No Jutsu is a jutsu that shoots multiple fire balls from the mouth that explode in fire on contact of a target.","Katon")
				if(findtext(katonknow,"ryuuka",1,0)||findtext(katonknow,"dragon fire",1,0))
					if(usr.KatonKnowledge<75)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Ryuuka No Jutsu",0,"Ryuuka","Katon Ryuuka No Jutsu is a concentrated form of Karyuu Endan that shoots a concentrated blast that explodes on contact of a physical object.","Katon")
			//	if(findtext(katonknow,"ka no senbon",1,0)||findtext(katonknow,"fire needles",1,0))
			//		usr.LearnJutsu("Katon; Ka No Senbon",15,"KnowKaNoSenbon","Katon Ka No Senbon is a jutsu where the user releases a small torrent of weak, but highly flammable stream of needles from their mouth that make things catch on fire. It continuasly goes until the user decides to stop.","Katon")
				if(findtext(katonknow,"karyuu endan",1,0)||findtext(katonknow,"dragon flame projectile",1,0))
					if(usr.KatonKnowledge<500)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Karyuu Endan",0,"KaryuuEndan","Katon Karyuu Endan shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio.","Katon")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Katon?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Katon? Get some more Knowledge with Suiton!";return
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Katon? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Katon? Get some more Knowledge with Doton!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Katon? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
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
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Fire Chakra",AmountofExp,"FireChakra","The Fire Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform fire techniques. These techniques primarily hit health and stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think your capable of mastering another element."
					return
	Rain_Fuuton_Teacher
		name = "Akai"
		icon = 'Icons/New Base/Base.dmi'
		icon_state="NPC1"
		Village="Rain"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/leeH.dmi'
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(55,41,122)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"It's been a long time since it has rained."
			sleep(3)
			if(usr.WindE)
				var/katonknow = input("Tell me what Wind technique you would you like to learn?","Fuuton Technique")
				if(findtext(katonknow,"daitoppa",1,0)||findtext(katonknow,"great breakthrough",1,0))
					if(usr.FuutonKnowledge<25)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Fuuton Daitoppa No Jutsu",0,"Daitoppa","Fuuton Daitoppa No jutsu is a technique that fires a gust of wind that shoots targets back. It can be used for combustion.","Fuuton")

				if(findtext(katonknow,"spinning wind",1,0)||findtext(katonknow,"spinning",1,0))
					usr.LearnJutsu("Spinning Wind",0,"SpinningWind","Spinning Wind is a technique that emits a small gust that leaves the target within a spinning wind for a small amount of time.","Fuuton")

				if(findtext(katonknow,"wind trick",1,0)||findtext(katonknow,"trick",1,0))
					usr.LearnJutsu("Wind Trick",0,"WindTrick","Wind Trick is a jutsu utilizing wind currents. It produces a strong turrent of wind that pushes back nearby targets and possible attackers, the wind current increase in size the more mastery of it.","Fuuton")

				if(findtext(katonknow,"reppushou",1,0)||findtext(katonknow,"gale wind palm",1,0))
					usr.LearnJutsu("Fuuton Reppushou No Jutsu",0,"Reppushou","Fuuton Reppushou No Jutsu is a jutsu that shoots a wave of wind that can shoot back the enemy or speed up things.","Fuuton")

				if(findtext(katonknow,"kaze dangan",1,0))
					usr.LearnJutsu("Kaze Dangan No Jutsu",0,"KazeDangan","Fuuton Kaze Dangan No Jutsu is a technique that shoots a fast paced bullet that hits the opponent with incredible force and pressure.","Fuuton")

				if(findtext(katonknow,"renkuudan",1,0)||findtext(katonknow,"drilling air projectile",1,0))
					if(usr.FuutonKnowledge<150)
						usr<<"You need more Fuuton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Fuuton Renkuudan No Jutsu",0,"Renkuudan","Fuuton Renkuudan No Jutsu is a strong, powerful blast of wind that explodes on contact with the enemy!","Fuuton")
				if(findtext(katonknow,"senbon",1,0))
					if(usr.FuutonKnowledge<100)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Fuuton Senbon Dice",25000,"SenbonDice","Fuuton: Senbon Dice is a Wind Based technique that allows the user to increase the speed of small projectiles, such as Senbons. Because of the Jutsu's fierce power, it is commonly used by the Hunter-Nin Ops for assassinations.","Fuuton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Fuuton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Fuuton? Get some more Knowledge with Suiton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Fuuton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Fuuton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Fuuton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Wind Chakra",AmountofExp,"WindChakra","The Wind Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Wind-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Rain_Doton_Teacher
		name = "Raruyio"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Shirt='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				Base+=rgb(235,145,52)
				Shirt+=rgb(55,41,122)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=Shirt
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am one of the strongest Earth-Natured Ninja in all of the village. But I also take my time to teach ninja techniques."
			sleep(3)
			if(usr.EarthE)
				var/katonknow = input("Tell me what Earth technique you would you like to learn?","Earth Technique")
				if(findtext(katonknow,"doryo dango",1,0))
					usr.LearnJutsu("Doton Doryo Dango",0,"DoryoDango","Doton Doryo Dango is a technique in which the user uses their strength to pull a boulder from the ground and throw it with great force.","Doton")

				if(findtext(katonknow,"doruki gaeshi",1,0))
					usr.LearnJutsu("Doton; Doruki Gaeshi",0,"DorukiGaeshi","Doton; Doruki Gaeshi is a jutsu which places a earth wall of defence in front of you to protect you.","Doton")

				if(findtext(katonknow,"tsuchi wana",1,0))
					if(usr.DotonKnowledge<50)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Tsuchi Wana",0,"TsuchiWana","Doton; Tsuchi Wana is a technique that creates a field of rocks around the target, binding them.","Doton")

//					if(findtext(katonknow,"dochu eigyo",1,0))
//						usr.LearnJutsu("Doton; Dochu Eigyo No Jutsu",15,"Dochu Eigyo","Doton; Dochu Eigyo No Jutsu is a technique that allows the user to move freely underground.","Doton")

				if(findtext(katonknow,"taiga",1,0)||findtext(katonknow,"earth flow river",1,0))
					if(usr.DotonKnowledge<100)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryu Taiga",0,"Taiga","Doton; Doryuu Taiga is a technique which creates a flow of river made out of mud, pushing the target away.","Doton")

				if(findtext(katonknow,"doryuuheki",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuuheki No Jutsu",0,"Doryuuheki","Doton; Doryuuheki is a jutsu that creates a strong wall of defence in front of you to block techniques.","Doton")

				if(findtext(katonknow,"Dorou Domu",1,0))
					if(usr.DotonKnowledge<200)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton: Dorou Domu",0,"DorouDomu","Doton: Dorou Domu is a defensive earth sphere. It surrounds you and prevents almost any attack from penetrating. Unfortunately it is difficult to master and while in use you are unable to see outside.","Doton")

				if(findtext(katonknow,"doryuudan",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuudan No Jutsu",0,"Doryuudan","Doton; Doryuudan No Jutsu is a strong jutsu that summons a dragon that shoots spikes from its mouth.","Doton")

				if(findtext(katonknow,"yomi numa",1,0))
					if(usr.DotonKnowledge<500)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Yomi Numa No Jutsu",0,"YomiNuma","Doton; Yomi Numa produces a strong swamp that captures all who are within it.","Doton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Doton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
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
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Earth Chakra",AmountofExp,"EarthChakra","The Earth Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform earth-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Rain_Raiton_Teacher
		name = "Shinji, Aka"
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
			usr<<"Hello, I am one of the genius Lightning-Natured Jounin in the village. But I also take my time to teach ninja techniques."
			sleep(3)
			if(usr.LightningE)
				var/katonknow = input("Tell me what Lightning technique you would you like to learn?","Lightning Technique")
				if(findtext(katonknow,"raikyuu",1,0))
					usr.LearnJutsu("Raiton; Raikyuu No Jutsu",0,"Raikyuu","Raiton; Raikyuu No Jutsu is a technique where the user charges chakra within their hands and shoot it off.","Raiton")

				if(findtext(katonknow,"rairyuu no tatsumaki",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rairyuu no Tatsumaki",0,"Tatsumaki","Raiton; Rairyuu No Tatsumaki is a jutsu where the user creates a strong dragon that is controllable in movement and damage.","Raiton")

				if(findtext(katonknow,"ikazuchi no kiba",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Ikazuchi No Kiba",0,"IkazuchiKiba","Raiton; Ikazuchi No Kiba is a powerful Raiton technique which shoots bolts of lightning on all side of the user!","Raiton")

				if(findtext(katonknow,"garou",1,0))
					if(usr.RaitonKnowledge<35)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rai no Garou",0,"RairyuuGarou","Raiton; Rai no Garou is a technique where the user spins rapidly in a fierce tornado, attracting static energy which they can rip the opponent to shreds.","Raiton")

				if(findtext(katonknow,"gian",1,0))
					if(usr.RaitonKnowledge<500)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Raiton; Gian",0,"Gian","Raiton; Gian is an incredibly powerful technique which shoots a line of lightning from the user which zaps the target powerfully!","Raiton")

				if(findtext(katonknow,"raigeki",1,0))
					if(usr.RaitonKnowledge<45)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Raigeki No Yoroi",0,"Yoroi","Raiton; Raigeki No Yoroi is a powerful technique that absorbs all Raiton techniques shot at the user!","Raiton")

				if(findtext(katonknow,"jibashi",1,0))
					if(usr.RaitonKnowledge<125)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Jibashi",0,"Jibashi","Raiton; Jibashi is a jutsu where eletrical pulses are shot at the designated target, shocking and stunning them!","Raiton")
				if(findtext(katonknow,"touei",1,0))
					if(usr.RaitonKnowledge<200)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.ElementalCapacity>2)
						usr<<"You have too many elements to be able to master a jutsu of this level.";return
					usr.LearnJutsu("Raiton, Touei",0,"Touei","Raiton Touei is a jutsu that allows you to temporarily focus your elemental chakra into quick bursts for instantaneous-like movement.","Raiton")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Raiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Raiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Raiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Raiton? Get some more Knowledge with Katon!";return
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Raiton? Get some more Knowledge with Suiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0

					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Lightning Chakra",AmountofExp,"LightningChakra","The Lightning Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Lightning-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	RainJounin11
		name = "Shiroi, Erin"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,200)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Gee I hate that Haku! He doesn't have any idea how to use our ability properly with his snowball techniques! I'll show you how to really fight!"
			sleep(3)
			if(usr.Clan=="Shiroi"||usr.Clan2=="Shiroi")
				var/list/A=usr.LearnedJutsus
				var/found=0
				for(var/obj/SkillCards/IceShard/P in A)
					if(P.type == /obj/SkillCards/SnowShuriken) found=1
				for(var/obj/SkillCards/SensatsuSuishou/P in A)
					if(P.type == /obj/SkillCards/SensatsuSuishou) found=1
				for(var/obj/SkillCards/MakyouHyoushou/P in A)
					if(P.type == /obj/SkillCards/MakyouHyoushou) found=1
				if(found)
					usr<<"You're one of those pansies who follow him aren't you!? Tch, figures!"
				else
					usr<<"Hey, maybe I can teach you some real Ice Manipulation, huh?"
				switch(input(usr,"Would you like to learn some techniques?", "Shiroi Clan") in list ("Ice Shard Jutsu","Aisu Sawarabi","Cancel"))
					if("Ice Shard Jutsu")
						usr.LearnJutsu("Ice Shard Jutsu",0,"IceShard","Ice Shard Jutsu is a technique that requires water. Using the water provided, by adding Hyouton you're able to add a strong shard of ice, like icicles, that are able to pierce enemies on all sides.","Hyouton");return
					if("Aisu Sawarabi")
						if(usr.IceRush<45)
							usr<<"You don't have enough Ice Rush.";return
						usr.LearnJutsu("Aisu Sawarabi",0,"ISawarabi","Aisu Sawarabi is a technique utilizing the moist air around you to form ice spikes out of nowhere. It requires no handseals, thus can be done in some of the most dangerous situations.","Hyouton");return
	RainJounin12
		name = "Moya(NPC)"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi';Base+=rgb(235,145,52);src.icon=Base;src.overlays+='Icons/New Base/FemaleEyes.dmi';src.overlays+='Icons/New Base/Eyes.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi';A+=rgb(0,0,150)
				src.overlays+='Icons/New Base/Clothing/Panties.dmi';src.overlays+='Icons/New Base/Clothing/Bra.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/RainJounin.dmi'
				src.overlays+=A;src.overlays+='Icons/New Base/Clothing/Cloths.dmi';src.overlays+='Icons/New Base/Hair/InoH.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Art is a passion of mine."
			sleep(11)
			if(usr.Village=="Rain"&&usr.BeginningVillage=="Rain"||usr.Village=="Rain"&&usr.VMorale>125)
				if(usr.Clan=="Fuuma"||usr.Clan=="Basic")
					switch(input(usr,"Would you like to learn the artistic style of Origami Jutsu?", "Origami Jutsu") in list ("Yes","No"))
						if("Yes")
							if(usr.NinjutsuKnowledge<50)
								usr<<"You need more Ninjutsu Knowledge.";return
							switch(input(usr,"What would you like to learn?", "Origami Jutsu") in list ("Paper Style Dance","Paper Shuriken","Paper Butterflies","Butterfly Dance","Divine Spear","Paper Person Technique","Cancel"))//"Paper Person Technique","Cancel"))
								if("Paper Style Dance")
									if(usr.NinjutsuKnowledge<50)
										usr<<"You need more Ninjutsu Knowledge.";return
									if(usr.blevel=="D"||usr.blevel=="E")
										usr<<"Origami: Your class is too low for this technique.";return
									usr.LearnJutsu("Paper Style Dance",0,"Paper_Mode","Paper Style Dance is a powerful technique that allows you to transform yourself into paper.","Ninjutsu");return
								if("Paper Shuriken")
									if(usr.NinjutsuKnowledge<50)
										usr<<"You need more Ninjutsu Knowledge.";return
									var/Have=0
									for(var/obj/SkillCards/Paper_Mode/A in usr.LearnedJutsus)
										Have=1
									if(!Have)
										usr<<"You must learn Paper Style Dance first!";return
									usr.LearnJutsu("Paper Shuriken",0,"Paper_Shuriken","Paper Shuriken is a projectile technique utilizing paper.","Ninjutsu");return
								if("Paper Butterflies")
									if(usr.NinjutsuKnowledge<50)
										usr<<"You need more Ninjutsu Knowledge.";return
									var/Have=0
									for(var/obj/SkillCards/Paper_Mode/A in usr.LearnedJutsus)
										Have=1
									if(!Have)
										usr<<"You must learn Paper Style Dance first!";return
									usr.LearnJutsu("Paper Butterflies",0,"Paper_Butterfly","Paper Butterflies is a technique that allows you to release a torrent of sharp Butterflies that cause harm to those that bump into them..","Ninjutsu");return
								if("Butterfly Dance")
									if(usr.NinjutsuKnowledge<50)
										usr<<"You need more Ninjutsu Knowledge.";return
									var/Have=0
									for(var/obj/SkillCards/Paper_Butterfly/A in usr.LearnedJutsus)
										Have=1
									if(!Have)
										usr<<"You must learn Paper Butterflies first!";return
									usr.LearnJutsu("Butterfly Dance",0,"Butterfly_Dance","Butterfly Dance is a technique that calls a circle of Paper Butterflies to dance around a target making it difficult for them to lose target.","Ninjutsu");return
								if("Divine Spear")
									if(usr.NinjutsuKnowledge<50)
										usr<<"You need more Ninjutsu Knowledge.";return
									var/Have=0
									for(var/obj/SkillCards/Paper_Butterfly/A in usr.LearnedJutsus)
										Have=1
									if(!Have)
										usr<<"You must learn Paper Butterflies first!";return
									usr.LearnJutsu("Divine Spear",0,"Paper_Spear","Divine Spear is a Origami based technique that shoots a powerful spear with force and pressure designed to kill on contact.","Ninjutsu");return
								if("Paper Person Technique")
									if(usr.NinjutsuKnowledge<500)
										usr<<"You need more ninjutsu knowledge.";return
									var/Have=0
									for(var/obj/SkillCards/Paper_Spear/A in usr.LearnedJutsus)
										Have=1
									if(!Have)
										usr<<"You must have Paper Spear to learn this jutsu!";return
									usr.LearnJutsu("Paper Person Technique",0,"Paper_Person","Paper Person Technique is a weaker version of the technique used by Konan against Uchiha, Obito long ago before the Fourth Great Ninja War. It allows the user to create a multitude of paper infused with exploding tags, allowing the user to explode them on will.","Ninjutsu");return
				else
					usr<<"Can we pretend that airplanes..."
//Sound Ninja///////////////////////////////////////////////
	SoundJounin1
		name = "Shirei"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Base.dmi'
				var/Hair='MadaraH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,150,0)
				src.icon=Base
				src.overlays-='Boxers.dmi'
				src.overlays+='Boxers.dmi'
				src.overlays-='FemaleEyes.dmi'
				src.overlays+='FemaleEyes.dmi'
				src.overlays-='Eyes.dmi'
				src.overlays+='Eyes.dmi'
				src.overlays-='pants.dmi'
				src.overlays+='pants.dmi'
				src.overlays-='Cloths.dmi'
				src.overlays+='Cloths.dmi'
				src.overlays+='soundoutfit.dmi'
				src.overlays+='headband.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			if(usr.Village!="Sound")
				usr<<"Why aren't you a Sound Ninja?";return
			var/list/A=usr.LearnedJutsus
			var/found=0
			for(var/obj/SkillCards/Zankuuha/P in A)
				if(P.type == /obj/SkillCards/Zankuuha) found=1
			if(found)
				usr<<"Hm, I really need to develop more things for it.";return
			else
				usr<<"Finally I've finished!"
				sleep(3)
				switch(input(usr,"", "") in list ("Finish What?","Nevermind"))
					if("Finish What?")
						usr<<"The Sound Amplifiers. It took years trying to replicate such amazing technology. I can install them for a price!";sleep(1)
						switch(input(usr,"The price is 30,000 Yen!", "") in list ("Sure","Screw You!"))
							if("Sure")
								if(usr.Yen<30000)
									usr<<"Not enough yen!";return
								else
									usr.Yen-=30000;usr<<"Thank you. Now all you have to do is learn how to control the air vents.";sleep(1)
									usr.LearnJutsu("Zankuuha",0,"Zankuuha","Zankuuha is a powerful Ninjutsu releasing Sound/Air Waves from the user's palms corresponding with the attack verb for long-ranged and push-back techniques.","Ninjutsu")
							else
								return
					else
						return
	SoundJounin1x
		name = "Shirai"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Base.dmi'
				var/Hair='SleekH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,150,0)
				src.icon=Base
				src.overlays+='Boxers.dmi'
				src.overlays+='FemaleEyes.dmi'
				src.overlays+='Eyes.dmi'
				src.overlays+='pants.dmi'
				src.overlays+='Cloths.dmi'
				src.overlays+='soundoutfit.dmi'
				src.overlays+='headband.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			if(usr.Village!="Sound")
				usr<<"Why aren't you a Sound Ninja?";return
			var/list/A=usr.LearnedJutsus
			var/found=0
			for(var/obj/SkillCards/Zankuuha/P in A)
				if(P.type == /obj/SkillCards/Zankuuha) found=1
			if(found)
				usr<<"Oh great! Another person with a sound device? Did you know the former Pink-Haired Otokami used a weapon like that?"
				switch(input(usr,"", "") in list ("He did?","I don't care"))
					if("He did?")
						usr<<"Yeah! In fact, I've been given instruction to keep his legendary technique alive! It's called Decapitating Air Sphere! It rips the insides of someone!"
						switch(input(usr,"", "") in list ("Wanna learn it?","Nevermind"))
							if("Wanna learn it?")
								usr.LearnJutsu("Zankuuha: Spiraling Sphere",0,"ZankuuSpiralingSphere","Zankuu Spiraling Sphere is a powerful Ninjutsu releasing Sound/Air Waves from the user's palms in a circular ball. It creates a massive large screeching. Once inserted into the enemy, their insides will begin to rip up as the air waves shoot all through out the insides of the opponent's body. A deadly technique.","Ninjutsu")

			else
				usr<<"How's it going?";return
	SoundJounin2
		name = "Kumojin, Kidou"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/shikaH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
				src.overlays+='Icons/New Base/Clothing/Headbands/headband.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"A Sound ninja is a Sound ninja for life."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Kumojin"||usr.Clan2=="Kumojin")
				usr<<"Oh, you're of the Kumojin Clan?"
				switch(input(usr,"Would you like to learn some techniques?", "Kumojin Clan") in list ("Spider Cobweb Flower","Spider Sticky Gold(Kunai)","Armor of Sticky Gold","Spider War Bow","Flowering Web","Giant Web Capture Field","Cancel"))
					if("Spider Cobweb Flower")
						if(usr.WebMastery<35)
							usr<<"You need more Web Mastery.";return
						usr.LearnJutsu("Spider Cobweb Flower",0,"Kumosouka","Spider Cobweb Flower is a variation of Kumoshibari, but instead of shooting one web it shoots multiple ones that can catch multiple targets.","Ninjutsu");return

					if("Spider Sticky Gold(Kunai)")
						usr.LearnJutsu("Spider Sticky Gold",0,"Nenkin","The art of making sticky-gold is a powerful thing for Kumojin ninja, because it creates hard materials out of nowhere as strong as metal and dangerous.","Ninjutsu");return

					if("Armor of Sticky Gold")
						var/found=0
						for(var/obj/SkillCards/Nenkin/P in A)
							if(P.type == /obj/SkillCards/Nenkin) found=1
						if(!found)
							usr<<"You need to learn Spider Sticky Gold to use this jutsu!";return

						if(usr.SpiderMastery<25)
							usr<<"You need more Spider Mastery.";return
						usr.LearnJutsu("Armor of Sticky Gold",0,"NenkinYoroi","Armor of Sticky Gold is a technique using the sticky gold function to cover the whole body to create an incredible defence.","Ninjutsu");return

					if("Spider War Bow")
						var/found=0
						for(var/obj/SkillCards/Nenkin/P in A)
							if(P.type == /obj/SkillCards/Nenkin) found=1
						if(!found)
							usr<<"You need to learn Spider Sticky Gold to use this jutsu!";return

						if(usr.SpiderMastery<75)
							usr<<"You need more Spider Mastery.";return
						usr.LearnJutsu("Spider War Bow",0,"Kumosenkyuu","Spider War Bow is a powerful technique rotating around the sticky-gold Kumojin ninja are able to make. It creates a bow which the ninja can shoot an arrow with such great velocity that they can level a forest.","Ninjutsu");return
					if("Flowering Web")
						if(usr.SpiderMastery<40)
							usr<<"You need more Spider Mastery.";return
						usr.LearnJutsu("Flowering Web",0,"DaiKumoshibariZ","Flowering Web is a jutsu that allows the Ninja to shoot their webs in all directions.","Ninjutsu");return
					if("Giant Web Capture Field")
						if(usr.SpiderMastery<49)
							usr<<"You need more Spider Mastery.";return
						usr.LearnJutsu("Giant Web Capture Field",0,"GiantWebMaze","Giant Web Capture Field is a jutsu that is great for Defence and Offence. The Kumojin releases a large amount of webs from within their body, capturing a large amount of people within it at once.","Ninjutsu");return
	SoundJounin3
		name = "Kaguya, Kuro"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,200)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Not everyone knows how to dance, that is."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Kaguya"||usr.Clan2=="Kaguya")
				usr<<"Oh, you're of the Kaguya Clan?"
				switch(input(usr,"Would you like to learn some techniques?", "Kaguya Clan") in list ("Bone Bullets","Bone Membrane","Dance of the Willow","Dance of the Camellia","Dance of the Larch","Dance of the Clematis","Cancel"))
					if("Bone Bullets")
						usr.LearnJutsu("Bone Bullets",0,"TenshiSendan","Bone Bullets is the jutsu where the user sends out multiple bullets from their fingers made from bones, with incredible power. Because of their shape, they can be a very dangerous weapon.");return

					if("Bone Membrane")
						usr.LearnJutsu("Bone Membrane",0,"BoneMembrane","Bone Membrane is a Kaguya specialty technique that allows you to create a dense armor underneath your skin in times of desperation that gives you an extreme amount of Endurance.");return

					if("Dance of the Willow")
						if(usr.BoneMastery<15)
							usr<<"You don't have enough Bone Mastery.";return
						usr.LearnJutsu("Dance of the Willow",0,"Yanagi","Dance of the Willow is the first dance among the several dances of the Kaguya Clan where the user moves in powerful, charging movements to dice down their enemies.","Taijutsu");return

					if("Dance of the Camellia")
						var/found=0
						for(var/obj/SkillCards/Yanagi/P in A)
							if(P.type == /obj/SkillCards/Yanagi) found=1
						if(!found)
							usr<<"You need to learn Yanagi No Mai to use this jutsu!";return

						if(usr.BoneMastery<15)
							usr<<"You don't have enough Bone Mastery.";return
						if(usr.DanceMastery<15)
							usr<<"You don't have enough Dance Mastery.";return
						usr.LearnJutsu("Dance of the Camellia",0,"Tsubaki","Dance of the Camellia is similiar to Dance of the Willow, except using one sword made of bone. It rotates on quick and flashy movements to dodge and swiftly destroy an enemy.","Taijutsu");return

					if("Dance of the Larch")
						var/found=0
						for(var/obj/SkillCards/Tsubaki/P in A)
							if(P.type == /obj/SkillCards/Tsubaki) found=1
						if(!found)
							usr<<"You need to learn Dance of the Camellia to use this jutsu!";return

						if(usr.BoneMastery<35)
							usr<<"You don't have enough Bone Mastery.";return
						if(usr.DanceMastery<20)
							usr<<"You don't have enough Dance Mastery.";return
						usr.LearnJutsu("Dance of the Larch",0,"Karamatsu","Dance of the Larch is a defensive and offensive technique for a Kaguya ninja. Bone spikes surrounding them, it guards them from attacks and they also have a offensive spinning attack.","Taijutsu");return

					if("Dance of the Clematis")
						var/found=0
						for(var/obj/SkillCards/Karamatsu/P in A)
							if(P.type == /obj/SkillCards/Karamatsu) found=1
						if(!found)
							usr<<"You need to learn Dance of the Larch to use this jutsu!";return

						if(usr.BoneMastery<65)
							usr<<"You don't have enough Bone Mastery.";return
						if(usr.DanceMastery<30)
							usr<<"You don't have enough Dance Mastery.";return
						usr.LearnJutsu("Dance of the Clematis",0,"Tessenka","Dance of the Clematis is a powerful dance which works on manipulating a whip out of your own spine to use on your offensive.","Taijutsu");return

	SoundJounin3x
		name = "Kaguya, Kai"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,200)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hey!"
			sleep(3)
//				var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Kaguya"||usr.Clan2=="Kaguya")
				usr<<"So you've come to learn the final Dance of our Clan, Dance of the seedling ferns? That's a tough technique, but I can teach it to you."
				switch(input(usr,"Would you like to learn some techniques?", "Kaguya Clan") in list ("Dance of the Seedling Fern","Dance of the Seedling Fern Advanced","Cancel"))
					if("Dance of the Seedling Fern")
						if(usr.blevel=="E"||usr.blevel=="D"||usr.blevel=="C")
							usr<<"I don't think you're ready to learn this technique.";return
						if(usr.BoneMastery<100)
							usr<<"You don't have enough Bone Mastery.";return
						if(usr.DanceMastery<30)
							usr<<"You don't have enough Dance Mastery.";return
						usr.LearnJutsu("Dance of the Seedling Fern",0,"Sawarabi","Dance of the Seedling Fern is a dance fully on massive bone manipulation, sending out spikes of controlled bones out from the ground to pierce through the enemies.","Taijutsu");return
					if("Dance of the Seedling Fern Advanced")
						if(!(locate(/obj/SkillCards/Sawarabi) in usr.LearnedJutsus))
							usr<<"You need to know Sawarabi before you can learn this jutsu!";return
						if(usr.blevel=="E"||usr.blevel=="D")
							usr<<"I don't think you're ready to learn this technique.";return
						if(usr.BoneMastery<99)
							usr<<"You don't have enough Bone Mastery.";return
						if(usr.DanceMastery<9)
							usr<<"You don't have enough Dance Mastery.";return
						usr.LearnJutsu("Dance of the Seedling Fern Advanced",0,"SawarabiAdvanced","Dance of the Seedling Fern Advanced is a step further with Dance of the Seedling Fern, allowing the user to place a weaker version of Sawa anywhere where they wish by double clicking.","Taijutsu");return
						return
					//	usr.LearnJutsu("Dance of the Seedling Fern Advanced",75000,"SawarabiAdvanced","Dance of the Seedling Fern Advanced is a step further with Dance of the Seedling Fern, allowing the user to place a weaker version of Sawa anywhere where they wish by double clicking.","Taijutsu");return

	SoundJounin3y
		name = "Kaguya, Link"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/WindH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,200)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hey!"
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Clan=="Kaguya"||usr.Clan2=="Kaguya")
				usr<<"Hey there. I'm Link and I teach the different moving techniques for the Kaguya Clan, if you're interested!"
				switch(input(usr,"Would you like to learn some techniques?", "Kaguya Clan") in list ("Swift Slash","Impale","Rapid Strike","Ibara","Clematis: Flower","Kochou","Cancel"))
					if("Swift Slash")
						usr.LearnJutsu("Swift Slash",0,"SwiftSlash","Swift Slash is a quick-paced fighting technique utilizing Yanagi. The user quickly slashes in all locations around them, wounding anyone.","Taijutsu");return
					if("Impale")
						usr.LearnJutsu("Impale",0,"Impale","Impale is a quick-paced fighting technique utilizing Yanagi. The user quickly moves their bone blades forward to impale the target.","Taijutsu");return
					if("Rapid Strike")
						var/found=0
						for(var/obj/SkillCards/SwiftSlash/P in A)
							found=1
						if(!found)
							usr<<"You need to learn Swift Slash to use this jutsu!";return
						usr.LearnJutsu("Rapid Strike",0,"RapidStrike","Rapid Strike is a quick-paced fighting technique utilizing Tsubaki. The user moves their blades at rapid speeds attacking multiple times.","Taijutsu");return
					if("Ibara")
						var/found=0
						for(var/obj/SkillCards/Karamatsu/P in A)
							found=1
						if(!found)
							usr<<"You need to learn Karamatsu No Mai to use this jutsu!";return
						usr.LearnJutsu("Ibara",0,"Ibara","Ibara is a powerful technique utilizing Kawaratsu. The user shoots out all their extracted Ribcages and regrow others. Because they can grow it, they can cause the Ribs to come out like spears.","Taijutsu");return
					if("Clematis: Flower")
						var/found=0
						for(var/obj/SkillCards/Tessenka/P in A)
							found=1
						if(!found)
							usr<<"You need to learn Tessenka No Mai to use this jutsu!";return
						usr.LearnJutsu("Clematis: Flower",0,"ArmBone","Clematis: Flower is a powerful technique utilizing Tessenka. The user grows their bones around their arms to create a drill which they will attack the enemy with. It is said to be unbreakable.","Taijutsu");return
					if("Kochou")
						var/found=0
						for(var/obj/SkillCards/ArmBone/P in A)
							found=1
						if(!found)
							usr<<"You need to learn Clematis:Flower to use this jutsu!";return
						usr.LearnJutsu("Kochou No Mai",0,"Kochou","A Kaguya is able to utilize his chakra to the point where he's able to turn his bones into a less dense form, while still maintaining the ability to function properly, aiding him in speed.","Taijutsu");return;

	Sound_Raiton_Teacher
		name = "Asuka"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Base.dmi'
				var/Hair='ThreadsH.dmi'
				var/Shirt='Shirt.dmi'
				Base+=rgb(100,35,0)
				Hair+=rgb(200,200,200)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Boxers.dmi'
				src.overlays+='Boxers.dmi'
				src.overlays-='MaleEyes.dmi'
				src.overlays+='MaleEyes.dmi'
				src.overlays-='Eyes.dmi'
				src.overlays+='Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='pants.dmi'
				src.overlays+='pants.dmi'
				src.overlays-='Cloths.dmi'
				src.overlays+='Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am one of the genius Lightning-Natured Jounin in the village. But I also take my time to teach ninja techniques."
			sleep(3)
			if(usr.LightningE)
				var/katonknow = input("Tell me what Lightning technique you would you like to learn?","Lightning Technique")
				if(findtext(katonknow,"raikyuu",1,0))
					usr.LearnJutsu("Raiton; Raikyuu No Jutsu",0,"Raikyuu","Raiton; Raikyuu No Jutsu is a technique where the user charges chakra within their hands and shoot it off.","Raiton")

				if(findtext(katonknow,"rairyuu no tatsumaki",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rairyuu no Tatsumaki",0,"Tatsumaki","Raiton; Rairyuu No Tatsumaki is a jutsu where the user creates a strong dragon that is controllable in movement and damage.","Raiton")

				if(findtext(katonknow,"ikazuchi no kiba",1,0))
					if(usr.RaitonKnowledge<100)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Ikazuchi No Kiba",0,"IkazuchiKiba","Raiton; Ikazuchi No Kiba is a powerful Raiton technique which shoots bolts of lightning on all side of the user!","Raiton")

				if(findtext(katonknow,"garou",1,0))
					if(usr.RaitonKnowledge<35)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Rai no Garou",0,"RairyuuGarou","Raiton; Rai no Garou is a technique where the user spins rapidly in a fierce tornado, attracting static energy which they can rip the opponent to shreds.","Raiton")

				if(findtext(katonknow,"gian",1,0))
					if(usr.RaitonKnowledge<500)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Raiton; Gian",0,"Gian","Raiton; Gian is an incredibly powerful technique which shoots a line of lightning from the user which zaps the target powerfully!","Raiton")

				if(findtext(katonknow,"raigeki",1,0))
					if(usr.RaitonKnowledge<45)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Raigeki No Yoroi",0,"Yoroi","Raiton; Raigeki No Yoroi is a powerful technique that absorbs all Raiton techniques shot at the user!","Raiton")

				if(findtext(katonknow,"jibashi",1,0))
					if(usr.RaitonKnowledge<125)
						usr<<"You need more Raiton Knowledge.";return
					usr.LearnJutsu("Raiton; Jibashi",0,"Jibashi","Raiton; Jibashi is a jutsu where eletrical pulses are shot at the designated target, shocking and stunning them!","Raiton")
				if(findtext(katonknow,"lightning cutter",1,0)||findtext(katonknow,"hinoko",1,0))
					if(usr.RaitonKnowledge<400)
						usr<<"You need more Raiton Knowledge.";return
					if(usr.Village!="Sound"&&prob(95))
						usr<<"Hm... I don't think I should teach you that technique.";return
					usr.LearnJutsu("Raiton; Hinoko",0,"Hinoko","Raiton; Hinoko is a fast electrical jutsu that utilizes shape and nature manipulation to form a vibrating blade of lightning that travels quickly and deals heavy damage to its targets, as well as temporarily numbing their bodies!","Raiton")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Raiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Raiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Raiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Raiton? Get some more Knowledge with Katon!";return
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Raiton? Get some more Knowledge with Suiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0

					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Lightning Chakra",AmountofExp,"LightningChakra","The Lightning Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Lightning-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	IronCountrySamurai
		name = "Mabatsu, Kiel"
		icon = 'Icons/New Base/Base.dmi'
		icon_state="NPC1"
		Village="Sound"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays+='Icons/New Base/Hair/WolverineH.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden= 1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The Samurai Kenjutsu is key!"
			sleep(3)
			if(src.Clan=="Samurai")
//				var/list/A=usr.LearnedJutsus
				usr<<"I have chosen to take the time to teach other Samurai the ways of our Kenjutsu. Would you like to learn?"
				switch(input(usr,"Do you want to learn it?", "Hansha") in list ("Yes","No"))
					if("Yes")
						usr.LearnJutsu("Rapid Slash",0,"Rapid Slash","Rapid slash is a quick slash with your sword.","Kenjutsu")
						return
			else
				usr<<"Hello, I am Samurai Master Kiel!"
				return
	IronCountryMonk
		name = "Monk, Sietsu"
		icon = 'Icons/New Base/Base.dmi'
		CNNPC=1
		health=999999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(100,35,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The rivers are always calm."
			sleep(3)
			if(usr.Clan!="Monk")
				usr<<"Get out of my face. I have to meditate."
				return
			if(usr.TaijutsuStyle=="Basic")
				usr<<"I as a Monk ninja wanted to show young monk how worthy we are of being ninja, so I deliberately made it my duty to create the monk fighting style! Would you like to learn it?"
				switch(input(usr,"Do you want to learn it?", "Quick Fist") in list ("Yes","No"))
					if("Yes")
						usr.TaijutsuStyle="Monk"
					else
						return
			if(usr.TaijutsuStyle=="Monk")
				switch(input(usr,"Would you like to learn some techniques?", "Monk Tai") in list ("Monk Focus Punch","Monk Fury Punch","Monk Chakra Kick","Cancel"))
					if("Monk Focus Punch")
						usr.LearnJutsu("Monk Focus Punch",0,"MonkPunch","Monk Focus Punch is a taijutsu that gives the monk the ability to focus their chakra into a powerful punch.","Taijutsu")
					if("Monk Fury Punch")
						usr.LearnJutsu("Monk Fury Punch",0,"MonkFuryPunch","Monk Fury Punch is a fast punch that uses nothing but brute force to take down your opponent.","Taijutsu")
					if("Monk Chakra Kick")
						usr.LearnJutsu("Monk Chakra Kick",0,"MonkKick","Monk kick is a jutsu that utilizes Speed and Power. Allowing a heavy strong kick with incredible Speed!.","Taijutsu")
			else
				usr<<"Hrm. Time to meditate!"
	Sound_Suiton_Teacher
		name = "Harmonia"
		icon = 'Icons/New Base/Base.dmi'
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(100,35,0)
				Hair+=rgb(0,0,150)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The rivers are always calm."
			sleep(3)

			if(usr.WaterE)
				var/katonknow = input("Tell me what Suiton technique you would you like to learn?","Suiton Technique")
				if(findtext(katonknow,"mizurappa",1,0))
					usr.LearnJutsu("Suiton Mizurappa No Jutsu",0,"Mizurappa","Suiton Mizurappa No Jutsu is a beam-water technique that shoots water out from the user's mouth with great force and pressure.","Suiton")

				if(findtext(katonknow,"suiryuudan",1,0))
					if(usr.SuitonKnowledge<85)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suiryuudan No Jutsu",0,"Suiryuudan","Suiton Suiryuudan No Jutsu is a jutsu which summons a dragon made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"suikoudan",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Suikoudan No Jutsu",0,"Suikoudan","Suiton Suikoudan No Jutsu is a jutsu whcih summons a shark made out of water from water to attack a targetted player.","Suiton")

				if(findtext(katonknow,"mizuame nabara",1,0))
					if(usr.SuitonKnowledge<45)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Mizuame Nabara No Jutsu",0,"MizuameNabara","Mizuame Nabara No Jutsu is a jutsu that creates sticky syrup around the user making those stuck in it immobile.","Suiton")

				if(findtext(katonknow,"daibakufu",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Daibakufu No Jutsu",0,"Daibakufu","Suiton Daibakufu No Jutsu is a jutsu which shoots a large torrent which keeps the enemy in repetive damage.","Suiton")

				if(findtext(katonknow,"baku suishou",1,0))
					if(usr.SuitonKnowledge<300)
						usr<<"You need more Suiton Knowledge.";return
					usr.LearnJutsu("Suiton Baku Suishouha No Jutsu",0,"BakuSuishouha","Suiton Baku Suishou No jutsu is a technique that shoots a large torrent wave that covers the field with water that can be used to the user's advantage.","Suiton")
				if(findtext(katonknow,"teppoudama",1,0))
					if(usr.SuitonKnowledge<450)
						usr<<"You need more Suiton Knowledge.";return
					if(usr.ElementalCapacity>2)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Suiton Teppoudama",0,"Teppoudama","Suiton Teppoudama is a strong and fast water bullet projectile that when it colldies with something bursts with a large shockwave knocking anyone nearby away with great force.","Suiton")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Suiton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Suiton? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Suiton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Suiton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Suiton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Water Chakra",AmountofExp,"WaterChakra","The Water Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Water-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Sound_Katon_Teacher
		name = "Haruneko"
		icon = 'Icons/New Base/Base.dmi'
		CNNPC = 1
		Village="Sound"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='ExclusiveH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(100,100,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Burn baby burn..."
			sleep(3)
			if(usr.FireE)
				var/katonknow = input("Tell me what Katon technique you would you like to learn?","Katon Technique")
				if(findtext(katonknow,"hikibou",1,0))
					usr.LearnJutsu("Katon Hikibou No Jutsu",0,"Hikibou","Katon Hikibou No Jutsu is a technique where the user heats the air around the target. After heating the air, that region will combust in flames. It is very useless at the beginning, but the more you use it the stronger it gets.","Katon")
				if(findtext(katonknow,"goukakyuu",1,0)||findtext(katonknow,"fireball",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Goukakyuu No Jutsu",0,"Goukakyuu","Katon Goukakyuu No jutsu is a field ranged jutsu that releases fire from the mouth. It covers a small radius, that can improve, so it can be very useful in combat.","Katon")
				if(findtext(katonknow,"housenka",1,0)||findtext(katonknow,"phoenix flower",1,0))
					if(usr.KatonKnowledge<50)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Housenka No Jutsu",0,"Housenka","Katon Housenka No Jutsu is a jutsu that shoots multiple fire balls from the mouth that explode in fire on contact of a target.","Katon")
				if(findtext(katonknow,"ryuuka",1,0)||findtext(katonknow,"dragon fire",1,0))
					if(usr.KatonKnowledge<75)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Ryuuka No Jutsu",0,"Ryuuka","Katon Ryuuka No Jutsu is a concentrated form of Karyuu Endan that shoots a concentrated blast that explodes on contact of a physical object.","Katon")
			//	if(findtext(katonknow,"ka no senbon",1,0)||findtext(katonknow,"fire needles",1,0))
			//		usr.LearnJutsu("Katon; Ka No Senbon",15,"KnowKaNoSenbon","Katon Ka No Senbon is a jutsu where the user releases a small torrent of weak, but highly flammable stream of needles from their mouth that make things catch on fire. It continuasly goes until the user decides to stop.","Katon")
				if(findtext(katonknow,"karyuu endan",1,0)||findtext(katonknow,"dragon flame projectile",1,0))
					if(usr.KatonKnowledge<500)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
					usr.LearnJutsu("Katon Karyuu Endan",0,"KaryuuEndan","Katon Karyuu Endan shoots a large blast of fire in a straight direction that burns enemies as it flows. It has incredible destruction ratio.","Katon")
				if(findtext(katonknow,"katon houka",1,0))
					if(usr.KatonKnowledge<550)
						usr<<"You don't have enough knowledge with Katon to learn this technique.";return
						var/found=0
						for(var/obj/SkillCards/Housenka/P in usr.LearnedJutsus)
							if(P.type == /obj/SkillCards/Housenka) found=1
						if(!found)
							usr<<"You need to know Katon Housenka No Jutsu first!";return
					usr.LearnJutsu("Katon Houka",0,"KatonHouka","Katon Houka is a powerful fireball technique that can be considered an enhancement to Housenka. It works by shooting a giant fireball that explodes on contact or through time to an even bigger flame.","Katon")

			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Katon?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Katon? Get some more Knowledge with Suiton!";return
					if(usr.WindE)
						if(usr.FuutonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Fuuton and you expect to use Katon? Get some more Knowledge with Fuuton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Katon? Get some more Knowledge with Doton!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Katon? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
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
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Fire Chakra",AmountofExp,"FireChakra","The Fire Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform fire techniques. These techniques primarily hit health and stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think your capable of mastering another element."
					return
	Sound_Fuuton_Teacher
		name = "Anana"
		icon = 'Icons/New Base/Base.dmi'
		CNNPC = 1
		Village="Sound"
		health = 9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/MadaraH.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/soundoutfit.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The wind is very versatile in change."
			sleep(3)
			if(usr.WindE)
				var/katonknow = input("Tell me what Wind technique you would you like to learn?","Fuuton Technique")
				if(findtext(katonknow,"daitoppa",1,0)||findtext(katonknow,"great breakthrough",1,0))
					if(usr.FuutonKnowledge<50)
						usr<<"You need more Fuuton Knowledge.";return
					usr.LearnJutsu("Fuuton Daitoppa No Jutsu",0,"Daitoppa","Fuuton Daitoppa No jutsu is a technique that fires a gust of wind that shoots targets back. It can be used for combustion.","Fuuton")

				if(findtext(katonknow,"spinning wind",1,0)||findtext(katonknow,"spinning",1,0))
					usr.LearnJutsu("Spinning Wind",0,"SpinningWind","Spinning Wind is a technique that emits a small gust that leaves the target within a spinning wind for a small amount of time.","Fuuton")

				if(findtext(katonknow,"wind trick",1,0)||findtext(katonknow,"trick",1,0))
					usr.LearnJutsu("Wind Trick",0,"WindTrick","Wind Trick is a jutsu utilizing wind currents. It produces a strong turrent of wind that pushes back nearby targets and possible attackers, the wind current increase in size the more mastery of it.","Fuuton")

				if(findtext(katonknow,"reppushou",1,0)||findtext(katonknow,"gale wind palm",1,0))
					usr.LearnJutsu("Fuuton Reppushou No Jutsu",0,"Reppushou","Fuuton Reppushou No Jutsu is a jutsu that shoots a wave of wind that can shoot back the enemy or speed up things.","Fuuton")

				if(findtext(katonknow,"kaze dangan",1,0))
					usr.LearnJutsu("Kaze Dangan No Jutsu",0,"KazeDangan","Fuuton Kaze Dangan No Jutsu is a technique that shoots a fast paced bullet that hits the opponent with incredible force and pressure.","Fuuton")

				if(findtext(katonknow,"renkuudan",1,0)||findtext(katonknow,"drilling air projectile",1,0))
					if(usr.FuutonKnowledge<150)
						usr<<"You need more Fuuton Knowledge.";return
					if(usr.ElementalCapacity>1)
						usr<<"This jutsu is too advanced for someone like you..";return
					usr.LearnJutsu("Fuuton Renkuudan No Jutsu",0,"Renkuudan","Fuuton Renkuudan No Jutsu is a strong, powerful blast of wind that explodes on contact with the enemy!","Fuuton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Fuuton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
						if(usr.SuitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Suiton and you expect to use Fuuton? Get some more Knowledge with Suiton!";return
					if(usr.EarthE)
						if(usr.DotonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Doton and you expect to use Fuuton? Get some more Knowledge with Doton!";return
					if(usr.FireE)
						if(usr.KatonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Katon and you expect to use Fuuton? Get some more Knowledge with Katon!";return
					if(usr.LightningE)
						if(usr.RaitonKnowledge<1000)
							usr<<"[src]: Woah wait, you haven't even mastered Raiton and you expect to use Fuuton? Get some more Knowledge with Raiton!";return
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.EarthE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Wind Chakra",AmountofExp,"WindChakra","The Wind Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform Wind-based techniques. These techniques primarily hit health.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	Sound_Doton_Teacher
		name = "Jirobu"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Sound"
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
			usr<<"Can you perform Doton?"
			sleep(3)
			if(usr.EarthE)
				var/katonknow = input("Tell me what Earth technique you would you like to learn?","Earth Technique")
				if(findtext(katonknow,"doryo dango",1,0))
					usr.LearnJutsu("Doton Doryo Dango",0,"DoryoDango","Doton Doryo Dango is a technique in which the user uses their strength to pull a boulder from the ground and throw it with great force.","Doton")

				if(findtext(katonknow,"doruki gaeshi",1,0))
					usr.LearnJutsu("Doton; Doruki Gaeshi",0,"DorukiGaeshi","Doton; Doruki Gaeshi is a jutsu which places a earth wall of defence in front of you to protect you.","Doton")

				if(findtext(katonknow,"tsuchi wana",1,0))
					if(usr.DotonKnowledge<50)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Tsuchi Wana",0,"TsuchiWana","Doton; Tsuchi Wana is a technique that creates a field of rocks around the target, binding them.","Doton")

//					if(findtext(katonknow,"dochu eigyo",1,0))
//						usr.LearnJutsu("Doton; Dochu Eigyo No Jutsu",15,"Dochu Eigyo","Doton; Dochu Eigyo No Jutsu is a technique that allows the user to move freely underground.","Doton")

				if(findtext(katonknow,"taiga",1,0)||findtext(katonknow,"earth flow river",1,0))
					if(usr.DotonKnowledge<100)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryu Taiga",0,"Taiga","Doton; Doryuu Taiga is a technique which creates a flow of river made out of mud, pushing the target away.","Doton")

				if(findtext(katonknow,"doryuuheki",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuuheki No Jutsu",0,"Doryuuheki","Doton; Doryuuheki is a jutsu that creates a strong wall of defence in front of you to block techniques.","Doton")

				if(findtext(katonknow,"Dorou Domu",1,0))
					if(usr.DotonKnowledge<200)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton: Dorou Domu",0,"DorouDomu","Doton: Dorou Domu is a defensive earth sphere. It surrounds you and prevents almost any attack from penetrating. Unfortunately it is difficult to master and while in use you are unable to see outside.","Doton")

				if(findtext(katonknow,"doryuudan",1,0))
					if(usr.DotonKnowledge<150)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Doryuudan No Jutsu",0,"Doryuudan","Doton; Doryuudan No Jutsu is a strong jutsu that summons a dragon that shoots spikes from its mouth.","Doton")

				if(findtext(katonknow,"yomi numa",1,0))
					if(usr.DotonKnowledge<500)
						usr<<"You need more Doton Knowledge.";return
					usr.LearnJutsu("Doton; Yomi Numa No Jutsu",0,"YomiNuma","Doton; Yomi Numa produces a strong swamp that captures all who are within it.","Doton")
			else
				usr.Frozen=1
				spawn(35)
					usr.Frozen=0
				usr<<"[src]: Oh, you can't use Doton?"
				sleep(11)
				usr<<"[src]: How would you like to learn how to use it then?"
				sleep(11)
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
				if(count==0){usr<<"You need to use chakra paper to gain your first element. Go buy some!";return}
				if(usr.ElementalCapacity>count)
					usr<<"[src]: Alright, how good are you at your previous Chakra manipulations?"
					if(usr.WaterE)
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
					usr<<"[src]: Alright, let's teach you!";usr.Frozen=0
					var/AmountofExp=0;var/NinjutsuKnowledgeReq=0
					if(usr.WaterE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.LightningE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.FireE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.WindE)
						AmountofExp+=0;NinjutsuKnowledgeReq+=200
					if(usr.NinjutsuKnowledge<NinjutsuKnowledgeReq)
						usr<<"You do not meet the Ninjutsu Knowledge requirement for another element. You need [NinjutsuKnowledgeReq] Ninjutsu Knowledge to learn another element."
						return
					usr.LearnJutsu("Earth Chakra",AmountofExp,"EarthChakra","The Earth Chakra Nature is a powerful and dangerous chakra nature that allows the user to wield and perform earth-based techniques. These techniques primarily hit stamina.","Ninjutsu")
				else
					usr<<"Sorry, I don't think you're capable of learning another element."
					return
	SoundJounin9
		name = "Yotsuki, Shurui"
		icon_state="NPC1"
		Village="Sound"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Base+=rgb(235,145,52)
				Shirt+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=Shirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				src.overlays+='Icons/New Base/Hair/MadaraH.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"You must be as quick as Sound."
			sleep(3)
//				var/list/A=usr.LearnedJutsus
			if(usr.Village!="Sound")
				usr<<"Get out of my face. Tch. You non-Sound ninja scum."
				return
			if(usr.TaijutsuStyle=="Basic")
				usr<<"I as a Yotsuki ninja wanted to show Sound Village how worthy we are of being one of their ninja, so I deliberately made it my duty to create the Quick Fist fighting style! Would you like to learn it?"
				switch(input(usr,"Do you want to learn it?", "Quick Fist") in list ("Yes","No"))
					if("Yes")
						usr.LearnJutsu("Quick Fist",0,"Quick Fist","The Quick Fist fighting style is a style incoporated to Sound as a fast-paced attack variations within speed and strength.","Taijutsu")
					else
						return
			if(usr.TaijutsuStyle=="Quick Fist")
				switch(input(usr,"Would you like to learn some techniques?", "Quick Fist") in list ("Quick Feet","Sound Spinning Kick","Rapid Punch","Sound Whirlwind Kick","Leaping Sound Spin Kick","Cancel"))
					if("Quick Feet")
						if(usr.VMorale<30)
							usr<<"You are not committed enough to this village!";return
						usr.LearnJutsu("Quick Feet",0,"QuickFeet","Quick Feet is a stance within the Quick Fist taijutsu style that enables you to move rather swiftly.","Taijutsu")
					if("Sound Spinning Kick")
						if(usr.VMorale<40)
							usr<<"You are not committed enough to this village!";return
						usr.LearnJutsu("Sound Spinning Kick",0,"SoundSpinningKick","Sound Spinning Kick is a torrent of spinning kicks where the user remains stationary in a kicking position.","Taijutsu")
					if("Rapid Punch")
						if(usr.VMorale<70)
							usr<<"You are not committed enough to this village!";return
						if(locate(/obj/SkillCards/QuickFeet) in usr.LearnedJutsus)
							if(usr.TaijutsuKnowledge<400)
								usr<<"You need more Taijutsu Knowledge.";return
							usr.LearnJutsu("Rapid Punch",0,"RapidPunch","Rapid Punch is a jutsu that utilizes Speed rather than Power. Allowing someone to do multiple punches at incredible Speed!.","Taijutsu")
						else
							usr<<"You need to learn Quick Feet First!";return
					if("Sound Whirlwind Kick")
						if(usr.VMorale<50)
							usr<<"You are not committed enough to this village!";return
						if(locate(/obj/SkillCards/SoundSpinningKick) in usr.LearnedJutsus)
							if(usr.TaijutsuKnowledge<45)
								usr<<"You need more Taijutsu Knowledge.";return
							usr.LearnJutsu("Sound Whirlwind Kick",0,"SoundWhirlwindKick","Sound Whirlwind Kick is a powerful kick that moves in at speeds almost bending Sound with the use of Chakra. On contact it blows the sound waves straight to the enemy's ear, causing discoordination.","Taijutsu")
						else
							usr<<"You need to learn Sound Spinning Kick to use this jutsu!";return
					if("Leaping Sound Spin Kick")
						if(usr.VMorale<70)
							usr<<"You are not committed enough to this village!";return
						if(locate(/obj/SkillCards/SoundWhirlwindKick) in usr.LearnedJutsus)
							if(usr.TaijutsuKnowledge<550)
								usr<<"You need more Taijutsu Knowledge.";return
							usr.LearnJutsu("Leaping Sound Spin Kick",0,"LeapingSoundSpinKick","Leaping Spin Kick is a kick that utilizes speed, properly executing a spinning Kick that damages the Opponent.","Taijutsu")
						else
							usr<<"You need to learn Sound Whirlwind Kick to use this jutsu!";return
			else
				usr<<"Hrm."

	SoundJounin10
		name = "Uchiha Roku"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SasukeH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(200,200,200)
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			if(usr.TaijutsuStyle=="Basic")
				switch(input(usr,"One of the most important features of us Uchiha is our fighting style. The Enjouhawa Ryu style was started by the Uchiha ninja who reformed the Uchiha Clan. We do not have records of his name but we've practiced his fighting style since. We could teach it to you.", "Enjouhawa Ryuu") in list ("Yes","No"))
					if("Yes")
						usr.LearnJutsu("Enjouhawa Ryu",0,"Enjouhawa","Enjouhawa Ryu is a taijutsu style that works toward quick paced attacks and combo-oriented damage.","Taijutsu")
					else
						return
			if(usr.TaijutsuStyle=="Enjouhawa")
				switch(input(usr,"Would you like to learn some techniques?", "Enjouhawa Ryuu") in list ("Axe Kick","Lion's Punch","Lion's Barrage","Cancel"))
					if("Axe Kick")
						usr.LearnJutsu("Axe Kick",0,"Axe_Kick","Axe Kick is a technique involving the powerful reflex capabilities to perform a non-dodgeable kicking technique to send the opponent back.","Taijutsu");return
					if("Lion's Punch")
						if(usr.TaijutsuKnowledge<250)
							usr<<"You need more Taijutsu Knowledge.";return
						usr.LearnJutsu("Lion's Punch",0,"Lion_Punch","Lion's Punch is a quick move that allows you to quickly dash behind the enemy for a fast attack.","Taijutsu");return
					if("Lion's Barrage")
						if(usr.TaijutsuKnowledge<1000)
							usr<<"You need more Taijutsu Knowledge.";return
						usr.LearnJutsu("Lion's Barrage",0,"Shishi","Lion's Barrage is a combo taijutsu technique where the user rapidly hits the target all together with a set of combos.","Taijutsu");return

			else
				usr<<"These eyes do not see everything."
	SoundJounin11
		name = "Kabuto"
		icon='Icons/SnakeNPC.dmi'
		//icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon='Icons/SnakeNPC.dmi'
				/*
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/itachiH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,0)
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
				*/

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hmm, sure is nice out here isn't it? I come here to get away from it all and practice this Forbidden skill."
			if(usr.Village=="Sound"&&usr.NinjutsuKnowledge>=2000&&(usr.Clan=="Basic"))
				switch(input(usr,"CurseSeal is a powerful Kinjutsu, and there is the possibilty of dying. Will you risk learning it?", "CursedSealActivation") in list ("Yes","No"))
					if("Yes")
						usr.CursedSealType=pick("Heaven","Earth","Fire","Thunder","Water","Air")
						usr<<"The ninja sinks his teeth into your neck and you're paralyzed with pain!"
						spawn()
							usr.StunAdd(40)
						sleep(400)
						var/Chance=45
						if(usr.Subscriber)
							Chance-=15
						if(prob(Chance))
							usr<<"You succumb to the pain and feel the life inside of your slipping away..."
							var/mob/P = new /mob/player
							P.health=5000;P.icon=src.icon;P.overlays=src.overlays;P.name="[src]'s corpse"
							P.icon_state="dead";P.loc=src.loc;P.knockedout=1;P.Dead=1;P.FrozenBind="Dead"
							spawn()
								P.EdoGetStats(src)
							spawn()
								P.DeleSelf(6000)
							var/firstletter=copytext(usr.ckey, 1, 2)
							fdel("Saves/[firstletter]/[usr.ckey].sav")
							world<<"<font color=#8b0000>[usr] attempted to achieve the power of the Curse Mark but died a failure...</font>"
							usr << "Character Deleted"
							del(usr)
						else
							usr.LearnJutsu("CursedSealActivation",0,"CursedSealActivation","Forbidden Jutsu passed down from a past Otokage","Ninjutsu");return

			else if(usr.Village=="Sound"&&usr.NinjutsuKnowledge>=2400)
				if(usr.Clan=="Kumojin"||usr.Clan=="Yotsuki"||usr.Clan=="Uchiha"||usr.Clan=="Kaguya")
					switch(input(usr,"CurseSeal is a powerful Kinjutsu, and there is the possibilty of permanent Death..... Will you risk it all to learn learn this incredible power?", "CursedSealActivation") in list ("Yes","No"))
						if("Yes")
							if(prob(20))
								usr.CursedSealType=pick("Heaven","Earth")
							else
								usr.CursedSealType=pick("Fire","Thunder","Water","Air")
							usr<<"The ninja sinks his teeth into your neck and you're paralyzed with pain!"
							spawn()
								usr.StunAdd(40)
							sleep(400)
							var/Chance2=55
							if(usr.Subscriber)
								Chance2-=15
							if(prob(Chance2))
								usr<<"You succumb to the unbearable pain and feel the life inside of you slowly slipping away..."
								var/mob/P = new /mob/player
								P.health=5000;P.icon=src.icon;P.overlays=src.overlays;P.name="[src]'s corpse"
								P.icon_state="dead";P.loc=src.loc;P.knockedout=1;P.Dead=1;P.FrozenBind="Dead"
								spawn()
									P.EdoGetStats(src)
								spawn()
									P.DeleSelf(6000)
								var/firstletter=copytext(usr.ckey, 1, 2)
								fdel("Saves/[firstletter]/[usr.ckey].sav")
								world<<"<font color=#8b0000>[usr] attempted to achieve the power of the Curse Mark but died a failure...</font>"
								usr << "Character Deleted"
								del(usr)
							else
								usr.LearnJutsu("CursedSealActivation",0,"CursedSealActivation","Forbidden Jutsu passed down from a past Otokage","Ninjutsu");return

			else
				usr<<"You don't meet the requirements for this jutsu.";


	SoundJounin12
		name = "Otoruke"
		CNNPC = 1
		health=9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			.=..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/icon/A='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
				A+=rgb(0,0,0)
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/SoundJounin.dmi'
				src.overlays+=A
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.icon_state="rest"
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Omn. Ommnn. Ommnnn."
			sleep(11)
			if(usr.Village=="Sound"&&usr.BeginningVillage=="Sound")
				switch(input(usr,"I hold the concentration for Sound Village's teleportation jutsu. It's developed as a defence for our ninja and can be used anytime. I can teach you the technique?", "Satake Teleporation") in list ("Yes","No"))
					if("Yes")
						if(usr.NinjutsuKnowledge<50)
							usr<<"You need more Ninjutsu Knowledge.";return
						usr.LearnJutsu("Satake Teleportation",0,"SatakeTeleportation","Satake Teleportation is a jutsu where the user concentrates for a couple of seconds and then teleports to the designated location in Sound. Could be used for defence or other means.","Ninjutsu");return
	SoundJounin13
		name = "Yotsuki, Do"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/leeH.dmi'
				Base+=rgb(135,95,32)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/JouninS.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/CloudChuuninSuit.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hmm.. You annoy me, get out of my sight!"
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.Village!="Sound"&&usr.Clan!="Yotsuki")
				usr<<"Unfortunately I have an honor to this village, and clan and I cannot spread our power to our enemies!"
				return
			if(usr.TaijutsuStyle=="Basic")
				if(usr.TaiSkill>=usr.NinSkill&&usr.GenSkill)
					usr<<"Hm, it seems like I can teach you in that fighting style!"
					switch(input(usr,"", "NinTai") in list ("Yes","No"))
						if("Yes")
							usr.LearnJutsu("Nin-Taijutsu",0,"NinTai","NinTai is a taijutsu style that works on bone-crushing powerful attacks.","Taijutsu")
						else
							return
			if(usr.TaijutsuStyle=="NinTai")
				switch(input(usr,"Would you like to learn some techniques?") in list ("Lightning Straight","Oppression Horizantal","Oppression Horizantal Chop","Lariat","Guillotine Drop","Liger Bomb","Cancel"))
					if("Lightning Straight")
						if(usr.Clan!="Yotsuki")
							usr<<"You snake! you tried to deceive me!";return
						if(usr.TaijutsuKnowledge<50)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Lightning Straight",0,"LightningStraight","A quick simple punch, so fast that it's even hard for the Sharingan to track it.","Taijutsu");return
					if("Oppression Horizantal")
						if(usr.Clan!="Yotsuki")
							usr<<"You snake! you tried to deceive me!";return
						if(usr.TaijutsuKnowledge<50)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Opression Horizantal",0,"Oppression","A simple back hand chop, powerful enough to break bones.","Taijutsu");return
					if("Oppression Horizantal Chop")
						if(usr.Clan!="Yotsuki")
							usr<<"You snake! you tried to deceive me!";return
						var/found=0
						for(var/obj/SkillCards/Oppression/P in A)
							if(P.type == /obj/SkillCards/Oppression) found=1
						if(!found)
							usr<<"You need to know Oppression Horizantal first!";return

						if(usr.TaijutsuKnowledge<100)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Oppression Horizantal Chop",0,"OppressionH","Oppression Horizantal Chop is a enhanced form of the Horizantal.","Taijutsu");return
					if("Lariat")
						if(usr.Clan!="Yotsuki")
							usr<<"You snake! you tried to deceive me!";return

						if(usr.TaijutsuKnowledge<200)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Lariat",0,"Lariat","Lariat is a powerful strike, whereby the user dashes swiftly at their target and hits their neck-chest area with excessive force.","Taijutsu");return
					if("Guillotine Drop")
						if(usr.Clan!="Yotsuki")
							usr<<"You snake! you tried to deceive me!";return
						var/found=0
						for(var/obj/SkillCards/Lariat/P in A)
							if(P.type == /obj/SkillCards/Lariat) found=1
						if(!found)
							usr<<"You need to know Lariat first!";return

						if(usr.TaijutsuKnowledge<300)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						usr.LearnJutsu("Guillotine Drop",0,"GuillotineDrop","This is a taijutsu technique where the user jumps into the air above his opponent and performs a downwards kick, using the momentum of the fall to increase the power behind the attack","Taijutsu");return
					if("Liger Bomb")
						if(usr.Clan!="Yotsuki")
							usr<<"You snake! you tried to deceive me!";return
						if(usr.TaijutsuKnowledge<500)
							usr<<"You don't have enough knowledge with Taijutsu techniques.";return
						if(usr.blevel=="E"||usr.blevel=="D"||usr.blevel=="C")
							usr<<"Your class is too low for this technique.";return
						var/found=0
						for(var/obj/SkillCards/RaitonYoroi/P in A)
							if(P.type == /obj/SkillCards/RaitonYoroi) found=1
						if(!found)
							usr<<"You need to know the secret lightning release first!";return
						usr.LearnJutsu("Liger Bomb",0,"LigerBomb","A technique where the user grabs his opponent and lifts them high into the air then, using extreme strength, smashes them head first into the ground resembling a 'Power Bomb'. This technique can easily shatter a target's bones even to the point of certain death.","Taijutsu");return

	SoundJounin14
		name = "Rai"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Sound"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/leeH.dmi'
				Base+=rgb(135,95,32)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/JouninS.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/CloudChuuninSuit.dmi'
				src.overlays+=Hair


		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"I forgot what happened to the old village of Cloud. But I hear it was pretty bad."
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.BlackLightning>0)
				usr<<"Ah, I see you're a chosen Ninja to carry on the Black Lightning legacy! Well what would you like to learn?"
				switch(input(usr,"Would you like to learn some techniques?", "Kuroi Raiton") in list ("Black Bolt","Black Pulse Release","Black Panther","Cancel"))
					if("Black Bolt")
						if(usr.RaitonKnowledge<2000)
							usr<<"You need more knowledge with Raiton.";return
						usr.LearnJutsu("BlackBolt",0,"BoltStrike","Black Bolt Strike is a simple technique, utilizing black lightning, releasing it from the palms of the hand straight infront of the user.","Ninjutsu");return

					if("Black Pulse Release")
						if(usr.RaitonKnowledge<2500)
							usr<<"You need more knowledge with Raiton.";return
						var/found=0
						for(var/obj/SkillCards/BoltStrike/P in A)
							found=1
						if(!found)
							usr<<"You need to learn Black Bolt Strike to learn this jutsu!";return
						usr.LearnJutsu("Black Pulse Release",0,"BlackPulse","Black Pulse Release is a high level black lightning technique that releases a highly charged pulse of lightning in all direction from the user.","Ninjutsu");return

					if("Black Panther")
						if(usr.RaitonKnowledge<3000)
							usr<<"You need more knowledge with Raiton.";return
						var/found=0
						for(var/obj/SkillCards/BlackPulse/P in A)
							found=1
						if(!found)
							usr<<"You need to learn Black Pulse to learn this jutsu!";return
						if(usr.blevel=="E"||usr.blevel=="D"||usr.blevel=="C")
							usr<<"You don't seem quite ready for this level of jutsu yet.";return
						usr.LearnJutsu("Black Panther",0,"BlackPanther","Black Panther is one of the highest level of black lightning jutsus that releases a giant, lightning panther, that explodes into highly charged electrical pulses when it hits. It's fast and very deadly.","Ninjutsu");return

//Missing Ninja/////////////////////////////////////////////
	MissingJounin3
		name = "Shou"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Kyah!"
			sleep(3)
			var/list/A=usr.LearnedJutsus
			if(usr.TaijutsuStyle=="Basic")
				usr<<"Hm, it seems like I can teach you in that fighting style!"
				switch(input(usr,"To convert to the Rakanken Ryuu fighting style, it requires vigorous. Do you want to learn it?", "Rakanken Ryuu") in list ("Yes","No"))
					if("Yes")
						usr.LearnJutsu("Rakanken Ryu",0,"Rakanken","Rakanken Ryu is a taijutsu style that works powerful and damaging techniques.","Taijutsu")
					else
						return
			if(usr.TaijutsuStyle=="Rakanken")
				switch(input(usr,"Would you like to learn some techniques?", "Rakanken Ryuu") in list ("Asshou","Chou Asshou","Hoshou","Shoushitzu","Flash Kick","Drop Kick","Cancel"))
					if("Asshou")
						usr.LearnJutsu("Asshou",0,"Asshou","Asshou is a fist curling taijutsu technique that highly damages the opponent.","Taijutsu");return
					if("Chou Asshou")
						var/found=0
						for(var/obj/SkillCards/Asshou/P in A)
							if(P.type == /obj/SkillCards/Asshou) found=1
						if(!found)
							usr<<"You need to learn Asshou to use this jutsu!";return

						if(usr.TaijutsuKnowledge<35)
							usr<<"You need more Taijutsu Knowledge.";return
						usr.LearnJutsu("Chou Asshou",0,"ChouAsshou","Chou Asshou is a stronger version of Asshou.","Taijutsu");return
					if("Hoshou")
						var/found=0
						for(var/obj/SkillCards/ChouAsshou/P in A)
							if(P.type == /obj/SkillCards/ChouAsshou) found=1
						if(!found)
							usr<<"You need to learn Chou Asshou to use this jutsu!";return

						if(usr.TaijutsuKnowledge<650)
							usr<<"You need more Taijutsu Knowledge.";return
						usr.LearnJutsu("Thrusting Shockwave",0,"Hoshou","Thrusting Shockwave is a jutsu that allows the user to slam their fist into the ground and throw people back based on their strength.","Taijutsu");return
					if("Shoushitzu")
						if(usr.TaijutsuKnowledge<35)
							usr<<"You need more Taijutsu Knowledge.";return
						usr.LearnJutsu("Shoushitzu",0,"Shoushitzu","Shoushitzu is a kicking technique that strikes the target with a powerful kick directly next to them.","Taijutsu");return
					if("Flash Kick")
						if(usr.TaijutsuKnowledge<1100)
							usr<<"You need more Taijutsu Knowledge.";return
						if(!(locate(/obj/SkillCards/Shoushitzu) in usr.LearnedJutsus))
							usr<<"You need to learn High Leaping Slam (Shoushitzu) first!"
							return
						usr.LearnJutsu("Flash Kick",0,"FlashKick","Flash kick is an incredibly powerful technique that sends your target flying away, and you follow up with a second powerful kick after disappearing and then reapparing beside them through the use of incredible speed.","Taijutsu");return
					if("Drop Kick")
						if(usr.TaijutsuKnowledge<1100)
							usr<<"You need more Taijutus Knowledge.";return
						if(!(locate(/obj/SkillCards/FlashKick) in usr.LearnedJutsus))
							usr<<"You need to learn Flash Kick first!"
							return
						usr.LearnJutsu("Drop Kick",0,"DroppingKick","Drop Kick is a jutsu that forcibly throws your opponent into the air, then with a rush of power, slamming them into the ground with incredible damage potential.","Taijutsu")

	MissingNinja20
		name = "Naga,Daoku"
		icon_state="NPC1"
		Village="Missing"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Official Clothing/cvest.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The Best Offence is a good Defence."
			sleep(3)
//				var/list/A=usr.LearnedJutsus

			if(usr.TaijutsuStyle=="Basic")
				usr<<"I have chosen to take the time to develop a Fighting Style that works solely on countering the Arts of Taijutsu rather than meeting it hand to hand. Would you like to learn it?"
				switch(input(usr,"Do you want to learn it?", "Hansha") in list ("Yes","No"))
					if("Yes")
						usr.LearnJutsu("Hansha",0,"Hansha","The Hansha fighting style is a defencive fighting style known by few around the Ninja World that is meant for those with low Physique. The Ninja will learn to defend and solely counter attack rather than cause damage with taijutsu.","Taijutsu")
					else
						return
			if(usr.TaijutsuStyle=="Hansha")
				switch(input(usr,"Would you like to learn some techniques?", "Hansha") in list ("Calm Mind","Soothing Slam","Cautionary Reaction Above","Cautionary Reaction Below","Eternal Defence","Cancel"))
					if("Calm Mind")
						usr.LearnJutsu("Calm Mind",0,"CalmMind","Calm Mind is the name of a meditative Pose many users of the Hansha tend to master, as it aids them in countering taijutsu greatly.","Taijutsu")
					if("Soothing Slam")
						usr.LearnJutsu("Soothing Slam",0,"SoothingSlam","Soothing Slam allows the user to counter an opponents taijutsu that involves grappling, and redirect it on them.","Taijutsu")
					if("Cautionary Reaction Above")
						if(locate(/obj/SkillCards/SoothingSlam) in usr.LearnedJutsus)
							if(usr.TaijutsuKnowledge<400)
								usr<<"You need more Taijutsu Knowledge.";return
							usr.LearnJutsu("Cautionary Reaction Above",0,"ReactionAbove","Cautionary Reaction Above is a form of counter that focuses on countering any taijutsu that is based on using the Arms. With enough practice the user is even able to break the arms of the Opponent.","Taijutsu")
						else
							usr<<"You need to learn Soothing Slam First!";return
					if("Cautionary Reaction Below")

						if(locate(/obj/SkillCards/SoothingSlam) in usr.LearnedJutsus)
							if(usr.TaijutsuKnowledge<400)
								usr<<"You need more Taijutsu Knowledge.";return
							usr.LearnJutsu("Cautionary Reaction Below",0,"ReactionBelow","Cautionary Reaction Below is a form of counter that focuses on countering any taijutsu that is based on using the Legs. With enough practice the user is even able to severely damage the legs of the Opponent.","Taijutsu")
						else
							usr<<"You need to learn Soothing Slam to use this jutsu!";return
					if("Eternal Defence")
						if(locate(/obj/SkillCards/ReactionBelow) in usr.LearnedJutsus)
							if(usr.TaijutsuKnowledge<950)
								usr<<"You need more Taijutsu Knowledge.";return
							usr.LearnJutsu("Eternal Defence",0,"EternalDefence","Eternal Defence is a nick name given to one that has mastered the Taijutsu Style Hansha. They have a chance to instively react to a taijutsu without having to prepare for it.","Taijutsu")
						else
							usr<<"You need to learn Cautionary Reaction Below to use this jutsu!";return
			else
				usr<<"Hrm."

	MissingJounin4
		name = "Darkrai"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/itachiH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(0,0,0)
				Hair+=rgb(0,0,0)
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			var/found=0
			if(found==0)
				usr<<"The darkness."
			sleep(5)
			for(var/obj/SkillCards/Kokuangyo/P in usr.LearnedJutsus)
				found=2
	//		if(found==1)
	//			for(var/obj/SkillCards/CrowVoid/P in usr.LearnedJutsus)
	//				found=2
			if(found==2)
				for(var/obj/SkillCards/HallucinatoryMeltingOvan/P in usr.LearnedJutsus)
					found=3
			if(found==2)
				usr<<"The Flames..."
			if(found==3)
				usr<<"The Ocean..."
			if(found==3)
				if(usr.GenjutsuKnowledge<=550)
					usr<<"You need more genjutsu knowledge to learn this technique.";return
				if((usr.GenSkill+(usr.ChakraC/25))<21)
					usr<<"You need more Control with your chakra to learn this technique.";return
				if((usr.GenSkill+(usr.ChakraC/25))>=21&&usr.GenjutsuKnowledge>550)
					switch(input(usr,"Drowning Ocean is a powerful genjutsu. Would you like to learn it?", "Kokuangyo") in list ("Yes","No"))
						if("Yes")
							usr<<"This is the final step...Oceans contain vast amounts of torture.."
							usr.LearnJutsu("Water Hallucinatory Drowning Technique: Drowning Ocean",0,"HallucinatoryDrowningOcean","Water Drowning Technique is a Genjutsu that causes the opponent to believe they're in the ocean, losing all traces of Oxygen, and eventually drowning.","Genjutsu");return
			else if(found==2)
				if(usr.GenjutsuKnowledge<=450)
					usr<<"You need more genjutsu knowledge to learn this technique.";return
				if((usr.GenSkill+(usr.ChakraC/25))<20)
					usr<<"You need more Control with your chakra to learn this technique.";return
				if((usr.GenSkill+(usr.ChakraC/25))>=20&&usr.GenjutsuKnowledge>450)
					switch(input(usr,"Hallucinatory Oven is a powerful genjutsu. Would you like to learn it?", "Kokuangyo") in list ("Yes","No"))
						if("Yes")
							usr<<"Let's take it one step even further..into the fiery depths of hell..."
							usr.LearnJutsu("Oven Genjutsu",0,"HallucinatoryMeltingOvan","Hallucinatory Melting Oven is a technique that truly makes the opponent's view a living hell.","Genjutsu");return
		//	else if(found==1)
		//		switch(input(usr,"ManEatingCrows is a powerful genjutsu. Would you like to learn it?", "Kokuangyo") in list ("Yes","No"))
		//			if("Yes")
		//				usr<<"Let's take it one step further.."
		//				usr.LearnJutsu("Void of ManEating Crows",50000,"CrowVoid","This genjutsu causes a large darkness to consume the opponent as Crows devour them..","Genjutsu");return
			else
				switch(input(usr,"Kokuangyo is a powerful genjutsu. Would you like to learn it?", "Kokuangyo") in list ("Yes","No"))
					if("Yes")
						if(usr.GenjutsuKnowledge<35)
							usr<<"You need more Genjutsu Knowledge.";return
						usr.LearnJutsu("Kokuangyo",0,"Kokuangyo","Kokuangyo is a technique that covers the target in darkness, disabling their ability to see.","Genjutsu");return
	MissingJounin5
		name = "Jigsaw"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SasukeH.dmi'
				Base+=rgb(235,145,52)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hi."
			switch(input(usr,"Do you want to teleport behind people in combat? I got something for you!", "Kage Buyou") in list ("Yes","No"))
				if("Yes")
					if(usr.TaijutsuKnowledge<15)
						usr<<"You need more Taijutsu Knowledge.";return
					usr.LearnJutsu("Kage Buyou",0,"KageBuyou","Kage Buyou is a quick technique that allows you to transport behind a target!");return
	MissingJounin6
		name = "Ion"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			var/list/A=usr.LearnedJutsus
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return

			switch(input(usr,"Brrr, I'm cold. How cold are you?", "Buriza-do") in list ("Really Cold","What?"))
				if("Really Cold")
					var/found=0
					for(var/obj/SkillCards/Burizado/P in A)
						found=1
					for(var/obj/SkillCards/Kokuangyo/P in A)
						found=2
					if(found==1&&usr.GenjutsuKnowledge>500)
						if((usr.GenSkill+(usr.ChakraC/25))>=20)
							usr<<"Sometimes Blizzards are strong enough to even affect those around you..."
							usr.LearnJutsu("AOEBuriza-do",0,"AOEBurizado","Burizado AOE is Blizzard, but AoE, allowing you to catch much more people in this cold Genjutsu.","Genjutsu");return
						else
							usr<<"You don't have enough control with your Chakra to learn this technique.";return
					else if(found==2&&usr.GenjutsuKnowledge>650)
						if((usr.GenSkill+(usr.ChakraC/25))>=21)
							usr<<"You thought Darkrai was the true master of Darkness...."
							usr.LearnJutsu("AOEKokuangyo",0,"AOEKokuangyo","Kokuangyo AOE is Kokuangyo, but a bit more powerful and allows you to catch multiple people in it.","Genjutsu");return
						else
							usr<<"You don't have enough control with your Chakra to learn this technique..";return
					else
						usr.LearnJutsu("Buriza-do",0,"Burizado","Buriza-do No Jutsu is a technique which covers the opponent in a blizzard, causing them to move slow! Because it is a genjutsu, only they can see it and only they think it's real","Genjutsu");return
	MissingJounin7
		name = "Iowa"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='ExclusiveH.dmi'
				Hair+=rgb(0,100,100)
				var/UchihaShirt='Icons/New Base/Clothing/cloak3.dmi'
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=UchihaShirt
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Illusions!!!", "Kasumi") in list ("I see them too!","What?"))
				if("I see them too!")
					if(usr.GenjutsuKnowledge<35)
						usr<<"You need more Genjutsu Knowledge.";return
					usr.LearnJutsu("Kasumi Juusha No Jutsu",0,"Kasumi","Kasumi Juusha No Jutsu is a genjutsu technique that creates false clones, allowing you to move around freely and secretly.","Genjutsu");return
	MissingJounin8
		name = "Irela"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Hair+=rgb(200,0,200)
				var/UchihaShirt='cloak.dmi'
				UchihaShirt-=rgb(100,100,100)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=UchihaShirt
				src.overlays-=Hair
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Yawn...", "Nehan Shouja no Jutsu") in list ("Are you tired?","What?"))
				if("Are you tired?")
					if(usr.GenjutsuKnowledge<50)
						usr<<"You need more Genjutsu Knowledge.";return
					usr.LearnJutsu("Nehan Shouja no Jutsu",0,"Nemurihane","Nehan Shouja no Jutsu is a technique that covers the whole field with petals, anyone in it automatically falling asleep.","Genjutsu");return
	MissingJounin40
		name = "Gyoushino"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Hair+=rgb(240,170,68)
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			//var/list/A=usr.LearnedJutsus
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Look Into My Eyes...Are you Scared..?") in list ("...","No"))
				if("...")
					if(usr.GenjutsuKnowledge<450)
						usr<<"You need more Genjutsu Knowledge, come back to me when you have more...";return
					usr.LearnJutsu("Gaze Of Horror",0,"GazeOfFear","Gaze Of Fear is a Genjutsu that requires the User to look into the eyes of the opponent, terrifying them and reducing their stats temporarily.","Genjutsu")
					return
	MissingJounin41
		name = "Kado"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Hair+=rgb(124,117,117)
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
		//		src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			//var/list/A=usr.LearnedJutsus
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Have you ever been to another Dimension...Who knows what lies on the other side...") in list ("I want to find out...","Who knows"))
				if("I want to find out...")
					if(usr.GenjutsuKnowledge<650)
						usr<<"You need more Genjutsu Knowledge, come back to me when you have more...";return
					usr.LearnJutsu("Draining Vortex",0,"DrainingVortex","DrainingVortex is a Genjutsu that causes a vortex to be seen by the opponent as it slowly drains their life away...","Genjutsu")
					return
	MissingJounin42
		name = "Yotim"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Hair+=rgb(124,117,117)
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				UchihaShirt-=rgb(255,255,255)
				src.icon=Base
				src.overlays-='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays-='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays-='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays-='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+=UchihaShirt
				src.overlays-='Icons/New Base/Clothing/Cloths.dmi'
		//		src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloak.dmi'
				src.overlays-=Hair
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			//var/list/A=usr.LearnedJutsus
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Genjutsu utilizing Ninja Tools is a deadly combination..") in list ("How So?","Ok."))
				if("How So?")
					if(usr.GenjutsuKnowledge<650)
						usr<<"You need more Genjutsu Knowledge, come back to me when you have more...";return
					else if(usr.KunaiMastery<=30)
						usr<<"You need more knowledge with Kunais to learn this Genjutsu..";return
					usr.LearnJutsu("Horrific Kunais",0,"FearofProjectiles","Fear of Projectiles: Horrific Kunais is a Genjutsu utilizing the ninja tool Kunai. It causes Kunais to fly at the opponent in a random direction unable to dodge them.","Genjutsu")
					return


	MissingJounin9
		name = "Kusakin, Rin"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/SasukeH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,50)
				UchihaShirt-=rgb(0,0,200)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Don't ever let life get you down!";sleep(1)
			if(usr.Clan=="Kusakin"||usr.Clan2=="Kusakin")
				usr<<"Oh, you're of the Kusakin Clan?"
				switch(input(usr,"Would you like to learn some techniques?", "Kusakin Clan") in list ("Seasonal-Edged Leaf Jutsu","Ivy-Whip Jutsu","VineFieldJutsu","Grass-Knot Jutsu","Ivy-Forest Jutsu","Cancel"))
					if("Seasonal-Edged Leaf Jutsu")
						usr.LearnJutsu("Seasonal-Edged Leaf Jutsu",0,"Kamisoriha","Seasonal-Edged Leaf Jutsu is a technique that shoots off leaves abnormally sharp that can slice an enemy to bits.","Mokuton");return
					if("Ivy-Whip Jutsu")
						if(usr.GrassMastery<35)
							usr<<"You need more Grass Mastery to learn this jutsu.";return
						usr.LearnJutsu("Ivy-Whip Jutsu",0,"Tsutakei","Ivy-Whip Jutsu is an offensive jutsu that allows the user to manipulate vines and use as whips.","Mokuton");return
					if("VineFieldJutsu")
						if(usr.GrassMastery<75)
							usr<<"You need more Grass Mastery to learn this jutsu.";return
						usr.LearnJutsu("Vine Field Jutsu",0,"VineFieldJutsu","Vine Field Jutsu is an offensive jutsu where the Kusakin throws vines at the opponent, severely damaging them if it hits.","Mokuton");return
					if("Grass-Knot Jutsu")
						if(usr.GrassMastery<50)
							usr<<"You need more Grass Mastery to learn this jutsu.";return
						usr.LearnJutsu("Grass-Knot Jutsu",0,"KusaBushi","Grass-Knot Jutsu is a technique that binds the target within grass and vines. They constrict and tangle in such a way that it can barely be broken.","Mokuton");return
					if("Ivy-Forest Jutsu")
						if(usr.GrassMastery<75)
							usr<<"You need more Grass Mastery to learn this jutsu.";return
						usr.LearnJutsu("Ivy-Forest Jutsu",0,"Kusahayashi","Ivy-Forest Jutsu is taking the manipulation of vines to the fullest extent, making a forest of vines which the user has the advantage in.","Mokuton");return
	MissingJounin10
		name = "Kusakin, Aito"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='SpikeyH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(0,0,50)
				UchihaShirt-=rgb(0,0,200)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"The beginning of our beautiful clan was started by a man with a wonderful ambition!";sleep(1)
			if(usr.Clan=="Kusakin"||usr.Clan2=="Kusakin")
				usr<<"Oh, you're of the Kusakin Clan? Have you gained control over Wood?"
				if(usr.Senju<1)
					usr<<"Ah, it's a shame. Perhaps it'll come one day.";return
				switch(input(usr,"Would you like to learn some techniques?", "Kusakin Clan") in list ("Wood Barrier Jutsu","Birth of a Dense Woodland Jutsu","Wood Spikes Jutsu","Wood Clone Jutsu","Wood Shards","Wood Prison","Wood Dragon","Cancel"))
					if("Wood Barrier Jutsu")
						usr.LearnJutsu("Wood Barrier Jutsu",0,"MokuShouheki","Wood Barrier Jutsu is a jutsu that creates a wooden defence in front of the user.","Mokuton");return
					if("Birth of a Dense Woodland Jutsu")
						if(usr.SturdyComposition<20)
							usr.<<"Come back when you're able to make stronger wood."
						usr.LearnJutsu("Birth of a Dense Woodland Jutsu",0,"JukaiKoutan","Birth of a Dense Woodland Jutsu is an amazing Mokuton technique which utilizes the roots of Mokuton and creates an extraordinary forest battleground.","Mokuton");return
					if("Wood Spikes Jutsu")
						usr.LearnJutsu("Wood Spikes Jutsu",0,"WoodSpikes","Wood Spikes Jutsu is a technique that creates a row of Wooden Spikes in a forward motion that can impale the enemy.","Mokuton");return
					if("Wood Shards")
						usr.LearnJutsu("Wood Shard Jutsu",0,"WoodShard","Wood Shards is a jutsu that quickly shoots weak, small wooden shards in all directions");return
					if("Wood Clone Jutsu")
						usr.LearnJutsu("Wood Clone Jutsu",0,"MokuBunshin","Wood Clone jutsu creates a hard copy of it's user, capable of much more than a simple Shadow Clone.");return
					if("Wood Prison")
						if(usr.SturdyComposition<18)
							usr.<<"Come back when you're able to make stronger wood."
						usr.LearnJutsu("Wooden Prison Jutsu",0,"WoodPrison","Wood Prison is a technique where the user forms a cage-like bind around the target.");return
					if("Wood Dragon")
						if(usr.SturdyComposition<20)
							usr.<<"Come back when you're able to make stronger wood."
						usr.LearnJutsu("Wooden Dragon Jutsu",0,"WoodDragon","Wooden Dragon is a technique that creates a dragon made entirely of wood. It is a very deadly technique.");return

	MissingJounin11
		name = "Ketsueki, Shikyo"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(0,0,50)
				UchihaShirt-=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hm.";sleep(1)
			if(usr.Clan=="Ketsueki"||usr.Clan2=="Ketsueki")
				usr<<"Oh, you're of the Ketsueki Clan?"
				switch(input(usr,"Would you like to learn some techniques?", "Ketsueki Clan") in list ("Blood Clone Jutsu","1st Seal","2nd Seal","3rd Seal","4th Seal","5th Seal","6th Seal","Cancel"))
					if("Blood Clone Jutsu")
						usr.LearnJutsu("Blood Clone Jutsu",0,"KetsuekiBunshin","Blood Clone Jutsu turns all blood nearby into clones. This is considerably the Ketsueki's Clan main offensive jutsu.","Ninjutsu");return

					if("1st Seal")
						usr.LearnJutsu("Fuuin: Chakra Shouheki",0,"firstSeal","Fuuin: Chakra Shouheki is a powerful and useful technique. For the cost of a little bit of control and blood supply, the Ketsueki Clan ninja is able to rejuvinate their chakra completely!","Ninjutsu");return

					if("2nd Seal")
						if(usr.SealMastery<25)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Banpaia",0,"secondSeal","Fuuin: Banpaia is the Ketsueki ninja's powerful boosting attack that raises their speed and attacking functions, allowing them automatic reflexes.","Ninjutsu");return

					if("3rd Seal")
						if(usr.SealMastery<35)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Ketsueki Bakuha",0,"thirdSeal","Fuuin: Ketsueki Bakuha is a technique that explodes the blood within your body to create a radius of blood which can be used for many other things afterwards.","Ninjutsu");return

					if("4th Seal")
						if(usr.SealMastery<45)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Ketsueki Dobu",0,"fourthSeal","Fuuin: Ketsueki Dobu is the fourth seal, which is placed on a victim. As long as the victim is near you, you will slowly drain their health and absorb it for yourself.","Ninjutsu");return
					if("5th Seal")
						if(usr.SealMastery<45)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Fifth Seal",0,"fifthSeal","Fifth Seal is a jutsu that binds you to someone, similar to a blood contract.","Ninjutsu");return

					if("6th Seal")
						if(usr.SealMastery<45)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin:Sixth Seal",0,"sixthSeal","Sixth Seal is a technique combined with the fifth seal, which causes the targetted person in fifth seal, to recieve damage, rather then you.","Ninjutsu");return

	MissingJounin12
		name = "Amaiyo"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='BuzH.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi'
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Sometimes being hungry can be bad.", "Kiga") in list ("Why?","What?"))
				if("Why?")
					usr.LearnJutsu("Kiga",0,"Kiga","Kiga is a genjutsu that slowly increases the opponent's hunger.","Genjutsu");return
	MissingJounin13
		name = "Amano"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='ExclusiveH.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Sometimes being thirsty can be bad.", "Nodono Kawaki") in list ("Why?","What?"))
				if("Why?")
					usr.LearnJutsu("Nodono Kawaki",0,"NodonoKawaki","Nodono Kawaki is a genjutsu that slowly increases the opponent's thirst.","Genjutsu");return
	MissingJounin14
		name = "Fuugaro"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='SpikeyH.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(0,100,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi'
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Are you Dizzy?", "Gyaku Bijon") in list ("Yes.","No."))
				if("No.")
					if(usr.GenjutsuKnowledge<35)
						usr<<"You need more Genjutsu Knowledge.";return
					usr.LearnJutsu("Gyaku Bijon",0,"GyakuBijon","Gyaku Bijon is a powerful Gejutsu that confuses the opponent by spinning their view.","Genjutsu");return
	MissingJounin15
		name = "Sei"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/KiraH.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(0,100,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi'
				src.overlays+='Icons/New Base/Clothing/glasses.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			switch(input(usr,"Too many people pass over wires, don't you agree?", "Harigane Gappei") in list ("Yes.","No."))
				if("Yes.")
					usr.LearnJutsu("Harigane Gappei",0,"HariganeGappei","Harigane Gappei is a weak but useful ninjutsu techniques that turns all the wires on the user's screen dense, making it useful as a trapping technique.","Ninjutsu");return
	MissingJounin16
		name = "Kenshin"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/itachiH.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(150,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/cloak3.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			sleep(3)
			var/list/A=usr.LearnedJutsus
			usr<<"The art of swordsmanship is a very delicate art."
			switch(input(usr,"Would you like to learn some techniques?", "Swordsmanship") in list ("Swift Slash","Impale","Rapid Strike","DancingCrescent","Anarchist","Departure In Flames","Moonsplitter","Cancel"))
				if("Swift Slash")
					usr.LearnJutsu("Swift Slash",0,"SwiftSlash","Swift Slash is a quick-paced fighting technique utilizing Yanagi. The user quickly slashes in all locations around them, wounding anyone.","Taijutsu");return
				if("Impale")
					usr.LearnJutsu("Impale",0,"Impale","Impale is a quick-paced fighting technique utilizing Yanagi. The user quickly moves their bone blades forward to impale the target.","Taijutsu");return
				if("Rapid Strike")
					var/found=0
					for(var/obj/SkillCards/SwiftSlash/P in A)
						found=1
					if(!found)
						usr<<"You need to learn Swift Slash to use this jutsu!";return
					usr.LearnJutsu("Rapid Strike",0,"RapidStrike","Rapid Strike is a quick-paced fighting technique utilizing Tsubaki. The user moves their blades at rapid speeds attacking multiple times.","Taijutsu");return
				if("DancingCrescent")
					var/found=0
					var/found1=0
					for(var/obj/SkillCards/SwiftSlash/P in A)
						found=1
					if(!found)
						usr<<"You need to learn Swift Slash to use this jutsu!";return
					for(var/obj/SkillCards/RapidStrike/P in A)
						found1=1
					if(!found1)
						usr<<"You need to learn Rapid Strike to use this jutsu!";return
					var/found2=0
					for(var/obj/SkillCards/Impale/P in A)
						found2=1
					if(!found2)
						usr<<"You need to learn Impale to use this jutsu!";return
					if(usr.Kenjutsu<=15)
						usr<<"You need more Kenjutsu!"
						return
					usr.LearnJutsu("Dancing Crescent Technique",0,"DancingCrescent","Dancing Crescent is a kenjutsu that utilizes the ninja's natural aerobics, allowing them to swiftly n in the air into a crescent and land a few spaces in front of them, harming all that were in the way of the crescent.","Taijutsu");return
				if("Anarchist")
					var/found=0
					var/found1=0
					for(var/obj/SkillCards/SwiftSlash/P in A)
						found=1
					if(!found)
						usr<<"You need to learn Swift Slash to use this jutsu!";return
					for(var/obj/SkillCards/RapidStrike/P in A)
						found1=1
					if(!found1)
						usr<<"You need to learn Rapid Strike to use this jutsu!";return
					var/found2=0
					for(var/obj/SkillCards/Impale/P in A)
						found2=1
					if(!found2)
						usr<<"You need to learn Impale to use this jutsu!";return
					var/found3=0
					for(var/obj/SkillCards/DancingCrescent/P in A)
						found3=1
					if(!found3)
						usr<<"You need to learn Dancing Crescent to use this jutsu!";return
					if(usr.Kenjutsu<=20)
						usr<<"You need more Kenjutsu!"
						return
					usr.LearnJutsu("Anarchist Bludgeoning Technique",0,"Anarchist","More of a technique used for those who are brutal and barbaric. Utilizing sheer strength the user attempts to bludgeon their weapon into the opponents upper body, possibly head, harming them severely.","Taijutsu");return
				if("Departure In Flames")
					var/found=0
					var/found1=0
					for(var/obj/SkillCards/SwiftSlash/P in A)
						found=1
					if(!found)
						usr<<"You need to learn Swift Slash to use this jutsu!";return
					for(var/obj/SkillCards/RapidStrike/P in A)
						found1=1
					if(!found1)
						usr<<"You need to learn Rapid Strike to use this jutsu!";return
					var/found2=0
					for(var/obj/SkillCards/Impale/P in A)
						found2=1
					if(!found2)
						usr<<"You need to learn Impale to use this jutsu!";return
					var/found3=0
					for(var/obj/SkillCards/DancingCrescent/P in A)
						found3=1
					if(!found3)
						usr<<"You need to learn Dancing Crescent to use this jutsu!";return
					var/found4=0
					for(var/obj/SkillCards/Anarchist/P in A)
						found4=1
					if(!found4)
						usr<<"You need to learn Anarchist Bludgeoning Technique to use this jutsu!";return
					if(usr.Kenjutsu<=25)
						usr<<"You need more Kenjutsu!"
						return
					usr.LearnJutsu("Departure In Flames: Assassinating Technique",0,"DepartureInFlames","A technique for the most sadistic of ninja, the user takes their blade and places it on the throat of the victim, ensuring the blood stained blade leaves a mark on the victim...This can become very deadly when trained.","Taijutsu");return


				if("Moonsplitter")
					var/found=0
					var/found1=0
					var/found2=0
					for(var/obj/SkillCards/SwiftSlash/P in A)
						found=1
					for(var/obj/SkillCards/RapidStrike/O in A)
						found1=1
					for(var/obj/SkillCards/Impale/I in A)
						found2=1
					if(usr.Kenjutsu<50)
						usr<<"You need more Kenjutsu!"
						return
					if((found==1)&&(found1==1)&&(found2==1)&&(usr.Kenjutsu>50))
						usr.LearnJutsu("Moon Splitter",0,"Moonsplitter","Moonsplitter is a quick paced jutsu utilizing fast paced Jutsu. The user is able to quickly overspeed his opponent, target a weak point, and impale them.","Taijutsu");return
					else
						usr<<"You're not able to learn this jutsu yet!";return
	Star1
		name = "Star"
		icon = 'Map/Turfs/HakumeiGetsu.dmi'
		icon_state="Moon3"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"You concentrate on the star.";usr.Frozen=1
			sleep(30);usr.Frozen=0
			if(usr.Clan!="Basic"&&usr.Clan!="Fuuma"&&usr.Clan!="Yotsuki"&&usr.key!=""&&usr.Clan!="Satou")
				usr<<"The star rejects you!";return
			switch(input(usr,"The star accepts you! Do you wish to learn Kujaku Myouhou?", "Kujaku Myouhou") in list ("Yes.","No."))
				if("Yes.")
					usr.LearnJutsu("Kujaku Myouhou",0,"KujakuMyouhou","Kujaku Myouhou is a technique that projects chakra which can be used as a beast to attack the target.","Ninjutsu");return
	reflexGuy
		name = "Masaharu Morimoto"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Base+=rgb(235,145,52)
				Hair+=rgb(250,21,140)
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
				usr<<"You need to be facing them!";return;
			if(usr.reflexQuestThreeCounter >= 10)
				alert("[src]: I sense my masters power within you!")
				alert("[usr]: I have collected the pieces of your masters power, please teach me how to unite it.")
				alert("[src]: You truly have earned this.")
				usr<<"[src] focuses his character into you."
				usr<<"You feel of surge of energy as Masaharu Morimoto infuses his masters powers within you."
				usr<<"Your reflex level increases to the highest level!"
				usr.reflexNew = 3
				return
	//		if(usr.Mtai<=22)
	//			alert("Masaharu Morimoto: Hello,.. oh I am to busy to talk to you")
	//			return;
			if(((usr.Mtai>=22)&&(usr.reflexNew == 0))||((usr.Swift>=3)&&(usr.TaijutsuKnowledge>=400)&&(usr.reflexNew == 0)))
				switch(input(usr, "Masaharu Morimoto: Oh,hello young one, what a lovely day, isn't it?", text)in list("Yeah it sure is!","I don't have time for this."))
					if("I don't have time for this.")
						alert("Masaharu Morimoto: I see goodbye then")
						return;
					if("Yeah it sure is!")
						switch(input(usr, "Masaharu Morimoto: This Land holds many adventures, many wonders, and many secrets, some horrible and others beyond belief, I was a ninja myself once. But now I just like to stay here, getting used to the elderly life. Bahh...Shinobis now a days don't have the spirit we had.", text) in list ("Why not?", "..."))
							if("...")
								return;
							if("Why not?")
								switch(input(usr, "Masaharu Morimoto: Well they don't seem to be able to break the historic codes of speed, no no son...I do not mean the speed of which you go but the speed of each limp equally, the speed of your mind! A Shinobi has to be mentaly ready for ANYTHING, at anytime! Not just your mind but your whole body. You have to make sure it fits right!", text) in list ("Thats what she said, haha" , "Please teach me  more!"))
									if("Thats what she said, haha")
										alert("Masaharu Morimoto: I am not an old fool!")
										return;
									if("Please teach me  more!")
										alert("Masaharu Morimoto: My father was a Shinobi teacher and he usually said 'The mental act of sensation which issues in reflex movement is so simple as to defy analysis.' None of us really understood this, but it had me realize that every single thing you do has somthing to do with your mental and physique reflexes. If you do a small task for me, I will show you")
										switch(input(usr, "Masaharu Morimoto: So will you do this task for me?", text) in list("Ofcourse","No way, old man"))
											if("No way, old man")
												alert("Fine don't learn my secrets")
												return;
											if("Ofcourse")
												alert("Masaharu Morimoto: Ok, now listen closely, there is a cave to the north, all I want to you to do is go north to the cave and get a scroll I left behind inside. That should be simple enough for you.")
												alert("[usr]: Yea that sounds easy enough.")
												alert("Masaharu Morimoto: Just be careful about the lava, it might burn the scroll if you dont get it soon enough")
												alert("[usr]: Lava...???")
												alert("Masaharu Morimoto: eh you better hurry bye now.. come back with scroll!")
												//spawn the scroll here,start the questvar
												var/obj/O = new/obj/reflex/reflexOneQuestScroll
												O.loc = locate(33,20,29)
												usr.reflexOneQuest = 1
												return;
			else if(((usr.Mtai>=37)&&(usr.reflexNew==1))||((usr.Swift>=4)&&(usr.TaijutsuKnowledge>=750)&&(usr.reflexNew == 1)))
				alert("Masaharu Morimoto: Ohh yes...you want to learn the ultimate secret of reflex I suppose....well..*cough* I'm afraid I can't tell you just yet...")
				alert("[usr]: What..?")
				switch(input(usr, "Argh!! don't raise your voice against me, don't think just because I'm old, I can't smack you one on the side of your head kid. Listen now, I know from the deed you did to me, that you are not like the other now-a-day shinobis. There are many basic necessities you will require to understand the secret of Reflex, and I will try to teach you that. Reflex has 3 phases the first one is Reaction time: This is the perception of an attack, or rather the interval between stimulus and the beginning of response.  What you just did for me before was a task in that area which you obviously  did well....but", text) in list ("But what?","Screw this, I thought you were going to give me cash!"))
					if("Screw this, I thought you were going to give me cash!")
						alert("Masaharu Morimoto: I guess I was wrong about your being different from other shinobi of the day")
						return;
					if("But what?")
						switch(input(usr, "You need to complete the two other tasks too, and I will gladly teach you, but this will be harsh. Do you understand? I will open the door, but you must enter by yourself.", text) in list("Of course I will!","Nah.. I am not into that"))
							if("Nah.. I am not into that")
								alert("Masaharu Morimoto: Well this path is not for everyone.")
								return;
							if("Of course I will!")
								alert("Masaharu Morimoto: Alright, then all I need to do is to show you the way of the speedy shinobi. But before I can get that, you will need to go get the second scroll.")
								alert("[usr]: ANOTHER SCROLL!!!??")
								alert("Masaharu Morimoto: Yes!, Another scroll! Go back to the dangerous lava cave and go get the second scroll I left behind. And like last time it is probably ready to catch fire so be quick about it!")
								alert("[usr]: But ... ")
								alert("Masaharu Morimoto: No buts, Just go get the scroll now, and also to be able to learn the secrets of the reflex you will also need the hidden ninja scroll in your possession. Remember the scroll will not last forever. Hurry and find it.")
								var/obj/O = new/obj/reflex/reflexOneQuestScroll2
								O.loc = locate(33,20,29)
								usr.reflexOneQuest = 1
								return
			else if ((usr.Mtai>=52)&&(usr.reflexNew == 2))
				alert("Masaharu Morimoto: So you are finally ready to be a true master of reflex. Unfortionately, I can only give you the task, My master traveled to Snow Village Long Ago and never returned. Perhaps if you travel there you can find what you are searching for. You must be quick though; if you take to long you will need to restart all over again. Also as always you will need the Hidden Ninja Scroll in your pocession.")
				alert("Masaharu Morimoto: Good luck, now hurry to snow village!.")
				usr.reflexOneQuest = 1
				var/mob/K  = new/mob/Teachers/reflexMaster
				K.loc = locate(160,189,22)
				sleep(10000)
				usr<<"You feel to much time has passed go back to talk to Morimoto, if you haven't started the next part of your mission yet."
				return
			else if (usr.reflexOneQuest == 1)
				switch(input(usr, "Masaharu Morimoto: You are in the middle of a mission, would you like to restart it?", text) in list ("I would like to restart it." , "No, I am fine."))
					if("No, I am fine.")
						usr<<"Masaharu Morimoto: Alright, hurry though, time waits for no one."
						return
					if("I would like to restart it.")
						usr<<"Masaharu Morimoto: Everyone needs a second chance, talk to me again."
						usr.reflexOneQuest = 0
						return

			else
				usr<<"I feel you have reached your limit."
				return;

	reflexMaster
		name = "Masaharu Morimoto's Master"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				Base+=rgb(190,60,52)
				Hair+=rgb(100,21,140)
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
				usr<<"You need to be facing them!";return;
			if(usr.reflexNew == 2 && usr.reflexOneQuest == 1 && usr.HasHiddenScroll)
				alert("[usr]: Are you Morimoto's Master?")
				alert("[src]: I am afraid, I am not, the real Master you seek died long ago. I am merely an inprint of him.")
				alert("[usr]: What happened to him?")
				alert("[src]: When traveling here to snow village I fell ill from the cold, it was at this time my enemies attacked me at my weakest and tried to steal my power.")
				alert("[usr]: What happened to your power?")
				alert("[src]: I split my power into many different pieces and sent it throughout the world, but now my enemies have finally collected all of the pieces and will unite them. With that power the will be able to destory the world. Only you can stop them now!")
				alert("[usr]: What must I do?")
				alert("[src]: Back through the cave to enter snow village there is a secret place where the enemy has gathered, find that place and defeat every enemy and reclaim the pieces. Take them back to my student. He will know what to do!")
				alert("[src]: My time is fading, rise to this challenge and save the world [usr].")
				usr<<"The man before you fades away.."
				var/obj/A = new/mob/NPC/BossReflex2
				A.loc = locate(81,117,22)
				var/obj/B = new/mob/NPC/BossReflex2
				B.loc = locate(84,117,22)
				var/obj/C = new/mob/NPC/BossReflex2
				C.loc = locate(88,117,22)
				var/obj/D = new/mob/NPC/BossReflex2
				D.loc = locate(91,117,22)
				var/obj/E = new/mob/NPC/BossReflex2
				E.loc = locate(84,114,22)
				del(src)
				return
			else
				usr<<"[src]: You are not the one whom I must talk too."
				return

		proc
			npcLife()
				sleep(10000)
				del(src)
				return

	/*
	reflex1 req tai = 22
	reflex2 req tai = 37
	reflex3 req tai = 52

	*/



	RainJounin13
		name = "Ketsueki, Shikyo"
		icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Rain"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/Hair='Icons/New Base/Hair/PainbodyH.dmi'
				var/UchihaShirt='Icons/New Base/Clothing/SasukeShirt.dmi'
				Base+=rgb(190,190,190)
				Hair+=rgb(0,0,50)
				UchihaShirt-=rgb(0,0,0)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+=UchihaShirt
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+=Hair

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hm.";sleep(1)
			if(usr.Clan=="Ketsueki"||usr.Clan2=="Ketsueki")
				usr<<"Oh, you're of the Ketsueki Clan?"
				switch(input(usr,"Would you like to learn some techniques?", "Ketsueki Clan") in list ("Blood Clone Jutsu","First Seal","Second Seal","Third Seal","Fourth Seal","Fifth Seal","Sixth Seal","Cancel"))
					if("Blood Clone Jutsu")
						usr.LearnJutsu("Blood Clone Jutsu",0,"KetsuekiBunshin","Blood Clone Jutsu turns all blood nearby into clones. This is considerably the Ketsueki's Clan main offensive jutsu.","Ninjutsu");return

					if("First Seal")
						usr.LearnJutsu("Fuuin: Chakra Shouheki",0,"FirstSeal","Fuuin: Chakra Shouheki is a powerful and useful technique. For the cost of a little bit of control and blood supply, the Ketsueki Clan ninja is able to rejuvinate their chakra completely!","Ninjutsu");return

					if("Second Seal")
						if(usr.SealMastery<25)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Banpaia",0,"SecondSeal","Fuuin: Banpaia is the Ketsueki ninja's powerful boosting attack that raises their speed and attacking functions, allowing them automatic reflexes.","Ninjutsu");return

					if("Third Seal")
						if(usr.SealMastery<35)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Ketsueki Bakuha",0,"ThirdSeal","Fuuin: Ketsueki Bakuha is a technique that explodes the blood within your body to create a radius of blood which can be used for many other things afterwards.","Ninjutsu");return

					if("Fourth Seal")
						if(usr.SealMastery<45)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Ketsueki Dobu",0,"FourthSeal","Fuuin: Ketsueki Dobu is the fourth seal, which is placed on a victim. As long as the victim is near you, you will slowly drain their health and absorb it for yourself.","Ninjutsu");return

					if("Fifth Seal")
						if(usr.SealMastery<45)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin: Fifth Seal",0,"FifthSeal","Fifth Seal is a jutsu that binds you to someone, similar to a blood contract.","Ninjutsu");return

					if("Sixth Seal")
						if(usr.SealMastery<45)
							usr<<"You need more Seal Mastery to learn this technique.";return
						usr.LearnJutsu("Fuuin:Sixth Seal",0,"SixthSeal","Sixth Seal is a technique combined with the fifth seal, which causes the targetted person in fifth seal, to recieve damage, rather then you.","Ninjutsu");return

	SensoryTeacher
		name = "Brotato"
		Village="Missing"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
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
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
				src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am the wandering Sensory Ninja. I have spent my whole life wandering the continent learning vast types of Sensory Jutsu."
			if(locate(/obj/SkillCards/ChakraSense) in usr.LearnedJutsus)
				if(!(locate(/obj/SkillCards/ChakraAuraRemoval) in usr.LearnedJutsus))
					usr<<"Time to learn the next Sensory Jutsu..."
					usr.LearnJutsu("Chakra Aura Removal",0,"ChakraAuraRemoval","Chakra Aura Removal is a jutsu that allows you to hide your chakra aura.","Ninjutsu")
			else if(locate(/obj/SkillCards/ChakraAuraRemoval) in usr.LearnedJutsus)
				if(!(locate(/obj/SkillCards/EyeoftheKagura) in usr.LearnedJutsus))
					usr<<"Time to learn the next Sensory Jutsu..."
					usr.LearnJutsu("Mind's Eye of the Kagura",0,"EyeoftheKagura","One of the strongest Sensory Techniques known to man; Allowing a Ninja to visualize where the opponent is at will.","Ninjutsu")

			else if((usr.GenSkill+(usr.ChakraC/25)>26))
				usr<<"Well, it looks like you're capable of learning the arts of Sensory..."
				switch(input(usr,"If you would like, I can help you learn Sensory Type Jutsu, what do you say?") in list ("Please Teach Me!","I don't want to learn."))
					if("Please Teach Me!")
						usr.LearnJutsu("Chakra Sensory",0,"ChakraSense","Chakra Sensory is a type of Sensory Jutsu that allows a ninja to sense nearby chakra, allowing them to find enemies.","Ninjutsu")
						return
					if("I don't want to learn.")
						usr<<"Suit yourself."
						return
	BarrierTeacher
		name = "Kunihiko"
		Village="Missing"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
				var/Hair='Icons/New Base/Hair/inoH.dmi'
				Hair+=rgb(210,216,41)
				var/Shirt='Icons/New Base/Clothing/Shirt.dmi'
				Shirt+=rgb(50,181,17)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/pants.dmi'
				src.overlays+='Icons/New Base/Clothing/Cloths.dmi'
		//		src.overlays+='Icons/New Base/Clothing/facewrap.dmi'
				src.overlays+=Shirt
				src.overlays+=Hair
		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hello, I am Kunihiko, the Ninja who teaches Defencive Barrier type Ninjutsu. I have spent my whole life learning these Barrier Jutsu."
			sleep(20)
			switch(input(usr,"Would you like to learn some Defencive Techniques?", "Barrier Ninjutsu") in list ("Chakra Barrier","Strengthened Chakra Barrier","Barrier Entrapment","Chakra Barrier Shielding","Cancel"))
				if("Chakra Barrier")
					if(usr.NinjutsuKnowledge<=150)
						usr<<"You need at least 150 Ninjutsu Knowledge. Current Ninjutsu Knowledge: [usr.NinjutsuKnowledge].";return
					usr.LearnJutsu("Chakra Barrier",0,"ChakraBarrier","Chakra Barrier is a jutsu that allows the user to manipulate their chakra and form it into a barrier in front of them to shield them from attacks.","Ninjutsu");return

				if("Strengthened Chakra Barrier")
					if(usr.NinjutsuKnowledge<=250)
						usr<<"You need at least 250 Ninjutsu Knowledge. Current Ninjutsu Knowledge: [usr.NinjutsuKnowledge].";return
					if(!(locate(/obj/SkillCards/ChakraBarrier) in usr.LearnedJutsus))
						usr<<"You Need to Learn Chakra Barrier First!";return
					usr.LearnJutsu("Enhanced Chakra Barrier",0,"ChakraBarrierBig","Enhanced Chakra Barrier is a jutsu that is created by using what you learned from Chakra Barrier but manipulating the chakra to a more advanced state, creating a much bigger shield to protect against attacks.","Ninjutsu");return

				if("Barrier Entrapment")
					if(usr.GenSkill<16)
						usr<<"Sorry. I don't think you have enough natural control with your Chakra...";return
					if(usr.NinjutsuKnowledge<=325)
						usr<<"You need at least 325 Ninjutsu Knowledge. Current Ninjutsu Knowledge: [usr.NinjutsuKnowledge].";return
					if(!(locate(/obj/SkillCards/ChakraBarrierBig) in usr.LearnedJutsus))
						usr<<"You Need to Learn Strengthened Chakra Barrier First!";return
					usr.LearnJutsu("Barrier Entrapment",0,"ChakraBarrierTrap","Barrier Entrapment may be considered an offencive or Countering Ninjutsu but it still utilizes the defencive properties of A Chakra Barrier. Barrier entrapment causes created barriers to form around an opponent, sealing them in while also protecting them.","Ninjutsu");return
				if("Chakra Barrier Shielding")
					if(usr.GenSkill<16)
						usr<<"Sorry. I don't think you have enough natural control with your Chakra...";return
					if(usr.NinjutsuKnowledge<=375)
						usr<<"You need at least 375 Ninjutsu Knowledge. Current Ninjutsu Knowledge: [usr.NinjutsuKnowledge].";return
					if(!(locate(/obj/SkillCards/ChakraBarrierTrap) in usr.LearnedJutsus))
						usr<<"You Need to Learn Barrier Entrapment First!";return
					usr.LearnJutsu("Chakra Barrier Shielding",0,"ChakraBarrierShield","Chakra Barrier Shield allows the user to create chakra shield in all four directions around them, encasing them in a more defencive formation.","Ninjutsu");return


	WhiteElder
		name = "Kinjutsu Teacher"
		CNNPC = 1
		health = 9999999999999999999999999999999999999999999999
		Village="Leaf"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				Base+=rgb(235,145,52)
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
				src.overlays+='Cloak.dmi'
				src.overlays+='Icons/New Base/Hair/RyuzakiH.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"..."
			sleep(3)
			if(usr.SecondName=="Karsumu")
				return
				/*switch(input(usr,"I can teach you a few techniques created by the Great Orochimaru-Sama", "White Snake Jutsus") in list ("Hide Identity","Living Corpse Reincarnation"))
					if("Hide Identity")
						usr.LearnJutsu("Hide Identity",10000,"HideIdentity","This jutsu was created to hide our names from those who might try to steal our secret Kinjutsu....","Ninjusu");return
					if("Living Corpse Reincarnation")
						if(locate(/obj/SkillCards/HideIdentity) in usr.LearnedJutsus)
							if(usr.NinjutsuKnowledge<50)
								usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
							usr.LearnJutsu("Living Corpse Reincarnation",100000,"FushiTensei","Living Corpse Reincarnation is a jutsu which allows the user to steal the bodies of others that was originally created by the great Orochimaru-Sama himself.....","Kinjutsu");return
						else
							usr<<"If you can't honor our secrets then why should we trust you....";return*/
			if(usr.Clan=="Basic")
				return
				/*if(usr.Mchakra>=15000)
					switch(input(usr,"I can teach you a few techniques created by the Great Orochimaru-Sama", "White Snake Jutsus") in list ("Hide Identity","Living Corpse Reincarnation"))
						if("Hide Identity")
							if(usr.NinjutsuKnowledge<500)
								usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
							usr.LearnJutsu("Hide Identity",100000,"HideIdentity","This jutsu was created to hide our names from those who might try to steal our secret Kinjutsu....","Ninjusu");return
						if("Living Corpse Reincarnation")
							if(locate(/obj/SkillCards/HideIdentity) in usr.LearnedJutsus)
								if(usr.NinjutsuKnowledge<4000)
									usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
								usr.LearnJutsu("Living Corpse Reincarnation",1000000,"FushiTensei","Living Corpse Reincarnation is a jutsu which allows the user to steal the bodies of others that was originally created by the great Orochimaru-Sama himself.....","Kinjutsu");return
							else
								usr<<"If you can't honor our secrets then why should we trust you....";return
				else
					usr<<"You do not have enough chakra to use this jutsu!";return*/
			else
				usr<<"There is nothing for scum like you here..";return


	RainHydroTeach
		name = "Hozuki, Kayaba"
	//	icon='Icons/SnakeNPC.dmi'
		//icon_state="NPC2"
		CNNPC=1
		health=9999999999999999999999999999999999999999999999
		Village="Missing"
		New()
			..()
			spawn()
				src.icon=null
				var/Base='Icons/New Base/Base.dmi'
				var/icon/Hair=new('Icons/New Base/Hair/itachiH.dmi'+rgb(0,0,150))
				Base+=rgb(235,145,52)
				Hair.Crop(1,24,32,1)
				src.icon=Base
				src.overlays+='Icons/New Base/Clothing/Boxers.dmi'
				src.overlays+='Icons/New Base/MaleEyes.dmi'
				src.overlays+='Icons/New Base/Eyes.dmi'
				src.overlays+='Icons/New Base/Clothing/BaggyPants.dmi'
				src.overlays+='Icons/New Base/Clothing/bandagesL.dmi'
				src.overlays+='Icons/New Base/Clothing/bandagesR.dmi'
				src.overlays+='Icons/New Base/Clothing/kakashi mask.dmi'
				src.overlays+='Icons/New Base/Clothing/Sleeveless Shirt.dmi'

				src.overlays+=Hair
				src.overlays+='Icons/New Base/Clothing/NinjaHat.dmi'

		verb/Command()
			set src in oview(1)
			set name="Command"
			set hidden=1
			if(!src in get_step(usr,usr.dir))
				usr<<"You need to be facing them!";return
			usr<<"Hmm, sure is nice out here isn't it? I come here to get away from it all and practice this Forbidden skill."
			if(usr.Village=="Rain" && usr.WaterE)
				if((usr.NinjutsuKnowledge>=2000&&(usr.Clan=="Basic"||usr.Clan=="Fuuma"||usr.Clan=="Shiroi"||usr.Clan=="Ketsueki")&&usr.SuitonKnowledge>3000)||(usr.NinjutsuKnowledge>=300&&usr.SuitonKnowledge>3500)||usr.ckey=="itsnothim")
					switch(input(usr,"The Hydro Form is a powerful Kinjutsu, and there is the possibilty of dying permanently. Will you risk learning it?", "") in list ("Yes","No"))
						if("Yes")
							usr<<"The ninja injects a vial into your neck before you could react!"
							spawn()
								usr.StunAdd(40)
							sleep(300)
							var/chance=35
							if(usr.Subscriber)
								chance-=10
							if(usr.SecondName=="Hozuki")
								chance-=35
							if(prob(chance) && usr.ckey!="itsnothim")
								usr<<"You succumb to the pain and feel the life inside of your slipping away. You feel... wet..."
								for(var/turf/T in getcircle(src,1))
									var/obj/Jutsu/Elemental/Suiton/Owater/Z = new /obj/Jutsu/Elemental/Suiton/Owater
									Z.loc=T;Z.Owner=src.Owner;//Z.JutsuLevel=src.JutsuLevel
								var/firstletter=copytext(usr.ckey, 1, 2)
								fdel("Saves/[firstletter]/[usr.ckey].sav")
								world<<"<font color=#8b0000>[usr] attempted to achieve the power of the Hydro Form, but his body collapsed into a puddle of water...</font>"
								usr << "Character Deleted"
								del(usr)
							else
								usr.LearnJutsu("HydroForm",0,"HydroForm","Forbidden Jutsu which allows the user to become like water!","Ninjutsu");return
				else
					usr<<"You don't meet the requirements for this jutsu.";

			else
				usr<<"You don't meet the requirements for this jutsu.";

	BijuuTamer
		name = "Elder Monk"
		CNNPC = 1
		health = 999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
		Village = "Missing"
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
			usr<<"[src]: It seems that you're here to become one with the demon sleeping inside you."
			if(usr.JinchuurikiControl)
				usr<<"[src]: You have no business with me, as i've sensed that you're already one witht eh demon inside."
				usr.Frozen=0
				return
			else
				usr.TalkingToElementalTeacher=1
				switch(input(usr,"[src]: Do you wish to communicate with this beast?") in list ("Yes, I want to take the chance.","No, i've changed my mind!"))
					if("No, i've changed my mind!")
						usr<<"[src]: I see, your destiny is elsewhere then. Begone!"
						usr.Frozen = 0
						usr.TalkingToElementalTeacher=0//too lazy to change this so we'll just use this variable :^)
						return
					if("Yes, I want to take the chance.")
						usr<<"[src]: Well then...Let us begin."
						sleep(300)
						switch(input(usr,"Tailed-Beast: Oh, so you want to try attaining my friendship now? Hah!") in list ("Calm down. There are threats in this world, that could cause us both death. For this we need to team up.","Now you listen here you under degenerate piece of shit."))
							if("Calm down. There are threats in this world, that could cause us both death. For this we need to team up.")
								usr<<"Tailed-Beast:You weakling! I'll never team up with you. You're too weak to use my power! Hahaha!!Get out of here!"
								usr.Frozen=0
								usr.TalkingToElementalTeacher=0
								usr.health-=1500
								usr.BijuuMastery-=60
							if("Now you listen here you under degenerate piece of shit.")
								sleep(10)
								usr<<"Demon:Quite bold for a Human. Hah! Now what is it you want from me?"
								sleep(5)
						switch(input(usr,"....") in list ("Good, now that I have your attention, we're going to be friends, whether you like it or not. Now, I know that sounds unreasonable for you, but do you really like being locked away?","Bitch, gimme power now, or else."))
							if("Bitch, gimme power now, or else.")
								usr<<"Tailed-Beast:To hell with you!"
								usr.Frozen=0
								usr.TalkingToElementalTeacher=0
								usr.health-=1500
								usr.BijuuMastery-=60
								return
							if("Good, now that I have your attention, we're going to be friends, whether you like it or not. Now, I know that sounds unreasonable for you, but do you really like being locked away?")
								usr<<"Tailed-Beast: Heh.. I like where this is going. Fine, i'll share this body with you. At least that way i'll get a little sunshine once a while.Stand still, maggot"
								sleep(30)
								var/Chance=90
								if(prob(Chance))
									usr.JinchuurikiControl++
									usr<<"Tailed-Beast:There.. the connection between our chakra has been made."
									usr.Frozen=0
									usr.TalkingToElementalTeacher=0
									usr.JinchuurikiControl++
									return
								else
									usr<<"The link connection between your chakra and the Tailed Beast was not established due to an unknown error that was made. Try again another time."
									usr.Frozen=0
									usr.TalkingToElementalTeacher=0
									usr.BijuuMastery-=60
									return







			/*
			if(usr.Village=="Leaf")
				var/found=0
				for(var/obj/SkillCards/Haruno/P in A)
					if(P.type == /obj/SkillCards/Haruno) found=1
				if(found)
					usr<<"So how's that technique I taught you?";return
				else
					var/list/buttons = list("Yes", \
							"No", "Cancel")
					sd_Alert(src, "How would you like to learn a technique? It's called Hand of Nature! It's a special time offer, and hey I'm only teaching Leaf Villagers!","Haruno Jutsu", buttons, pick(buttons),0,0,"300x300",,\
						"<STYLE>TH {text-align:left} A{color:black} A{text-decoration:none} A:hover{background:red}\
						</STYLE>",,,SD_ALERT_LINKS)
					if("Yes")
						if(usr.NinjutsuKnowledge<35)
							usr<<"You don't have enough knowledge with Ninjutsu techniques.";return
						usr.LearnJutsu("Haruno No Jutsu",10000,"Haruno","Haruno Jutsu is a jutsu which covers the enemy within leaves, binding them and then pressuring them with damage.","Ninjutsu")
					if("No")
						return
			else
				usr<<"Oh, I thought you were a Leaf Ninja for a second."
			*/



//////////////////////////////////////////////////////////
//Procs to Learn Jutsu
mob/proc/LearnJutsu(JutsuName,Cost,JutsuMemoryVar,JutsuDesc,JutsuType,ElementalPoints=0)
//	var/list/A=src.LearnedJutsus
	//Elemental Poitns means how much Elemental Points it's going to cost, if any
//	world<<"Your current amount of EP you are going to lose: [src.ElementalPointDeduction]."
	if(src.TrappedInGedoMazo)
		src<<"This isn't your real body!";return
	if(src.JutsuDelay>0)
		src<<"You need to wait to learn another jutsu!";return
	switch(input(src,"[JutsuDesc]            Training Requirements: [Cost] EXP", "[JutsuName]") in list("Yes","No","Cancel"))
		if("Yes")
			if(src.JutsuDelay>0)
				src<<sound('SFX/click2.wav',0);return
				src<<"You need to wait to learn another jutsu!";return
			src<<sound('SFX/click1.wav',0)
			if(JutsuMemoryVar!="Genjutsu Kai"&&JutsuMemoryVar!="Gouken"&&JutsuMemoryVar!="Enjouhawa"&&JutsuMemoryVar!="Rakanken"&&JutsuMemoryVar!="Initial Gate"&&JutsuMemoryVar!="Heal Gate"&&JutsuMemoryVar!="Life Gate"&&JutsuMemoryVar!="Wound Gate"&&JutsuMemoryVar!="Limit Gate"&&JutsuMemoryVar!="View Gate"&&JutsuMemoryVar!="Death Gate"&&JutsuMemoryVar!="Wonder Gate"&&JutsuMemoryVar!="Quick Fist"&&JutsuMemoryVar!="FireChakra"&&JutsuMemoryVar!="WaterChakra"&&JutsuMemoryVar!="WindChakra"&&JutsuMemoryVar!="LightningChakra"&&JutsuMemoryVar!="EarthChakra"&&JutsuMemoryVar!="Tero Hasaki"&&JutsuMemoryVar!="Hansha"&&JutsuMemoryVar!="EternalDefence")
				var/C = JutsuMemoryVar
				var/T = text2path("/obj/SkillCards/[C]")
				if(locate(T) in src.LearnedJutsus)
					src<<"You already know [JutsuName]";return
			if(src.JutsuInLearning!="")
				if(src.JutsuDelay>0)
					src<<"You need to wait to learn another jutsu!";return
				src<<"You're already trying to learn something."
				switch(input(src,"Would you like to give up trying to learn [src.JutsuInLearning] and learn [JutsuName]?", "Learn [JutsuName]?") in list("Yes","No"))
				//switch(input(src,"Would you like to give up trying to learn [src.JutsuInLearning] and learn [JutsuName]?") in list("Yes","No"))
					if("Yes")
						if(src.JutsuDelay>0)
							src<<"You need to wait to learn another jutsu!";return
						src.ElementalPointDeduction=0;
						src.ElementalPointDeduction=ElementalPoints
						src.JutsuEXPCost=0;
						src.exp=0;
						src.JutsuMEXPCost=Cost;
						src.JutsuInLearning="[JutsuMemoryVar]";
						src<<"You are in training for [JutsuName].";
						src.TypeLearning=JutsuType;
						return
					if("No")
				//		world<<"Your current amount of EP you are going to lose: [src.ElementalPointDeduction]."
						return
			else
				src.ElementalPointDeduction=0
				src.ElementalPointDeduction=ElementalPoints
				src.JutsuEXPCost=0;
				src.exp=0;
				src.JutsuMEXPCost=Cost;
				src.JutsuInLearning="[JutsuMemoryVar]";
				src<<"You are in training for [JutsuName].";
				src.TypeLearning=JutsuType;return
		else
			src<<sound('SFX/click2.wav',0);return





