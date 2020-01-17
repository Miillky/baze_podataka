/*Kopiranje tablice*/
create table new_table
	as (select * from old_table)M

/*Kopiranje samo pojedinih polja stare tablicu u novu tablicu*/
create table new_table
	as (select column_1, coumn_2, ... column_n
		from old_table);

/*Kreiranje tablice bez podataka*/
create table kopija_tablice_a
	as (select *
		from tablica_a where 1=2);

create table mjesta1
	as (select *
		from mjesta where 1=2)


/*Insert*/
insert into table
	(column1, column2, ... column_n)
values
	(expression1, expression2, ... expression_n);

insert into table
	(column1, column2, ... column_n)
	sekect expression1, expression2, ... expression_n
from source_table
	[WHERE coindtions];

insert into klijenti
	(klijent_id, klijent_ime)
select
	dobavljac_id, dobavljac_ime
from
	dobavljaci
where not exists
(select
	*
from
	klijenti
where
	klijenti.klijent_id = dobavljaci.dobavljac_id)

insert into mjesta1(
	select
		*
	from
		mjesta1
	where
		mjesta.mjesto_a = mjesta1.mjesto_a and
		mjesta1.mjesto_a like 'Š___') and
mjesto_a like 'Š%');

/*import data opcija insert*/
insert into mjesta (id, mjesto_a, mjesto_b, zupanija)
values (seq_mjesta.nextval, 'Žuta Lokva', 'Brinje', 21);

insert into mjesta (id, mjesto_a, mjesto_b, zupanija)
values (seq_mjesta.nextval, 'Žutnica', 'Krapina', 18);

-- ovi insertovi su se mogli zapisati pojednostavljeno
insert all
	into mjesta (id, mjesto_a, mjesto_b, zupanija) values
		(seq_mjesta.nextval, 'Žuta Lokva', 'Brinje', 21)
	into mjesta (id, mjesto_a, mjesto_b, zupanija) values
		(seq_mjesta.nextval, 'Žutinica', 'Krapina', 18)
select * from dual;

-- prethodni zapis nam omogućava unos podataka u više tablica pa možemo zapisati

insert all
	into mjesta (id, mjesto_a, posta, mjesto_b, zupanija) values
		(seq_mjesta.nextval, 'Lučko', 10250, 'Lučko', 1);
	ubti zupanije (id, zupanija) values
		(1, 'GRAD ZAGREB')
	into prirezi (id, mjesto, iznos) values
		(seq_prirezi.nextval, 'Adrijaševci', 8.0)
select * from dual;

/*Update*/
update table
 set coulmn1 = expression1,
	 coulmn2 = expression2,
	 ...
	 column_n = expression_n
[WHERE conditions];

-- sintaksa za update jedne tablice s podacima iz druge tablice
update table1
set coulmn1 = (select expression1
				from table2
				where conditions)
[WHERE condition];

-- update sa exit uvijetom
update
	mjesta1
set
	satatus = 2
where exists
	(select
		1
	from
		mjesta
	where
		mjesta.id = mjesta1.id);

/*Brisanje podataka iz dablice*/
delete from table
	[where contidions];

select * from mjesta1
	where exists
		(select 1
		from mjesta
		where mjesta.id = mjesta1.id
		and mjesta.id < 1000);

select count(1) from mjesta1
where exists
	(select 1
	from mjesta
	where mjesta.id = mjesta1.id
	and mjesta.id < 1000);

delete from mjesta1
	where exists
		(select 1
			from mjesta
			where mjesta.id = mjesta1.id
			and mjesta.id < 1000)


/*Redosljed za izradu mjesta1 tablice*/
create table mjesta1
    as (select * from mjesta where 1=2);

insert into mjesta1 select * from mjesta where mjesto_a like '___';

insert into mjesta1(
    select * from mjesta
    where not exists
        (select * from mjesta1
        where
            mjesta.mjesto_a = mjesta1.mjesto_a and
            mjesta1.mjesto_a like 'Š__') and
            mjesto_a like 'Š%');

select * from mjesta1
    where exists
        (select 1
            from mjesta
            where mjesta.id = mjesta1.id
            and mjesta.id < 1000);