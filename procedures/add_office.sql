/*
 drop procedure if exists add_office(text,int,bigint);
*/
create or replace procedure public.add_office(p_description text,
											  p_capacity int4,
											  p_id inout int8 )
language plpgsql
as $$
begin

	if p_capacity <= 0 then
		raise exception 'вместимость не может быть меньше или равна 0!';
	end if;

	insert into public.office(description, capacity)
	values
	(p_description, p_capacity) returning id into p_id;

exception
		when others then
		raise notice 'Ошибка при добавлении офиса: %', sqlerrm;
end;
$$;

/*
При добавлении офиса - возращаем айдишник для дальнейшей обработки в бэке

DO $$ 
DECLARE 
l_id int8;
l_office text = 'Офис домашний';
l_capacity int4 = 3;
BEGIN
call public.add_office(l_office, l_capacity, l_id);
RAISE NOTICE 'id: %', l_id;
END $$;
*/