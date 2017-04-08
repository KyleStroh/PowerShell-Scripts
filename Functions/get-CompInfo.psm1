<#
 .NOTES
    Works on 8 and 10 but ouput is currently formatted for server 2012 R2, produced in a vm enviroment.
 #>
function get-ComputerInfo
{
    Param(
        [parameter(Mandatory=$true)]
        [string]$ComputerName = "local host",
        [string]$Drive='C:'
        )
    $MyIpInfo = Get-NetIPConfiguration
    $myAdapterInfo = Get-NetAdapter | Select-Object name, MacAddress 
    $osinfo = gcim Win32_OperatingSystem | Select-Object Caption, OSArchitecture
    $driveinfo = gcim Win32_LogicalDisk -Filter "deviceID='$Drive'"

$driveinfo
$osinfo
$myAdapterInfo
$MyIpInfo
}