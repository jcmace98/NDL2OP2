//var/list/ServerList=list("byond://75.126.182.129:2011","byond://75.126.182.129:2012")
//This is the list of official servers.
/*
This system should make some things easier. One bug with kages, is that if they move to another server, they glitch.
This way, this won't happen. Also would be able to be used in the case of instantly updating bans.
*/
/*
proc/ServerSend(Type as text,Text as text,mob/Who)
	return
	switch(Type)
		if("Kage")
			var/mob/M=Who
			for(var/S in ServerList)
				if(S!="byond://[world.address]:[world.port]")
					world.Export("[S]?type=Kage&key=[M.key]&village=[M.Village]")
		if("Ban")
			for(var/S in ServerList)
				if(S!="byond://[world.address]:[world.port]")
					world.Export("[S]?type=Ban&[Text]")
		if("Unban")
			for(var/S in ServerList)
				if(S!="byond://[world.address]:[world.port]")
					world.Export("[S]?type=Unban&[Text]")

world/Topic(T)
	var/list/S = params2list(T)
	switch(S["type"])
		if("Kage")
			var/M = S["key"]
			var/Village=S["village"]
			if(Village=="Leaf")	Hokage=M
			if(Village=="Rain")	Amekoutei=M
			if(Village=="Rock")	Tsuchikage=M
			if(Village=="Sound")	Otokami=M
		if("Ban")//ServerSend(Type="Ban",Text="kind=key&key=thatguy&ip=100.00.00.00&id=1234&who=[usr.key]")
			switch(S["kind"])
				if("Key")
					Bans:Add(S["key"])
					Bans[S["key"]]="[S["address"]]"
					world << "<font color = red><b>(Server Info)</b></color>([world.realtime]) The key [S["key"]] has been Banned.</font>"
					for(var/mob/M in world)
						if(M.key == S["key"])
							M<<"You have been banned by [S["who"]] (Banned). If you wish to find out why or feel you've been improperly banned, please post in the Ban Appeal section of the forums. </br>http://s8.zetaboards.com/NarutoFinalFight/forum/37185/</br>Note:: You must join to see and post in this section."
							del(M)
				if("IP")
					IPBans:Add(S["ip"])
					for(var/mob/M in world)
						if("[M.client.address]"=="[S["ip"]]")
							world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) [M] has been IP Banned by [S["who"]].</font>"
							del(M)
				if("ID")
					computer_bans[S["key"]]=S["id"]
					for(var/mob/M in world)
						if("[M.client.computer_id]"=="[S["id"]]")
							world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) [M] has been <b>computer banned</b>.</font>"
		if("Unban")
			switch(S["kind"])
				if("Key")
					Bans:Remove(S["key"])
					TimeBans:Remove(S["key"])
					world<<"<font color = red><b>(Server Info)</b></color>([world.realtime]) [S["key"]] has been unbanned.</font>"
				if("IP")
					for(var/IP in IPBans)
						if("[IP]"=="[S["ip"]]")
							world<<"<font color = red><b>(Server Info)</b></color>([world.realtime])The IP:\"[IP]\" has been Unbanned(IP)</font>."
							del(IP)
*/


