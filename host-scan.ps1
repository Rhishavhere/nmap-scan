Write-Host "Select an option"
Write-Host "1. Fast Scan (ping)"
Write-Host "2. Detailed Scan (nmap)"
Write-Host "3. Nmap ARP"
Write-Host "4. Nmap ICMP"
Write-Host "5. OS Scan (-sS -O)"
Write-Host "6. Service Scan (-sS -sV)"
$choice = Read-Host "Enter Choice"

# network range
$network = "192.168.1"
$fullRange = "$network.0/24"
$results = "scan_results.txt"

# if (Test-Path $results){
#   Remove-Item $results
# }

if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
  }

if ($choice -eq "1"){
  Write-Host "`nPerforming Fast Scan..."

  For ($i = 1; $i -le 255; $i++){
    $ip = "$network.$i"
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
      Write-Host "Host $ip is up" | Tee-Object -FilePath $results -Append
    } else {
      Write-Host "Host $ip is down"
    }
  }
}
elseif ($choice -eq "2") {
  Write-Host "`nPerforming detailed scan..."

  nmap -sn -v --reason $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "3") {
  Write-Host "`nPerforming ARP scan..."

  nmap -sn -PR $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "4") {
  Write-Host "`nPerforming ICMP scan..."

  nmap -sn -PE $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "5") {
  Write-Host "`nPerforming OS guess scan..."

  nmap -sS -O --osscan-guess $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "6") {
  Write-Host "`nPerforming Service scan..."

  nmap -sS -sV $fullRange | Tee-Object -FilePath $results
}
else {
  Write-Host "Invalid choice!"
}

Write-Host "`nScan complete. Results saved to $results"