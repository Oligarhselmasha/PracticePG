/*
 drop procedure if exists delete_office(bigint);
*/
create or replace procedure public.delete_office(p_id int8)
language plpgsql
as $$
begin
	
	if not exists (select id from public.office where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
	end if;

	delete from public.office
	where id = p_id;
exception
		when others then
		raise notice 'Ошибка при удалении офиса: %', sqlerrm;
end;
$$;

/*
 Пример использования:
 call public.delete_office(1);
 * */