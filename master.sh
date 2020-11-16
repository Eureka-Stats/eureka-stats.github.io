#!/bin/bash
#
#
#
#                                                                         +-----------------+
#                                                                      	 |"Always has been"|
#                                                                         +-----------------+
#                                                                                
#                                                                                 -/osyyso/.
#                   .....                                                      .+hddddddddhho`
#              -:/:///yo:::/-.                                                .---:sddddddhhho
#            -+o/////:/:--:/o//-                                             .     `hyyyshhhhs
#          .:ss+/////::------+:/:.      +---------------------+              .     `    `:ohdddhhhhy+
#         .-+s/::/:-....---.-:o/+/.     |"Wait, it's all AWK?"|              .     .  `/syhssddddhhy/
#        `--++::+:.....--...-///o++`    +---------------------+              .    `./osdhoyysssso/:-`
#        .---/+:::-....-....-::///+.                                          :/hhysyohddhhyhhyo//::.
#        .-----::::::----....-::-:+.                                          -s+ohdddddddddhhy/..:hy
#        `------:/:::///----..-..-+`           .::::.                          .+yhdddhhhhhhhhhh./ohd
#         .-----:/:--::://-..---.::           :ydddhhoo      .-/+oys.         -syyhdd+o+ssoyhy:yydddd
#          .-----:/+//+o+:...--...           : -hhhhyoh     `o+++sosho.-----:/yhhhyhdyhddddddhso+yddd
#           `------o::+/---.---.             `-ohhhhyy:      ` ``/+oyhhyddddddyhhddhddddddddddy:+yddd
#             `..--+//-...--.`                .hosyso/-       ```/o::+osyhhhhdyhhhhhdddddddddhy/yyddd
#                 ``.....``                  -yhhhyyo+//-            ````..-+hyhhhhhdhdddhhhhyy/+yddd
#                                           -dhhhho//+ohh/          `````  -syhhdddhyhhdhhdddyy++dddd
#                                          .hhyhyo://+ddhy.          ````  `ohhyhddhyhhhhhhhhhh++hddd
#                                          +ddddho--//ddho`          `` `   sdddhhddhddddddddddy`sddd
#                                          shhhhs:.-:/ddh+                  oddddddhhddddddddhy/ /ddd
#                                          ydhhho....:ddh:                  +ddddddhddddddddddy` -ddd
#                                          hddhs-``` :dhy-                  /dddddh+shhdddddhho``.hdd
#                                         yddhs/-`` `-dhy.                 `:ddhdddyhdddddddhh/`` ohh
#                                        odhhs/h.`.```+/.                   .dhhdddddddddhhhys/.``.sy
#                                        hdsosd+```````/                     ohhhhhhdddhddhhsy/..```s
#                                      .hddsddho```````/                      ohyhdhhhhdhyys--```-``h
#
#
#
## A sane person would have just learned how to actually work with json objects  
## But a sane person also wouldn't still be doing Eureka content
## So here is a few hundred lines of AWK code duct-taped together to make a webpage
## I am sorry in adance to anyone trying to follow this

apikey="31d98d791aa06ce083fdd71939a83cb1"
report=$(tail -1 ingest | awk -F,  '{ print $1 }')
dc=$(tail -1 ingest | awk -F,  '{ print $2 }')
reportday=$(date -d $(tail -1 ingest | awk -F,  '{ print $3 }') +%F )


mkdir -p ./_data/reports/$report/{finals/{debuffs,casts},trash} &&


if [ ! -f ./_data/reports/$report/trash/fights.json ]; then
	echo "No Fights found, downloading now"
	wget "https://www.fflogs.com:443/v1/report/fights/$report?api_key=$apikey" -O ./_data/reports/$report/trash/fights.json
	echo "Encounters downloaded. Moving on"

else
	echo "Encounters already downloaded. Moving on"
fi

if [ ! -f ./_data/reports/$report/finals/fightscleaned.csv ]; then
        jq -r '.fights | map(.name), map(.start_time), map(.end_time) | @csv' ./_data/reports/$report/trash/fights.json  | csvtool transpose - > ./_data/reports/$report/finals/fightscleaned.csv
	cat ./_data/reports/$report/finals/fightscleaned.csv
        echo "Encounters cleaned"

else
        echo "Encounters already cleaned. Moving on"
fi

avkilltime=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./_data/reports/$report/finals/fightscleaned.csv |  awk -F , '$1 == "Absolute Virtue" { printf $4}' | tail -1)
ozmakilltime=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./_data/reports/$report/finals/fightscleaned.csv |  awk -F , '$1 == "Proto Ozma" { printf  $4}' | tail -1)

avkilltimerounded=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./_data/reports/$report/finals/fightscleaned.csv |  awk -F , '$1 == "Absolute Virtue" { printf ( "%3.0f\n", $4 ) }' | tail -1)
ozmakilltimerounded=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./_data/reports/$report/finals/fightscleaned.csv |  awk -F , '$1 == "Proto Ozma" { printf ( "%3.0f\n", $4 ) }' | tail -1)

avkillband=$(awk -F , '$1 == "Absolute Virtue" {print "start="$2"&end="$3}' ./_data/reports/$report/finals/fightscleaned.csv | tail -1)
ozmakillband=$(awk -F , '$1 == "Proto Ozma" {print "start="$2"&end="$3}' ./_data/reports/$report/finals/fightscleaned.csv | tail -1)


starttime=$(if grep -Fq "Ovni" ./_data/reports/$report/finals/fightscleaned.csv;then awk -F , '$1 == "Ovni" { printf ( "%3.0f\n", $2 ) }' ./_data/reports/$report/finals/fightscleaned.csv | tail -1;else awk -F,  '{ print $2 }' ./_data/reports/$report/finals/fightscleaned.csv | head -1; fi
)
endtime=$(tail -1 ./_data/reports/$report/finals/fightscleaned.csv | awk -F,  '{ print $3 }')


## Check to see if enemies actually died for stats
if [ ! -f ./_data/reports/$report/trash/enemydeaths.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/deaths/$report?start=$starttime&end=$endtime&hostility=1&api_key=$apikey" -O ./_data/reports/$report/trash/enemydeaths.json
        echo "Enemy Deaths Downloaded"

else
        echo "Enemy Deaths already Downloaded. Moving on"
fi

if grep -q 'Absolute Virtue' "./_data/reports/$report/trash/enemydeaths.json"; then
	avdead="Yes"
	echo "AV was killed"
else
	avdead="No"
	echo "AV was killed"
fi

if grep -q 'Proto Ozma' "./_data/reports/$report/trash/enemydeaths.json"; then
	ozmadead="Yes"       
 	echo "Ozma was killed"
else
        ozmadead="No"
	echo "Ozma was not killed"
fi

if grep -q 'Skatene' "./_data/reports/$report/trash/enemydeaths.json"; then
	skatenedead="Yes"
        echo "Skatenes were killed :("
else
	skatenedead="No"
        echo "Skatenes were not killed"
fi


# Grab Damage done for AV
if [ ! -f ./_data/reports/$report/trash/avdamage.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/damage-done/$report?$avkillband&api_key=$apikey" -O ./_data/reports/$report/trash/avdamage.json
        echo "AV Damage Downloaded"

else
        echo "AV Damage already Downloaded. Moving on"
fi

if [ ! -f ./_data/reports/$report/finals/avdamage.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./_data/reports/$report/trash/avdamage.json  |
        sort -t, -nrk3 |
        awk -v d="$avkilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
        awk -v d="$avkilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'|
        awk -v d="$avdead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' |
	awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./_data/reports/$report/trash/avdamage.csv &&
	sed -i 's/RedMage/Red Mage/g;s/WhiteMage/White Mage/g;s/BlackMage/Black Mage/g;s/DarkKnight/Dark Knight/g;s/BlueMage/Blue Mage/g;/LimitBreak/d;/GroundEffect/d' ./_data/reports/$report/trash/avdamage.csv 
	awk -v d="$(cat ./_data/reports/$report/trash/avdamage.csv  | wc -l)" -F"," 'BEGIN { OFS = "," } {$8=d; print}' ./_data/reports/$report/trash/avdamage.csv  > ./_data/reports/$report/finals/avdamage.csv &&
	                                                                                                                                                                                                                     
        echo "AV Damage Cleaned"
	cat ./_data/reports/$report/finals/avdamage.csv

else
        echo "AV Damage already cleaned. Moving on"
fi


# Grab healing done for AV
if [ ! -f ./_data/reports/$report/trash/avhealing.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/healing/$report?$avkillband&api_key=$apikey" -O ./_data/reports/$report/trash/avhealing.json 
	echo "AV Healing Downloaded"

else
        echo "AV Healing already Downloaded. Moving on"
fi

if [ ! -f ./_data/reports/$report/finals/avhealing.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./_data/reports/$report/trash/avhealing.json  |
        sort -t, -nrk3 |
 	awk -v d="$avkilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
	awk -v d="$avkilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'| 
        awk -v d="$avdead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' | 
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./_data/reports/$report/finals/avhealing.csv
	
        echo "AV Healing Cleaned"
	cat ./_data/reports/$report/finals/avhealing.csv

else
        echo "AV Healing already cleaned. Moving on"
fi


# Grab Damage done for Ozma
if [ ! -f ./_data/reports/$report/trash/ozmadamage.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/damage-done/$report?$ozmakillband&api_key=$apikey" -O ./_data/reports/$report/trash/ozmadamage.json
        echo "Ozma Damage Downloaded"

else
        echo "Ozma Damage already Downloaded. Moving on"
fi

if [ ! -f ./_data/reports/$report/finals/ozmadamage.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./_data/reports/$report/trash/ozmadamage.json  |
        sort -t, -nrk3 |
        awk -v d="$ozmakilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
        awk -v d="$ozmakilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'|
        awk -v d="$ozmadead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./_data/reports/$report/finals/ozmadamage.csv
        echo "Ozma Damage Cleaned"
	cat ./_data/reports/$report/finals/ozmadamage.csv

else
        echo "Ozma Damage already cleaned. Moving on"
fi


# Grab healing done for Ozma
if [ ! -f ./_data/reports/$report/trash/ozmahealing.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/healing/$report?$ozmakillband&api_key=$apikey" -O ./_data/reports/$report/trash/ozmahealing.json
        echo "Ozma Healing Downloaded"

else
        echo "Ozma Healing already Downloaded. Moving on"
fi

if [ ! -f ./_data/reports/$report/finals/ozmahealing.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./_data/reports/$report/trash/ozmahealing.json  |
        sort -t, -nrk3 |
        awk -v d="$ozmakilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
        awk -v d="$ozmakilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'|
        awk -v d="$ozmadead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./_data/reports/$report/finals/ozmahealing.csv

        echo "Ozma Healing Cleaned"
	cat ./_data/reports/$report/finals/ozmahealing.csv

else
        echo "Ozma Healing already cleaned. Moving on"
fi


# Grab Ovni Multikills
if [ ! -f ./_data/reports/$report/trash/prey.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/debuffs/$report?start=$starttime&end=$endtime&abilityid=1000149&api_key=$apikey" -O ./_data/reports/$report/trash/prey.json
	jq -r '.auras[] | "\(.name),start=\(.bands[].startTime)&end=\(.bands[].endTime)"' ./_data/reports/$report/trash/prey.json > ./_data/reports/$report/trash/prey.csv
        echo "Prey Markers Downloaded"
	cat ./_data/reports/$report/trash/prey.csv

else
        echo "Prey Markers already Downloaded. Moving on"
fi

if [ ! -f ./_data/reports/$report/finals/multikills.csv ]; then
 while read line; do
    deathtime=$(echo $line | cut -d, -f2)
    name=$(echo $line | cut -d, -f1)
 if [ ! -f ./_data/reports/$report/trash/"$name".json ]; then
    wget -q "https://www.fflogs.com:443/v1/report/tables/deaths/$report?$deathtime&by=source&abilityid=14788&difficulty=0&api_key=$apikey" -O ./_data/reports/$report/trash/"$name".json
    kills=$(jq -r '.entries[] | "\(.name)"' ./_data/reports/$report/trash/"$name".json  | wc -l)
    echo $name,$kills >> ./_data/reports/$report/finals/multikills.csv
    sort -nrk2 -o ./_data/reports/$report/finals/multikills.csv{,}
    cat ./_data/reports/$report/finals/multikills.csv
 else
    kills=$(jq -r '.entries[] | "\(.name)"' ./_data/reports/$report/trash/"$name".json  | wc -l)
    echo $name,$kills >> ./_data/reports/$report/finals/multikills.csv
	sort -nrk2 -o ./_data/reports/$report/finals/multikills.csv{,}
	cat ./_data/reports/$report/finals/multikills.csv
 fi
 done < ./_data/reports/$report/trash/prey.csv
else
        echo "Ozma Multikills already Cleaned. Moving on"                                                                                                                                                                                                                                                                    
fi


# Grab casts of interest
while read line; do
    abilityid=$(echo $line)
if [ ! -f ./_data/reports/$report/trash/$abilityid.json ]; then
    wget -q "https://www.fflogs.com:443/v1/report/tables/casts/$report?start=$starttime&end=$endtime&abilityid=$abilityid&api_key=$apikey" -O ./_data/reports/$report/trash/$abilityid.json
else
	echo "Ability already downloaded!"
fi

if [ ! -f ./_data/reports/$report/finals/casts/$abilityid.csv ]; then               
	jq '.entries[] | "\(.name),\(.total)"' ./_data/reports/$report/trash/$abilityid.json |
	tr -d '"' |
	awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$3=d; print}' > ./_data/reports/$report/finals/casts/$abilityid.csv &&
	sort -t, -nrk2 -o ./_data/reports/$report/finals/casts/$abilityid.csv{,}
	cat ./_data/reports/$report/finals/casts/$abilityid.csv
else
        echo "Ability already cleaned!"
fi
done < ./casts.csv

# Test scripting debuffs
while read line; do
    abilityid=$(echo $line)
if [ ! -f ./_data/reports/$report/trash/$abilityid.json ]; then
    wget -q "https://www.fflogs.com:443/v1/report/tables/debuffs/$report?start=$starttime&end=$endtime&abilityid=$abilityid&api_key=$apikey" -O ./_data/reports/$report/trash/$abilityid.json
else
        echo "Debuff already downloaded!"
fi

if [ ! -f ./_data/reports/$report/finals/debuffs/$abilityid.csv ]; then
        jq '.auras[] | "\(.name),\(.totalUses)"' ./_data/reports/$report/trash/$abilityid.json |
        tr -d '"' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$3=d; print}' > ./_data/reports/$report/finals/debuffs/$abilityid.csv &&
        sort -t, -nrk2 -o ./_data/reports/$report/finals/debuffs/$abilityid.csv{,}
	cat ./_data/reports/$report/finals/debuffs/$abilityid.csv
else
        echo "Debuffs already cleaned!"
fi
done < ./debuffs.csv
