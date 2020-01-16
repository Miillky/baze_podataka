create table studenti(
	jmbag number(8) not null,
	prezime varchar2(20) not null,
	ime varchar2(20) not null,
	redovni number(1) default 1 not null
);

create table studenti(
	jmbag number(8) not null,
	prezime varchar2(20) not null,
	ime varchar2(20) not null,
	redovni number(1) default 1 not null,
	mobitel number(12) null,
	e_mail varchar2(40)
);

insert into studenti
	(jmbag, prezime, ime)
values
	(12345, 'Vukoja', 'Oliver');

insert into studenti
	(jmbag, prezime, ime)
values
	(12346, 'Milković', 'Vedran');

insert into studenti
	(jmbag, prezime, ime)
values
	(12347, 'Zorić', 'Tomislav', null);

insert into studenti
	(jmbag, prezime)
values
	(12348, 'Skender'); /* Greška jer je prezime obavezno */

select * from studenti;

/* Primary keys */
drop table studenti;

create table studenti(
    jmbag number(8) not null,
    prezime varchar2(20) not null,
    ime varchar2(20) not null,
    redovni number(1) default 1 not null,
    mobitel number(12) null,
    e_mail varchar2(40) null,
    CONSTRAINT pk_studenti_j primary key (jmbag)
);

insert into studenti
    (jmbag, prezime, ime)
values
    (12345, 'Vukoja', 'Oliver');

select * from studenti;

insert into studenti
    (jmbag, prezime, ime)
values
    (12345, 'Zorić', 'Tomislav'); /* Greška jer id korisnika već postoji (jmbag) koji je primary key */

insert into studenti
    (jmbag, prezime, ime)
values
    (12346, 'Zorić', 'Tomislav');

select * from studenti;

/* Dodavanje primarnog ključa postojećoj tablici */
ALTER TABLE table_name
ADD CONSTRAINT constraint_name PRIMARY KEY (column1, column2, ... column_n);

/* Sintaksa za brisanje primarnog ključa */
ALTER TABLE talbe_name
DROP CONSTRAINT constraint_name;

alter table studenti
add constraint pk_ime unique (ime);

insert into studenti
    (jmbag, prezime, ime)
values
    (12347, 'Skender', 'Oliver') /* Greška unique constraint violated (jer je ime unitque) */