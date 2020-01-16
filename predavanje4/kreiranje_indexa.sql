select * from studenti where prezime = 'Milković' and ime = 'Vedran';

/*Kreiranje unique indexa*/
CREATE [UNIQUE] INDEX index_name
	ON table_name (column1, column2, ... coumn_n)
	[ONLINE]
	[COMPUTER STATISTICS];

/*Kreiranje non-unique indexa*/
create index ix_imena on studenti
	(prezime, ime);

/* bitan je redosljed where-a jer traži po redosljedu pisanja, tako da je bolje da se pretražuju prvo prezimena, pa nakon toga ime od dobivenih prezimena */
select /*+ index(studenti ix_imena) */ * from studenti where prezime = 'Milković' and ime='Vedran';

/*provjera baze do dolaska rezultata autotrace*/
/*mora se omogučit korisniku autotrace ovlasti*/
grant SELECT_CATALOG_ROLE to vedran;
grant SELECT ANY DICTIONARY to vedran;

/*Case sensitive query*/
select * from
	STUDENTI
WHERE
	UPPER(prezime) = UPPER('MilkoviĆ') AND
	UPPER(ime) = UPPER('VedraN');

/*Sa funkcijama (upper) ne možemo koristiti indexe pa tako moramo definicirat novi function based index*/
create index fx_imena on studenti
    (upper(prezime), upper(ime));

select * from
    studenti
where
    upper(prezime) = upper('MilkoviĆ') and
    upper(ime) = upper('VedraN');

/*Kreiranje function based index-a*/
/*
	mogu se koristit oracle-ove funkcije i funkcije definirane od strane korisnika
	funkcija mora biti determinisitčka tj. za iste ulazne vrijednosti mora vratiti iste izlazne
	funkcija se mora deklarirati kao deterministička
*/

CREATE OR REPLACE
function f_neka_funkcija
(i_ime in varchar2) return varchar2
DETERMINISTIC is ..