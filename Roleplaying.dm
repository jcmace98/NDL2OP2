obj/RPFlag
	icon = 'RPFlag.dmi'
	var
		descr = ""
		owntBy = null
	Click()
		usr<<"[descr]."
	DblClick()
		if(usr == src.owntBy)
			del src

mob/verb/Set_RP_Flag()
	for(var/obj/RPFlag/B in world)
		if(B.owntBy == usr)
			usr<<"You can't have more than one RP flags out. Delete the other one first."
			return
	var/text = input("What will the flag say?")as message
	var/obj/RPFlag/A = new
	A.loc = usr.loc
	A.descr = text
	A.owntBy = usr
	usr<<"Double Click to Remove."