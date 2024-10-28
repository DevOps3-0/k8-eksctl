From the K8s Server

Step 1: Update kubectl Context to EKS Cluster
Make sure your kubectl context points to your EKS cluster.
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>

Step 2: Deploy the Kubernetes Dashboard
    1. Install the Dashboard
        kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
        
    2. Verify the Deployment: Ensure the dashboard pod and services are up and running:
        kubectl get pods -n kubernetes-dashboard
        kubectl get services -n kubernetes-dashboard

Step 3: Create an Admin Service Account and Bind ClusterRole
1. Create a Service Account:
        cat <<EOF | kubectl apply -f -
        apiVersion: v1
        kind: ServiceAccount
        metadata:
            name: admin-user
            namespace: kubernetes-dashboard
        EOF
    
2. Bind ClusterRole:
        cat <<EOF | kubectl apply -f -
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRoleBinding
        metadata:
            name: admin-user-binding
        roleRef:
            apiGroup: rbac.authorization.k8s.io
            kind: ClusterRole
            name: cluster-admin
        subjects:
        - kind: ServiceAccount
          name: admin-user
          namespace: kubernetes-dashboard
        EOF

Step 4: Access the Kubernetes Dashboard
To access the Dashboard safely, use kubectl proxy to set up a secure connection:
    >> kubectl proxy

# To access the dashboard - one of the approach is change the ClusterIP service to LoadBalancer Service
>> kubectl get svc -n kubernetes-dashboard
>> kubectl edit service kubernetes-dashboard -n kubernetes-dashboard
>> kubectl get svc -n kuberentes-dashboard

Browser: https://ad27b4db61cea426784949ffb8753a79-1161717839.us-east-1.elb.amazonaws.com

Step 5: Obtain a Bearer Token for Authentication
1. Retrieve the Token:
    >> kubectl -n kubernetes-dashboard create token admin-user
2. Copy the Token and use it to log in to the Dashboard.

Step 6: Test the Dashboard
    Login with the Token you generated.
    Navigate through the Dashboard to ensure you can visualize various resources, such as Pods, Deployments, Nodes, and Namespaces.
    Verify that all EKS cluster resources appear as expected.

Additional Considerations (Optional)
    If you’d like to expose the Dashboard externally, consider using a secured ingress with proper authentication. However, for production environments, avoid direct exposure of the Dashboard to the internet without strong authentication and authorization measures.



To properly remove the Kubernetes Dashboard,
---------------------------------------------
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.1/aio/deploy/recommended.yaml

kubectl delete service kubernetes-dashboard -n kubernetes-dashboard

kubectl delete namespace kubernetes-dashboard

kubectl get all -n kubernetes-dashboard