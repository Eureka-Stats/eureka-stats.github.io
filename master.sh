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
## So here is a few thousand lines of AWK code duct-taped together to make a webpage
## I am sorry in adance to anyone trying to follow this

apikey="31d98d791aa06ce083fdd71939a83cb1"
report=$(tail -1 ingest | awk -F,  '{ print $1 }')
dc=$(tail -1 ingest | awk -F,  '{ print $2 }')


mkdir -p ./reports/$report/{finals,trash} &&


if [ ! -f ./reports/$report/fights.json ]; then
	echo "No Fights found, downloading now"
	wget "https://www.fflogs.com:443/v1/report/fights/$report?api_key=$apikey" -O ./reports/$report/fights.json
	echo "Encounters downloaded. Moving on"

else
	echo "Encounters already downloaded. Moving on"
fi

if [ ! -f ./reports/$report/fightscleaned.csv ]; then
        jq -r '.fights | map(.name), map(.start_time), map(.end_time) | @csv' ./reports/$report/fights.json  | csvtool transpose - > ./reports/$report/fightscleaned.csv
        echo "Encounters cleaned"

else
        echo "Encounters already cleaned. Moving on"
fi

avkilltime=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./reports/$report/fightscleaned.csv |  awk -F , '$1 == "Absolute Virtue" { printf $4}')
ozmakilltime=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./reports/$report/fightscleaned.csv |  awk -F , '$1 == "Proto Ozma" { printf  $4}')

avkilltimerounded=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./reports/$report/fightscleaned.csv |  awk -F , '$1 == "Absolute Virtue" { printf ( "%3.0f\n", $4 ) }')
ozmakilltimerounded=$(awk -F, -v OFS="," '{$4=($3-$2)/1000}1' ./reports/$report/fightscleaned.csv |  awk -F , '$1 == "Proto Ozma" { printf ( "%3.0f\n", $4 ) }')

avkillband=$(awk -F , '$1 == "Absolute Virtue" {print "start="$2"&end="$3}' ./reports/$report/fightscleaned.csv)
ozmakillband=$(awk -F , '$1 == "Proto Ozma" {print "start="$2"&end="$3}' ./reports/$report/fightscleaned.csv)


starttime=$(head -1 ./reports/$report/fightscleaned.csv | awk -F,  '{ print $2 }')
endtime=$(tail -1 ./reports/$report/fightscleaned.csv | awk -F,  '{ print $3 }')


## Check to see if enemies actually died for stats
if [ ! -f ./reports/$report/enemydeaths.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/deaths/$report?start=$starttime&end=$endtime&hostility=1&api_key=$apikey" -O ./reports/$report/enemydeaths.json
        echo "Enemy Deaths Download"

else
        echo "Enemy Deaths already Downloaded. Moving on"
fi

if grep -q 'Absolute Virtue' "./reports/$report/enemydeaths.json"; then
	avdead="Yes"
	echo "AV Death was found"
else
	avdead="No"
	echo "AV Death not found"
fi

if grep -q 'Proto Ozma' "./reports/$report/enemydeaths.json"; then
	ozmadead="Yes"       
 	echo "Ozma death was found"
else
        ozmadead="No"
	echo "Ozma Death not found"
fi

if grep -q 'Skatene' "./reports/$report/enemydeaths.json"; then
	skatenedead="Yes"
        echo "Skatene Death was found"
else
	skatenedead="No"
        echo "Skatene Death not found"
fi


# Grab Damage done for AV
if [ ! -f ./reports/$report/avdamage.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/damage-done/$report?$avkillband&api_key=$apikey" -O ./reports/$report/avdamage.json
        echo "AV Damage Downloaded"

else
        echo "AV Damage already Downloaded. Moving on"
fi

if [ ! -f ./reports/$report/avdamage.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./reports/$report/avdamage.json  |
        sort -t, -nrk3 |
        awk -v d="$avkilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
        awk -v d="$avkilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'|
        awk -v d="$avdead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./reports/$report/avdamage.csv                                                                                                                                                                                                                      
        echo "AV Damage Cleaned"

else
        echo "AV Damage already Cleaned. Moving on"
fi


# Grab healing done for AV
if [ ! -f ./reports/$report/avhealing.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/healing/$report?$avkillband&api_key=$apikey" -O ./reports/$report/avhealing.json 
	echo "AV Healing Downloaded"

else
        echo "AV Healing already Downloaded. Moving on"
fi

if [ ! -f ./reports/$report/avhealing.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./reports/$report/avhealing.json  |
        sort -t, -nrk3 |
 	awk -v d="$avkilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
	awk -v d="$avkilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'| 
        awk -v d="$avdead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' | 
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./reports/$report/avhealing.csv
	
        echo "AV Healing Cleaned"

else
        echo "AV Healing already Cleaned. Moving on"
fi


# Grab Damage done for Ozma
if [ ! -f ./reports/$report/ozmadamage.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/damage-done/$report?$ozmakillband&api_key=$apikey" -O ./reports/$report/ozmadamage.json
        echo "Ozma Damage Downloaded"

else
        echo "Ozma Damage already Downloaded. Moving on"
fi

if [ ! -f ./reports/$report/ozmadamage.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./reports/$report/ozmadamage.json  |
        sort -t, -nrk3 |
        awk -v d="$ozmakilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
        awk -v d="$ozmakilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'|
        awk -v d="$ozmadead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./reports/$report/ozmadamage.csv
        echo "Ozma Damage Cleaned"

else
        echo "Ozma Damage already Cleaned. Moving on"
fi


# Grab healing done for Ozma
if [ ! -f ./reports/$report/ozmahealing.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/healing/$report?$ozmakillband&api_key=$apikey" -O ./reports/$report/ozmahealing.json
        echo "Ozma Healing Downloaded"

else
        echo "Ozma Healing already Downloaded. Moving on"
fi

if [ ! -f ./reports/$report/ozmahealing.csv ]; then
        jq -r '.entries[] | "\(.name),\(.type),\(.total)"' ./reports/$report/ozmahealing.json  |
        sort -t, -nrk3 |
        awk -v d="$ozmakilltimerounded" -F"," 'BEGIN { OFS = "," } {$4=d; print}' |
        awk -v d="$ozmakilltime" -F "," 'BEGIN { OFS = "," } {print $2, $1, $3/(d), $3, $4}'|
        awk -v d="$ozmadead" -F"," 'BEGIN { OFS = "," } {$6=d; print}' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$7=d; print}'  > ./reports/$report/ozmahealing.csv

        echo "Ozma Healing Cleaned"

else
        echo "Ozma Healing already Cleaned. Moving on"
fi


# Grab Ovni Multikills
if [ ! -f ./reports/$report/prey.json ]; then
        wget "https://www.fflogs.com:443/v1/report/tables/debuffs/$report?start=$starttime&end=$endtime&abilityid=1000562&api_key=$apikey" -O ./reports/$report/prey.json
	jq -r '.auras[] | "\(.name),start=\(.bands[].startTime)&end=\(.bands[].endTime)"' ./reports/$report/prey.json > ./reports/$report/prey.csv
        echo "Prey Markers Downloaded"

else
        echo "Prey Markers already Downloaded. Moving on"
fi

if [ ! -f ./reports/$report/finals/multikills.csv ]; then
 while read line; do
    deathtime=$(echo $line | cut -d, -f2)
    name=$(echo $line | cut -d, -f1)
 if [ ! -f ./reports/$report/"$name".json ]; then
    wget -q "https://www.fflogs.com:443/v1/report/tables/deaths/$report?$deathtime&by=source&abilityid=14788&difficulty=0&api_key=$apikey" -O ./reports/$report/"$name".json
    kills=$(jq -r '.entries[] | "\(.name)"' ./reports/$report/"$name".json  | wc -l)
    echo $name,$kills >> ./reports/$report/multikills.csv
    sort -nrk2 -o ./reports/$report/multikills.csv{,}
 else
    kills=$(jq -r '.entries[] | "\(.name)"' ./reports/$report/"$name".json  | wc -l)
    echo $name,$kills >> ./reports/$report/finals/multikills.csv
	sort -nrk2 -o ./reports/$report/finals/multikills.csv{,}
 fi
 done < ./reports/$report/prey.csv
else
        echo "Ozma Multikills already Cleaned. Moving on"                                                                                                                                                                                                                                                                       fi
fi

# Start grabbing buffs
if [ ! -f ./reports/$report/sacrifices.json ]; then
	wget "https://www.fflogs.com:443/v1/report/tables/buffs/$report?start=$starttime&end=$endtime&abilityid=1001743&api_key=$apikey" -O ./reports/$report/sacrifices.json
        echo "Buffs: Sacrifices Downloaded"

else
        echo "Buffs: Sacrifices already Downloaded. Moving on"
fi

if [ ! -f ./reports/$report/sacrifices.csv ]; then
        jq -r '.auras[] | "\(.type),\(.name),\(.totalUses)"' ./reports/$report/sacrifices.json  |
        sort -t, -nrk3 |
	tr -d '"' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$4=d; print}'  > ./reports/$report/sacrifices.csv

        echo "Buffs: Sacrifices Cleaned"

else
        echo "Buffs: Sacrifices already Cleaned. Moving on"
fi



# Test scripting buffs
while read line; do
    abilityid=$(echo $line)
if [ ! -f ./reports/$report/trash/$abilityid.json ]; then
    wget -q "https://www.fflogs.com:443/v1/report/tables/buffs/$report?start=$starttime&end=$endtime&by=target&abilityid=$abilityid&api_key=$apikey" -O ./reports/$report/trash/$abilityid.json
else
	echo "Ability already downloaded!"
fi

if [ ! -f ./reports/$report/finals/$abilityid.csv ]; then               
	jq '.auras[] | "\(.name),\(.totalUses)"' ./reports/$report/trash/$abilityid.json |
	tr -d '"' |
	awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$3=d; print}' > ./reports/$report/finals/$abilityid.csv &&
	sort -t, -nrk2 -o ./reports/$report/finals/$abilityid.csv{,}
else
        echo "Ability already cleaned!"
fi
done < ./buffs.csv

# Test scripting debuffs
while read line; do
    abilityid=$(echo $line)
if [ ! -f ./reports/$report/trash/$abilityid.json ]; then
    wget -q "https://www.fflogs.com:443/v1/report/tables/debuffs/$report?start=$starttime&end=$endtime&by=target&abilityid=$abilityid&api_key=$apikey" -O ./reports/$report/trash/$abilityid.json
else
        echo "Debuff already downloaded!"
fi

if [ ! -f ./reports/$report/finals/$abilityid.csv ]; then
        jq '.auras[] | "\(.name),\(.totalUses)"' ./reports/$report/trash/$abilityid.json |
        tr -d '"' |
        awk -v d="$report" -F"," 'BEGIN { OFS = "," } {$3=d; print}' > ./reports/$report/finals/$abilityid.csv &&
        sort -t, -nrk2 -o ./reports/$report/finals/$abilityid.csv{,}
else
        echo "Debuffs already cleaned!"
fi
done < ./debuffs.csv
