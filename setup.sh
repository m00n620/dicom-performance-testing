#!/bin/bash
ssh-keygen -t rsa -b 4096 -f aws_key -N "" -C "dicom-testing-key"
chmod 600 aws_key
terraform init
terraform apply -auto-approve
terraform output -raw inventory > inventory.ini
sleep 30
ansible-playbook -i inventory.ini orthanc.yml
ansible-playbook -i inventory.ini dicomtk.yml
