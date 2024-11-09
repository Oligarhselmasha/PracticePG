insert into public.office (description, capacity)
values
('Центральный open-space', 100),
('Уральский филиал', 50),
('Сибирский филиал', 50);

insert into public.department (description)
values
('Закупки'),
('Продажи'),
('IT'),
('Бухгалтерия');

insert into public.role (description, default_salary)
values
('Специалист по закупу', 100000),
('Специалист по продажам', 80000),
('Программист 3 категории', 50000),
('Программист 2 категории', 150000),
('Программист 1 категории', 250000);

insert into public.employee (firstname, surname, father_name, dob, dep_id, is_remote, office_id, role_id,  salary)
values
('Петров','Петр','Петрович', '03-10-1991'::date, 1, false, 1, 4,  150000);

insert into public.employee (firstname, surname, father_name, dob, dep_id, is_remote, office_id, role_id, director_id, salary)
values
 ('Кирилл','Буланов','Дмитриевич', '03-03-1991'::date, 1, false, 1, 4, 3, 100000)
,('Саманта','Смит','Джексовна', '03-03-1990'::date, 1, false, 2, 2, 3, 600000)
,('Сильвестр','Грушевский','Яковлевич', '03-03-1960'::date, 1, true, 3, 3, 3, 100000)
,('Джон','Уэйн','Петрович', '03-03-1980'::date, 1, false, 1, 4, 3, 800000)
;