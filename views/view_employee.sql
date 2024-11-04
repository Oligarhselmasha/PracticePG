drop view if exists public.view_employee;

create or replace view public.view_employee AS
select e.surname as �������
	  ,e.firstname as ���
	  ,e.father_name as ��������
	  ,r.description  as ���������
	  ,d.description  as �����
	  ,o.description  as ����
	  ,e.dob as ����_��������
	  ,e.is_remote as ���������_������
	  ,e.salary as ��������
	  ,r.default_salary as ��������_��_���������
from public.employee e
left join public.department d 
	   on d.id = e.dep_id
left join public.office o
	   on o.id = e.office_id
left join public.role r
	   on r.id = e.role_id;
	   
/*	  
select *
from public.view_employee
*/