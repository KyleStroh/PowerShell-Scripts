
SL E:\myscripts\dashboard
For(;;){ 
            #zeroed out variables
$main = $Null 
$index = 0 
$head = $Null
$tail = $Null
$style = $Null
$ram =0
$cpu = 0
$ipv4add = 0

$head = (Get-Content .\head.html) -replace '%4',(get-date).DateTime
$tail = Get-Content .\tail.html


$servers =@( 'name', 'name', 'name')
foreach( $i in $servers)
{
 If (Test-Connection -BufferSize 32 -Count 1 -ComputerName $i -ErrorAction SilentlyContinue -Quiet) {
    $Status = "Online"
    $name = gcim Win32_OperatingSystem -ComputerName $i -ErrorAction SilentlyContinue | foreach {$_.CSName} 
    $bit = gcim Win32_OperatingSystem -ComputerName $i -ErrorAction SilentlyContinue | foreach  {$_.OSArchitecture} 
    $arch = gcim Win32_OperatingSystem -ComputerName $i -ErrorAction SilentlyContinue | foreach  {$_.Caption} 
    $ipv4add = Get-NetIPAddress -CimSession $i -AddressFamily IPv4 -ErrorAction SilentlyContinue | where {$_.IPAddress -notmatch '127.0.0.1'} | foreach {$_.IPv4Address}
    $disk = gcim Win32_LogicalDisk -ComputerName $i | ForEach {[math]::truncate($_.freespace / 1GB)}  -ErrorAction SilentlyContinue
    $disktotal = 0
    foreach ($s in $disk)
    {
       $disktotal +=$s
    } 
    $cpu = gcim win32_processor -ComputerName $i -ErrorAction SilentlyContinue | Measure-Object -property `
    LoadPercentage -Average | foreach {$_.Average} 

    $ram = gcim Win32_OperatingSystem -ComputerName $i -ErrorAction SilentlyContinue
    $ram = ([math]::round($ram.FreePhysicalMemory / 1024/1024, 2))     
        
    }
 Else {
        $Status = "Ofline"
        $name = $i
        $ram = "unavailable"
        $cpu = "unavailable"
      }
    
    #increment $i, to use the many different background image options
    $index++
    
    
    #choosing styles
    if ($Status -eq 'Ofline'){
        $style = 'style1'
        }
        elseif($Status -eq 'online'){
        $style = "style2"
        }
        else{
        #VM is haunted or something else
        $style = "style3"
        }
    
    #if the VM is on, don't just show it's name, but it's RAM and CPU usage too
    if ($Status -eq 'online'){
     
        $Name="$($Name)<br>
         Free RAM: $($ram)<br>
         CPU uasge: $($cpu)<br>
         Address: $($ipv4add)
         "
    }
        else{
        $Name="$($servers[$index])<br>
         Machine: $($Status)<br>
         "
    
    }
    #Set the flavor text, which appears when we hover over the card
    $description= @"
        Free space on drives: $($disktotal)GB<br>
        Running $($arch)<br>
        $($bit)
        
"@

    #make a card
    $tile = @"
                              <article class="$style">
									<span class="image">
										<img src="images/pic01.jpg" alt="" />
									</span>
									<a> 
										<h2>$Name</h2>
										<div class="content">
											<p>$($description)</p>
										</div>
									</a>
								</article>
"@
$main += $tile
}
$html = $head + $main + $tail
$html | Set-Content -Encoding UTF8 -Path dashboard1.html
write-output "done" 
(Get-Date).dateTime
Start-Sleep -Seconds 9}
