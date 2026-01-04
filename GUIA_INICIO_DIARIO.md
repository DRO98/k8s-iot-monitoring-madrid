# Guía de Inicio Diario (Workflow de Reinicio)

Sigue estos pasos cada vez que enciendas el ordenador para asegurarte de que todo tu entorno se carga correctamente.

## 1. Arrancar y Actualizar el Clúster (Script Maestro)

En lugar de iniciar Minikube manualmente, usaremos el script de inicio. Esto arranca la máquina virtual y **aplica todos los ficheros YAML** para asegurar que no falte nada (Deployments, Services, Ingress).

1. Abrir Docker
2. Abre una terminal (VS Code o PowerShell).


**Windows (PowerShell):**
```powershell
.\minikube-start.ps1
```

**Linux/Bash:**
```bash
./minikube-start.sh
```

*Espera a que termine. Al final te mostrará el estado de los pods y abrirá el Dashboard.*

## 2. Activar el Túnel (Requiere Administrador)

El script anterior no lanza el túnel porque este bloquea la terminal. Debes hacerlo aparte.

1. Abre **otra** terminal (PowerShell o CMD) **como Administrador**.
2. Ejecuta:

```powershell
minikube tunnel
```
*(Nota: Deja esta ventana abierta, no la cierres).*

## 3. Iniciar Grafana

Aquí hay dos opciones. Elige la que corresponda:

### Opción A: Rutina normal (Si ya configuraste Madrid ayer)
Simplemente despierta el contenedor:

```bash
docker start grafana
```

### Opción B: Si acabas de añadir Madrid hoy (o falla la conexión)
Debes borrar el contenedor viejo y crear uno nuevo que conozca la dirección de Madrid:

```bash
docker rm -f grafana

docker run -d -p 3000:3000 --add-host castilla.monitor.es:host-gateway --add-host aravaca.monitor.es:host-gateway --add-host madrid.monitor.es:host-gateway --add-host www.madrid.es:host-gateway --name grafana grafana/grafana
```
Accede a Grafana: [http://localhost:3000](http://localhost:3000)

### 3.1. Configuración de Data Sources (Si se pierden)

Si al entrar en Grafana no ves los datos (porque el contenedor se ha recreado), ve a **Connections > Data Sources > Add new data source > Prometheus** y añade estos tres:

1.  **Prometheus Castilla**
    *   **Name:** `Prometheus-Castilla` (Opcional)
    *   **Prometheus server URL:** `http://castilla.monitor.es`
    *   *Click en "Save & Test"*

2.  **Prometheus Aravaca**
    *   **Name:** `Prometheus-Aravaca` (Opcional)
    *   **Prometheus server URL:** `http://www.madrid.es/aravaca`
    *   *Click en "Save & Test"*

3.  **Prometheus Madrid**
    *   **Name:** `Prometheus-Madrid` (Opcional)
    *   **Prometheus server URL:** `http://madrid.monitor.es`
    *   *Click en "Save & Test"*

## 4. Lanzar los Sensores Simulados y Conexiones

Este script no solo lanza los sensores, sino que también **abre túneles de conexión directa** (port-forwarding) para que puedas ver los datos en tiempo real sin depender del Ingress.

En la terminal (puedes usar la del Paso 1), ejecuta:

**Windows (PowerShell):**
```powershell
.\lanzar_sensores.ps1
```
*(Se abrirán varias ventanas negras. **No las cierres**, son los túneles y los sensores).*

**Linux/Bash:**
```bash
./lanzar_sensores.sh
```

## 5. Resumen de URLs de Acceso (Validación Final)

### Acceso Directo (Vía script de sensores)
Estas URLs funcionan gracias a las ventanas que abrió el script `lanzar_sensores.ps1`. Son las más fiables para depurar:

*   **Pushgateway Aravaca:** [http://localhost:30005](http://localhost:30005)
*   **Pushgateway Castilla:** [http://localhost:30006](http://localhost:30006)
*   **Prometheus Aravaca:** [http://localhost:30007](http://localhost:30007)
*   **Prometheus Castilla:** [http://localhost:30008](http://localhost:30008)

### Acceso por Dominio (Vía Ingress)
Usa estas URLs para confirmar que las reglas de Ingress y el túnel funcionan bien (requisito del proyecto):

*   **Grafana:** [http://localhost:3000](http://localhost:3000)
*   **Prometheus (Madrid - Fase 4):** [http://madrid.monitor.es/graph](http://madrid.monitor.es/graph)
*   **Prometheus (Castilla - Host):** [http://castilla.monitor.es/graph](http://castilla.monitor.es/graph)
*   **Prometheus (Aravaca - Ruta):** [http://www.madrid.es/aravaca/graph](http://www.madrid.es/aravaca/graph)

*(Si estas fallan, revisa que `minikube tunnel` siga corriendo).*

## 6. Al terminar el día

Apagado ordenado para evitar corrupción de datos:

1.  Detén los sensores: `./parar_sensores.sh`
2.  Detén Grafana: `docker stop grafana`
3.  Detén Minikube: `minikube stop`
4.  Cierra la ventana del túnel (Administrador).
