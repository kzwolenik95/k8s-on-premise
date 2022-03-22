sudo mkdir -p /etc/keepalived/ /etc/haproxy/
envsubst < keepalived.conf | sudo tee /etc/keepalived/keepalived.conf
envsubst < haproxy.cfg | sudo tee /etc/haproxy/haproxy.cfg
envsubst < check_apiserver.sh | sudo tee /etc/keepalived/check_apiserver.sh
envsubst < haproxy.yaml | sudo tee /etc/kubernetes/manifests/haproxy.yaml
sudo cp keepalived.yaml /etc/kubernetes/manifests/

