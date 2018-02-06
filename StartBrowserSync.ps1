# I have it list all of the folders in my GitHub directory because that is where most of my projects sit
Get-ChildItem 'C:\Users\USERNAME\Documents\GitHub' -dir | Sort-Object | Format-Table name
#uses user input to select what folder
$folder = Read-Host 'input folder name' 
#enters the folder
cd "C:\Users\USERNAME\Documents\GitHub\$folder"
# reads what folders, example structure: html files then css and js in subfolders
$files = ((gci -dir -name) | foreach {"$($_)/*.$($_)"}) -join ", "
#opens browser sync gui, using default urls
start chrome.exe http://localhost:3001
#starts browser sync and monitors files based off of folders that are in main directory, by default will open index.html in default browser
browser-sync start --server --files "*.html, $files"
