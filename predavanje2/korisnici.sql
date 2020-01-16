create table korisnici(
    id_korisnika number(10) not null,
    ime varchar2(20),
    prezime varchar2(20),
    e_mail varchar2(60),
    e_mail_domena varchar2(60 CHAR) as (substr(e_mail,
        instr(e_mail, '@', 1, 1)+1)) virtual );

insert into korisnici
    (id_korisnika, ime, prezime, e_mail)
values
    (73298, 'Vedran', 'Milković', 'vmilkovic@vub.hr');

select * from korisnici;

/* Pregled output-a funkcije */
select substr('vmilkovic@vub.hr', instr('vmilkovic@vub.hr', '@', 1,1)+1) from dual;