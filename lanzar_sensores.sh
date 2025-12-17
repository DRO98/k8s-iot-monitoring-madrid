#! /bin/bash
if [ -z "$1" ]; then
    COMANDO='fake_sensor.py'
else
    COMANDO=$1
fi

# Obtener la IP de minikube dinámicamente
MINIKUBE_IP=$(minikube ip)

if [ -z "$MINIKUBE_IP" ]; then
    echo "Error: No se pudo obtener la IP de minikube. Asegúrate de que minikube esté corriendo."
    exit 1
fi

echo "Usando IP de Minikube: $MINIKUBE_IP"

python3 $COMANDO -p 10 -gip $MINIKUBE_IP -gp 30005 -j aravaca -la 40.396968 -lo -3.665827 -n Avda_Albufera_37 &
python3 $COMANDO -p 10 -gip $MINIKUBE_IP -gp 30005 -j aravaca -la 40.389939 -lo -3.627135 -n Alan_Turing_s_n &
python3 $COMANDO -p 10 -gip $MINIKUBE_IP -gp 30006 -j castilla -la 40.404807 -lo -3.744192 -n Sepulveda_166 &
python3 $COMANDO -p 10 -gip $MINIKUBE_IP -gp 30006 -j castilla -la 40.374524 -lo -3.774525 -n Sinfonia_20 &
python3 $COMANDO -p 10 -gip $MINIKUBE_IP -gp 30006 -j castilla -la 40.383141 -lo -3.770663 -n Avda_Aguilas_41 &