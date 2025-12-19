# Activar entorno virtual (Windows)
if (Test-Path "venv\Scripts\Activate.ps1") {
    # Intentar activar, aunque si ya está activo en la terminal actual no afectará al script hijo 
    # Pero como el usuario ya parece tenerlo activo, nos centramos en las dependencias
} else {
    Write-Host "Creando entorno virtual..."
    python -m venv venv
}

# Asegurar dependencias
pip install -r requirements.txt

# Iniciar Minikube
minikube start
minikube addons enable metrics-server
minikube addons enable ingress

# Parchear Ingress para que funcione con minikube tunnel en Windows
Write-Host "Configurando Ingress como LoadBalancer..."
kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'

# Aplicar namespaces
kubectl apply -f k8s/comun/namespace.yaml

# Aplicar PushGateway
kubectl apply -f k8s/castilla/push_gateway1.yaml
kubectl apply -f k8s/aravaca/push_gateway2.yaml

# Aplicar ConfigMaps de Prometheus
kubectl apply -f k8s/castilla/prometheus-configmap.yaml
kubectl apply -f k8s/aravaca/prometheus-configmap.yaml
kubectl apply -f k8s/madrid/prometheus-configmap.yaml

# Aplicar Prometheus
kubectl apply -f k8s/castilla/prometheus.yaml
kubectl apply -f k8s/aravaca/prometheus.yaml
kubectl apply -f k8s/madrid/prometheus.yaml

# Aplicar Ingress
kubectl apply -f k8s/castilla/ingress.yaml
kubectl apply -f k8s/aravaca/ingress.yaml
kubectl apply -f k8s/madrid/ingress.yaml

# Mostrar estado
Write-Host "`n--- ESTADO DE LOS PODS ---" -ForegroundColor Cyan
kubectl get pods -n castilla-p5
kubectl get pods -n aravaca-p5
kubectl get pods -n madrid-p5

Write-Host "`n--- DEPLOYMENTS ---" -ForegroundColor Cyan
kubectl get deployments -A

Write-Host "`n--- SERVICES ---" -ForegroundColor Cyan
kubectl get services --all-namespaces

# Abrir dashboard
Write-Host "Abriendo dashboard..."
Start-Process minikube -ArgumentList "dashboard"
