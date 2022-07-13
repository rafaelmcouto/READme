echo "#########################################################################################"
echo "#                          Starting Installing GRAFANA                                  #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_GRAFANA};

if [[ $SHOULD_RUN -eq 1 ]]; then 
  NAMESPACE=${GRAFANA_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi

  echo "===========>  Configuring GRAFANA"
  echo ${GRAFANA_VALUES} | base64 --decode > ./grafana.yaml
  kubectl apply -f ./grafana.yaml
  
  echo "===========>  Finished GRAFANA"
else
  echo "Should Not Install GRAFANA"
fi

echo "#########################################################################################"
echo "#                        FINISHING Installing GRAFANA                                   #"
echo "#########################################################################################"