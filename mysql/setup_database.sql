CREATE DATABASE `students` ;
USE `students`;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    student_name VARCHAR(100),
    KEY `student_id` (`student_id`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert  into `students`(`student_id`,`student_name`) values 
(1,'Ivanov'),
(2,'Petrov'),
(3,'Sidorov'),
(4,'Kuznetsov'),
(5,'Kozlov'),
(6,'Komarov');

CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task1 INT,
    task2 INT,
    task3 INT,
    student_id INT,
    KEY `student_id` (`student_id`),
    CONSTRAINT `c1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



insert  into `results`(`task1`,`task2`,`task3`,`student_id`) values 
(0,0,0,1),
(1,1,1,2),
(2,2,2,3),
(3,3,3,4),
(0,1,2,5),
(1,2,3,6);
