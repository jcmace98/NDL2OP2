mob/proc
	AwardMedal(medal)
		var/hasmedalSharinganGain=world.GetMedal(medal,src)
		if(!hasmedalSharinganGain)
			world.SetMedal(medal,src)
			src<<"<font size=3><font color=yellow>You've attained the [medal] Medal!"