$browser = "chrome.exe"
Start-Process -FilePath $browser
$Steam = "C:\Program Files (x86)\Steam\Steam.exe"
Start-Process -FilePath $Steam
$Discord = "C:\Users\USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
#used location above so different updates/ versions aren't affected
Start-Process -FilePath $Discord
