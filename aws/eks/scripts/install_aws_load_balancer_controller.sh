echo "#########################################################################################"
echo "#                Starting Installing AWS LOAD BALANCER CONTROLLER                       #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_AWS_LOAD_BALANCER_CONTROLLER};

if [[ $SHOULD_RUN -eq 1 ]]; then 
  NAMESPACE="kube-system"
  SERVICE_ACCOUNT_NAME="aws-load-balancer-controller"
  echo "===========>  Configuring AWS LOAD BALANCER CONTROLLER"
  echo "===> AWS LOAD BALANCER CONTROLLER - Downloading eksctl"
  curl --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  echo "===> AWS LOAD BALANCER CONTROLLER - Configuring service account '$SERVICE_ACCOUNT_NAME' on Kubernetes"
  /tmp/eksctl create iamserviceaccount \
    --cluster="${CLUSTER_NAME}" \
    --namespace=$NAMESPACE \
    --name=$SERVICE_ACCOUNT_NAME \
    --region=${REGION} \
    --attach-policy-arn="${ARN_AWS_LOAD_BALANCER_CONTROLLER_POLICY}" \
    --override-existing-serviceaccounts \
    --approve
  
  helm repo add eks https://aws.github.io/eks-charts

  echo "===> AWS LOAD BALANCER CONTROLLER - Adding custom resource definitions to AWS LOAD BALANCER CONTROLLER"
  kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

  echo "===> AWS LOAD BALANCER CONTROLLER - installing helm chart eks/aws-load-balancer-controller"
  helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n $NAMESPACE \
    --set clusterName="${CLUSTER_NAME}" \
    --set serviceAccount.create=false \
    --set serviceAccount.name=$SERVICE_ACCOUNT_NAME \
    --set image.repository="${EKS_REPO_ADD_ONS}/amazon/aws-load-balancer-controller"
  
  echo "===========>  Finished AWS LOAD BALANCER CONTROLLER"
else
  echo "Should Not Install AWS LOAD BALANCER CONTROLLER"
fi

echo "#########################################################################################"
echo "#              FINISHING Installing AWS LOAD BALANCER CONTROLLER                        #"
echo "#########################################################################################"