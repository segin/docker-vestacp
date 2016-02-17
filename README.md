Thanks lagun4ik

Failed when autobuild on hub.docker.com
please download and build on your computer/server

run great without FTP.

# VestaCP on Docker

A dockerized version of VestaCP. Without FTP server.

Usage
-----

apache + nginx + php5
```bash
git clone https://github.com/babim/docker-vestacp.git
```

apache + nginx + php7
```bash
git clone --branch php7 https://github.com/babim/docker-vestacp.git
```

Create the image

```bash
cd docker-vestacp
docker build -t babim/vestacp .
```

Create the data volume
```bash
docker volume create --name=vesta-data
```

Running VestaCP docker image
```bash
docker run -d \
  --restart=always \
  -p 2222:22 \
  -p 80:80 \
  -p 8083:8083 \
  -p 3306:3306 \
  -p 443:443 \
  -p 25:25 \
  -p 993:993 \
  -p 110:110 \
  -p 53:53 \
  -p 54:54 \
  -v vesta-data:/vesta \
  babim/vestacp
```

Authorization
---

`Login: admin`
`Password: admin`


SSH and FTP
---

Use SFTP instead of FTP.

SSH and SFTP are available on the `2222` port
