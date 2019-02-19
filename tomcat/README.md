# Tomcat Web Application
A simple tomcat web application displays a random number. Included HPA(Horizontal Pod Scaller) manifest yaml file to configure HPA for tomcat. Know more about [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
```
$ git clone https://github.com/veerendra2/my-k8s-applications.git
$ cd my-k8s-applications/tomcat
$ kubectl create -f tomcat-deployment.yaml
$ kubectl create -f tomcat-hpa.yaml
```
