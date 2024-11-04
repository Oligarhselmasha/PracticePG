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
		raise notice '������ ��� ���������� ������: %', sqlerrm;
end;
$$;

/*
��� ���������� ������ - ��������� �������� ��� ���������� ��������� � ����

DO $$ 
DECLARE 
l_id int8;
l_description text = '����� �� ������ � �������������';
BEGIN
call public.add_department(l_description, l_id);

RAISE NOTICE 'id: %', l_id;
END $$;
*/