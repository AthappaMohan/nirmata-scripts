#!/bin/bash
CLUSTER_NAME=<cluster-name>  #Enter cluster name
ENVIRONMENT=<Environment>    #sandbox or dev or Production
FILE_DATE=$(date -r /opt/nirmata/ssl/kubelet.crt "+%Y-%m-%d")
CURRENT_DATE=$(date "+%Y-%m-%d")
DATE_DIFF=$(( ($(date -d "$CURRENT_DATE" +%s) - $(date -d "$FILE_DATE" +%s)) / (60*60*24) ))
echo "The number of days when the certificate is created: $DATE_DIFF"
YEAR=365
CERT_DIFF=$DATE_DIFF
#Number of days left to expire
let "DAYS_LEFT=$YEAR-$CERT_DIFF"
echo "Number of days left to expire: $DAYS_LEFT"
# Number of days in the warning threshhold
WARNDAYS=30
if [ "${DAYS_LEFT}" -le "${WARNDAYS}" ]; then
   #     echo "The cert will expire soon!"
        echo '"Hi, k8s certs is going to expire soon on cluster named '$CLUSTER_NAME' in '$ENVIRONMENT' Environment"' | mail -r "Nirmata" -s "k8s certs will be expire soon :  '$ENVIRONMENT'" "<Receiver-Email>" # Action if true
else
        echo "Looks good till now!"
fi
