/*
Mitchell Quinn
Ninja Cash System

The idea for this system is basically to have a system that allows for editing people in a fair and balance way.


Everyone will have the oppertunity to get these upgrades it will basically be an npc who sells them.
*/

mob/var/BattlePoints = 0
mob/var/CharacterCooldown = 0


obj/BattlePoints
	ExpScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Exp Scroll(25k)"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				if(usr.JutsuDelay<0)
					usr.JutsuEXPCost+=(25000)
					usr<<"Your gained EXP towards learning your jutsu! You're filled with knowledge!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return


	CooldownScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Cooldown Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)

		proc
			Utilize(mob/M)
				M=usr
				if(usr.JutsuDelay>0)
					usr.JutsuDelay-=(50000)
					usr<<"Your Jutsu Learning CoolDown was reduced! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CurryofLife
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Curry of Life"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				if(usr.calories>100000)
					usr.calories+=100000
					usr<<"Your calories have increased! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					del(src)
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	EPBoost1Scroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="EP Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				if(locate(/obj/BattlePoints/EPBoost1Scroll) in usr.contents)
					usr.ElementalPoints+=25
					usr<<"Your Elemental Points have increased! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	EPBoost2Scroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="EP Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				if(locate(/obj/BattlePoints/EPBoost2Scroll) in usr.contents)
					usr.ElementalPoints+=50
					usr<<"Your Elemental Points have increased! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	SPBoostScroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="EP Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				if(locate(/obj/BattlePoints/SPBoostScroll) in usr.contents)
					usr.StartingPoints+=25
					usr<<"Your Starting Points have increased! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return
	SPBoost2Scroll
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="SP Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				if(locate(/obj/BattlePoints/SPBoost2Scroll) in usr.contents)
					usr.StartingPoints+=50
					usr<<"Your Starting Points have increased! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	Chakra10000
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Instant Chakra 10k"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				if(locate(/obj/BattlePoints/Chakra10000) in usr.contents)
					usr.Mchakra=10000
					usr<<"Your Chakra has increased! You feel energetic!!"
					usr.SaveK()
					del(src)
				else
					usr<<"Best to save this scroll for another time.."
					return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	SageModeApeJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Sage Mode Ape Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.JutsuInLearning="SageModeApe"
				usr<<"You have learned SAGE MODE! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	SageModeSlugJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Sage Mode Slug Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.JutsuInLearning="SageModeSlug"
				usr<<"You have learned SAGE MODE! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	SageModeLionJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="Sage Mode Lion Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.JutsuInLearning="SageModeLion"
				usr<<"You have learned SAGE MODE! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSHJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Heaven Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Heaven"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Heaven! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSEJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Earth Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Earth"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Earth! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSFJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Fire Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Fire"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Fire! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSWJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Water Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Water"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Water! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSTJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Thunder Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Thunder"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Thunder! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSAJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Air Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Air"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Air! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSHJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Heaven Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Heaven"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Heaven! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSEJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Earth Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Earth"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Earth! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSFJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Fire Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Fire"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Fire! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSWJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Water Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Water"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Water! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				return

	CSTJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Thunder Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Thunder"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Thunder! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				del(src)
				return

	CSAJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Air Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Air"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Air! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSHellJutsuBuy
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Hell Scroll"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Hell"
				usr.CursedSealPool=30000
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Hell! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return

	CSHellJutsuBuy2
		icon='scrolls.dmi'
		icon_state="gay scroll"

		name="CS Hell Scroll 2"
		/*Click()
			if(src in usr.contents)
				src.Utilize(usr)
			else
				usr<<"You need to pick the scroll up first!"
				return*/
		verb
			Get()
				set src in oview(1)
				usr<<"You Pick Up The Scroll."
				src.Move(usr)

			Use()
				src.Utilize(usr)
			Drop()
				src.Dropping(usr)


		proc
			Utilize(mob/M)
				M=usr
				usr.CursedSealType="Hell"
				usr.CursedSealPool=50001
				usr.JutsuInLearning="CursedSealActivation"
				usr<<"You have learned CS Hell! You feel energetic!!"
				usr.SaveK()
				del(src)
				return
			Dropping(mob/M)
				src.loc=locate(usr.x,usr.y-1,usr.z)
				view(usr)<<"[usr] drops [src]."
				usr.SaveK()
				del(src)
				return