/*
 drop procedure if exists delete_role(bigint);
*/
create or replace procedure public.delete_role(p_id int8)
language plpgsql
as $$
begin
	
	if not exists (select id from public.role where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
	end if;

	delete from public.role
	where id = p_id;
exception
		when others then
		raise notice 'Ошибка при удалении роли: %', sqlerrm;
end;
$$;


/*
 Пример использования:
 call public.delete_role(5);
 * */