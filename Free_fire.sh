#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
#         FREE FIRE ACCOUNT RECOVERY - TERMUX AUTO SETUP
# ============================================================

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
RED="\033[91m"
BLUE="\033[94m"
WHITE="\033[97m"
ORANGE="\033[38;5;214m"
PINK="\033[38;5;206m"
PURPLE="\033[38;5;129m"

# আরিয়ান কালার প্যালেট
RGB=(
    "\033[38;5;196m"  # লাল
    "\033[38;5;208m"  # কমলা
    "\033[38;5;226m"  # হলুদ
    "\033[38;5;118m"  # গ্রিন
    "\033[38;5;51m"   # সায়ান
    "\033[38;5;45m"   # নীল
    "\033[38;5;93m"   # পার্পল
    "\033[38;5;201m"  # ম্যাজেন্টা
    "\033[38;5;198m"  # পিঙ্ক
    "\033[38;5;214m"  # অরেঞ্জ
    "\033[38;5;220m"  # সোনালী
    "\033[38;5;154m"  # চুন
    "\033[38;5;57m"   # ইন্ডিগো
    "\033[38;5;129m"  # ভায়োলেট
    "\033[38;5;212m"  # হট পিঙ্ক
)
RGB_LEN=15

FLASH=("$RED" "$ORANGE" "$YELLOW" "$WHITE" "$PINK" "$PURPLE" "$CYAN" "$GREEN" "$ORANGE" "$RED" "$YELLOW" "$PINK" "$PURPLE")

# ============================================================
# FREE FIRE LOGO (আরিয়ান ভার্সন)
# ============================================================
FF_L0="            ⣀⣠⡤                        "
FF_L1="   ⢀⣤⡶⠁⣠⣴⣾⠟⠋⠁                          "
FF_L2="  ⢀⣴⣿⣿⣴⣿⠿⠋⣁⣀⣀⣀⣀⣀⡀                      "
FF_L3="  ⣰⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀                "
FF_L4="⣠⣾⣿⡿⠟⠋⠉⠀⣀⣀⣨⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣴⠂"
FF_L5="⠈⠉⠁⠀⣀⣴⣾⣿⣿⡿⠟⠛⠉⠉⠉⠉⠛⠻⠿⠿⠿⠿⠿⠿⠟⠋⠁          "
FF_L6="   ⢀⣴⣿⣿⣿⡿⠁⢀⣀⣤⣤⣤⣤⣀⣀                      "
FF_L7="   ⣾⣿⣿⣿⡿⠁⢀⣴⣿⠋⠉⠉⠉⠉⠛⣿⣿⣶⣤⣤⣤⣤⣶⠖            "
FF_L8="  ⢸⣿⣿⣿⣿⡇⢀⣿⣿⣇⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠃              "
FF_L9="  ⠸⣿⣿⣿⣿⡇⠈⢿⣿⣿⠇⠀⠀⠀⠀⢠⣿⣿⣿⠟⠋                "
FF_LA="   ⢿⣿⣿⣿⣷⡀⠀⠉⠉⠀⠀⠀⢀⣾⣿⣿⡏                    "
FF_LB="    ⠙⢿⣿⣿⣷⣄⡀⠀⠀⣀⣴⣿⣿⣿⣋⣠⡤⠄                  "
FF_LC="       ⠈⠙⠛⠛⠿⠿⠿⠿⠿⠟⠛⠛⠛⠉⠁                   "

print_ff_logo() {
    local offset=${1:-0}
    local dim=${2:-0}
    local ri=$(( RANDOM % RGB_LEN ))
    local rc="${RGB[$ri]}"

    echo -e "  ${rc}${BOLD} ⚡ ফ্রি ফায়ার অ্যাকাউন্ট রিকভারি সেটআপ চলছে... ⚡${RESET}"
    echo ""

    local lines=("$FF_L0" "$FF_L1" "$FF_L2" "$FF_L3" "$FF_L4" "$FF_L5" "$FF_L6" "$FF_L7" "$FF_L8" "$FF_L9" "$FF_LA" "$FF_LB" "$FF_LC")
    local i
    for i in $(seq 0 12); do
        local ci=$(( (i + offset) % 13 ))
        local c="${FLASH[$ci]}"
        if [ "$dim" -eq 1 ] && [ $(( i % 2 )) -ne 0 ]; then
            echo -e "  ${PURPLE}${DIM}${lines[$i]}${RESET}"
        else
            echo -e "  ${c}${BOLD}${lines[$i]}${RESET}"
        fi
    done
    echo ""
}

# ============================================================
# ANIMATION
# ============================================================
ANIM_PID=""
FF_FLAG="${TMPDIR:-$HOME}/_ariyan_ff_flag"
LOGO_ROWS=16
STATUS_ROW=$(( LOGO_ROWS + 2 ))

start_anim() {
    touch "$FF_FLAG"
    (
        local offset=0
        while [ -f "$FF_FLAG" ]; do
            printf "\033[H"
            local mode=$(( offset % 3 ))
            if [ "$mode" -eq 2 ]; then
                print_ff_logo "$offset" 1
            else
                print_ff_logo "$offset" 0
            fi
            offset=$(( (offset + 1) % 39 ))
            sleep 0.12
        done
    ) &
    ANIM_PID=$!
}

stop_anim() {
    rm -f "$FF_FLAG" 2>/dev/null
    [ -n "$ANIM_PID" ] && kill "$ANIM_PID" 2>/dev/null && wait "$ANIM_PID" 2>/dev/null
    ANIM_PID=""
}

# ============================================================
# RGB PROGRESS BAR
# ============================================================
rgb_bar() {
    local filled=$1
    local total=30
    local bar=""
    for i in $(seq 1 $total); do
        local ci=$(( (i + filled) % RGB_LEN ))
        local c="${RGB[$ci]}"
        if [ "$i" -le "$filled" ]; then
            bar="${bar}${c}${BOLD}█${RESET}"
        else
            bar="${bar}${DIM}░${RESET}"
        fi
    done
    echo -ne "$bar"
}

print_status() {
    local idx=$1
    local total=$2
    local name=$3
    local state=$4
    local pct=$(( idx * 100 / total ))
    local filled=$(( idx * 30 / total ))
    local ci=$(( idx % RGB_LEN ))
    local c="${RGB[$ci]}"

    printf "\033[%d;0H\033[2K" "$STATUS_ROW"
    echo -ne "  "
    rgb_bar "$filled"
    echo ""

    printf "\033[%d;0H\033[2K" "$(( STATUS_ROW + 1 ))"
    if   [ "$state" = "ok" ];   then echo -e "  ${GREEN}${BOLD}[✔] $name ${RESET} ${GREEN}✅ সফল${RESET}  ($pct%)"
    elif [ "$state" = "fail" ]; then echo -e "  ${RED}${BOLD}[✗] $name ${RESET} ${RED}❌ ব্যর্থ${RESET}  ($pct%)"
    else                             echo -e "  ${c}${BOLD}⬇️  ইনস্টল হচ্ছে: $name ${RESET}  ($pct%)"
    fi
}

# ============================================================
# ডাউনলোড অ্যানিমেশন ও হ্যান্ডলার
# ============================================================
download_animation() {
    local folder_name="$1"
    local repo_url="https://github.com/Ariyan20267/Account-recovery.git"
    local target_path="$2"
    
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${PINK}${BOLD}     📥 ${folder_name} ডাউনলোড হচ্ছে...${RESET}"
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    
    # স্মার্ট ইন্টারনেট চেক (Ping + Curl Fallback)
    echo -e "${YELLOW}${BOLD}  [*] ইন্টারনেট কানেকশন চেক করা হচ্ছে...${RESET}"
    if ! ping -c 1 -W 2 8.8.8.8 &>/dev/null && ! curl -s --connect-timeout 3 https://www.google.com &>/dev/null; then
        echo -e "${RED}${BOLD}  ❌ ইন্টারনেট কানেকশন নেই!${RESET}"
        echo -e "${YELLOW}${BOLD}  ⚠️  ওয়াই-ফাই বা মোবাইল ডাটা চালু করুন${RESET}"
        sleep 2
        return 1
    fi
    echo -e "${GREEN}${BOLD}  ✅ ইন্টারনেট সংযুক্ত${RESET}"
    echo ""
    
    # গিট চেক
    echo -e "${YELLOW}${BOLD}  [*] গিট চেক করা হচ্ছে...${RESET}"
    if ! command -v git &>/dev/null; then
        echo -e "${RED}${BOLD}  ❌ গিট ইনস্টল নেই!${RESET}"
        echo -e "${YELLOW}${BOLD}  ⚠️  গিট ইনস্টল করা হচ্ছে...${RESET}"
        pkg install git -y
    fi
    echo -e "${GREEN}${BOLD}  ✅ গিট প্রস্তুত${RESET}"
    echo ""
    
    # ফোল্ডার ডিলিট না করে ক্লিন করা
    mkdir -p "$target_path"
    if [ -d "$target_path" ]; then
        echo -e "${YELLOW}${BOLD}  [*] পুরনো ডিরেক্টরি পরিস্কার করা হচ্ছে...${RESET}"
        rm -rf "${target_path:?}"/* 2>/dev/null
        rm -rf "${target_path:?}"/.[!.]* 2>/dev/null
    fi
    
    # স্পিনার অ্যানিমেশন
    local spin_chars=("⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷")
    local colors=("$RED" "$ORANGE" "$YELLOW" "$GREEN" "$CYAN" "$BLUE" "$PURPLE" "$PINK")
    local dots=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    
    local temp_dir="${TMPDIR:-/tmp}/download_anim"
    mkdir -p "$temp_dir"
    local flag_file="$temp_dir/running"
    echo "1" > "$flag_file"
    
    # অ্যানিমেশন ব্যাকগ্রাউন্ড প্রসেস
    (
        local i=0
        while [ -f "$flag_file" ]; do
            local c_idx=$(( i % ${#colors[@]} ))
            local sp_idx=$(( i % ${#spin_chars[@]} ))
            local d_idx=$(( (i / 2) % ${#dots[@]} ))
            local color="${colors[$c_idx]}"
            local spinner="${spin_chars[$sp_idx]}"
            local dot="${dots[$d_idx]}"
            
            local msgs=(
                "📦 ফাইল সংগ্রহ করা হচ্ছে"
                "🔍 রিপোজিটরি খোঁজা হচ্ছে"
                "⚡ ডেটা ট্রান্সফার চলছে"
                "📁 ফাইল কপি হচ্ছে"
                "🔄 ফাইল সিঙ্ক্রোনাইজ করা হচ্ছে"
                "🚀 ডাউনলোড প্রগতি"
            )
            local msg="${msgs[$(( i % ${#msgs[@]} ))]}"
            
            local progress=$(( (i * 100) / 40 ))
            [ $progress -gt 95 ] && progress=95
            local bar_len=$(( progress * 40 / 100 ))
            local bar=""
            for j in $(seq 1 40); do
                if [ $j -le $bar_len ]; then
                    local ci=$(( (j + i) % RGB_LEN ))
                    bar="${bar}${RGB[$ci]}█${RESET}"
                else
                    bar="${bar}${DIM}░${RESET}"
                fi
            done
            
            printf "\033[1A\033[2K"
            printf "\r  ${color}${BOLD}${spinner} ${dot} ${msg}${RESET}\n"
            printf "  ${color}${BOLD}[${bar}] ${progress}%%${RESET}\n"
            printf "  ${DIM}ফোল্ডার: ${folder_name}${RESET}\n"
            
            i=$((i + 1))
            sleep 0.15
        done
    ) &
    local anim_pid=$!
    
    # রিপোজিটরি ক্লোন
    echo -e "${YELLOW}${BOLD}  [*] রিপোজিটরি ক্লোন করা হচ্ছে...${RESET}"
    git clone --depth 1 "$repo_url" "$target_path" &>/dev/null
    local result=$?
    
    # অ্যানিমেশন থামানো
    rm -f "$flag_file"
    wait $anim_pid 2>/dev/null
    rm -rf "$temp_dir"
    
    # ফলাফল
    if [ $result -eq 0 ] && [ -f "$target_path/main.py" ]; then
        printf "\033[2A\033[2K"
        printf "\r  ${GREEN}${BOLD}✅ ${folder_name} ডাউনলোড সম্পূর্ণ!${RESET}\n"
        printf "  ${GREEN}${BOLD}🚀 main.py রান করার জন্য প্রস্তুত${RESET}\n"
        sleep 1
        return 0
    else
        printf "\033[2A\033[2K"
        printf "\r  ${RED}${BOLD}❌ ডাউনলোড ব্যর্থ!${RESET}\n"
        printf "  ${YELLOW}${BOLD}⚠️  রিপোজিটরি লিংক চেক করুন${RESET}\n"
        sleep 2
        return 1
    fi
}

# ============================================================
# STEP 1 — Storage Permission
# ============================================================
clear
echo -e "${CYAN}${BOLD}  [*] স্টোরেজ অনুমতি চেক করা হচ্ছে...${RESET}"

STORAGE_OK=0
if [ -d ~/storage/shared ] || [ -d ~/storage/downloads ]; then
    STORAGE_OK=1
fi

if [ "$STORAGE_OK" -eq 1 ]; then
    if ! touch ~/storage/downloads/.test_write 2>/dev/null; then
        STORAGE_OK=0
    else
        rm -f ~/storage/downloads/.test_write 2>/dev/null
    fi
fi

if [ "$STORAGE_OK" -eq 0 ]; then
    echo -e "${YELLOW}${BOLD}  [!] স্টোরেজ অনুমতি পাওয়া যায়নি!${RESET}"
    echo -e "${YELLOW}${BOLD}  [!] অনুমতি চাওয়া হচ্ছে...${RESET}"
    termux-setup-storage
    sleep 3
    echo -e "${GREEN}${BOLD}  [✔] অনুমতি দেওয়া হয়েছে!${RESET}"
else
    echo -e "${GREEN}${BOLD}  [✔] স্টোরেজ অনুমতি আগে থেকেই আছে${RESET}"
fi
echo ""

# ============================================================
# STEP 2 — pkg update
# ============================================================
echo -e "${CYAN}${BOLD}  [*] প্যাকেজ আপডেট করা হচ্ছে...${RESET}"
pkg update -y 2>/dev/null || true
pkg upgrade -y 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] প্যাকেজ আপডেট সম্পূর্ণ${RESET}"
echo ""

# ============================================================
# STEP 3 — Python
# ============================================================
echo -e "${CYAN}${BOLD}  [*] পাইথন চেক করা হচ্ছে...${RESET}"
if command -v python3 &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] পাইথন: $(python3 --version)${RESET}"
else
    echo -e "${YELLOW}${BOLD}  [!] পাইথন ইনস্টল করা হচ্ছে...${RESET}"
    pkg install python -y
    command -v python3 &>/dev/null || { echo -e "${RED}${BOLD}  [✗] পাইথন ইনস্টল ব্যর্থ!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] পাইথন ইনস্টল সম্পূর্ণ${RESET}"
fi
echo ""

# ============================================================
# STEP 4 — pip
# ============================================================
echo -e "${CYAN}${BOLD}  [*] পাইপ আপগ্রেড করা হচ্ছে...${RESET}"
python3 -m pip install --upgrade pip -q 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] পাইপ প্রস্তুত${RESET}"
echo ""

# ============================================================
# STEP 5 — Git
# ============================================================
echo -e "${CYAN}${BOLD}  [*] গিট চেক করা হচ্ছে...${RESET}"
if command -v git &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] গিট: $(git --version)${RESET}"
else
    pkg install git -y
    command -v git &>/dev/null || { echo -e "${RED}${BOLD}  [✗] গিট ইনস্টল ব্যর্থ!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] গিট ইনস্টল সম্পূর্ণ${RESET}"
fi
echo ""

# ============================================================
# STEP 6-7 — MODULE INSTALL (সুন্দর ডিজাইন)
# ============================================================

BOX_W=50
B="${PINK}${BOLD}"
RS="${RESET}"

box_top()  { echo -e "${B}  ╔$(printf '═%.0s' $(seq 1 $BOX_W))╗${RS}"; }
box_bot()  { echo -e "${B}  ╚$(printf '═%.0s' $(seq 1 $BOX_W))╝${RS}"; }
box_line() { echo -e "${B}  ╠$(printf '═%.0s' $(seq 1 $BOX_W))╣${RS}"; }

box_center() {
    local text="$1" color="${2:-$WHITE}"
    local clean; clean=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local tlen=${#clean}
    local lpad=$(( (BOX_W - tlen) / 2 ))
    local rpad=$(( BOX_W - tlen - lpad ))
    printf "${B}  ║${RS}%${lpad}s${color}${BOLD}%s${RS}%${rpad}s${B}║${RS}\n" "" "$text" ""
}

box_left() {
    local text="$1" color="${2:-$WHITE}"
    local clean; clean=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local pad=$(( BOX_W - ${#clean} - 2 ))
    [ $pad -lt 0 ] && pad=0
    printf "${B}  ║${RS} ${color}${BOLD}%s${RS}%${pad}s${B} ║${RS}\n" "$text" ""
}

LOGO_LINES=(
    "░█████╗░██████╗░██╗██╗   ██╗░█████╗░███╗░░██╗"
    "██╔══██╗██╔══██╗██║╚██╗ ██╔╝██╔══██╗████╗░██║"
    "███████║██████╔╝██║ ╚████╔╝ ███████║██╔██╗██║"
    "██╔══██║██╔══██╗██║  ╚██╔╝  ██╔══██║██║╚████║"
    "██║  ██║██║  ██║██║   ██║   ██║  ██║██║ ╚███║"
    "╚═╝  ╚═╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚══╝"
)

flash_logo() {
    local colors=("$RED" "$ORANGE" "$YELLOW" "$GREEN" "$CYAN" "$BLUE" "$PURPLE" "$PINK" "$WHITE")
    local ci=0
    for round in 1 2 3 4; do
        printf "\033[8A"
        box_line
        for line in "${LOGO_LINES[@]}"; do
            local c="${colors[$ci]}"
            ci=$(( (ci + 1) % ${#colors[@]} ))
            box_center "$line" "$c"
        done
        box_line
        sleep 0.15
    done
}

rgb_progress_box() {
    local done=$1 total=$2
    local filled=$(( done * (BOX_W - 4) / total ))
    local empty=$(( BOX_W - 4 - filled ))
    local bar=""
    local ci=0
    for i in $(seq 1 $filled); do
        ci=$(( (i + done) % RGB_LEN ))
        bar="${bar}${RGB[$ci]}${BOLD}▰${RESET}"
    done
    for i in $(seq 1 $empty); do
        bar="${bar}${DIM}▱${RESET}"
    done
    printf "${B}  ║${RS} ${bar} ${B}║${RS}\n"
}

clear
box_top
box_center "⚡ 𝗙𝗥𝗘𝗘 𝗙𝗜𝗥𝗘 𝗔𝗖𝗖𝗢𝗨𝗡𝗧 𝗥𝗘𝗖𝗢𝗩𝗘𝗥𝗬 ⚡" "$YELLOW"
box_center "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$YELLOW"
box_line

for line in "${LOGO_LINES[@]}"; do
    box_center "$line" "$CYAN"
done
box_line

flash_logo

box_center "📦  মডিউল ইনস্টল করা হচ্ছে  📦" "$YELLOW"
box_line

FAILED=()
MODULES=(
    "psutil|pkg"
    "requests|pip"
    "PyJWT|pip"
    "urllib3|pip"
    "aiohttp|pip"
    "flask|pip"
    "pycryptodome|pip"
    "protobuf|pip"
    "protobuf-decoder|pip"
    "google-play-scraper|pip"
    "pytz|pip"
    "pyfiglet|pip"
)
TOTAL=${#MODULES[@]}
DONE=0

for entry in "${MODULES[@]}"; do
    name="${entry%%|*}"
    method="${entry##*|}"
    DONE=$(( DONE + 1 ))

    box_left "  ⏳ ${name}  [${DONE}/${TOTAL}]" "$YELLOW"

    if [ "$method" = "pkg" ]; then
        pkg install "python-${name}" -y &>/dev/null || python3 -m pip install "$name" -q &>/dev/null
    else
        python3 -m pip install "$name" -q &>/dev/null
    fi

    if [ $? -eq 0 ]; then
        printf "\033[1A\033[2K"
        box_left "  ✅ ${name} (সফল)" "$GREEN"
    else
        printf "\033[1A\033[2K"
        box_left "  ❌ ${name} (ব্যর্থ)" "$RED"
        FAILED+=("$name")
    fi

    rgb_progress_box "$DONE" "$TOTAL"
    printf "\033[1A"
done

echo ""
rgb_progress_box "$TOTAL" "$TOTAL"
box_bot

# ============================================================
# FINAL REPORT
# ============================================================
clear
print_ff_logo 4 0
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════════${RESET}"
if [ ${#FAILED[@]} -gt 0 ]; then
    echo -e "${YELLOW}${BOLD}  [!] ব্যর্থ মডিউল:${RESET}"
    for f in "${FAILED[@]}"; do
        echo -e "  ${RED}    ❌ $f${RESET}"
    done
    echo -e "${YELLOW}${BOLD}  [!] ইন্টারনেট চেক করে আবার চেষ্টা করুন।${RESET}"
else
    echo -e "${GREEN}${BOLD}  [✔] সব মডিউল সফলভাবে ইনস্টল হয়েছে! 😊${RESET}"
fi
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""

# ============================================================
# WHATSAPP GROUP JOIN
# ============================================================
WHATSAPP_LINK="https://whatsapp.com/channel/0029Vb7jk7n6mYPIZIHDeV1T"

echo -e "${CYAN}${BOLD}  [*] WhatsApp গ্রুপে জয়েন করা হচ্ছে...${RESET}"
sleep 1

if command -v termux-open &>/dev/null; then
    termux-open "$WHATSAPP_LINK"
else
    am start -a android.intent.action.VIEW -d "$WHATSAPP_LINK" 2>/dev/null || true
fi

echo -e "${GREEN}${BOLD}  [✔] WhatsApp ওপেন করা হয়েছে${RESET}"
sleep 2

# ============================================================
# FREE FIRE ACCOUNT RECOVERY (স্মার্ট চেক ও ডিরেক্ট রান লজিক)
# ============================================================

clear
echo -e "${PURPLE}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo -e "${PURPLE}${BOLD}     🎮 FREE FIRE ACCOUNT RECOVERY - সেটআপ ও রান 🎮${RESET}"
echo -e "${PURPLE}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""

STORAGE_PATH="/sdcard/free fire account recovery"
[ ! -d "/sdcard" ] && [ -d "/storage/emulated/0" ] && STORAGE_PATH="/storage/emulated/0/free fire account recovery"

# 🔥 প্রধান ফিক্স: ফাইল আগে থেকে থাকলে ডাউনলোড স্কিপ করে ডিরেক্ট রান করবে
if [ -f "$STORAGE_PATH/main.py" ]; then
    echo -e "${GREEN}${BOLD}  ✅ ফ্রি ফায়ার অ্যাকাউন্ট রিকভারি টুল আগে থেকেই ইনস্টল আছে!${RESET}"
    echo -e "${CYAN}${BOLD}  ⚡ ডাউনলোড স্কিপ করে সরাসরি চালু করা হচ্ছে...${RESET}"
    echo ""
    sleep 2
    clear
    
    print_ff_logo 0 0
    echo -e "${GREEN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}${BOLD}     🚀 FREE FIRE ACCOUNT RECOVERY চালু হচ্ছে... 🚀${RESET}"
    echo -e "${GREEN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    sleep 1
    
    cd "$STORAGE_PATH" && python3 main.py
    exit 0
fi

# ফাইল না থাকলে ডাউনলোড প্রক্রিয়া শুরু হবে
if download_animation "free fire account recovery" "$STORAGE_PATH"; then
    echo ""
    echo -e "${GREEN}${BOLD}  ✅ ফাইল প্রস্তুত!${RESET}"
    echo -e "${CYAN}${BOLD}  🚀 main.py রান করা হচ্ছে...${RESET}"
    echo ""
    sleep 2
    clear
    
    print_ff_logo 0 0
    
    echo -e "${GREEN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}${BOLD}     🚀 FREE FIRE ACCOUNT RECOVERY চালু হচ্ছে... 🚀${RESET}"
    echo -e "${GREEN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    sleep 1
    
    cd "$STORAGE_PATH" && python3 main.py
else
    echo ""
    echo -e "${RED}${BOLD}  ❌ ডাউনলোড ব্যর্থ!${RESET}"
    echo -e "${YELLOW}${BOLD}  ⚠️  অনুগ্রহ করে ইন্টারনেট কানেকশন চেক করুন এবং আবার চেষ্টা করুন${RESET}"
    echo ""
    exit 1
fi
