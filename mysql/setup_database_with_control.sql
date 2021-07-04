CREATE DATABASE IF NOT EXISTS `students` ;
USE `students`;

DROP TABLE IF EXISTS `students`;

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

DROP TABLE IF EXISTS `results`;

CREATE TABLE results (
    id INT AUTO_INCREMENT,
    task1 INT,
    task2 INT,
    task3 INT,
    student_id INT PRIMARY KEY,
    KEY `id` (`id`),
    CONSTRAINT `c1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*task contains marks 0 - no info, 1 - not done, 2 - done, 3 - done with extra */
/*there must be ENUM instead but it must be in separate table as ech task has the same ENUM */

insert  into `results`(`task1`,`task2`,`task3`,`student_id`) values 
(0,0,0,1),
(1,1,1,2),
(2,2,2,3),
(3,3,3,4),
(0,1,2,5),
(1,2,3,6),
(5,5,5,6)  on DUPLICATE KEY UPDATE task1=values(task1),task2=values(task2),task3=values(task3),student_id=student_id;

/*mark 5 used for testind update on insert */
