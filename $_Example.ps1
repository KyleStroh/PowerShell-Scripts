Get-Service | Where-Object { $_.name -eq "bits" }

$service = Get-Service
$service | Where-Object {$_.DisplayName -like "*oo*"}

foreach($s in $service)
{
    if ($s.DisplayName -like "*oo*")
    {
        Write-Output $($s.Name)
    }
}