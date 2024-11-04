/*
 drop procedure update_employee(int8, text,text,date,int8,boolean,int8,text,int8,int8,decimal);
*/
create or replace procedure public.update_employee(p_id int8,
												   p_firstname text default null,
												   p_surname text default null,
												   p_dob date default null,
												   p_dep_id int8 default null,
												   p_is_remote boolean default null,
												   p_role_id int8 default null,
												   p_father_name text default null,
												   p_office_id int8 default null,
												   p_director_id int8 default null,
												   p_salary decimal(10,2) default null)
language plpgsql
as $$
declare l_current_capacity int4;
		l_context text;
begin
	
	if p_salary <= 0 then
		raise exception 'зарплата не может быть меньше или равна 0!';
	end if;

	if not exists (select id from public.employee where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
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

	update public.employee
	set firstname = coalesce(p_firstname, firstname) 
	   ,surname = coalesce(p_surname, surname)
	   ,father_name = coalesce(p_father_name, father_name)
	   ,dob = coalesce(p_dob, dob)
	   ,dep_id = coalesce(p_dep_id, dep_id)
	   ,is_remote = coalesce(p_is_remote, is_remote)
	   ,office_id = coalesce(p_office_id, office_id)
	   ,role_id = coalesce(p_role_id, role_id)
	   ,director_id = coalesce(p_director_id, director_id)
	   ,salary = coalesce(p_salary, salary)
	where id = p_id;

exception
		when others then
		get stacked diagnostics l_context = pg_exception_context;
		raise notice 'Ошибка при обновлении сотрудника: % на этапе %', sqlerrm, l_context;
end;
$$;

/*
 Пример использования:
 call public.update_employee(p_id := 2, p_firstname:= 'Аристарх', p_surname:= 'Иванов', p_dob:= '01-11-1996'::date, p_dep_id:= 1, p_is_remote:= false, p_role_id:= 2, p_salary:=50);
 * */