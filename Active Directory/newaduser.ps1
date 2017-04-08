$newusers = Import-Csv -Delimiter "," -Path E:\myscripts\newusers.txt
foreach ($line in $newusers)
{
$firstname = $line.FirstName
$lastname = $line.LastName
$displayname = $line.FirstName+ " " + $line.LastName
$Sam = $line.SamAccountName
$ou = $line.OU
$upn = $Sam + "@entername.entername"
New-ADUser -Name $displayname -GivenName $firstname -Surname $lastname -DisplayName $displayname `
-SamAccountName $sam -Path "OU=$OU,DC=entername,DC=entername" -UserPrincipalName $upn
}
