/*
 drop procedure if exists add_role(text,decimal,bigint);
*/
create or replace procedure public.add_role(p_description text,
											p_salary decimal(10,2),
											p_id inout int8)
language plpgsql
as $$
begin

	if p_salary <= 0 then
		raise exception '�������� �� ����� ���� ������ ��� ����� 0!';
	end if;

	insert into public.role(description, default_salary)
	values
	(p_description, p_salary) returning id into p_id;

exception
		when others then
		raise notice '������ ��� ���������� ����: %', sqlerrm;
end;
$$;

/*
��� ���������� ���� - ��������� �������� ��� ���������� ��������� � ����

DO $$ 
DECLARE 
l_id int8;
l_description text = '���������';
l_salary int4 = 500000;
BEGIN
call public.add_role(l_description, l_salary, l_id);

RAISE NOTICE 'id: %', l_id;
END $$;
*/