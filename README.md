# k8s-on-premise

 1. Create the environment using vagrant

        vagrant up
2. Set up machines for kubernetes cluster

       ansible-playbook cluster.yaml -i inventory
3. On the first master node init the cluster
	
       sudo kubeadm init --apiserver-advertise-address=10.0.0.10 \
         --pod-network-cidr=192.168.0.0/16 --control-plane-endpoint 10.0.0.9:8443 \
         --upload-certs
4. Set up kubectl 

       mkdir -p $HOME/.kube
       sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
       sudo chown $(id -u):$(id -g) $HOME/.kube/config
5. Set up networking plugin

       kubectl create -f https://projectcalico.docs.tigera.io/manifests/tigera-operator.yaml
       kubectl create -f https://projectcalico.docs.tigera.io/manifests/custom-resources.yaml

6. Join second master node

       sudo kubeadm join 10.0.0.9:8443 --token TOKEN \
         --apiserver-advertise-address=10.0.0.11 \
    	 --discovery-token-ca-cert-hash DISCOVERY_TOKEN \
    	 --control-plane --certificate-key CERTIFICATE_KEY
7. Join third master node

       sudo kubeadm join 10.0.0.9:8443 --token TOKEN \
         --apiserver-advertise-address=10.0.0.12 \
    	 --discovery-token-ca-cert-hash DISCOVERY_TOKEN \
    	 --control-plane --certificate-key CERTIFICATE_KEY
8. Join worker nodes, run it on both nodes

       sudo kubeadm join 10.0.0.9:8443 --token TOKEN \
         --discovery-token-ca-cert-hash DISCOVERY_TOKEN

9. Run demo app

       kubectl apply -f https://k8s.io/examples/application/deployment.yaml

