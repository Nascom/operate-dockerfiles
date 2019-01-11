# Socat

This is a simple socat container that allows you to forward traffic on a
specific port to a port on another server or container.

## Usage

In docker-compose.yml you can use :

```yaml
services:
  mysql:
    image: nascom/socat
    container_name: mysql
    command: 'tcp-listen:3306,fork,reuseaddr tcp-connect:remote-server.domain.tld:3306'
    port: '127.0.0.1:3306:3306'
```

and use host 'mysql' in other containers to access the database on the remote
server named `remote-server.domain.tld` (you can also use an IP of course).
