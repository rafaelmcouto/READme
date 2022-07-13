echo "#########################################################################################"
echo "#                     Stating Installing KAFKA SCHEMA REGISTRY                          #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_SCHEMA_REGISTRY};

if [[ $SHOULD_RUN -eq 1 ]]; then
  NAMESPACE=${kAFKA_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi
  
  echo "===========>  COPYING CHART HELM SCHEMA REGISTRY"
  cp -r ${KAFKA_CHART_PATH}/cp-schema-registry/ ./cp-schema-registry
  echo "===========>  FINISHING COPYING"

  echo "===========>  KAFKA SCHEMA REGISTRY HELM VALUES"
  echo ${KAFKA_SCHEMA_REGISTRY_VALUES} | base64 --decode > ./cp-schema-registry-values.yaml
  helm install ${KAFKA_CHART_PATH}/cp-schema-registry --values=./cp-schema-registry-values.yaml --name-template cp-schema-registry -n $NAMESPACE

else 
  echo "Should Not Install Kafka Schema Registry"
fi

echo "#########################################################################################"
echo "#                    FINISHING Installing KAFKA SCHEMA REGISTRY                         #"
echo "#########################################################################################"