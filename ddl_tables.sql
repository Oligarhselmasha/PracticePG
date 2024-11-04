/*
 drop table if exists public.office cascade;
 drop table if exists public.department  cascade;
 drop table if exists public.role  cascade;
 drop table if exists public.employee  cascade;
*/

create table if not exists public.office
(
	id serial8 
   ,description text not null unique
   ,capacity int4 not null
);

alter table public.office
add primary key (id);

create table if not exists public.department
(
	id serial8
   ,description text not null unique
);

alter table public.department
add primary key (id);


create table if not exists public.role
(
	id serial8
   ,description text not null unique
   ,default_salary decimal(10,2) not null
);

alter table public.role
add primary key (id);

create table if not exists public.employee
(
	id serial8
   ,firstname text not null
   ,surname text not null
   ,father_name text 
   ,dob date not null
   ,dep_id int8 not null
   ,is_remote boolean not null
   ,office_id int8
   ,role_id int8 not null
   ,director_id int8
   ,salary decimal(10,2) not null
);

alter table public.employee
add primary key (id);

alter table public.employee
add constraint fk_office_id foreign key (office_id) 
references public.office (id)
on delete set null;

alter table public.employee
add constraint fk_department_id foreign key (dep_id) 
references public.department (id)
on delete cascade;

alter table public.employee
add constraint fk_role_id foreign key (role_id) 
references public.role (id)
on delete cascade;

alter table public.employee
add constraint fk_director_id foreign key (director_id) 
references public.employee (id)
on delete set null;

grant all privileges on all tables in schema public to public;

