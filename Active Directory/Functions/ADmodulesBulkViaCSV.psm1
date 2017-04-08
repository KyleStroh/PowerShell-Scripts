<#
.Synopsis
   Adds new users via a csv file
.EXAMPLE
   Add-NewAdUserViaCSV -Path e:\myscripts\file.csv
.INPUTS
   must use .csv file for input
.NOTES
   CSV structure is firstname, lastname, OU
.FUNCTIONALITY
   Adds new users via a csv file
#>
function Add-UserToOUviaCSV
{
Param(
    [parameter(Mandatory=$true)]
    [string]$Path
    )
$newusers = Import-Csv -Delimiter "," -Path "$Path"
foreach ($line in $newusers)
{
$firstname = $line.FirstName
$lastname = $line.LastName
$displayname = $line.FirstName+ " " + $line.LastName
$Sam = $line.FirstName[0] + $line.LastName
$sam = $sam.tolower()
$ou = $line.OU
$Password = 'fillinwithpassword'
$upn = $Sam + "@entername.local"
New-ADUser -Name $displayname -GivenName $firstname -Surname $lastname -DisplayName `
 $displayname -SamAccountName $sam -Path "OU=$OU,DC=entername,DC=local" -Enabled $true `
  -UserPrincipalName $upn -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $true
}
}

<#
.Synopsis
   Adds new OU's via a Csv file
.EXAMPLE
   Add-NewOUBulkCSV -Path e:\myscripts\file.csv
.INPUTS
   must use .csv file for input
.NOTES
   CSV structure is ouname
.FUNCTIONALITY
   Adds new Organizational units via a csv file
#>
function Create-OUviaCSV
{
Param(
    [parameter(Mandatory=$true)]
    [string]$Path
    )
$newous = Import-Csv -Delimiter "," -Path "$Path"
foreach ($line in $newous)
{
$ounames = $line.ouname

New-ADOrganizationalUnit -name $ounames -Path "DC=entername,DC=local" -PassThru `
 -ProtectedFromAccidentalDeletion $false
 }
 }

<#
.Synopsis
   Adds new Groups via a Csv file
.EXAMPLE
   Add-NewGroupBulkCSV -Path e:\myscripts\file.csv
.INPUTS
   must use .csv file for input
.NOTES
   CSV structure is grpname, ou
.FUNCTIONALITY
   Adds new AD Groups units via a csv file
#>

function Add-NewGroupBulkCSV
{
Param(
    [parameter(Mandatory=$true)]
    [string]$Path
    )
$newgroups = Import-Csv -Delimiter "," -Path "$Path"
foreach ($line in $newgroups)
{
$groupname = $line.grpname
$ous = $line.ou

New-ADGroup -name $groupname -Path "OU=$ous,DC=entername,DC=local" -GroupCategory Security -GroupScope Global 
 }
 }

function Add-ADMembersToGrp
{
Param(
    [parameter(Mandatory=$true)]
    [string]$Path
    )

$newgroups = Import-Csv -Delimiter "," -Path "$Path"
foreach ($line in $newgroups)
{
$groupname = $line.grpname
$ous = $line.ou
Get-ADUser -SearchBase "OU=$ous,DC=entername,DC=local" -Filter * | ForEach-Object {Add-ADGroupMember "$groupname" -Members $_}
}
}