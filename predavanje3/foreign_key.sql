ALTER TABLE korisnici
ADD CONSTRAINT pk_korisnici
    PRIMARY KEY (id_korisnika);

ALTER TABLE prodaja
ADD CONSTRAINT fk_korisnici
    FOREIGN KEY (id_korisnika)
    REFERENCES korisnici (id_korisnika);

insert into prodaja
    (id_prodaje, id_korisnika, cijena, porez, dostava)
values
    (seq_prodaja.nextval, 12345, 400, 100, 18); /* Greška jer ne postoji sekvenca i ne postoji korisnik sa id-om prodaje od 12345) */

create sequence seq_prodaja_id
    minvalue 1
    maxvalue 999999999999999999999999999
    start with 12345
    increment by 1
    cache 20;

insert into korisnici
    (id_korisnika, ime, prezime, e_mail)
values
    (12345, 'Ivica', 'Molnar', 'imolnar@fmail.com');

insert into prodaja
    (id_prodaje, id_korisnika, cijena, porez, dostava)
values
    (seq_prodaja_id.nextval, 12345, 400, 100, 18);

select * from prodaja;

/* Brisanje podatak */
/* Da ne dođe do orphan zapisa (zapisi koji se vežu na parent-e) prilikom brisanja moramo
moramo postaviti da se brišu i childreni određenog zapisa */
CREATE TABLE table_name
(
	column1 datatype null/not null,
	column2 datatype null/not null,
	...
	CONSTRAINT fk_column
		FOREIGN KEY (column1, column2, ... coulmn_n)
		REFERENCES parent_table (column1, column2, ... coulmn_n)
		ON DELETE CASCADE
); /* Sa ON DELETE CASCARE se pri birasnju parent zapisa brišu svi njegovi child zapisi */

ALTER TABLE PRODAJA
DROP CONSTRAINT fk_korisnici;

ALTER TABLE prodaja
ADD CONSTRAINT fk_korisnici
    FOREIGN KEY (id_korisnika)
    REFERENCES korisnici (id_korisnika)
    ON DELETE CASCADE;

select * from korisnici;
select * from prodaja;

delete from korisnici where id_korisnika = 12345; /*Izbriše se parent i svi njegovi child zapisi*/

ON DELTE SET NULL; /* Ne preporučuje se jer će se dobit orpahn zapisi */

/* Update zapisa */
/* Sa deferred odgađamo provjeru ispravnosti tek na zadnjoj naredbi commit */
SET CONSTARINT ime_constarinta DEFERRED;

update studenti set ime = 'Ivan' where id = 5877;
update ocjene set ocjena = 4 where id_predmeta = 7;
commit;

/* Disable constraint */
ALTER TABLE table_name
DISABLE CONSTRAINT contraint_name;
