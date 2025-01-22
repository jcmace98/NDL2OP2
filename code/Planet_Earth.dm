var/TimeBetweenShift=18000//18000//Default 30 minutes


proc
	SaveDay()
		var/savefile/F = new("World Save Files/Time.sav")

		F["Season"]<<Season
		F["Month"]<<Month
		F["Date"]<<Date
		F["Year"]<<Year
		F["TimeOfDay"]<<TimeOfDay

	LoadDay()
		var/savefile/F = new("World Save Files/Time.sav")
		if(F)
			F["Season"]>>Season
			F["Month"]>>Month
			F["Date"]>>Date
			F["Year"]>>Year
			F["TimeOfDay"]>>TimeOfDay
/*
The Planet Earth Engine works by giving the game itself a calender of time.
The Calender is a simple one but I guess it can effected in your own way,
But it allows the game to have Seasons.

It starts off at Year 3000. You can set it at any Year pending on the storyline
if you're still doing that.
This should all be savable.
*/

var
	Season="Winter"

	Month=10
	Date=1
	Year=3000

	TimeOfDay="Morning"

/*There's 5 Phases. Morning, Day, Afternoon, Evening and Night. Repeat.
After all Phases are done, the Day is increased. So everytime it becomes
Morning.

Did not include leap years and all the complicated Calender specifics...
Just made everything equal. Ex. 3 Months in a Season.*/

proc
	ChangeTimeOfDay()
		if(TimeOfDay=="Evening")
			TimeOfDay="Night"
		else if(TimeOfDay=="Night")
			TimeOfDay="Morning"
			Adjust_Date()
		else if(TimeOfDay=="Morning")
			TimeOfDay="Day"
		else if(TimeOfDay=="Day")
			TimeOfDay="Afternoon"
		else if(TimeOfDay=="Afternoon")
			TimeOfDay="Evening"
		SaveDay()
		spawn(TimeBetweenShift)
			ChangeTimeOfDay()
proc
	Adjust_Date()
		Date+=1
		if(Month==2&&Date>28)
			Month+=1
			Date=1
		if(Month==4&&Date>30||Month==6&&Date>30||Month==9&&Date>30||Month==11&&Date>30)
			Month+=1
			Date=1
		else
			if(Date>31)
				Month+=1
				Date=1

		if(Month>12)
			Year+=1
			Month=1
			Date=1
			Season="Spring"

		if(Month>3)
			Season="Summer"

		if(Month>6)
			Season="Fall"

		if(Month>9)
			Season="Winter"
/*WeatherStart
proc
	TimeofDay()
		for(var/obj/ScreenStuff/TimeOfDay/A in src.client.screen)
			del(A)
		if(src.z>2&&src.z<40)
			if(TimeOfDay=="Morning")
				src.client.screen+=new/obj/ScreenStuff/TimeOfDay/Morning
			if(TimeOfDay=="Afternoon")
				src.client.screen+=new/obj/ScreenStuff/TimeOfDay/Afternoon
			if(TimeOfDay=="Evening")
				src.client.screen+=new/obj/ScreenStuff/TimeOfDay/Evening
			if(TimeOfDay=="Night")
				src.client.screen+=new/obj/ScreenStuff/TimeOfDay/Night*/
obj/ScreenStuff
	TimeOfDay
		icon='Icons/HUD/Weather.dmi'
		screen_loc="1,1 to 19,19"
		layer=MOB_LAYER+10
		Morning
			icon_state="Morning"
		Afternoon
			icon_state="Afternoon"
		Evening
			icon_state="Night"
		Night
			icon_state="DarkNight"

///////////////////////////////////////////
/*
var
	Year=2000
	Year_Speed=1
	Day=1
	Day_Speed=1
	Time="Day"
	TimeSystem="DayNight"
proc/DayNight()
	while(1)
		sleep(144000/Day_Speed) //144000
		spawn()CallDayShit()

proc/CallDayShit()
	set background=1
	if(Time=="Day")
		Time="Night"
		world<<"<font color=#FFFF00> <B> The sun starts to set, slowly darkening the area. It is now nighttime."
		world<<"<font color=yellow>Earth's pale moon rises..."
		for(var/area/Outside/A in world)
			if(A.WeatherOn==1&&A.WeatherOdds>0)
				A.icon='Sunset.dmi'
				spawn(1100) A.icon='Dark.dmi'
	else if(Time=="Night")
		Time="Day"
		Day++
//		SetNewTierSCap()
		world<<"<font color=#FFFF00>The sun begins to rise, bringing on a new day."
		for(var/area/Outside/Planet/A in world)
			if(A.WeatherOn==1&&A.WeatherOdds>0)
				A.icon='Sunrise.dmi'
				spawn(1100)
					A.icon=null

				if(global.MoonsActive==1)
					if(EarthsMoon==1&&prob(5))
						for(var/mob/Players/P)
							if(initial(P.Tail)&&P.Age<16&&P.z==1)
								P.Tail(1)
							for(var/obj/Oozaru/O in P)
								if(O.Looking&&P.z==1&&!istype(P.loc,/area/Inside))
									P.Oozaru(1)
							if(P.Race=="Nobody")
								P.LunarRage=1
						world<<"<font color=yellow>Earth's moon has blocked out the Sun!"
						spawn(1200)
							A.icon='SuperDarkness.dmi'
					if(VegetasMoon==1&&prob(5))
						for(var/mob/Players/P)
							if(initial(P.Tail)&&P.Age<16&&P.z==3)
								P.Tail(1)
							for(var/obj/Oozaru/O in P)
								if(O.Looking&&P.z==3)
									P.Oozaru(1)
							if(P.Race=="Nobody")
								P.LunarRage=1
						world<<"<font color=yellow>Vegeta's large moon has blocked out the Sun!"
						spawn(1200)
							A.icon='SuperDarkness.dmi'
					if(ArconiasMoons>0&&prob(5*ArconiasMoons))
						for(var/mob/Players/P)
							if(initial(P.Tail)&&P.Age<16&&P.z==5)
								P.Tail(1)
							for(var/obj/Oozaru/O in P)
								if(O.Looking&&P.z==5)
									P.Oozaru(1)
							if(P.Race=="Nobody")
								P.LunarRage=1
						world<<"<font color=yellow>One of Arconia's moons has blocked out the Sun!"
						spawn(1200)
							A.icon='SuperDarkness.dmi'
					if(SanctuarysMoon==1&&prob(5))
						for(var/mob/Players/P)
							if(initial(P.Tail)&&P.Age<16&&P.z==18)
								P.Tail(1)
							for(var/obj/Oozaru/O in P)
								if(O.Looking&&P.z==18)
									P.Oozaru(1)
							if(P.Race=="Nobody")
								P.LunarRage=1
						world<<"<font color=yellow>Sanctuary's green moon blocks out the sun, bathing the planet in dull green light!"
						spawn(1200)
							A.icon='GreenDay.dmi'
proc/DayTimeCheck()
	if(Time=="Day")
		for(var/area/Outside/Planet/A in world)
			if(A.WeatherOn==1&&A.WeatherOdds>0)
				A.icon=null
	else if(Time=="Night")
		for(var/area/Outside/Planet/A in world)
			if(A.WeatherOn==1&&A.WeatherOdds>0)
				A.icon='Dark.dmi'

proc/Years()
	//set background=1
	while(1)
		sleep(36000/Year_Speed)
		spawn Add_Planet_Money()
		Log("Admin","<font color=#FFFF00>Planetary resources have regenerated.")
		Year+=0.1
		var/Month=round(Year-round(Year),0.1)
		for(var/mob/Players/P)
			P.Age_Increase(0.1)
		//Log("Admin","<font color=#FFFF00>It is now month [Month*10] of year [round(Year)]")
		world<<"<font color=#FFFF00>It is now month [Month*10] of year [round(Year)]"
		for(var/mob/Players/P)
			P.MakyoBPUp()
			P.Age_Increase(0.1)
/*			if(prob(20))
				world<<"<small><font color=yellow>The moon comes out..."
				for(var/mob/Players/P)
					if(initial(P.Tail)&&P.Age<16)
						P.Tail(1)
					for(var/obj/Oozaru/O in P)
						if(O.Looking&&P.z!=2)
							P.Oozaru(1)
			if(Year>1)
				if(Year%10==0&&global.StarActive==1)
					MakyoStar=1
					if((Year*10)%100==0)
						world<<"<small><font color=red>The Makyo Star approaches..."
						StarsActivated++
				else
					MakyoStar=0*/
mob/proc/Age_Increase(YearInput)
	if(Dead)
		if(Age<20)
			Age+=YearInput
	if(!Dead) Age+=YearInput
	Log_Year=Year
	//if(Year>=Birth_Year+20) AngerMax=150
	if(Age>(Decline*2))
		if(prob(30))Death(null,"old age")

mob/proc/Age_Update()
	if(Dead&&Age<20)
		Age+=Year-Log_Year
		if(Age>20)
			Age=20
	if(!Dead) Age+=Year-Log_Year
	Log_Year=Year*/


