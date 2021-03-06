## task 6 databases
### setup mysql container with docker
```
docker run --name some-mysql --rm -e MYSQL_ROOT_PASSWORD=<pwd> -d mysql:5.7.34
```
### connect to db with mysql client
```
mysql -h172.17.0.2 -uroot -p 
```

### sql file with two tables to create database and checking data input [setup_database_with_control.sql ](https://github.com/ekozlovsky/june2021/blob/main/mysql/setup_database_with_control.sql)
```
setup_database_with_control.sql 
```

### setup database with mysql client
```
mysql -h172.17.0.2 -uroot -p  < setup_database_with_control.sql 
or execute in mysql terminal
mysql> source setup_database_with_control.sql
```

### select from two tables with join
```
select students.student_id, students.student_name, results.task1, results.task2, results.task3 from students inner join results on students.student_id=results.student_id where student_name='Petrov';
```

### database dump
```
mysqldump -h3.12.166.16x -uroot -p --column-statistics=0 students > mysql/students_dump.sql
```

### deploy mysql database with ansible roles
#### please see playbooks in [../task4ansible/roles/deploy_mysql/tasks/main.yml](https://github.com/ekozlovsky/june2021/blob/main/task4ansible/roles/deploy_mysql/tasks/main.yml) 
```
ansible-playbook -i inventory  -vvvv -u ec2-user start_roles.yml -e 'ansible_python_interpreter=/usr/bin/python3' -e 'root_db_pass=<pwd>'
```
