/*
 drop procedure if exists add_employee(text,text,date,int8,boolean,int8,int8,text,int8,int8,decimal);
*/
create or replace procedure public.add_employee(p_firstname text,
												p_surname text,
												p_dob date,
												p_dep_id int8,
												p_is_remote boolean,
												p_role_id int8,
												p_id inout int8,
												p_father_name text default null,
												p_office_id int8 default null,
												p_director_id int8 default null,
												p_salary decimal(10,2) default null)
language plpgsql
as $$
declare l_salary decimal(10,2);
		l_current_capacity int4;
		l_context text;
begin
	
	if p_salary <= 0 then
		raise exception 'зарплата не может быть меньше или равна 0!';
	end if;
	
	if not exists (select id from public.department where id = p_dep_id) then
		raise exception 'id отдела % отсуствует в базе!', p_dep_id;
	end if;

	if not exists (select id from public.role where id = p_role_id) then
		raise exception 'id должности % отсуствует в базе!', p_role_id;
	end if;

	if p_office_id is not null and not exists (select id from public.office where id = p_office_id) then
		raise exception 'id офиса % отсуствует в базе!', p_office_id;
	end if;

	if p_director_id is not null and not exists (select id from public.employee where id = p_director_id) then
		raise exception 'id сотрудника(руководителя) % отсуствует в базе!', p_director_id;
	end if;

	if p_salary is null then
		select default_salary
		from public.role
		where id = p_role_id
		into l_salary;
	else  l_salary = p_salary;
	end if;
	
	if p_office_id is not null then
		select count(e.*)
		from public.employee e
		join public.office o
		  on o.id = e.office_id
		where e.office_id = dep_id
		into l_current_capacity;

		if (select capacity from public.office where id = p_office_id) <= l_current_capacity then
			raise exception 'Превышена вместимость офиса % !', p_office_id;
		end if;
	end if;

	insert into public.employee(firstname, surname, father_name, dob, dep_id, is_remote, office_id, role_id, director_id, salary)
	values
	(p_firstname, p_surname, p_father_name, p_dob, p_dep_id, p_is_remote, p_office_id, p_role_id, p_director_id, l_salary) returning id into p_id;

exception
		when others then
		get stacked diagnostics l_context = pg_exception_context;
		raise notice 'Ошибка при добавлении сотрудника: % на этапе %', sqlerrm, l_context;
end;
$$;

/*
При добавлении сотрудника - возращаем айдишник для дальнейшей обработки в бэке

DO $$ 
DECLARE 
l_id int8;
BEGIN
call public.add_employee(p_firstname:= 'Иван', p_surname:= 'Иванов', p_dob:= '01-01-1991'::date, p_dep_id:= 1, p_is_remote:= false, p_role_id:= 2, p_id:= l_id);
call public.add_employee(p_firstname:= 'Иван', p_surname:= 'Иванов', p_dob:= '01-01-1991'::date, p_dep_id:= 1, p_is_remote:= false, p_role_id:= 2, p_id:= l_id, p_office_id:=1);

RAISE NOTICE 'id: %', l_id;
END $$;
*/