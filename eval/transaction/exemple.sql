insert into posts(pos_libelle)
values('Retraité');
SELECT emp_pos_id FROM employees WHERE emp_lastname LIKE 'HANNAH' AND emp_firstname LIKE 'Amity';

UPDATE employees
set emp_pos_id = (SELECT pos_id FROM posts
                  WHERE pos_libelle LIKE 'Retraité')
WHERE emp_lastname LIKE 'HANNAH' AND emp_firstname LIKE 'Amity';

SELECT CONCAT(emp_lastname," ",emp_firstname),emp_enter_date
FROM employees
WHERE emp_enter_date = (SELECT MIN(emp_enter_date) FROM employees WHERE emp_pos_id = (SELECT pos_id FROM
                        posts WHERE pos_libelle LIKE 'pépiniériste'));
---une autre version
SELECT emp_pos_id, concat(emp_lastname,' ',emp_firstname), emp_enter_date
FROM `employees`
WHERE emp_enter_date IN (SELECT MIN(emp_enter_date) FROM employees where emp_pos_id IN (SELECT pos_id from posts
WHERE pos_libelle LIKE 'pépiniériste'))