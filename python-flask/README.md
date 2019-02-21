# Python Flask Application in Docker
```
$ git clone https://github.com/veerendra2/my-k8s-applications.git
$ cd my-k8s-applications/python-flask
$ docker build -t my_flask_app .
```
* Place your flask application directory in `myapp` directory, modify `Dockerfile` and build docker image.
#### Directory Tree
```
.
├── Dockerfile
├── httpd.conf
└── myapp
    ├── flask_app
    │   └── __init__.py
    └── flask_app.wsgi
```