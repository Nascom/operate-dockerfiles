# Basic Varnish containers

## Environment variables

The following environment variables can be used to configure this container :

| Env var             | Description                                        |
|---------------------|----------------------------------------------------|
| VARNISH_PORT        | Varnish listen port (default 80)                   |
| VARNISH_MEMORY      | Space to allocate for Varnish Cache (default 512m) | 
| VARNISH_DAEMON_OPTS | Extra options to pass to the Varnish daemon        |

## Configuration

The Varnish daemon will read the configuration from /etc/varnish/default.vcl and the secret
from /etc/varnish/secret, so you will have to copy your configuration file(s) to those locations 
in the container.

## Example usage with docker-compose

```
services:
  varnish:
    image: nascom/varnish:4.1
    volumes:
      - /var/docker/etc/varnish:/etc/varnish
    ports:
      - "80:80"
    environment:
      - VARNISH_DAEMON_OPTS=-T :6082
    restart: unless-stopped
```
