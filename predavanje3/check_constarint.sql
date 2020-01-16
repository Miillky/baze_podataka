/*
	provjera vrijednostu u polju,
	provjera dvije vrijednostu u različitim poljima u istoj tablici,
	provjera formata podataka koristeći regular expression
*/
CREATE TABLE table_name
(
	column1 datatype null/not null,
	column2 datatype null/not null,
	...
	CONSTRAINT constraint_name CHECK (column_name condition)
	[DISABLE]
);

CREATE TABLE mobiteli(
    mobitel_id numeric(8),
    pozivni_broj numeric(3),
    mobitel_broj numeric(7),
    CONSTRAINT check_pozivni
    CHECK (pozivni_broj in (99,98,97,95,92,91) )
);

insert into mobiteli
    (mobitel_id, pozivni_broj, mobitel_broj)
values
    (1,99, 5982354);

select * from mobiteli;

insert into mobiteli
    (mobitel_id, pozivni_broj, mobitel_broj)
values
    (1, 96, 8954221); /* Greška jer imamo constraint u pozivni broj polju jer se 96 ne nalazi u constarntu */

/* Definiranje check constraint-a */
CHECK(ime_polja BETWEEN 100 AND 999)
CHECK(ime_polja IN (1,2,3))
CHECK(ime_polja1 > ime_polja2)
CHECK(REGEXP_LIKE(e_mail, ‘^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$’ ))

ALTER TABLE klijenti
ADD CONSTRAINT check_dobavljaci
	CHECK (dobavljaci IN('IBM', 'Microsoft', 'NVIDIA'));