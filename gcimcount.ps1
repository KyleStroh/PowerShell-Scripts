$servicelist = gcim -ClassName Win32_Service

$count =0
Write-Host "this is set to auto start"
foreach ($i in $servicelist)
{
    if ($i.StartMode -eq "Auto")
    {
     write-host  $i.DisplayName
    $count = $count+1
    }
}
"`n"
Write-Host "number of auto commands: $count"  

"`n"

$count = 0
$servicelist = gcim -ClassName Win32_Service

Write-Host "this is set to manual start"
foreach ($i in $servicelist)
{
    if ($i.StartMode -eq "Manual")
    {
    write-host  $i.DisplayName
    $count = $count+1
    }
}
"`n"
Write-Host "number of manual commands: $count"


