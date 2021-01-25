#!/bin/bash

NGINX_HOST=$(terraform output -raw external_ip_address_vm_nginx)
POSTGRES_HOST=$(terraform output -raw external_ip_address_vm_postgres)
WEB1_HOST=$(terraform output -raw external_ip_address_vm_web1)
WEB2_HOST=$(terraform output -raw external_ip_address_vm_web2)