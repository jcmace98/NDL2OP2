var/list/ClanLock=list()

mob/owner/verb/ClanLockControl()
	set name="Clan Locks"
	set category="Staff"
	var/list/controlselection=list("Add Clan Lock","Remove Clan Lock","Cancel")
	var/obj/selection=input("")in controlselection
	switch(selection)
		if("Add Clan Lock")
			var/list/addracelockcontrol=list("Cancel")
			for(var/clanlockcheck in list("Basic","Akimichi","Nara","Hyuuga","Kusakin","Inuzuka","Aburame","Fuuma","Ketsueki","Hoshigaki","Shiroi","Kyomou","Iwazuka","Shojin","Kiro","Satou","Sabaku","Uchiha","Kaguya","Kumojin","Yotsuki"))
				if(!ClanLock.Find("[clanlockcheck]"))
					addclanlockcontrol.Add("[clanlockcheck]")
			var/obj/clanlockselection=input("")in addclanlockcontrol
			if(clanlockselection=="Cancel")
				return
			ClanLock.Add(clanlockselection)
		if("Remove Clan Lock")
			var/list/addracelockcontrol=list("Cancel")
			for(var/clanlockcheck in list("Basic","Akimichi","Nara","Hyuuga","Kusakin","Inuzuka","Aburame","Fuuma","Ketsueki","Hoshigaki","Shiroi","Kyomou","Iwazuka","Shojin","Kiro","Satou","Sabaku","Uchiha","Kaguya","Kumojin","Yotsuki"))
				if(ClanLock.Find("[clanlockcheck]"))
					addclanlockcontrol.Add("[clanlockcheck]")
			var/obj/clanlockselection=input("")in addclanlockcontrol
			if(clanlockselection=="Cancel")
				return
			ClanLock.Remove(clanlockselection)
		if("Cancel")
			return

	spawn(10)BootWorld("Load")

proc/BootWorld(var/blah)
	switch(blah)
		if("Load")
			BootFile("All","Load")


proc/BootFile(var/file,var/op)
	set background=1
	switch(file)
		if("ClanLock")
			if(op=="Load")
				if(fexists("Saves/ClanLock"))
					var/savefile/F=new("Saves/ClanLock")
					F["ClanLock"]>>ClanLock
			if(op=="Save")
				var/savefile/F=new("Saves/ClanLock")
				F["ClanLock"]<<RaceLock


	if(ClanLock.Find(usr.Clan))
			usr<<"This clan has been locked out by the admins."
			return