/*
 drop procedure if exists delete_employee(bigint);
*/
create or replace procedure public.delete_employee(p_id int8)
language plpgsql
as $$
begin
	
	if not exists (select id from public.employee where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
	end if;

	delete from public.employee
	where id = p_id;
exception
		when others then
		raise notice 'Ошибка при удалении сотрудника: %', sqlerrm;
end;
$$;


/*
 Пример использования:
 call public.delete_employee(1);
 * */
