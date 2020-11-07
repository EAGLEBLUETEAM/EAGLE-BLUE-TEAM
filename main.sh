#!/data/data/com.termux/files/usr/bin/bash

function tampilkan_logo () {
   echo $'                               \e[34;1m/T /I
                              / |/ | .-~/
                          T Y  I  |/  /  _
         /T               | I  |  I  Y.-~/
        I l   /I       T |  |  l  |  T  /
      __  |      I l __l  l      `  _. |
      ~-l  `   `    \ ~     `. .-~   |
     ~-. "-.  `    ^._ ^. "-.  /     |
.--~-._  ~-  `  _  ~-_.-"-." ._ /._ ." ./
>--.  ~-.   ._  ~>-"    "\   7   7   ]
^.___~"--._    ~-{  .-~ .  ` Y . /    |
<__ ~"-.  ~       /_/      I  Y   : |
   ^-.__           ~(_/      >._:   | l______
       ^--.,___.-~"  /_/   !  `-.~"--l_ /     ~"-.
              (_/ .  ~(   /\'     "~"--,Y   -=b-. _)
               (_/ .    :           / l      c"~o
                 /    `.    .     .^   _.-~"~--.  )
                 (_/ .   `  /     /       !       )/
                  / / _.   \'.   .\':      /        \'
                  ~(_/ .   /    _  `  .-<_
                    /_/ . \' .-~" `.  /             ,z=.
                    ~( /   \'  :   | K   "-.~-.______//
                      "-,.    l   I/ _    __{--->._(==.
                       //(       <    ~"~"     //
                      /\' /            ,v=.  ((
                    .^. / /     "  }__ //===-  `
                   / / \' \'  "-.,__ {---(==-
                 .^ \'       :  T  ~"   ll
                / .  .  . : | :!
               (_/  /   | | j-"          ~^
                 ~-<_(_.^-~"\e[0m

    +------------------------------------------------------------+
    | \e[38;5;15;1mGitHub\e[0m:   \e[31;1mhttps://github.com/EAGLEBLUETEAM\e[0m                 |
    | \e[38;5;15;1mWhatsApp\e[0m: \e[31;1mhttps://chat.whatsapp.com/Kn644dL9qnFKMEnOwR27VF\e[0m |
    +------------------------------------------------------------+';
}

function tampilkan_menu () {
   echo -e "$1" && shift;
   local menu=("$@");
   local panjang_maksimum=0;

   if (($# % 2 == 1)); then
      local banyak_sisi_kiri=$((($# + 1) / 2));
   else
      local banyak_sisi_kiri=$(($# / 2));
   fi;

   for ((i = 0; i < banyak_sisi_kiri; i++)); do
      if ((${#menu[i]} > panjang_maksimum)); then
         panjang_maksimum=${#menu[i]};
      fi;
   done;

   for ((i = 0; i < banyak_sisi_kiri; i++)); do
      local j=$((i + banyak_sisi_kiri));

      if [ -v menu[j] ]; then
         printf "    %02d: %-${panjang_maksimum}b    %02d: %b\n" $((i + 1)) "${menu[i]}" $((j + 1)) "${menu[j]}";
      else
         printf "    %02d: %b\n" $((i + 1)) "${menu[i]}";
      fi;
   done;
   echo -en "\nMasukkan pilihan anda > ";
}

function main () {
   local input bersihkan_menu_2 bersihkan_menu_3;
   local nama_skrip="$0";
   local nama_direktori="$(dirname "$nama_skrip")";
   local menu=(
      "\e[1m***\e[0m \e[34;1mPILIHAN MENU\e[0m \e[1m***\e[0m"
      "\e[34;1mK\e[0mostumisasi Termux"
      "\e[34;1mI\e[0mnstal skrip"
      "\e[34;1mB\e[0mantuan"
      "\e[34;1mE\e[0mksit"
   );
   local IFS=$'\n';
   mkdir -p ~/.termux;
   tampilkan_logo && echo;
   bersihkan_menu_2=false;
   bersihkan_menu_3=false;

   while true; do
      read -ep "$(tampilkan_menu "${menu[@]}")" input && history -s "$input";

      if (($? == 0)); then
         input="${input,,}";
         local mentahan_menu=($(sed "s/\\\e\[[^m]\+m//g" <<< $(printf "%s\n" "${menu[@],,}")));

         if [ "$input" == 1 ] || [[ "${mentahan_menu[1]}" == "${input:-kosong}"* ]] || [ "$input" == 01 ]; then
            local menu_kostumisasi=(
               "\e[1m***\e[0m \e[34;1mKOSTUMISASI TERMUX\e[0m \e[1m***\e[0m"
               "\e[34;1mG\e[0maya warna"
               "\e[34;1mF\e[0mon teks"
               "\e[34;1mB\e[0mantuan"
               "\e[34;1mK\e[0membali"
            );
            local mentahan_menu_kostumisasi=($(sed "s/\\\e\[[^m]\+m//g" <<< $(printf "%s\n" "${menu_kostumisasi[@],,}")));

            if $bersihkan_menu_3; then
               echo -en "\e[11F\e[0J";
               bersihkan_menu_3=false;
            elif $bersihkan_menu_2; then
               echo -en "\e[8F\e[0J";
               bersihkan_menu_2=false;
            else
               echo -en "\e[5F\e[0J";
            fi;

            while true; do
               read -ep "$(tampilkan_menu "${menu_kostumisasi[@]}")" input && history -s "$input";

               if (($? == 0)); then
                  input="${input,,}";

                  if [ "$input" == 1 ] || [[ "${mentahan_menu_kostumisasi[1]}" == "${input:-kosong}"* ]] || [ "$input" == 01 ]; then
                     local gaya_warna=("\e[1m***\e[0m \e[34;1mGAYA WARNA\e[0m \e[1m***\e[0m" $(basename -s .properties "$nama_direktori/assets/colors/"*.properties) "\e[34;1mK\e[0membali");

                     if $bersihkan_menu_3; then
                        echo -en "\e[11F\e[0J";
                        bersihkan_menu_3=false;
                     else
                        echo -en "\e[5F\e[0J";
                     fi;

                     while true; do
                        read -ep "$(tampilkan_menu "${gaya_warna[@]}")" input && history -s "$input";
                        input="${input,,}";

                        if ((input > 0)) && ((input < 95)); then
                           echo -en "Konfigurasi gaya warna \e[38;5;15;1m${gaya_warna[input]}\e[0m \e[33m...\e[0m";
                           cp "$nama_direktori/assets/colors/${gaya_warna[input]}.properties" ~/.termux/colors.properties && termux-reload-settings;
                           echo -en "\e[3D\e[0K\e[38;5;46;1mSelesai\e[0m";
                           sleep 1;
                           clear;
                        elif ((input == 95)) || [[ "kembali" == "${input:-kosong}"* ]]; then
                           clear;
                           tampilkan_logo && echo;
                           break;
                        else
                           clear;
                        fi;
                     done;
                  elif [ "$input" == 2 ] || [[ "${mentahan_menu_kostumisasi[2]}" == "${input:-kosong}"* ]] || [ "$input" == 02 ]; then
                     local fon_teks=("\e[1m***\e[0m \e[34;1mFON TEKS\e[0m \e[1m***\e[0m" $(basename -s .ttf "$nama_direktori/assets/fonts/"*.ttf) "\e[34;1mK\e[0membali");

                     if $bersihkan_menu_3; then
                        echo -en "\e[11F\e[0J";
                        bersihkan_menu_3=false;
                     else
                        echo -en "\e[5F\e[0J";
                     fi;

                     while true; do
                        read -ep "$(tampilkan_menu "${fon_teks[@]}")" input && history -s "$input";
                        input="${input,,}";

                        if ((input > 0)) && ((input < 25)); then
                           echo -en "Konfigurasi fon teks \e[38;5;15;1m${fon_teks[input]}\e[0m \e[33m...\e[0m";
                           cp "$nama_direktori/assets/fonts/${fon_teks[input]}.ttf" ~/.termux/font.ttf && termux-reload-settings;
                           echo -en "\e[3D\e[0K\e[38;5;46;1mSelesai\e[0m";
                           sleep 1;
                           echo -en "\e[16F\e[0J";
                        elif ((input == 25 )) || [[ "kembali" == "${input:-kosong}"* ]]; then
                           echo -en "\e[16F\e[0J";
                           tampilkan_logo && echo;
                           break;
                        else
                           echo -en "\e[16F\e[0J";
                        fi;
                     done;
                  elif [ "$input" == 3 ] || [[ "${mentahan_menu_kostumisasi[3]}" == "${input:-kosong}"* ]] || [ "$input" == 03 ]; then
                     if $bersihkan_menu_3; then
                        echo -en "\e[11F\e[0J";
                        bersihkan_menu_3=false;
                     else
                        echo -en "\e[5F\e[0J";
                     fi;

                     bersihkan_menu_3=true;
                     echo -e "\e[1m***\e[0m \e[34;1mBANTUAN\e[0m \e[1m***\e[0m";
                     printf "    • %-34b    %b\n"   "\e[38;5;15;1mGaya warna\e[0m" "\e[91;1mKostumisasi gaya warna tampilan Termux.\e[0m";
                     printf "    • %-34b    %b\n"   "\e[38;5;15;1mFon teks\e[0m"   "\e[91;1mKostumisasi bentuk fon teks Termux.\e[0m";
                     printf "    • %-34b    %b\n"   "\e[38;5;15;1mBantuan\e[0m"    "\e[91;1mMemunculkan ini.\e[0m";
                     printf "    • %-34b    %b\n\n" "\e[38;5;15;1mKembali\e[0m"      "\e[91;1mKembali ke menu sebelumnya.\e[0m";
                  elif [ "$input" == 4 ] || [[ "${mentahan_menu_kostumisasi[4]}" == "${input:-kosong}"* ]] || [ "$input" == 04 ]; then
                     if $bersihkan_menu_3; then
                        echo -en "\e[11F\e[0J";
                        bersihkan_menu_3=false;
                     else
                        echo -en "\e[5F\e[0J";
                     fi;
                     break;
                  else
                     echo -en "\e[5F\e[0J";
                  fi;
               else
                  echo -en "\e[4F\e[0J";
               fi;
            done;
         elif [ "$input" == 2 ] || [[ "${mentahan_menu[2]}" == "${input:-kosong}"* ]] || [ "$input" == 02 ]; then
            if $bersihkan_menu_3; then
               echo -en "\e[11F\e[0J";
               bersihkan_menu_3=false;
            elif $bersihkan_menu_2; then
               echo -en "\e[8F\e[0J";
            else
               echo -en "\e[5F\e[0J";
            fi;

            bersihkan_menu_2=true;
            echo -e "\e[1m***\e[0m \e[34;1mINSTAL SKRIP\e[0m \e[1m***\e[0m";
            echo -e "    MENU INI MASIH DALAM PENGEMBANGAN ^_\n";
         elif [ "$input" == 3 ] || [[ "${mentahan_menu[3]}" == "${input:-kosong}"* ]] || [ "$input" == 03 ]; then
            if $bersihkan_menu_3; then
               echo -en "\e[11F\e[0J";
            elif $bersihkan_menu_2; then
               echo -en "\e[8F\e[0J";
               bersihkan_menu_2=false;
            else
               echo -en "\e[5F\e[0J";
            fi;

            bersihkan_menu_3=true;
            echo -e "\e[1m***\e[0m \e[34;1mBANTUAN\e[0m \e[1m***\e[0m";
            printf "    • %-34b    %b\n"   "\e[38;5;15;1mKostumisasi Termux\e[0m" "\e[91;1mKostumisasi warna dan fon teks Termux.\e[0m";
            printf "    • %-34b    %b\n"   "\e[38;5;15;1mInstal skrip\e[0m"       "\e[91;1mInstal skrip-skrip keren.\e[0m";
            printf "    • %-34b    %b\n"   "\e[38;5;15;1mBantuan\e[0m"            "\e[91;1mMemunculkan ini.\e[0m";
            printf "    • %-34b    %b\n\n" "\e[38;5;15;1mEksit\e[0m"              "\e[91;1mBerhenti dan keluar dari program.\e[0m";
         elif [ "$input" == 4 ] || [[ "${mentahan_menu[4]}" == "${input:-kosong}"* ]] || [ "$input" == 04 ]; then
            break;
         else
            echo -en "\e[5F\e[0J";
         fi;
      else
         echo -en "\e[4F\e[0J";
      fi;
   done;
}

main;
