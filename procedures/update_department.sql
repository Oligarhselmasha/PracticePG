/*
 drop procedure if exists update_department(bigint,text);
*/
create or replace procedure public.update_department(p_id int8,
											   p_description text)
language plpgsql
as $$
begin
	
	if not exists (select id from public.department where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
	end if;

	update public.department
	set description = coalesce(p_description, description) 
	where id = p_id;
exception
		when others then
		raise notice 'Ошибка при обновлении отдела: %', sqlerrm;
end;
$$;


/*
 Пример использования:
 call public.update_department(p_id := 3,  p_description := 'Отдел информационных технологий'); 
 * */