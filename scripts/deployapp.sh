cd kubernetes
kubectl apply -f backend.yaml
kubectl apply -f frontend.yaml
kubectl apply -f ./nginx/service.yaml
kubectl apply -f ./nginx/deployment.yaml
kubectl apply -f ./nginx/configmap.yaml
#kubectl delete -f frontend.yaml backend.yaml
#kubectl delete -f ./nginx/service.yaml -f ./nginx/deployment.yaml -f ./nginx/configmap.yaml