insert into public.office (description, capacity)
values
('����������� open-space', 100),
('��������� ������', 50),
('��������� ������', 50);

insert into public.department (description)
values
('�������'),
('�������'),
('IT'),
('�����������');

insert into public.role (description, default_salary)
values
('���������� �� ������', 100000),
('���������� �� ��������', 80000),
('����������� 3 ���������', 50000),
('����������� 2 ���������', 150000),
('����������� 1 ���������', 250000);

insert into public.employee (firstname, surname, father_name, dob, dep_id, is_remote, office_id, role_id,  salary)
values
('������','����','��������', '03-10-1991'::date, 1, false, 1, 4,  150000);


insert into public.employee (firstname, surname, father_name, dob, dep_id, is_remote, office_id, role_id, director_id, salary)
values
 ('������','�������','����������', '03-03-1991'::date, 1, false, 1, 4, 3, 100000)
,('�������','����','���������', '03-03-1990'::date, 1, false, 2, 2, 3, 600000)
,('���������','����������','���������', '03-03-1960'::date, 1, true, 3, 3, 3, 100000)
,('����','����','��������', '03-03-1980'::date, 1, false, 1, 4, 3, 800000)
;