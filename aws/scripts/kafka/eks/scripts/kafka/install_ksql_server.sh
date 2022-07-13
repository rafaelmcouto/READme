echo "#########################################################################################"
echo "#                             Stating Installing KSQL SERVER                            #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_KSQL_SERVER};

if [[ $SHOULD_RUN -eq 1 ]]; then
  NAMESPACE=${kAFKA_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi
  
  echo "===========>  COPYING CHART HELM KSQL SERVER"
  cp -r ${KAFKA_CHART_PATH}/cp-ksql-server/ ./cp-ksql-server
  echo "===========>  FINISHING COPYING"

  echo "===========>  KAFKA CONNECT HELM VALUES"
  echo ${KSQL_SERVER_VALUES} | base64 --decode > ./cp-ksql-server-values.yaml
  helm install ${KAFKA_CHART_PATH}/cp-ksql-server --values=./cp-ksql-server-values.yaml --name-template cp-ksql-server -n $NAMESPACE

else 
  echo "Should Not Install KSql Server"
fi

echo "#########################################################################################"
echo "#                            FINISHING Installing KSQL SERVER                           #"
echo "#########################################################################################"