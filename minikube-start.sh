#!/bin/bash
.\venv\Scripts\Activate.ps1    
pip install -r requirements.txt
minikube start
minikube addons enable metrics-server
minikube addons enable ingress
kubectl apply -f k8s/comun/namespace.yaml  
kubectl apply -f .\k8s\castilla\push_gateway1.yaml  
kubectl apply -f .\k8s\aravaca\push_gateway2.yaml 
kubectl get pods -n castilla-p5   
kubectl get pods -n aravaca-p5
kubectl get deployments -A  
kubectl get services --all-namespaces
minikube dashboard &