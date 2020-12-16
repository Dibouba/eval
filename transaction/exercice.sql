--déclaration de mes variables
SELECT @emp_id:=emp_id,@emp_superior_id:=emp_superior_id,@emp_pos_id:=emp_pos_id,@emp_sho_id:=emp_sho_id FROM employees WHERE emp_lastname LIKE 'Hannah' AND emp_firstname LIKE 'Amity';
SELECT @emp_id2:=emp_id FROM employees WHERE emp_enter_date IN (SELECT MIN(emp_enter_date) FROM employees where emp_pos_id IN (SELECT pos_id from posts WHERE pos_libelle LIKE 'pépiniériste') AND emp_sho_id IN(SELECT sho_id FROM shops where sho_city LIKE 'Arras' ));
--MAJ de la tables employees pour transferer les poste de HANNAH Amity à l'employé le plus ancien de pépiniériste
START TRANSACTION;
UPDATE employees
set emp_superior_id = @emp_superior_id,
 emp_pos_id= @emp_pos_id,
 emp_sho_id = @emp_sho_id, 
 emp_salary = emp_salary*1.05
WHERE emp_id=@emp_id2;
--MAJ la tables employees pour les anciens collaborateurs sous la responsabilité de l'ancien de pépiniériste
UPDATE employees
SET emp_superior_id=@emp_id2
WHERE emp_pos_id IN (SELECT pos_id FROM posts WHERE pos_libelle LIKE 'pépiniériste') AND emp_sho_id IN (SELECT sho_id FROM shops WHERE sho_city LIKE 'Arras');
--Ajout de la ligne Retraite à la table posts
insert into posts(pos_libelle)
values('Retraité');
SELECT emp_pos_id FROM employees WHERE emp_id=@emp_id;
--Transferer l'id de l'employees qui part en retraite
UPDATE employees
set emp_pos_id = (SELECT pos_id FROM posts
                  WHERE pos_libelle LIKE 'Retraité')
WHERE emp_id=@emp_id;
COMMIT;

