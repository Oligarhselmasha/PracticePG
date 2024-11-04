/*
 drop procedure if exists add_department(text,bigint);
*/
create or replace procedure public.add_department(p_description text
												 ,p_id inout int8)
language plpgsql
as $$
begin

	insert into public.department(description)
	values
	(p_description) returning id into p_id;

exception
		when others then
		raise notice 'Ошибка при добавлении отдела: %', sqlerrm;
end;
$$;

/*
При добавлении отдела - возращаем айдишник для дальнейшей обработки в бэке

DO $$ 
DECLARE 
l_id int8;
l_description text = 'Отдел по борьбе с задолженостью';
BEGIN
call public.add_department(l_description, l_id);

RAISE NOTICE 'id: %', l_id;
END $$;
*/