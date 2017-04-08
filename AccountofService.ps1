# get name of service
gcim Win32_service | Select-Object StartName, Name
# now enter name in between the quotes below
gcim Win32_service | Select-Object StartName, Name | Where-Object {$_.Name -eq "enter name here"}