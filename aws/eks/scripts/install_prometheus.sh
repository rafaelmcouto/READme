echo "#########################################################################################"
echo "#                       Starting Installing PROMETHEUS                                  #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_PROMETHEUS};

if [[ $SHOULD_RUN -eq 1 ]]; then 
  NAMESPACE=${PROMETHEUS_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi

  echo "===========>  Configuring Prometheus"
  echo ${PROMETHEUS_VALUES} | base64 --decode > ./prometheus.yaml
  kubectl apply -f ./prometheus.yaml
  
  echo "===========>  Finished PROMETHEUS"
else
  echo "Should Not Install PROMETHEUS"
fi

echo "#########################################################################################"
echo "#                     FINISHING Installing PROMETHEUS                                   #"
echo "#########################################################################################"