## task 6 databases
### setup mysql container
```
docker run --name some-mysql --rm -e MYSQL_ROOT_PASSWORD=<pwd> -d mysql:5.7.34
```
### connect to db with mysql client
```
mysql -h172.17.0.2 -uroot -p
mysql -h3.12.166.162 -uroot -p 
```

### sql file with two tables to create database
```
setup_database_with_control.sql 
```
### select from two tables with join
```
select students.student_id, students.student_name, results.task1, results.task2, results.task3 from students inner join results on students.student_id=results.student_id where student_name='Petrov';
```

### database dump
```
mysqldump -h3.12.166.162 -uroot -p --column-statistics=0 students > mysql/students_dump.sql
```

### deploy mysql database database with ansible roles
#### please see playbooks in [../task4ansible/roles/deploy_mysql/tasks/main.yml](https://github.com/ekozlovsky/june2021/blob/main/task4ansible/roles/deploy_mysql/tasks/main.yml) 
```
ansible-playbook -i inventory  -vvvv -u ec2-user start_roles.yml -e 'ansible_python_interpreter=/usr/bin/python3' -e 'root_db_pass=<pwd>'
```
