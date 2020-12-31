# hombre-fail2ban
![Docker Pulls](https://img.shields.io/docker/pulls/hombrelab/hombre-fail2ban) ![Docker Image Version (latest by date)](https://img.shields.io/docker/v/hombrelab/hombre-fail2ban) ![GitHub commit activity](https://img.shields.io/github/last-commit/hombrelab/hombre-fail2ban)  

The [hombre-fail2ban](https://hub.docker.com/repository/docker/hombrelab/hombre-fail2ban) image is based on the [hombre-alpine](https://hub.docker.com/repository/docker/hombrelab/hombre-alpine) image and [Fail2ban v0.11.2](https://www.fail2ban.org/wiki/index.php/Main_Page).  
It is a Docker image for and by [@Hombrelab](me@hombrelab.com) to scan log files and ban ip adresses from a website.

Deployment examples:

Command line
```shell script
docker run \
    --name fail2ban \
    --detach \
    --restart unless stopped \
    --volume /home/data/fail2ban/config:/etc/fail2ban \
    --volume /home/data/fail2ban/data:/var/lib/fail2ban \
    --volume /var/log:/var/log:ro \
    --volume /etc/localtime:/etc/localtime:ro \
    --cap-add NET_ADMIN \
    --cap-add NET_RAW \
    hombrelab/hombre-fail2ban
```
Docker Compose
```yaml
  fail2ban:
    container_name: fail2ban
    restart: unless-stopped
    image: hombrelab/hombre-fail2ban
    volumes:
      - /home/data/fail2ban/config:/etc/fail2ban
      - /home/data/fail2ban/data:/var/lib/fail2ban
      - /var/log:/var/log:ro
      - /etc/localtime:/etc/localtime:ro
    cap_add:
      - NET_ADMIN
      - NET_RAW
```