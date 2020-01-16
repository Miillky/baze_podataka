/* praovo na sequente korisniku (logiran kao system) */
grant create sequence to vedran;

create sequence seq_studenti_id
    minvalue 1
    maxvalue 999999999999999999999999999
    start with 12347
    increment by 1
    cache 20;

insert into studenti
    (jmbag, prezime, ime)
values
    (seq_studenti_id.nextval, 'Skender', 'Miroslav');

select * from studenti;

/* Iskorištavanje sekvence korištenjem jednostavih selectova */
/* Svaki će podići sekvencu za definirani increment u ovom slučaju 1 */
select seq_studenti_id.nextval from dual; /*12348*/