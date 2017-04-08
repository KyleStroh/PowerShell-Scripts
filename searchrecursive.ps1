#asks for user entry or you can modify below
$file = Read-Host "what file would you like to search for"
$searchstr = $file + ".*"
Get-ChildItem -Path e:\, c:\ -Filter $searchstr -Recurse -ErrorAction SilentlyContinue


# or you can use
#Get-ChildItem -Recurse | Where-Object {$_.Extension -eq ".exe"}
