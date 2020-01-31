# Dockerfile for sshd

### Build image :

` bash
docker build -t alpine_sshd .
`

### Run the container 

` bash
docker run -d -P --name alpine-sshd alpine_sshd
`

### Get the port

``` bash
docker port alpine-sshd 22
0.0.0.0:XXXXX
```

### Access the container using ssh

``` bash
$ ssh root@{ipaddress} -p XXXXX
# or
$ ssh root@localhost -p XXXXX
root@anonymous:/#
```



