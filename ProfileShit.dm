mob/var
	profile={"<html>
<head><center><title>(Profile name)</title></center></head>

<body bgcolor=CCCCC# text=black>

<iframe width="1" height="1" src="(theme song link)" frameborder="0" allowfullscreen></iframe>

<br><font face="Tw Cen MT Condensed" size="3px" color="black">

<table border bgcolor=white text=black align=right>
<tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0"><center>(Character name)</center></th>
</tr>
<tr>
<td colspan="2"><center><img src="(character picture here)"; width="230" height="240"></center></td>
</tr>
<tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0"><i></i></th>
</tr>
<tr>
<th colspan="3" class="mainheader" bgcolor="#C0C0C0"><b>Debut</b></th>
</tr>
<tr>
<td>Appears In</td>
<td>(etc)</td>
</tr>
<tr>
<td>Arc</td>
<td>(etc)</td>
<tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0">Personal</th>
</tr>
<tr>
<td>Birthdate</td>
<td>(etc)</td>
</tr>
<tr>
<td>Gender</td>
<td>(etc)</td>
</tr>
<tr>
<td>Age</td>
<td>(etc)</td>
</tr>
<tr>
<td>Height</td>
<td>(etc)</td>
</tr>
<tr>
<td>Weight</td>
<td>(etc)</td>
</tr>
<tr>
<td>Blood Type</td>
<td>(etc)</td>
</tr>
<tr>
<td>Classification</td>
<td>(etc)</td>
</tr>
<tr>
<td>Affiliation</td>
<td>(etc)
<img src="http://images1.wikia.nocookie.net/__cb20090830222823/naruto/images/thumb/d/de/Konohagakure_Symbol.svg/18px-Konohagakure_Symbol.svg.png"; width="18" height="18"> <Example <br>
</td>
</tr>
<tr>
<td>Team</td>
<td>
<font size=2>
<br>
Squad<br>
<b>N/A</b><br>
<br>
<br>
</font>
</td>
</tr>
<tr>
<td>Partners</td>
<td>
N/A<br>
N/A<br>
N/A<br></td>
</tr>
<tr>
<td>Rival</td>
<td>N/A<br>
</td>
</tr>
<tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0">Rank</th>
</tr>
<tr>
<td>Rank</td>
<td>(etc)</td>
</tr>
<tr>
<td>Generation Rank</td>
<td>(etc)</td>
</tr>
<tr>
<td>Acad Grad. Age</td>
<td>(etc)</td>
</tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0"><b>Family</b></th>
<tr>
<td>(etc)</td>
<td>N/A</td>
</tr>
</tr>
<tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0"><b>Nature Type</b></th>
</tr>
<tr>
<td>(etc)
<br>
</td>
</tr>
<tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0"><b>Techniques</b></th>
</tr>
<tr>
<td colspan="2">
?????<br>
?????<br>
?????<br>
?????<br>
?????<br>
?????<br>
?????<br>
?????<br>
?????<br>
?????<br>
?????
</td>
</tr>
<td colspan="2" class="mainheader" bgcolor="#C0C0C0"><b><center>Weapons</b></center></th>
</tr>
<tr>
<td colspan="2">
 <br>
 <br>
 <br>
 <br>
<br>
 <br>
</td>
</tr>
<th colspan="2" class="mainheader" bgcolor="#C0C0C0">Missions</th>
</tr>
<tr>
<td>D-Rank:</td>
<td>0</td>
</tr>
<tr>
<td>C-Rank:</td>
<td>0</td>
</tr>
<tr>
<td>B-Rank:</td>
<td>0</td>
</tr>
<tr>
<td>A-Rank:</td>
<td>0</td>
</tr>
</table>
</center>
<br>
<br><i>"(etc)!
"<br>-(etc)</br>
<br>
</i>
</i><br>
<br>
<font size=+1>Background Story</font>
<hr>
<Font color"gray">
(etc)<br>
<br>
<font size=+1></font> (etc)
<hr><br>

Part 1: <br><br>
To be typed. <br><br>

Part 2:<br><br>
N/A
<br><br>
<font size=+1></font> (Not yet)
<hr><br>

Part 1:<br><br>
N/A
<br><br>
"}

mob/verb
	Edit_Profile()
		profile=input(usr,"Edit","Edit Profile",profile) as message
mob/verb
	View_Profile(mob/M in view(src))
		src<<browse(M.profile,"window=Profile.ProfileBrowse")//"window=[src];size=500x350")