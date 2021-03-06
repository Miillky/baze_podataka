/*Na temelju vježbe iz web programiranje 1, koja se nalazi na sljedećoj stranici ispod, potrebno je
kreirati model baze podataka sa svim constraint-ima, te unesite po 5 zapisa u svaku tablicu.
Na kraju vježbe napišite select koji će spojiti sve tablice i prikazati sve podatke.*/

/*
Izradite formu u kojoj ćete koristiti HTML5 elemente
- osnovni podaci (korisnici)
ime required 60 max char
prezime required 60 max char
email required 60 max char
pozivni broj mobitela (dropdown lista s mogućim brojevima mobitela) required 3 max number
broj mobitela required 7 max number
spol radio button slati broj 0 muško 1 žensko required 1 max number
Datum rođenja required date
- adresa korisnika (adrese)
Adresa 60 max char
Kućni broj 4 max number
Dodatni broj 10 max char
Grad 40 max char
Županija (slati broj na temelju podataka na sljedećoj stranici dropdown ) 2 max number
- ostali podaci (trivia)
Broj kućnih ljubimaca preko range-a (0 do max 5) 1 max number
Omiljena boja slati #heksa broj 7 max char
Omiljeni film - link s imdb-a url 200 max char
Odaberite vrstu programskog jezika (web programiranje, mobilno programiranje, baze, game development)
radio button slati (1,2,3,4) 1 max number
*/

/*
1 GRAD ZAGREB
2 ZAGREBAČKA
3 DUBROVAČKO-NERETVANSKA
4 SPLITSKO-DALMATINSKA
5 ŠIBENSKO-KNINSKA
6 ZADARSKA
7 OSJEČKO-BARANJSKA
8 VUKOVARSKO-SRIJEMSKA
9 VIROVITIČKO-PODRAVSKA
10 POŽEŠKO-SLAVONSKA
11 BRODSKO-POSAVSKA
12 MEĐIMURSKA
13 VARAŽDINSKA
14 BJELOVARSKO-BILOGORSKA
15 SISAČKO-MOSLAVAČKA
16 KARLOVAČKA
17 KOPRIVNIČKO-KRIŽEVAČKA
18 KRAPINSKO-ZAGORSKA
29 PRIMORSKO-GORANSKA
20 ISTARSKA
21 LIČKO-SENJSKA
*/

create table zupanije(
    broj number(2) generated by default as identity (start with 1) not null primary key,
    naziv varchar2(60) not null
);

select * from zupanije;

insert into zupanije (naziv) values ('GRAD ZAGREB');
insert into zupanije (naziv) values ('ZAGREBAČKA');
insert into zupanije (naziv) values ('DUBROVAČKO-NERETVANSKA');
insert into zupanije (naziv) values ('SPLITSKO-DALMATINSKA');
insert into zupanije (naziv) values ('ŠIBENSKO-KNINSKA');
insert into zupanije (naziv) values ('ZADARSKA');
insert into zupanije (naziv) values ('OSJEČKO-BARANJSKA');
insert into zupanije (naziv) values ('VUKOVARSKO-SRIJEMSKA');
insert into zupanije (naziv) values ('VIROVITIČKO-PODRAVSKA');
insert into zupanije (naziv) values ('POŽEŠKO-SLAVONSKA');
insert into zupanije (naziv) values ('BRODSKO-POSAVSKA');
insert into zupanije (naziv) values ('MEĐIMURSKA');
insert into zupanije (naziv) values ('VARAŽDINSKA');
insert into zupanije (naziv) values ('BJELOVARSKO-BILOGORSKA');
insert into zupanije (naziv) values ('SISAČKO-MOSLAVAČKA');
insert into zupanije (naziv) values ('KARLOVAČKA');
insert into zupanije (naziv) values ('KOPRIVNIČKO-KRIŽEVAČKA');
insert into zupanije (naziv) values ('KRAPINSKO-ZAGORSKA');
insert into zupanije (naziv) values ('PRIMORSKO-GORANSKA');
insert into zupanije (naziv) values ('ISTARSKA');
insert into zupanije (naziv) values ('LIČKO-SENJSKA');

create table korisnici(
	id number(8) generated by default as identity (start with 1) not null primary key,
    ime varchar2(60) not null,
    prezime varchar2(60) not null,
    email varchar2(60) not null,
    pozivni_broj_mobitela number(3) not null,
    broj_mobitela number(7) not null,
    spol number(1) not null,
    datum_rodenja date default sysdate not null,
    constraint pozivni_mobitel
        check (pozivni_broj_mobitela in(99,98,97,95,92,91)),
    constraint check_spol
        check (spol in (0,1))
);

insert into korisnici
    (ime, prezime, email, pozivni_broj_mobitela, broj_mobitela, spol, datum_rodenja)
values
    ('Vedran', 'Milković', 'vmilkovic@vub.hr', 98, 9533857, 0, '25.1.1990');

create table adrese(
    korisnik number(8) not null,
    adresa varchar2(60) null,
    kucni_broj number(4) null,
    dodatni_broj varchar2(10) null,
    grad varchar2(40) null,
    zupanija number(2) not null,
    constraint fk_korisnik_adrese
        foreign key (korisnik)
        references korisnici(id),
    constraint fk_zupanija
        foreign key (zupanija)
        references zupanije(broj)
);

create table programski_jezici(
    broj number(1) generated by default as identity (start with 1) not null primary key,
    naziv varchar2(60) not null
);

insert into programski_jezici (naziv) values ('web programiranje');
insert into programski_jezici (naziv) values ('mobilno programiranje');
insert into programski_jezici (naziv) values ('baze');
insert into programski_jezici (naziv) values ('game development');

select * from programski_jezici;

create table trivia (
	id number(8) generated by default as identity (start with 1) not null primary key,
    korisnik number(8) not null,
	broj_kucnih_ljubimaca number(1) null,
    omiljena_boja varchar2(7) null,
    omiljeni_film varchar2(200),
    programski_jezik number(1) null,
	constraint fk_korisnik_trivia
        foreign key (korisnik)
        references korisnici(id),
    constraint kucni_ljubimci
        check (broj_kucnih_ljubimaca >= 0 and broj_kucnih_ljubimaca <= 5),
    constraint fk_programski_jezik
        foreign key (programski_jezik)
        references programski_jezici(broj)
);

insert into trivia
    (korisnik, broj_kucnih_ljubimaca, omiljena_boja, omiljeni_film, programski_jezik)
values
    (1, 1, '#cccccc', '12 Angry Men', 1);

select * from korisnici k, adrese a, trivia t, zupanije z, programski_jezici p where
    k.id = a.korisnik and k.id = t.korisnik and a.zupanija = z.broj and t.programski_jezik = p.broj;