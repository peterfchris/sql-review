-- https://postgres.devmountain.com/
-- when googling, specify: postgresSQL

-- # Sql order of operations
1. from - Choose and join tables to get base data
2. where - filters the base data
3. group by - aggregates the base data 
4. having - filters the aggregated data
5. select - returns the final data 
6. order by - sorts the final data 
7. limit - limits the returned data to a row count
-- # Querying rows
<!-- select distinct -->
select distinct city from customer;
<!-- updating rows -->
update customer 
set first_name = 'John', last_name = 'Wayne'
where customer_id = 1;
<!-- setting values to null -->
update customer 
set address = null
where customer_id = 1;
<!-- deleting rows (run select first) -->
select * from playlist_track
where playlist_id = 1;
delete from playlist_track
where playlist_id = 1;
# Altering a table 
<!-- Altering a table -->
create table pets (
    id serial primary key,
    type text
)
<!-- adding a column -->
ALTER TABLE pets
ADD COLUMN name text
<!-- altering column data type -->
ALTER TABLE pets
ALTER COLUMN type
SET DATA TYPE varchar(20);
ALTER TABLE pets
ALTER type
TYPE varchar(20);
<!-- renaming a table -->
ALTER TABLE pets
RENAME COLUMN type
TO species;
<!-- Dropping a column -->
ALTER TABLE pets
DROP COLUMN name;
<!-- renaming a table -->
ALTER TABLE pets
RENAME TO animals;
<!-- Dropping a table -->
DROP TABLE animals
<!-- foreign keys -->
CREATE TABLE networth (
  id SERIAL PRIMARY KEY,
  foreign_id INTEGER REFERENCES artist (artist_id),
  amount integer
)
<!-- adding foreign key after creation -->
ALTER TABLE networth
ADD COLUMN artist_id integer REFERENCES artist (artist_id)
# Joining Tables
<!-- Inner join (must have match in both) -->
select *
from artist ar
join album al
on al.artist_id = ar.artist_id;
<!-- outer join (joins records from both that don't have matches) -->
select *
from artist ar
full join album al
on al.artist_id = ar.artist_id;
<!-- Left join (joins records and pulls all from left table regardless of match) -->
select *
from artist ar
left join album al
on al.artist_id = ar.artist_id;
<!-- Right join (joins records and pulls all from left table regardless of match) -->
select *
from artist ar
right join album al
on al.artist_id = ar.artist_id;
# Relationship examples
<!-- one to one relationship set up  -->
create table social_security_number (
    id serial primary key,
    number integer 
);
create table person (
    id serial primary key,
    name text,
    social_security_id integer references social_security_number(id) UNIQUE
);
insert into social_security_number (number) 
values (22342432);
insert into person (name, social_security_id)
values ('Zach', 1);
insert into person (name, social_security_id) 
values ('John', 1);
<!-- one to many relationship set up -->
create table books (
    id serial primary key,
    book_name text
);
create table author (
    id serial primary key,
    author_name text,
    book_id integer references books(id)
);
insert into books (book_name)
values ('Micro');
insert into author (author_name, book_id)
values ('Michael Crichton', 1), ('Richard Preston', 1);
select * from author;
<!-- Many to many relationship set up -->
create table classes (
    id serial primary key,
    class_name text
);
create table students (
    id serial primary key,
    student_name text
);
create table class_student_link (
    id serial primary key,
    student_id integer references students(id),
    class_id integer references classes(id)
);
insert into classes (class_name) 
values ('Biology'), ('Chemistry');
insert into students (student_name)
values ('John'), ('Lisa');
insert into class_student_link (student_id, class_id)
values (1, 1), (1, 2), (2, 1), (2, 2);
select * from 
classes c
join class_student_link l
on l.class_id = c.id 
join students s 
on l.student_id = s.id;
# Sub select
<!-- nested subquery -->
select * from album
where artist_id in (
    select artist_id from artist 
  where name ilike 'a%'
  );
  
# Group by
<!-- group by -->
select count(*), genre_id
from track
group by genre_id;
select count(*), g.name, t.genre_id from track t
join genre g
on g.genre_id = t.genre_id
group by t.genre_id, g.name;
# Having 
<!-- having -->
select count(*), g.name, t.genre_id from track t
join genre g
on g.genre_id = t.genre_id
group by t.genre_id, g.name
having count(*) > 80;