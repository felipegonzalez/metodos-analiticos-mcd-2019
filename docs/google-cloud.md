
Crear una instancia nueva con imagen del curso
---

1. Crear un proyecto nuevo. Crear una instancia nueva en VM Instances
2. Seleccionar tamaño de la instancia (vCPUs y memoria). En *container*, 
dar click a *Deploy a container image to this VM instance*. En container image agregar el nombre que está en el README del repositorio. En *advanced
container options* dar click a *Run as privileged* y agregar una *Environment variable*, con nombre PASSWORD y el password que quieras.
3. Más abajo, escoger el tamaño del boot disk (puedes agregar otros volúmenes también).
4. Presionar *Create* hasta abajo.

Conectarse de manera segura
---

1. Tienes que tener instalado el SDK de google cloud, como se explica en https://cloud.google.com/sdk/docs/quickstart-macos

2. En una terminal hacer port forwarding sobre ssh:

gcloud compute ssh [INSTANCE] \
    --project [PROJECT] \
    --zone [ZONE] \
    -- -L 8787:localhost:8787

Donde tienes que rellenar [INSTANCE], [PROJECT], [ZONE]. Por ejemplo:

gcloud compute ssh instance-1 \
    --project metodos-analiticos-clase \
    --zone us-east1-b \
    -- -L 8787:localhost:8787

3. Conectarse a la instancia en un browser: localhost:8787


---

Para utilizar un cluster en lugar de una sola máquina, puedes
seguir las instrucciones en

https://cloud.google.com/solutions/running-rstudio-server-on-a-cloud-dataproc-cluster

donde explica cómo instalar **sparklyr**. Nota que en estas instrucciones
los paquetes adicionales que necesitas tienes que instalarlos (no utiliza
nuestro Dockerfile).


