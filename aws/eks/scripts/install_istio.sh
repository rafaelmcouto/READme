echo "#########################################################################################"
echo "#                       Starting Installing ISTIO                                       #"
echo "#########################################################################################"

SHOULD_RUN=${INSTALL_ISTIO};

if [[ $SHOULD_RUN -eq 1 ]]; then 
  NAMESPACE=${ISTIO_NAMESPACE}
  FILTER_NAMESPACE=$(kubectl get namespace | awk -v target=$NAMESPACE 'FNR > 1  {if ($1 == target) print $1}');

  if [[ -z "$FILTER_NAMESPACE" ]]; then
    kubectl create namespace $NAMESPACE;
  fi

  SUBNETS=${ISTIO_SUBNETS};
  

  echo "===========>  Downloading Istio"
  curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.10.2 sh -
  cd istio*/bin

  echo "===> Istio - Configuring Istio with istio-ingressgateway as NodePort"
  istioctl manifest apply -y --set values.gateways.istio-ingressgateway.type=NodePort

  echo "===> Istio - Configuring ingress with ALB using aws load balancer controller"
  ingressYaml=$(cat <<-K8S_YML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: istio-system
  name: ingress
  labels:
    app: ingress
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internal
    alb.ingress.kubernetes.io/subnets: $SUBNETS
    alb.ingress.kubernetes.io/load-balancer-name: istio-alb-${CLUSTER_NAME}
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port
    alb.ingress.kubernetes.io/healthcheck-path: /istio-ingressgateway.istio-system/healthz/ready
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: istio-ingressgateway
            port:
              number: 80
K8S_YML
)
  echo "$ingressYaml" | kubectl apply -f -

  istioHealthcheckYaml=$(cat <<-K8S_YML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: gateway-istio-healthcheck
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - "*"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: vs-istio-healthcheck
  namespace: istio-system
spec:
  hosts:
    - "*"
  gateways:
    - gateway-istio-healthcheck
  http:
    - match:
        - uri:
            prefix: '/istio-ingressgateway.istio-system/'
      rewrite:
        uri: "/"
      route:
        - destination:
            host: istio-ingressgateway.istio-system.svc.cluster.local
            port:
              number: 15021
K8S_YML
)
  echo "$istioHealthcheckYaml" | kubectl apply -f -
  
  echo "===========>  Finished Istio"
else
  echo "Should Not Install ISTIO"
fi

echo "#########################################################################################"
echo "#                     FINISHING Installing ISTIO                                        #"
echo "#########################################################################################"