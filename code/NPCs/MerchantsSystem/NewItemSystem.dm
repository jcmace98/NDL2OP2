obj/RandomEquipment
	icon='Icons/Hud/wskillcards.dmi'
	var
		Ammount=1
		OriginalName
	New()
		src.ReCheckAmount()
		..()
	proc
		ReCheckAmount()
			if(src.Ammount<=0)
		//		usr.UpdateInv()//just added 6/19/2013
				del(src)
			else
				src.name="[src.OriginalName]([src.Ammount])"
		//		if(usr.client)
		//			usr.UpdateInv()//Just added 6/19/2013
	Wire
		icon_state="Wire"
		OriginalName="Wire"
		PlacementWeight=5
		var/tmp/Delay=0
		verb/SetWire()
			set name="Set Wire"
			if(src.Delay)
				usr<<"Wait for the delay.";return
			if(usr.FrozenBind=="Shibari")
				return
			if(usr.Frozen||usr.Status=="Asleep"||usr.UsingBow||usr.Kumosenkyuu||usr.Guarding||usr.Stun>0||usr.knockedout||usr.SoundSpinningKick||usr.icon_state=="handseal"||usr.icon_state=="Power"||usr.alreadytalkingtohim)
				return
			for(var/mob/M in OnlinePlayers)
				if(M.key=="")
					M<<"[usr] is using a Wire."
			src.Ammount-=1
			var/obj/NinjaEquipment/TheWires/A=new();A.loc=locate(usr.x,usr.y,usr.z);A.dir=usr.dir;walk(A,usr.dir);A.Owner=usr
			if(usr.layer<4) A.layer=usr.layer
			src.ReCheckAmount()
			src.Delay=1
			spawn(180)
				src.Delay=0

		verb/Get()
			set src in oview(1)
			if(src.Ammount==1)
				usr<<"You picked up a [src]"
			else
				usr<<"You picked up some [src]."
			var/counter=0
			for(var/obj/RandomEquipment/Wire/O in usr.contents)
				counter+=1
			if(counter<=0)
				Move(usr)
			else
				for(var/obj/RandomEquipment/Wire/O in usr.contents)
					O.Ammount+=src.Ammount
					if(O.Ammount>=40)
						O.Ammount=40
					O.ReCheckAmount()
					del(src)

	Poison
		icon_state="Poison"
		OriginalName="Poison"
		PlacementWeight=25
		verb
			Get()
				set src in oview(1)
				src.loc = usr
				usr<<"You picked up [src]"
			Drop()
				src.loc=locate(usr.x,usr.y-1,usr.z)
			PlacePoison()
				set src in usr
				usr.Frozen=1
				usr<<"You begin to place poison onto your close range weapons. Stand still to apply it properly."
				if(usr.PoisonOn)
					usr<<"You're already using a poison."
					return
				if(usr.UsingPoison)
					usr<<"You've already attached poison onto your weapons."
					return
				if(usr.knockedout)
					usr<<"You weren't able to place the poison on your weapons.."
					del(src)
				spawn(50/(usr.PoisonExpert+1))
					usr.Frozen=0
					usr<<"You have placed poison onto your weapons. Hit the opponent with your weapon to poison them. You have 30 seconds until the poison wears off."
					usr.PoisonOn=1
					if(prob(15))
						usr.PoisonKnowledge++
					del(src)
	Paper
		icon_state="Paper"
		OriginalName="Paper"
		PlacementWeight=2
		var
			Message=""
		Click()
			if(src.Message!="")
				usr<<"[src.Message]"
				return
			var/HaveInk=0
			for(var/obj/RandomEquipment/Ink/A in usr.contents)
				HaveInk=1
			if(!HaveInk)
				usr<<"You need to have Ink to write something on the paper."
			else
				usr<<"What do you want to write?"
				src.Message=input("Write down the message on the Paper.","Paper",src.Message)
				for(var/obj/RandomEquipment/Ink/A in usr.contents)
					A.Ammount--;A.ReCheckAmount()
		verb
			Get()
				set src in oview(1)
				if(src.Ammount==1)
					usr<<"You picked up a [src]"
				else
					usr<<"You picked up some [src]."
				var/counter=0
				for(var/obj/RandomEquipment/Paper/O in usr.contents)
					counter+=1
				if(counter<=0)
					Move(usr)
				else
					for(var/obj/RandomEquipment/Paper/O in usr.contents)
						O.Ammount+=src.Ammount
						O.ReCheckAmount()
						del(src)
			Drop()
				var/drop = input(usr,"How many pieces do you wish to drop?")as num
				if(drop>src.Ammount)
					usr<<"You don't have that many to drop.";return
				if(drop <= 0)
					usr<<"You can not do that";return
				if(src.Ammount==drop)
					src.loc=locate(src.x,src.y-1,src.z)
					usr.SaveK()
				else
					src.Ammount-=drop
					var/obj/RandomEquipment/Paper/P=new()
					P.Ammount=drop;P.loc=locate(src.x,src.y-1,src.z);P.Message=src.Message
					usr.SaveK()

	Ink
		icon_state="Ink"
		OriginalName="Ink"
		verb
			Get()
				set src in oview(1)
				if(src.Ammount==1)
					usr<<"You picked up a [src]"
				else
					usr<<"You picked up some [src]."
				var/counter=0
				for(var/obj/RandomEquipment/Ink/O in usr.contents)
					counter+=1
				if(counter<=0)
					Move(usr)
				else
					for(var/obj/RandomEquipment/Ink/O in usr.contents)
						O.Ammount+=src.Ammount
						O.ReCheckAmount()
						del(src)
	Clay
		icon_state="Clay"
		OriginalName="Clay"
		PlacementWeight=1
		verb
			Get()
				set src in oview(1)
				if(src.Ammount==1)
					usr<<"You picked up a [src]"
				else
					usr<<"You picked up some [src]."
				var/counter=0
				for(var/obj/RandomEquipment/Clay/O in usr.contents)
					counter+=1
				if(counter<=0)
					Move(usr)
				else
					for(var/obj/RandomEquipment/Clay/O in usr.contents)
						O.Ammount+=src.Ammount
						O.ReCheckAmount()
						del(src)
	WolfMane
		OriginalName="Wolf's Mane"
		icon_state="WolfMane"
		verb
			Get()
				set src in oview(1)
				if(usr.CurrentMission!="Find Wolf Mane")
					usr<<"This looks kinda heavy. No reason to bring it back.";return
				usr<<"You picked up some [src]."
				usr.MissionComplete()
				del(src)
	DNA
		OriginalName="DNA"
		icon_state="WolfMane"
		verb
			Get()
				set src in oview(1)
				if(usr.CurrentMission!="Find Wolf Mane")
					usr<<"This looks kinda heavy. No reason to bring it back.";return
				usr<<"You picked up some [src]."
				usr.MissionComplete()
				del(src)
	DarkWolfMane
		OriginalName="Wolf's Mane"
		icon_state="DWolfMane"
		verb
			Get()
				set src in oview(1)
				if(usr.CurrentMission!="Find Dark Wolf Mane")
					usr<<"This looks kinda heavy. No reason to bring it back.";return
				usr<<"You picked up some [src]."
				usr.MissionComplete()
				del(src)



mob/proc/Poisoned()
	if(src.knockedout)
		src<<"The sharp pains leave your body..."
		return
	if(src.Poisoned)
		return
	else
		src.Poisoned=1
		spawn(20)
			src<<"You begin to feel sharp pains in your body...."
			var/Damage=rand(50,75)
			var/Damage2=rand(10,20)
			var/time=1
			var/time2=1
			while(time<10)
				src.stamina-=Damage
				src.health-=Damage2
				time+=1
				sleep(rand(30,50))
				if(time>=10)
					src.health-=Damage
					time2+=1
					sleep(rand(10,30))
					if(time2>=5)
						src.Poisoned=0
						src<<"The poison wears off..."
		//For Antidotes make a new Variable called "Used Antidotes"
		//add at the beginning of this proc
		//if(src.UsedAntidote)
			//blahblah

mob/verb/Aim()
	if(usr.SenbonAim=="Feet")
		usr.SenbonAim="Body"
		//view(M)<<output("Senbons set to aim at feet","output")
		usr<<"Senbons set to aim at feet"
	else if(usr.SenbonAim=="Body")
		usr.SenbonAim="Hands"
		//view(M)<<output("Senbons set to aim at hands","output")
		usr<<"Senbons set to aim at hands"
	else if(usr.SenbonAim=="Hands")
		usr.SenbonAim="Feet"
		//view(M)<<output("Senbons set to aim at body","output")
		usr<<"Senbons set to aim at body"
	else
		usr.SenbonAim="Hands"
		//view(M)<<output("Senbons set to aim at hands","output")
		usr<<"Senbons set to aim at hands"

mob/verb/ServerPerformance()
	set name="Auto Server Message"
	if(!usr.ServerMessage)
		usr<<"You will no longer see the automated server performance message."
		usr.ServerMessage=1
	else
		usr<<"You will now see the automated server performance message."
		usr.ServerMessage=0





