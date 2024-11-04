/*
 drop procedure if exists update_office(bigint,text,int);
*/
create or replace procedure public.update_office(p_id int8,
												 p_description text default null,
												 p_capacity int4 default null)
language plpgsql
as $$
begin
	
	if not exists (select id from public.office where id = p_id) then
		raise exception 'id % отсуствует в базе!', $1;
	end if;

	if p_capacity <= 0 then
		raise exception 'вместимость не может быть меньше или равна 0!';
	end if;

	update public.office
	set description = coalesce(p_description, description) 
	   ,capacity = coalesce(p_capacity, capacity)
	where id = p_id;
exception
		when others then
		raise notice 'Ошибка при обновлении офиса: %', sqlerrm;
end;
$$;

/*
 Пример использования:
 call public.update_office(p_id := 8, p_capacity := 4);
 call public.update_office(p_id := 2,  p_description := 'Уральский филиал', p_capacity := 70); 
 * */