$portRange = Read-Host "Enter port range (e.g., 20-80 or 443)" 

# Dynamic IP fetch
# $network = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" -and $_.InterfaceAlias -notlike "*Loopback*" }).IPAddress
# $fullRange = "$($network.Substring(0, $network.LastIndexOf('.'))).0/24"

$network = "192.168.1.40"
# $fullRange = "$network.0/24"
$fullRange = $network


$results = "port_scan_results.txt"

# Performing port scan
Write-Host "\nPerforming Port Scan on $fullRange for ports $portRange..."
if (-Not (Get-Command nmap -ErrorAction SilentlyContinue)) {
    Write-Host "Nmap not found. Please install nmap and try again."
    Exit
}

nmap -p $portRange $fullRange | Tee-Object -FilePath $results

Write-Host "\nPort scan complete. Results saved to $results"
