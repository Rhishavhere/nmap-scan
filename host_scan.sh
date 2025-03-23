echo "Select an option"
echo "1. Fast Scan (ping)"
echo "2. Detailed Scan (nmap)"
echo "3. Nmap ARP"
echo "4. Nmap ICMP"
echo "5. OS Scan (-sS -O)"
echo "6. Service Scan (-sS -sV)"
read -p "Enter Choice: " choice

# Network range
network="192.168.1"
fullRange="$network.0/24"
results="scan_results/host_results.txt"

# Check if Nmap is installed
if ! command -v nmap &> /dev/null; then
    echo "Nmap not found. Please install Nmap and try again."
    exit 1
fi

# Clear previous results
# if [ -f "$results" ]; then
#     rm "$results"
# fi


if [ "$choice" -eq 1 ]; then
  echo -e "\nPerforming Fast Scan (ping)..."
  for i in {1..255}; do
    ip="$network.$i"
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
      echo "Host $ip is up" | tee -a "$results"
    else
      echo "Host $ip is down"
    fi
  done

elif [ "$choice" -eq 2 ]; then
    echo -e "\nPerforming Detailed Scan..."
    nmap -sn -v --reason "$fullRange" | tee "$results"

elif [ "$choice" -eq 3 ]; then
    echo -e "\nPerforming ARP Scan..."
    nmap -sn -PR "$fullRange" | tee "$results"

elif [ "$choice" -eq 4 ]; then
    echo -e "\nPerforming ICMP Scan..."
    nmap -sn -PE "$fullRange" | tee "$results"

elif [ "$choice" -eq 5 ]; then
    echo -e "\nPerforming OS Guess Scan..."
    nmap -sS -O --osscan-guess "$fullRange" | tee "$results"

elif [ "$choice" -eq 6 ]; then
    echo -e "\nPerforming Service Scan..."
    nmap -sS -sV "$fullRange" | tee "$results"

else
    echo "Invalid choice!"
fi

echo -e "\nScan complete. Results saved to $results"
