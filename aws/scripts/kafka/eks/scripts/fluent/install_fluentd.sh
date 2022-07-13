echo "#########################################################################################"
echo "#                              Stating Installing FLUENTD                               #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_FLUENTD};

if [[ $SHOULD_RUN -eq 1 ]]; then
  NAMESPACE=${FLUENTD_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi
  
  echo "===========>  COPYING CHART HELM FLUENTD"
  cp -r ${FLUENTD_CHART_PATH}/fluentd/ ./fluentd
  echo "===========>  FINISHING COPYING"

  echo "===========>  FLUENTD HELM VALUES"
  echo ${FLUENTD_VALUES} | base64 --decode > ./fluentd-values.yaml
  helm install ${FLUENTD_CHART_PATH}/fluentd --values=./fluentd-values.yaml --name-template fluentd -n $NAMESPACE

else 
  echo "Should Not Install Fluentd"
fi

echo "#########################################################################################"
echo "#                              FINISHING Installing FLUENTD                             #"
echo "#########################################################################################"