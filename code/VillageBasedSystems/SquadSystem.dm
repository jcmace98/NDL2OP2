/////////////////////////////////////////////////////////////////////////////////////////
//Squads
//////////////////////////////////////////////////////////////////
var
	list/
		Guilds = list()
mob/var/party_count=0
mob/GainedAfterLogIn/
	verb
		Guild_Create()
			set hidden=1
			set name="Create Squad"
			set desc="Creates a Squad with the permission of a Kage."
			if(!usr.PermissionToStartSquad||usr.Village=="Missing")
				usr<<"You don't have permission to start a Squad!"
				return
			var/list/L
			L = list("font size")

			if(usr.in_guild)
				usr<<"You are in a Squad already!"
				return
			switch(alert("Are you sure you wish to create a Squad?","Squad Creation","Yes","No"))
				if("Yes")
					goto Create
				if("No")
					return
			Create
				var/savefile/F = new("World Save Files/Guilds.sav")
				var/new_guild_name = input("What do you wish to Call your Squad?","Squad Name") as text
				if(findtextEx("Guilds.txt","[new_guild_name]")==1)
					alert("There is already a Squad with that name.")
					return
				if(!new_guild_name)
					alert("Squad Name may not be blank.")
					return
				for(var/X in L)
					if(findtext(new_guild_name,X))
						alert("You may not change your font size.")
						return
				if(length(new_guild_name)>1000000)
					alert("Cannot be more than 1000000 Characters!")
					goto Create
				switch(alert("Do you wish to call your Squad [new_guild_name]?","Squad Name","Yes","No"))
					if("Yes")
						goto Finalise
					if("No")
						goto Create
				Finalise
					text2file("(Squad - Creation)-[time2text(world.realtime)]:[new_guild_name] : Owner-[src]","Guilds.txt")
					src.guild_name = new_guild_name
					src.guild_leader = 1
					src.guild_rank="Leader"
					src.in_guild=1
					Guilds.Add(new_guild_name)
					F["Guilds"] << Guilds
					src.Give_Guild_Verbs()
					src.verbs -= new/mob/GainedAfterLogIn/verb/Guild_Create()
					src.party_count=1
mob/Guild_Leader
	verb
		Guild_Invite()
			set category = "Squad"
			set name = "Squad Invitation"
			if(src.party_count>=4) return
			var/list/Menu = list()
			for(var/mob/M in world)
				if(!M.client) continue
				if(M.name != usr.name)
					if(!M.in_guild)
						Menu.Add(M)

			var/mob/M = input("Invite Who?","Squad Invite") as null | anything in Menu
			if(!M)return
			if(istype(M,/mob))
				if(!M.Village==usr.Village)
					usr<<"They must be in the same village as you!";return
				switch(alert(M,"Would you like to join [usr]'s Squad?","Squad Join","Yes","No"))

					if("Yes")
						M.guild_name = usr.guild_name
						M.guild_member = 1
						M.guild_rank = "Member"
						M.in_guild = 1
						usr.party_count+=1
						M.Give_Guild_Verbs()
						M.verbs -= new/mob/GainedAfterLogIn/verb/Guild_Create()

						for(var/mob/X in world)
							if(X.guild_name == usr.guild_name)
								X << "<font color = #BB0EDA>Squad Information:</font> [M] has joined the Squad!"


					if("No")
						usr << "[M] has declined your Squad Invite"
						return
		Squad_Boot()
			set category = "Squad"
			var/list/Menu = list()
			for(var/mob/M in world)
				if(!M.client) continue
				if(M.name != usr.name)
					if(M.in_guild)
						if(M.guild_name == usr.guild_name)
							Menu.Add(M)

			var/mob/M = input("Boot Who?","Squad Boot") as null | anything in Menu
			if(!M)return
			if(istype(M,/mob))
				if(M.guild_leader)
					alert("You cannot boot the Leader!")
					return
				switch(alert("Would you like to Boot [M] from the Squad?","Squad Boot","Yes","No"))

					if("Yes")
						M.Remove_Guild_Verbs()

						for(var/mob/X in world)
							if(X.guild_name == M.guild_name)
								X << "<font color = #BB0EDA>Squad Information:</font> [M] has been Booted from the Squad!"

						M.guild_name = "None"
						M.guild_leader = 0
						M.guild_member = 0
						usr.party_count-=1

						M.guild_rank = ""
						M.in_guild = 0

						M.verbs += new/mob/GainedAfterLogIn/verb/Guild_Create()

					if("No")
						usr << "You decided not to Boot [M]"
						return

		Squad_Announce(T as text)
			set category = "Squad"
			set desc = "Announce to the Squad"

			var/list/L
			L = list("font size")

			if(length(T) > 350)
				alert("Message must be less than 350 Characters!")
				return

			if(!T)
				alert("Your message may not be blank.")
				return

			for(var/X in L)
				if(findtext(T,X))
					alert("You may not change your font size.")
					return

			for(var/mob/X in world)
				if(X.guild_name == usr.guild_name)
					X << "<BR>----- Squad Announce -----<BR><font color=#000066>{<font color=#FFFFFF><font face = Arial>[src.guild_rank]<font color=#000066>}</font> [usr]: [T]<BR>"

mob/Guild_Verbs
	verb
		Squad_Chat(T as text)
			set category = "Squad"
			set desc = "Chat to the Squad"

			var/list/L
			L = list("font size")

			if(length(T) > 300)
				alert("Message must be less than 300 Characters!")
				return

			if(!T)
				alert("Your message may not be blank.")
				return

			for(var/X in L)
				if(findtext(T,X))
					alert("You may not change your font size.")
					return

			for(var/mob/X in world)
				if(X.guild_name == usr.guild_name)
					X << {"<pre><strong><font color="#000066">{<font color="#FFFFFF"><font face = Arial>Squad<font color="#000066">}<font color="#000066">[src.guild_name]: {<font color="#FFFFFF"><font face = Arial>[src.guild_rank]<font color="#000066">}</font></font></font></strong></pre> [src.name] Says:<font color = #CCCCCC> [T]"}


		Squad_Who()
			set category = "Squad"
			var/count = 0
			usr << "-------------------------------"
			for(var/mob/X in world)
				if(X.in_guild)
					if(X.guild_name == usr.guild_name)
						count += 1
						usr << "<font color=#000066>{<font color=#FFFFFF><font face = Arial>[X.guild_rank]<font color=#000066>}</font> [X]"
			usr << "Squad Members Online: [count]"
			usr << "-------------------------------"
		Mission_Join_Toggle()
			set category = "Squad"
			if(usr.MissionJoinLaw)
				usr<<"You toggle it off."
				usr.MissionJoinLaw=0
				return
			else
				usr<<"You toggle it on! You will now join every Mission any of your Squad Mate starts."
				usr.MissionJoinLaw=1
				return
		Squad_Leave()
			set category = "Squad"
			if(!src.guild_leader)
				switch(alert("Are you sure you wish to leave the Squad [src.guild_name]?","Squad Leave","Yes","No"))

					if("Yes")
						src.Remove_Guild_Verbs()

						for(var/mob/X in world)
							if(X.guild_name == src.guild_name)
								X << "<font color = #BB0EDA>Squad Information:</font> [src] has left the Squad!"

						src.guild_name = ""
						src.guild_leader = 0
						src.guild_member = 0

						src.guild_rank = ""
						src.in_guild = 0

						src.verbs += new/mob/GainedAfterLogIn/verb/Guild_Create()

					if("No")
						return
			else
				switch(alert("Are you sure you wish to leave the Squad [src.guild_name]?","Squad Leave","Yes","No"))

					if("Yes")
						for(var/mob/M in world)
							if(M.guild_name==src.guild_name)
								M<< "<font color = #BB0EDA>Squad Information:</font> [src] has Disbanded [src.guild_name]!"
						var/savefile/F = new("World Save Files/Guilds.sav")

						src.Remove_Guild_Verbs()


						for(var/mob/M in world)
							if(M.guild_name==src.guild_name)
								if(M==src.guild_leader)
									M.party_count-=1
						Guilds.Remove(src.guild_name)
						F["Guilds"] << Guilds
						text2file("(Squad - DELETED)[time2text(world.realtime)]:[src.guild_name] : Owner-[src]","Guilds.txt")

						src.guild_name = ""
						src.guild_leader = 0
						src.guild_member = 0

						src.guild_rank = ""
						src.in_guild = 0



						src.verbs += new/mob/GainedAfterLogIn/verb/Guild_Create()

					if("No")
						return

mob
	proc
		Give_Guild_Verbs()
			if(src.guild_leader)
				src.verbs += typesof(/mob/Guild_Leader/verb)
				src.verbs += typesof(/mob/Guild_Verbs/verb)

			if(src.guild_member)
				src.verbs += typesof(/mob/Guild_Verbs/verb)

		Remove_Guild_Verbs()
			if(src.guild_leader)
				src.verbs -= typesof(/mob/Guild_Leader/verb)
				src.verbs -= typesof(/mob/Guild_Verbs/verb)

			if(src.guild_member)
				src.verbs -= typesof(/mob/Guild_Verbs/verb)