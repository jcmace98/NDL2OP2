//Village Messeging System
//Mitchell Quinn
// 10/15/2011


/*
Need to make it visable inside the Stat()
Need to add 4variables that display the message x
Need to add a command for kages to set the verb x

*/



var/global.leafVillageMessage
var/global.rainVillageMessage
var/global.soundVillageMessage
var/global.rockVillageMessage



mob/Kage/verb/KageMessage()
	set name = "Set a Village Message"
	set category = "Kage"

	if(usr.Village == "Leaf")
		switch(input(src, "Would you like to set a village message?") in list ("Yes" , "No"))
			if("Yes")
				leafVillageMessage = input("Please enter a message.")
				return
			if("No")
				src<<"Your village Message will remain the same."
				return
	if(usr.Village == "Rain")
		switch(input(src, "Would you like to set a village message?") in list ("Yes" , "No"))
			if("Yes")
				rainVillageMessage = input("Please enter a message.")
				return
			if("No")
				src<<"Your village Message will remain the same."
				return
	if(usr.Village == "Sound")
		switch(input(src, "Would you like to set a village message?") in list ("Yes" , "No"))
			if("Yes")
				soundVillageMessage = input("Please enter a message.")
				return
			if("No")
				src<<"Your village Message will remain the same."
				return
	if(usr.Village == "Rock")
		switch(input(src, "Would you like to set a village message?") in list ("Yes" , "No"))
			if("Yes")
				rockVillageMessage = input("Please enter a message.")
				return
			if("No")
				src<<"Your village Message will remain the same."
				return