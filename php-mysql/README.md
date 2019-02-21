# Sample PHP-MySQL Web Application in Docker
### Build Mysql Docker Image.
MySQL docker image contains `employee` DB, collected from [datacharmer/test_db](https://github.com/datacharmer/test_db)
##### Tips to load DB tables to mysql
* Copy `.dump` and `.sql` files to `/docker-entrypoint-initdb.d/`. The scripts in container will take of loading DB tables and data while starting container
```
$ git clone https://github.com/veerendra2/my-k8s-applications.git
$ cd my-k8s-applications/php-mysql/mysqlDB
$ docker build -t mysqldb .
```
### Build apache-php Docker Image
A sample PHP code, retrieves employee `name` from `mysqldb`. `mysql-v2/` directory has slight chages to PHP script which retrives employee `name` & `title`
 ```
$ cd my-k8s-applications/php-mysql/
$ docker build -t php-app .
 ```
#### Directory Tree
```
.
├── Dockerfile
├── myapp
│   └── index.php
├── myapp-v2
│   └── index.php
├── mysqlDB
│   ├── Dockerfile
│   ├── employees.sql
│   ├── load_departments.dump
│   ├── load_dept_emp.dump
│   ├── load_dept_manager.dump
│   ├── load_employees.dump
│   ├── load_salaries1.dump
│   ├── load_salaries2.dump
│   ├── load_salaries3.dump
│   └── load_titles.dump
└── README.md

```

