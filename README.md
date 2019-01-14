# Métodos analiticos (ITAM, 2019)
Notas y material para el curso de Métodos Analíticos (Ciencia de Datos, ITAM).

- [Notas](https://admiring-feynman-7b07f8.netlify.com). Estas notas son producidas
en un contenedor (con [imagen base de rocker](https://www.rocker-project.org, y unos
8G de memoria)  construido con el Dockerfile del repositorio:

```
docker build -t ma-rstudio .
docker run --rm -p 8787:8787 -e PASSWORD=mipass -v ~/tu/carpeta/local:/home/rstudio/ma ma-rstudio
```

- Para correr las notas usa el script notas/\_build.sh. Abre el archivo notas/\_book/index.html para ver tu copia local de las notas.

- Todos los ejercicios y tareas corren también en ese contenedor. Es opcional usarlo,
pero si tienes problemas de reproducibilidad puedes intentarlo.

- Puedes también utilizar un contenedor en Google Cloud si necesitas una computadora más grande usando la imagen: 

```
gcr.io/metodos-analiticos-clase/ma-rstudio@sha256:9a36c845fbf2761baa3b76dc69c259e8dcd255dc18d252d9c1c5c32aca4ad9c7
```

Canal de Slack
---

https://join.slack.com/t/maestriaencie-re79200/shared_invite/enQtNTIyNTE0MDU1MTM2LTU0ODU2YWE1NGQ1MmNmMTljOWQwOWFlNWRiOGIyZGVhNjAzN2U1YjFmYTFjYzEyZjEyNWQ1MjNmMzJjMjYzOWM

