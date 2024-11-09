/*
 drop procedure if exists update_role(bigint,text,decimal);
*/
create or replace procedure public.update_role(p_id int8,
											   p_description text default null,
											   p_salary decimal(10,2) default null)
language plpgsql
as $$
begin
	
	if not exists (select id from public.role where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
	end if;

	if p_salary <= 0 then
		raise exception 'зарплата не может быть меньше или равна 0!';
	end if;

	update public.role
	set description = coalesce(p_description, description) 
	   ,default_salary = coalesce(p_salary, default_salary)
	where id = p_id;
exception
		when others then
		raise notice 'Ошибка при обновлении роли: %', sqlerrm;
end;
$$;


/*
 Пример использования:
 call public.update_role(p_id := 1, p_salary := 4000000);
 call public.update_role(p_id := 6,  p_description := 'Главный бухгалтер', p_salary := 8000000); 
 * */
