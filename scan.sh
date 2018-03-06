#!/bin/bash
# Initialize vars
verdict='SAFE'
logfile='/output.json'
url=$1
aggressive=$2

touch $logfile

# Run WPScan and pass params to it
if [ "$aggressive" = "true" ];
then
  wpscan \
    --url $url \
    # --output $logfile \
    --format json \
    --ignore-main-redirect \
    --update \
    --detection-mode=aggressive
else
  wpscan \
    --url $url \
    # --output $logfile \
    --format json \
    --ignore-main-redirect \
    --update \
    --stealthy
fi

# log.txt is the default output filename when using --log. Something different can be specified also.
# Alternative curl command if the first site goes away or gives trouble:
# curl -s https://vulners.com/api/v3/search/id/?id=CVE-2017-14722 | grep -m 1 "score" | awk '{print $2}'| sed 's/,//g'

# grep "cvename.cgi?name=" $logfile | while IFS='=' read trash cve; do
#   echo " "
#   echo Checking CVSS score for "$cve"
#   score=`curl -s http://cve.circl.lu/api/cve/$cve | grep "\"cvss\":" | awk '{print $2}' | sed 's/"//g' | sed 's/,//g'`
#   echo CVSS Score: "$score"

#   if (( $(echo "$score > 6.9" | bc -l) ))
#   then
#     verdict="VULNERABLE"
#     echo Result is $verdict! Exiting...
#     echo " "
#     echo Final Scan result: $verdict
#     exit 1
#   else
#     echo Result is $verdict - moving on...
#     echo " "
#   fi
# done
