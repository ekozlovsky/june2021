#!/bin/bash
  
POD=$(kubectl get pod -l tier=mysql -o jsonpath=\"{.items[0].metadata.name}\")
echo ${POD} | sed -e 's/^"//' -e 's/"$//'

OUTPUT=$(kubectl exec  $(echo ${POD} |sed -e 's/^"//' -e 's/"$//') --  echo ${MYSQL_ROOT_PASSWORD} )
echo ${OUTPUT}

kubectl exec $(echo ${POD} |sed -e 's/^"//' -e 's/"$//' ) --  mysqldump -uredmine -pemptypassword  redmine > redmine-dump$(date +"%F").sql
