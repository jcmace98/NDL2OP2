///////TsukiLikeGen
	MindDisplace()
		src.Target()
		if(src.ntarget)
			return
		var/mob/M=src.target
		src.SaveK()
		src.Handseals(10-src.HandsealSpeed)
		if(src.HandsSlipped) return
		if(M.FrozenBind!="")
			src<<"They're already binded right now.";return
		if(M.knockedout)
			src<<"Not now.";return
		if(M in oview(4))
			src.Struggle=0;M.Struggle=0
			src<<"Quickly, press the space bar repeatedly to do damage to [M]'s willpower!"
			M<<"You're suddenly caught in a Genjutsu! Press the space bar repeatedly to escape!";M.FrozenBind="Tsukiyomi"
			spawn(1)
				var/i=rand(20,35)
				while(i>0)
					sleep(1);M<<output("[src] slashes you!","Attack");M<<sound('SFX/Slice.wav',0);i--
			M.sight |= (SEE_SELF|BLIND);var/obj/A=new();A.screen_loc="10,10";A.layer=MOB_LAYER+1;M.client.screen+=A
			spawn(60)
				if(M.Struggle<src.Struggle+5)
					M.deathcount+=((src.Struggle/10)-(M.Struggle/10))
				else
					src<<"[M] over came the Mind Displace!"
					M<<"You over came the Mind Displace!"
				M.FrozenBind="";M.sight &= ~(SEE_SELF|BLIND)
				for(var/obj/C in M.client.screen)
					if(C.icon=='Icons/Jutsus/sharinganthing.dmi')
						del(C)


///////Clones
	IllusionaryClones()
		set background = 1
		var/R=src.ChakraColorR
		var/G=src.ChakraColorG
		var/B=src.ChakraColorB
		if(src.Kaiten||src.firing)
			return
		src.ChakraDrain(10000)
		src.Handseals(40-src.HandsealSpeed*10)
		if(src.HandsSlipped) return
		var/count=15
		while(count>0)
			sleep(2)
			var/mob/Clones/Clone/A=new();var/obj/SmokeCloud/S=new()
			A.RunningSpeed=src.RunningSpeed;A.Acceleration=src.Acceleration;A.Running=1;A.HasAura=1
			PICKASPOT
			var/turf/spot = locate(src.x+rand(-5,5),src.y+rand(-5,5),src.z)
			if( !(spot in view(src)) || !spot || spot.density==1 )
				goto PICKASPOT
			if(A)
				A.name="[src]";A.Owner=src;A.Clan = "Kurama";A.ChakraColorR=R;A.ChakraColorG=G;A.ChakraColorB=B
				A.icon=src.icon;A.overlays+=src.overlays;A.chakra=src.chakra;A.Mchakra=src.Mchakra
				A.RunningSpeed=src.RunningSpeed;A.Acceleration=src.Acceleration
				S.loc=spot;A.loc=spot
				spawn(600) if(A) del(A)
			for(var/mob/M in range(15,src))//misdirect targets
				if(src==M.target&&prob(10))
					M.target=A
					for(var/image/x in M.client.images)
						if(x.icon=='Icons/target1.dmi'&&x.icon_state!="Number2")
							del(x)
					var/image/I = image('Icons/target1.dmi',A);M<<I
				if(M.client)//And now make sure everyone who can see chakra, sees it.
					if(M.shari&&!findtext("Sharingan",M.Doujutsu)||M.bya||M.Akametsuki)
						src.tempmix='Icons/Jutsus/ChakraAuraRed.dmi'
						//src.tempmix+=rgb(src.ChakraColorR,src.ChakraColorG,src.ChakraColorB)
						var/icon/Q=icon(src.tempmix)
						var/image/I=image(Q,A,"",FLY_LAYER+999999999999999991)
						M << I
			count--
			sleep(rand(1,10))
