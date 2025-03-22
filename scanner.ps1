Write-Host "Select an option"
Write-Host "1. Fast Scan (ping)"
Write-Host "2. Detailed Scan (nmap)"
$choice = Read-Host "Enter Choice : "

# network range
$network = "192.168.1"
$results = "scan_results.txt"

#clear previous results
if (Test-Path $results){
  Remove-Item $results
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

  if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
  }

  # Detailed nmap scan
  $fullRange = "$network.0/24"
  nmap -sn $fullRange | Out-File -FilePath $results
}
else {
  Write-Host "Invalid choice!"
}

Write-Host "`nScan complete. Results saved to $results"