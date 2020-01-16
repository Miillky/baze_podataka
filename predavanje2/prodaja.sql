create table prodaja(
	id_prodaje number(10) not null,
	datum_prodaje date default sysdate not null,
	id_korsinika number(10),
	cijena number(10,2),
	porez number(10,2),
	dostava number(10,2),
	ukupno number(10,2)
);

insert into prodaja
	(id_prodaje, id_korsinika, cijena, porez, dostava, ukupno)
values
	(78432, 73298, 500, 125, 5, 630);

select * from prodaja;

/* Virtualna polja */
create table prodaja(
	id_prodaje number(10) not null,
	datum_prodaje date default sysdate not null,
	id_korsinika number(10),
	cijena number(10,2),
	porez number(10,2),
	dostava number(10,2),
	ukupno number(10,2) as (cijena + porez + dostava) virtual
);

insert into prodaja
	(id_prodaje, id_korsinika, cijena, porez, dostava, ukupno)
values
	(78432, 73298, 500, 125, 5);

select * from prodaja;

update prodaja set dostava  = 2 where id_prodaje = 78432;