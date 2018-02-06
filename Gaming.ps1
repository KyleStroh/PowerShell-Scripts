#$browser = "chrome.exe"
#Start-Process -FilePath $browser
$Steam = "C:\Program Files (x86)\Steam\Steam.exe"
Start-Process -FilePath $Steam
$Discord = "C:\Users\USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk"
Start-Process -FilePath $Discord -WindowStyle Minimized
#$Burner = "C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"
#Start-Process -FilePath $Burner
