echo "#########################################################################################"
echo "#                           Starting Installing JAEGER                                  #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_JAEGER};

if [[ $SHOULD_RUN -eq 1 ]]; then 
  NAMESPACE=${JAEGER_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi

  echo "===========>  Configuring JAEGER"
  echo ${JAEGER_VALUES} | base64 --decode > ./jaeger.yaml
  kubectl apply -f ./jaeger.yaml
  
  echo "===========>  Finished JAEGER"
else
  echo "Should Not Install JAEGER"
fi

echo "#########################################################################################"
echo "#                         FINISHING Installing JAEGER                                   #"
echo "#########################################################################################"