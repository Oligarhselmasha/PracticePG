drop view if exists public.view_employee;

create or replace view public.view_employee AS
select e.surname as Фамилия
	  ,e.firstname as Имя
	  ,e.father_name as Отчество
	  ,r.description  as Должность
	  ,d.description  as Отдел
	  ,o.description  as Офис
	  ,e.dob as Дата_рождения
	  ,e.is_remote as Удаленная_работа
	  ,e.salary as Зарплата
	  ,r.default_salary as Зарплата_по_умолчанию
from public.employee e
left join public.department d 
	   on d.id = e.dep_id
left join public.office o
	   on o.id = e.office_id
left join public.role r
	   on r.id = e.role_id;

	   
/*	  
select *
from public.view_employee
*/