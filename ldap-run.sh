#!/bin/bash

ERROR_COLOR='\033[0;31m';
HIGHLIGHT_COLOR='\033[0;32m';
INPUT_COLOR='\033[0;33m';
NO_COLOR='\033[0m';


function print_highlight() {
  printf "${HIGHLIGHT_COLOR}$1${NO_COLOR}\n"
}

function print_error() {
  printf "${ERROR_COLOR}$1${NO_COLOR}\n"
}

function input() {
  read -p "$(echo -e ${INPUT_COLOR}$1 ${NO_COLOR})" $2
}

DOCKER_COMPOSE_FILE=./docker-compose.yml
BOOTSTRAP_FILE=./data/bootstrap.ldif
CA_CERT_FILE=./data/certs/ldap-ca.pem
CERT_FILE=./data/certs/server.pem
KEY_FILE=./data/certs/server-key.pem

print_highlight "Start setup ldap service..."

command -v docker-compose &> /dev/null
if [ $? != 0 ]; then
    print_error "docker compose not detected"
    exit;
fi

print_highlight "docker compose detected" &> /dev/null

docker container ls -a | grep 'portainer_ldap' &> /dev/null
if [ $? == 0 ]; then
    docker stop portainer_ldap
    docker rm portainer_ldap
    print_highlight "removing existing container portainer_ldap"
fi

docker volume ls | grep 'portainer_ldap_data'
if [ $? == 0 ]; then
    docker volume rm portainer_ldap_data
    print_highlight "removing existing volume portainer_ldap_data"
fi

docker container ls -a | grep 'ldap_server' &> /dev/null
if [ $? == 0 ]; then
    docker stop ldap_server
    docker rm ldap_server
    print_highlight "removing existing container ldap_server"
fi

docker container ls -a | grep 'ldap_server_admin' &> /dev/null
if [ $? == 0 ]; then
    docker stop ldap_server_admin
    docker rm ldap_server_admin
    print_highlight "removing existing container ldap_server_admin"
fi

docker network ls | grep 'openldap-network' &> /dev/null
if [ $? == 0 ]; then
    docker network rm openldap-network
    print_highlight "removing existing container openldap-network"
fi
set -e

if [[ ! -e "${DOCKER_COMPOSE_FILE}" ]]; then
    print_error "${DOCKER_COMPOSE_FILE} not found"
    exit;
fi

if [[ ! -e "${BOOTSTRAP_FILE}" ]]; then
    print_error "${BOOTSTRAP_FILE} not found"
    exit;
fi

if [[ ! -e "${CA_CERT_FILE}" ]]; then
    print_error "${CA_CERT_FILE } not found"
    exit;
fi

if [[ ! -e "${CERT_FILE}" ]]; then
    print_error "${CERT_FILE} not found"
    exit;
fi

if [[ ! -e "${KEY_FILE}" ]]; then
    print_error "${KEY_FILE } not found"
    exit;
fi

 
docker-compose up -d 

print_highlight "Open LDAP service run up successfully."

print_highlight "Login DN(username): cn=admin,dc=example,dc=org"
print_highlight "Password: admin_pass"

sleep 5

input "Visit LDAP page with 'http://localhost:8090'. Continue(y/n)? " TEST_NEXT

input "Input your testing docker image(portainerci/portainer-ee:prxxx): " TEST_IMAGE

docker volume create portainer_ldap_data

docker run -d \
-p 8000:8000 \
-p 9000:9000 \
-p 9443:9443 \
--network openldap-network \
--name portainer_ldap \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /portainer_ldap_data:/data \
${TEST_IMAGE}

print_highlight "Portainer run up successfully."

sleep 8

print_highlight "Visit Portainer page with 'http://localhost:9000'. "

