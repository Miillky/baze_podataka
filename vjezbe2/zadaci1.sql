/*
    1. Unijeti 5 studenata u tablicu studenti
    2. Kreirati tablicu predmeti, tablica mora sadržavati numeričku šifru predmeta
    3. Unijeti nekoliko predmeta u tablicu
    4. Kreirati tablicu ocjene koja će povezati predmete i studente
    5. Unijeti nekoliko ocjena u tablicu
    6. Napraviti select koji će povezati te tri tablice tako da se mogu vidjeti ocjene za svkaog sudenta iz pojedinog predmeta
    7. Kreirajte potrebne constraint-e (pk, fk) i sequence za svaku tablicu
*/

create table studenti(
    jmbag number(8) not null,
    prezime varchar2(20) not null,
    ime varchar2(20) not null,
    redovni number(1) default 1,
    mobitel number(12) null,
    e_mail varchar2(40)
);

create sequence seq_studenti_jmbag
    minvalue 1
    maxvalue 999999999999999999999999999
    start with 1
    increment by 1
    cache 20;

insert into studenti
    (jmbag, prezime, ime)
values
    (seq_studenti_jmbag.nextval, 'Milković', 'Vedran');

insert into studenti
    (jmbag, prezime, ime)
values
    (seq_studenti_jmbag.nextval, 'Sedmak', 'Marko');

insert into studenti
    (jmbag, prezime, ime)
values
    (seq_studenti_jmbag.nextval, 'Begović', 'Davor');

select * from studenti;

/* Primary key */
alter table studenti
add constraint pk_studenti_jmbag primary key(jmbag);

/* ili odmah pri kreiranju tablice */
create table studenti(
    jmbag number(8) not null,
    prezime varchar2(20) not null,
    ime varchar2(20) not null,
    redovni number(1) default 1 not null,
    mobitel number(12) null,
    e_mail varchar2(40) null,
    constraint pk_studenti_jmbag primary key (jmbag)
);

create table predmeti(
    sifra number(8) not null,
    naziv varchar2(40) not null,
    constraint pk_predmet_sifra primary key(sifra)
);

create sequence seq_predmeti_sifra
    minvalue 1
    maxvalue 999999999999999999999999999
    start with 1
    increment by 1
    cache 20;

insert into predmeti
    (sifra, naziv)
values
    (seq_predmeti_sifra.nextval, 'Baze podataka');

insert into predmeti
    (sifra, naziv)
values
    (seq_predmeti_sifra.nextval, 'Web programiranje 1');

insert into predmeti
    (sifra, naziv)
values
    (seq_predmeti_sifra.nextval, 'Programiranje mobilnih aplikacija');

select * from predmeti;

create table ocjene
(
    jmbag number(8) not null,
    sifra_predmeta number(8) not null,
    ocjena number(1) default 1 not null,
    constraint fk_jmbag_studenta
        foreign key (jmbag)
        references studenti (jmbag),
    constraint fk_sifra_predmeta
        foreign key (sifra_predmeta)
        references predmeti (sifra)
);

insert into ocjene
    (jmbag, sifra_predmeta, ocjena)
values
    (1, 1, 5);

insert into ocjene
    (jmbag, sifra_predmeta, ocjena)
values
    (1, 2, 4);

insert into ocjene
    (jmbag, sifra_predmeta, ocjena)
values
    (2, 3, 2);

select * from studenti s, predmeti p, ocjene o where s.jmbag = o.jmbag and p.sifra = o.sifra_predmeta;