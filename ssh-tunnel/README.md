# SSH Tunnel

This is a simple SSH tunnel container that allows you to connect to services on other servers / containers. 
It will use your local SSH agent to connect to the endpoint.

## Usage

To open a tunnel and expose it via a local port :

    docker run -p 127.0.0.1:$local_port:$local_port -v $SSH_AUTH_SOCK:/ssh-agent -e LOCAL_PORT=$local_port -e REMOTE_PORT=$remote_port -e USER=$user -e SERVER=$server nascom/ssh-tunnel
    
eg. to connect to a MySQL server and expose it on local port 3306 : 

    docker run -p 127.0.0.1:3306:3306 -v $SSH_AUTH_SOCK:/ssh-agent -e LOCAL_PORT=3306 -e REMOTE_PORT=3306 -e USER=username -e SERVER=host.domain.tld nascom/ssh-tunnel

In order to use it to forward traffic coming from other containers without exposing a local port, you should set the 
GATEWAY environment variable to yes.
 
eg. in docker-compose.yml you can use :

```yaml
services:
  mysql:
    image: nascom/ssh-tunnel
    container_name: mysql
    volumes:
      - ${SSH_AUTH_SOCK}:/ssh-agent
    environment:
      - LOCAL_PORT=3306
      - REMOTE_PORT=3306
      - USER=user
      - SERVER=host.domain.tld
      - GATEWAY=yes
``` 

and use host 'mysql' in other containers to access the database on the remote server.
