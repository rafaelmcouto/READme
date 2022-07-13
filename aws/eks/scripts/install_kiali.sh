echo "#########################################################################################"
echo "#                            Starting Installing KIALI                                  #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_KIALI};

if [[ $SHOULD_RUN -eq 1 ]]; then 
  NAMESPACE=${KIALI_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi

  echo "===========>  Configuring KIALI"
  echo ${KIALI_VALUES} | base64 --decode > ./kiali.yaml
  kubectl apply -f ./kiali.yaml
  
  echo "===========>  Finished KIALI"
else
  echo "Should Not Install KIALI"
fi

echo "#########################################################################################"
echo "#                          FINISHING Installing KIALI                                   #"
echo "#########################################################################################"