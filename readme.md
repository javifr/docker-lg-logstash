# Como usarlo

- Dejar fichero que se llame 'config' en la razi del docker a construir
- Crear imagen: ```docker build -t nombreimagen .```
- Hacer run de la imagen ```docker run -it --rm nombreimagen logstash -f .config```
- Saca nombre del docker ```docker ps```y saca nombre.
- Para conectarnos desde fuera al docker y ver consola ```docker exec -it nombre bash```