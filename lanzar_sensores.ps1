$COMANDO = "fake_sensor.py"

# Lanzamos los port-forward en ventanas separadas
Start-Process kubectl -ArgumentList "port-forward -n aravaca-p5 service/pushgateway-svc 30005:20000"
Start-Process kubectl -ArgumentList "port-forward -n castilla-p5 service/pushgateway-svc 30006:20000"
Start-Process kubectl -ArgumentList "port-forward -n aravaca-p5 service/prometheus-svc 30007:9090"
Start-Process kubectl -ArgumentList "port-forward -n castilla-p5 service/prometheus-svc 30008:9090"

# Esperamos unos segundos para que se establezcan los túneles
Start-Sleep -Seconds 5
Start-Process python -ArgumentList "$COMANDO -p 10 -gip 127.0.0.1 -gp 30005 -j aravaca -la 40.396968 -lo -3.665827 -n Avda_Albufera_37"
Start-Process python -ArgumentList "$COMANDO -p 10 -gip 127.0.0.1 -gp 30005 -j aravaca -la 40.389939 -lo -3.627135 -n Alan_Turing_s_n"
Start-Process python -ArgumentList "$COMANDO -p 10 -gip 127.0.0.1 -gp 30006 -j castilla -la 40.404807 -lo -3.744192 -n Sepulveda_166"
Start-Process python -ArgumentList "$COMANDO -p 10 -gip 127.0.0.1 -gp 30006 -j castilla -la 40.374524 -lo -3.774525 -n Sinfonia_20"
Start-Process python -ArgumentList "$COMANDO -p 10 -gip 127.0.0.1 -gp 30006 -j castilla -la 40.383141 -lo -3.770663 -n Avda_Aguilas_41"