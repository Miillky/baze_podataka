/*Brisanje tablica*/
DROP TABLE ime_tablice;

/*Readonly tablica*/
ALTER TABLE ime_tablice READ ONLY;

/*Vraćanje tablice iz readonly*/
ALTER TABLE ime_tablice READ WRITE;

/*Izmjena naziva tablice*/
RENAME staro_ime TO novo_ime;

/*Izmjena naziva polja*/
ALTER TABLE ime_tablice RENAME COLUMN staro_ime TO novo_ime;

/*Dodavanje polja u tablicu*/
ALTER TABLE ime_tablice ADD(
	ime_polja definicija_polja,
	ime_polja definicija_polja
);

/*Brisanje polja (fizičko)*/
ALTER TABLE ime_tablice DROP COLUMN (ime_polja1, ime_polja2);

/*Ili naknadno fizičko brisanje polja kada baza nije opterečena (kod velikih tablica)*/
ALTER TABLE ime_tablice SET UNSET (ime_polja1, ime_polja2);
ALTER TABLE ime_tablice DROP UNUSED COLUMNS;

/*Promjena tipa podaka na polju u tablici*/
ALTER TABLE ime_Tablice MODIFY(
	ime_polja novi_tip_podataka
);

/*Dodavanje komentara na tablicu*/
COMMENT ON TABLE ime_tablice IS 'tekst komentara'
COMMENT ON TABLE studenti is 'Ovo je tablica s popisom svih studenata';

/*Dodavanje komentara na polje*/
COMMENT ON COLUMN ime_tablice.ime_polja IS 'tekst komentara';
COMMENT ON COLUMN studenti.jmbag is 'Jedinstveni broj akademskog građana';

/*Opis tablice*/
DESC ime_tablice;

/*Dohvaćanje podataka*/
create table studenti(
    jmbag number(8) not null,
    prezime varchar2(20) not null,
    ime varchar2(20) not null,
    redovni number(1) default 1 not null,
    godiste number(4)  not null,
    spol varchar2(1) not null,
    pozivni_mob number(3) null,
    mobitel number(9) null,
    e_mail varchar2(40) null,
    constraint pk_studenti_jmbag primary key (jmbag),
    constraint check_spol
    check (spol in ('M', 'F')),
    constraint check_pozivni
    check (pozivni_mob in(99,98,97,95,92,91))
);

Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12367,'Vukoja','Oliver',1,1997,'M',98,587451,'OVUKOJA@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12368,'Zorić','Tomislav',1,1995,'M',98,685973,'TZORIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12369,'Kopčić','Josip',1,1997,'M',95,574123,'JKOPCIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12370,'Marinić','Jelena',1,1996,'F',91,564873,'JMARINIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12371,'Arnold','Mirela',1,1994,'F',91,147985,'MARNOLD@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12373,'Reš¡tarović','Karmela',1,1997,'F',97,268951,'KRESTAROVIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12374,'Klisović','Sanja',1,1994,'F',92,547847,'JKLISOVIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12375,'Kunović','Damir',1,1995,'M',98,647894,'DKUNOVIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12376,'Hundrić','Stjepan',1,1995,'M',98,325861,'SHUNDRIC@VUB.HR');
Insert into STUDENTI (JMBAG,PREZIME,IME,REDOVNI,GODISTE,SPOL,POZIVNI_MOB,MOBITEL,E_MAIL) values
(12377,'Krnjić','Marina',1,1996,'F',91,265875,'MKRNJIC@VUB.HR');

SELECT izraz
FROM tablice
	[WHERE uvjet]
	[ORDER BY izraz [ASC | DESC]];

SELECT * FROM studenti;

/*Studenti koji su 1997 godište*/
SELECT * FROM studenti WHERE GODISTE = 1997;

/*Dohvatite ime prezime i godine starosti za sve muške studente*/
SELECT ime, prezime, (2018 - godiste) FROM studenti WHERE SPOL = 'M';

/*Dohvatite ime i prezime studenata mlađih od 23 godina*/
SELECT
    ime, prezime, (to_number(to_char(sysdate, 'YYYY')) - godiste ) starost
from
    studenti
where
    (to_number(to_char(sysdate, 'YYYY')) - godiste ) <= 23;

/*Sysdate*/
select sysdate from dual;
select to_char(sysdate, 'YYYY/MM/DD')as datum from dual;
select 5*(13-1) as matematika from dual

/* Koje sve mreže mobitela koriste žene?*/
SELECT DISTINCT pozivni_mob FROM studenti WHERE spol = 'F';

/*Dohvatite ime i prezime studenata (ime i prezime treba spojiti), kraj imena i prezimena ispišite muško | žensko */
SELECT
    ime ||' '|| prezime,
    case spol
    when 'M' then
        'muško'
    when 'F' then
        'žensko'
    else
        null
    end as naziv_spola
from studenti;

/* ili */
SELECT
    ime || prezime AS "Ime i prezime",
    case spol
    when 'M' then
        'muško'
    when 'F' then
        'žensko'
    else
        null
    end as naziv_spola
from studenti;

/*ili*/

SELECT
    ime || prezime AS ime_i_prezime,
    case spol
    when 'M' then
        'muško'
    when 'F' then
        'žensko'
    else
        null
    end as naziv_spola
from studenti;

/*Dohvatite sve sudente kojima je godište između 1995 i 1997. */
select
    ime, prezime, godiste
from
    studenti
where
    godiste between 1995 and 1997;

/*Dohvatite sve studente kojima su ili 1995. ili 1997. godište*/
select
    ime, prezime, godiste
from
    studenti
where
    godiste in(1995, 1997);

/*ili*/

select
    ime, prezime, godiste
from
    studenti
where
    godiste = 1995 OR
    godiste = 1997;

/*Dohvatite sve sudente koji nisu 1995 ili 1997. godište*/
select
    ime, prezime, godiste
from
    studenti
where
    godiste not in (1995, 1997);

/*ili*/
select
    ime, prezime, godiste
from
    studenti
where
    godiste != 1995 and
    godiste != 1997;

/*Dohvatite sve studente kojima ime počinje sa S*/
select
    *
from
    studenti
where
    ime like 'S%';