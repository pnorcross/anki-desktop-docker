# Anki Desktop

This is a dockerfile for the desktop version of Anki, which is useful for automating anki using addons like Anki-Connect. The app is accessible via a web interface bound to port 3000. The anki configuration is bound to a volume mounted at /config/app in the container. 


## Docker Compose Examples

### Ports Exposed Directly

```
services: 
  anki-desktop: 
    image: "pnorcross/anki-desktop:latest"
    volumes:
      - /data/apps/anki/config:/config/app
    ports: 
      - 3000:3000
      # Anki Connect port
      - 8765:8765
 ```

### Proxied through Traefik

```
services: 
  anki-desktop: 
    image: "pnorcross/anki-desktop:latest"
    networks:
      - TraefikNet
    volumes:
      - /data/apps/anki/config:/config/app
    labels:
      - "traefik.docker.network=TraefikNet"
      - "traefik.enable=true"
      - "traefik.http.routers.anki.entryPoints=https"
      - "traefik.http.routers.anki.tls=true"
      - "traefik.http.routers.anki.service=anki"
      - "traefik.http.services.anki.loadbalancer.server.port=3000"
      - "traefik.http.services.anki.loadbalancer.server.scheme=http"
      - "traefik.http.routers.anki.rule=Host(`anki.example.com`)"
      # Anki Connect port
      - "traefik.http.routers.ankiapi.entryPoints=https"
      - "traefik.http.routers.ankiapi.tls=true"
      - "traefik.http.routers.ankiapi.service=ankiapi"
      - "traefik.http.services.ankiapi.loadbalancer.server.port=8765"
      - "traefik.http.services.ankiapi.loadbalancer.server.scheme=http"
      - "traefik.http.routers.ankiapi.rule=Host(`ankiapi.example.com`)"

      
networks: 
  TraefikNet: 
    external: true
 ```
