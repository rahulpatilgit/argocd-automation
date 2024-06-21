aws eks update-kubeconfig --name my-cluster
kubectl create namespace argocd        
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml        
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'        
while [[ `kubectl get svc argocd-server -n argocd | awk '{print $4}' | tail -1` != *"elb.amazonaws.com"* ]]; do
    sleep 10
done
ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd | awk '{print $4}' | tail -1`
export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`        
echo $ARGOCD_SERVER
echo $ARGO_PWD
