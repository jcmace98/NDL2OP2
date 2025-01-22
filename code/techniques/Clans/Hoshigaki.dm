/*Hoshigaki not needed 2.0
mob/Hoshigaki/verb/CreateSameHade()
	var/CreatingSword=0
	if(CreatingSword)
		return
	CreatingSword=1
	usr<<"You begin to create the sword."
	sleep(100);CreatingSword=0
	usr.stamina-=2500
	var/obj/WEAPONS/Samehade/A=new();A.loc=usr
*/
mob/proc/SamehadeReturn()
	for(var/obj/WEAPONS/Samehade/A in src.contents)
		if(A.Equipped)
			src<<"It's already equipped!";return
		else
			if(prob(50))
				src<<"You return the Samehade to your hand!"
				A.Equipped=1
				src.WeaponInLeftHand="Samehade"
				src.WeaponInRightHand="Samehade"

mob/proc/ReleaseShark(Control=0,Speed=0)
	if(Control)
		if(src.knockedout)
			return
		src<<"You begin to form into a shark!"
		if(!Speed)
			src.icon_state="Power"
			var/X=rand(5,10)
			while(X>0)
				src.chakra+=25
				if(src.icon_state!="Power")
					src<<"You have become a shark!";X=0
				X--
				sleep(11)
			src.icon_state=""
		src.icon='Icons/Jutsus/SharkMode.dmi'
		src.BijuuMastery+=rand(0,1)
		src<<"Your shark powers are much stronger then ever!"
		spawn(20)
			src<<"You feel your wounds heal and your stamina regenerate!"
			if(src.stamina<=src.maxstamina)
				src.stamina+=src.maxstamina*0.50
			if(src.health<=src.maxhealth)
				src.health+=src.maxhealth*0.20
		src.TailState=0.5
		var/WearOffTime=160
		if(Speed)
			WearOffTime+=60
		src.tai=src.Mtai*0.8;src.nin=src.Mnin*2;src.gen=src.Mgen*1.3
		while(src.TailState==0.5&&WearOffTime>0)
			src.tai=src.Mtai*0.8;src.nin=src.Mnin*2;src.gen=src.Mgen*1.3
			src.chakra+=25
			WearOffTime--
			sleep(11)
		src.tai=src.Mtai;src.nin=src.Mnin;src.gen=src.Mgen
		src.TailState=0
		var/icon/X='Icons/New Base/Base.dmi'
		src.deathcount+=2
		X+=rgb(usr.BaseR,usr.BaseG,usr.BaseB)
		src.icon=null
		src.icon=X