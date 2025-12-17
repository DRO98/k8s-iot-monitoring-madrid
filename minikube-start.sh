#!/bin/bash

# Activar entorno virtual (Linux)
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
else
    echo "Creando entorno virtual..."
    python3 -m venv venv
    source venv/bin/activate
fi

pip install -r requirements.txt
minikube start
minikube addons enable metrics-server
minikube addons enable ingress

# Aplicar namespaces
kubectl apply -f k8s/comun/namespace.yaml

# Aplicar PushGateway
kubectl apply -f k8s/castilla/push_gateway1.yaml
kubectl apply -f k8s/aravaca/push_gateway2.yaml

# Aplicar ConfigMaps de Prometheus
kubectl apply -f k8s/castilla/prometheus-configmap.yaml
kubectl apply -f k8s/aravaca/prometheus-configmap.yaml

# Aplicar Prometheus
kubectl apply -f k8s/castilla/prometheus.yaml
kubectl apply -f k8s/aravaca/prometheus.yaml

# Aplicar Ingress
kubectl apply -f k8s/castilla/ingress.yaml
kubectl apply -f k8s/aravaca/ingress.yaml

kubectl get pods -n castilla-p5
kubectl get pods -n aravaca-p5
kubectl get deployments -A
kubectl get services --all-namespaces
minikube dashboard &