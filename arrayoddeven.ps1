$x=read-host "what number to start with"
$y=read-host "what number to end with"
$ary=$x..$y
foreach($x in $ary)
{if($x%2 -eq 0)
{
    write-host "your number $x is even"
}
else{ write-host "your number $x is odd"}
}

#This script doesn't have a true use, I commonly used it when testing my powershell dashobards responsivenesss.