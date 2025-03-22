Write-Host "Select an option"
Write-Host "1. Fast Scan (ping)"
Write-Host "2. Detailed Scan (nmap)"
Write-Host "3. Nmap ARP"
Write-Host "2. Nmap ICMP"
$choice = Read-Host "Enter Choice"

# network range
$network = "192.168.1"
$results = "scan_results.txt"

#clear previous results
# if (Test-Path $results){
#   Remove-Item $results
# }

if ($choice -eq "1"){
  Write-Host "`nPerforming Fast Scan..."
  For ($i = 35; $i -le 45; $i++){
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

  if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
  }

  # Detailed nmap scan
  $fullRange = "$network.0/24"
  nmap -sn -v --reason $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "3") {
  Write-Host "`nPerforming detailed scan..."

  if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
  }

  # Detailed nmap scan
  $fullRange = "$network.0/24"
  nmap -sn -PR $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "4") {
  Write-Host "`nPerforming detailed scan..."

  if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
  }

  # Detailed nmap scan
  $fullRange = "$network.0/24"
  nmap -sn -PE $fullRange | Tee-Object -FilePath $results
}
elseif ($choice -eq "2") {
  Write-Host "`nPerforming detailed scan..."

  if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
  }

  # Detailed nmap scan
  $fullRange = "$network.0/24"
  nmap -sn -v --reason $fullRange | Tee-Object -FilePath $results
}
else {
  Write-Host "Invalid choice!"
}

Write-Host "`nScan complete. Results saved to $results"