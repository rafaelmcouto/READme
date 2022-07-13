echo "#########################################################################################"
echo "#                           Stating Installing KAFKA CONNECT                            #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_KAFKA_CONNECT};

if [[ $SHOULD_RUN -eq 1 ]]; then
  NAMESPACE=${kAFKA_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi
  
  echo "===========>  COPYING CHART HELM KAFKA CONNECT"
  cp -r ${KAFKA_CHART_PATH}/cp-kafka-connect/ ./cp-kafka-connect
  echo "===========>  FINISHING COPYING"

  echo "===========>  KAFKA CONNECT HELM VALUES"
  echo ${KAFKA_CONNECT_VALUES} | base64 --decode > ./cp-kafka-connect-values.yaml
  helm install ${KAFKA_CHART_PATH}/cp-kafka-connect --values=./cp-kafka-connect-values.yaml --name-template cp-kafka-connect -n $NAMESPACE

else 
  echo "Should Not Install Kafka Connect"
fi

echo "#########################################################################################"
echo "#                           FINISHING Installing KAFKA CONNECT                          #"
echo "#########################################################################################"