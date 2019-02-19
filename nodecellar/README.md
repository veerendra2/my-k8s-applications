# Nodecellar App From Cloudify
Created K8s deployment yaml from cloudify blueprint. [cloudify-cosmo/cloudify-nodecellar-example](https://github.com/cloudify-cosmo/cloudify-nodecellar-example)
```
$ git clone https://github.com/veerendra2/my-k8s-applications.git
$ cd nodecellar
$ kubeclt create -f nodecellar-deployment.yaml
$ kubeclt create -f nodecellar-deployment.yaml # Should have "metric-server" installed
```