# VestaCP on Docker

A dockerized version of VestaCP. Without FTP server.

Usage
-----

Create the image
```
git clone https://github.com/lagun4ik/dockerizedVestaCP.git
cd dockerizedVestaCP/
docker build -t lagun4ik/vestacp .
```

Create the data volume
```
docker volume create --name=vesta-data
```

Running VestaCP docker image
```
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
  lagun4ik/vestacp
```

Authorization
`Login: admin`
`Password: admin`