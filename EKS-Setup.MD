workflow for EKS cluster creation
    1) Run terraform init, terraform plan and terraform apply to create EC2 Instance (from workstation.sh)
        System specification source is workstation.sh (containes all the nessasary files)
    
    2) Login to workstation with centos / DevOps321
    3) clone the k8-eksctl repository with https URL
        git clone <https://k8-eksctl.git>
    
    4) navigate to k8-eksctl # cd k8-eksctl
    5) Run the below command to create the cluster
        eksctl create cluster --config-file=eks.yaml

    To Destroy
        Login to workstation
        eksctl delete cluster --config-file=eks.yaml
        Run terraform destroy from the laptop to remove the workstation