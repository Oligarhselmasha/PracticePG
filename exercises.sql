/*
Для наполнения таблц данными - выполнить скрипт dml_tables.sql
Если таблицы не созданы - создать скриптом ddl_tables.sql
*/

--a.Сотрудники, которых приняли на работу, но не выделили им рабочее место (работают удаленно)

select e.surname 
	  ,e.firstname 
	  ,e.father_name 
from public.employee e
where 1=1
  and e.is_remote is false
  and office_id is null;

--b.Количество сотрудников в каждом отделе (по убыванию количества)

select d.description as Отдел
	  ,count(e.id) as Количество
from public.department d
left join public.employee e
	   on e.dep_id = d.id
group by d.id
order by count(e.id) desc;

--c.Сотрудники, у которых год рождения – нечетное число.

select e.surname as Фамилия
	  ,e.firstname as Имя
	  ,e.father_name as Отчество
	  ,date_part('year', dob) as Год_рождения
from public.employee e
where date_part('year', dob)::integer % 2 <> 0;

--h. Сотрудники, у которых есть однофамильцы

with cte as 
	(
	select e.surname
	from public.employee e
	group by e.surname 
	having count(e.surname) > 1
	)
	
	select *
	from public.employee e 
	where surname in
	(
	select surname
	from cte
	);

--i.+ бонус = вывести в виде:  [СотрудникФИО], [Список однофамильцев (их ФИО) через запятую]

with cte as 
	(
	select e.surname
	from public.employee e
	group by e.surname 
	having count(e.surname) > 1
	)
	
	select coalesce(e.firstname, '') || ' ' || coalesce(e.surname, '') || ' ' || coalesce(e.father_name, '') as Сотрудник_ФИО
		 , array_to_string(array (select coalesce(e2.surname, '') || ' ' || coalesce(e2.firstname, '') || ' ' || coalesce(e2.father_name, '')
				  from public.employee e2
				  where e2.surname = e.surname
				  and e2.id <> e.id), ',', '') as Список_однофамильцев 
	from public.employee e 
	where e.surname in
	(
	select surname
	from cte
	);

--i.Сотрудники, имеющие максимальный уровень заработной платы в своем отделе

with cte as(
		select e.surname
			  ,e.firstname
			  ,e.father_name
			  ,e.salary
			  ,e.dep_id 
			  ,e.id
			  ,row_number () over(partition by e.dep_id order by salary desc) rn
		from public.employee e
		)
select cte.surname as Фамилия
	  ,cte.firstname as Имя
	  ,cte.father_name as Отчество
	  ,cte.salary as Зарплата
	  ,d.description as Отдел
	  ,cte.id as Табельный_номер
from cte cte
join public.department d 
  on d.id = cte.dep_id 
where cte.rn = 1

--k.Список офисов, в которых есть еще свободные места i.+ бонус = данный список отсортировать по убыванию количества мест и соотв. вывести это количество вместе с вместимостью офиса
with cte as 
(
select count(e.*)
	,e.office_id 
	,o.capacity 
	,o.capacity - count(e.*) as diff
	,o.description 
from public.employee e
join public.office o 
  on o.id = e.office_id 
where e.office_id is not null
group by office_id
		,o.capacity
		,o.description
)

select cte.description as Название_офиса
	  ,cte.capacity as Вместимость
	  ,cte.diff as Количество_свободных_мест
from cte cte 
where cte.diff > 0
order by cte.diff desc;



