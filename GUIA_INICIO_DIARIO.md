# Guía de Inicio Diario (Workflow de Reinicio)

Sigue estos pasos cada vez que enciendas el ordenador y quieras retomar el trabajo con el proyecto.

## 1. Iniciar Minikube y el Túnel (Requiere Administrador)

Para que los dominios (Ingress) funcionen y puedas acceder a Grafana correctamente, necesitas el túnel.

1.  Abre una terminal (PowerShell o CMD) **como Administrador**.
2.  Ejecuta el siguiente comando y **deja la ventana abierta** (no la cierres):
    ```powershell
    minikube start
    minikube tunnel
    ```
    *(Nota: Te pedirá confirmación de permisos de red/firewall).*

## 2. Verificar el Estado de Kubernetes

En una **nueva terminal** (normal, no hace falta admin), verifica que los pods de tu proyecto se han levantado correctamente tras el inicio de Minikube:

```bash
./kstatus.sh
```
*Deberías ver los pods de `prometheus` y `pushgateway` en estado `Running`.*

> **Nota:** Si por alguna razón el clúster está vacío o da errores, puedes volver a desplegar todo ejecutando `./minikube-start.sh`.

## 3. Iniciar Grafana

Como ya creaste el contenedor de Grafana anteriormente, no debes usar `docker run` (eso crearía uno nuevo vacío). Debes "despertar" el que ya tienes.

1.  En la terminal, ejecuta:
    ```bash
    docker start grafana
    ```
2.  Accede a Grafana en tu navegador: [http://localhost:3000](http://localhost:3000)

> **Solo si es la PRIMERA vez absoluta** (o si borraste el contenedor), usa el comando de creación:
> `docker run -d -p 3000:3000 --add-host castilla.monitor.es:host-gateway --add-host www.madrid.es:host-gateway --name grafana grafana/grafana`

## 4. Lanzar los Sensores Simulados

Los sensores no se guardan, son scripts que deben estar corriendo para generar datos.

1.  En la terminal, ejecuta:
    *   **Windows (PowerShell):**
        ```powershell
        .\lanzar_sensores.ps1
        ```
    *   **Linux/Bash:**
        ```bash
        ./lanzar_sensores.sh
        ```

## 5. Resumen de URLs de Acceso

Una vez todo está corriendo:

*   **Grafana:** [http://localhost:3000](http://localhost:3000)
*   **Prometheus (Aravaca):** [http://localhost:30007](http://localhost:30007)
*   **Prometheus (Castilla):** [http://localhost:30008](http://localhost:30008)
*   **PushGateway (Aravaca):** [http://localhost:30005](http://localhost:30005)
*   **PushGateway (Castilla):** [http://localhost:30006](http://localhost:30006)

## 6. Al terminar el día

Para apagar todo ordenadamente:

1.  Detén los sensores:
    ```bash
    ./parar_sensores.sh
    ```
2.  Detén Grafana:
    ```bash
    docker stop grafana
    ```
3.  Detén Minikube:
    ```bash
    minikube stop
    ```
4.  Ya puedes cerrar la ventana del túnel.
