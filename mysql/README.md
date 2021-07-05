## task 6 databases
### setup mysql container
```
docker run --name some-mysql --rm -e MYSQL_ROOT_PASSWORD=mysecretpw -d mysql:5.7.34
```
### connect to db
```
mysql -h172.17.0.2 -uroot -p
mysql -h3.12.166.162 -uroot -p 
```

### create database
```
setup_database_with_control.sql 
```
### select from two tables with join
```
select students.student_id, students.student_name, results.task1, results.task2, results.task3 from students inner join results on students.student_id=results.student_id where student_name='Petrov';
```

