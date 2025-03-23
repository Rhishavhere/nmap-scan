echo "Enter port range (e.g., 20-80 or 443):"
read portRange

# Dynamic IP fetch using ipconfig
network=$(ipconfig | grep -oP '(?<=IPv4 Address[. ]+: )[0-9.]+')
fullRange=$network

results="scan_results/port_results.txt"

# Performing port scan
echo -e "\nPerforming Port Scan on $fullRange for ports $portRange..."

if ! command -v nmap &> /dev/null; then
    echo "Nmap not found. Please install nmap and try again."
    exit 1
fi

nmap -p "$portRange" "$fullRange" | tee "$results"

echo -e "\nPort scan complete. Results saved to $results"
