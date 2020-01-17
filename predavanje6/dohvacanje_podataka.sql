/*1. Ispisati mjesta u Hrvatskoj koja počinju sa slovom N i ukupno imaju 7 znakova*/
select * from mjesta where mjesto_a like 'N______';

/*2. Ispisati popis mjesta s nazivima županija (select u select-u)*/
select
	m.mjesto_a,
	m.posta,
	m.mjesto_b,
	(
		select
			zupanija
		from
			zupanije z
		where
			z.id = m.zupanija
	)
from mjesta m;

/*3. Ispisati mjesta samo u BJELOVARSKO-BILOGORSKOJ županiji*/
select
    m.mjesto_a,
    m.posta,
    z.zupanija
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA';

/*4. Ispisati mjesta samo u BJELOVARSKO-BILOGORSKOJ županiji i rasporediti ih po abecedi*/
select
    m.mjesto_a,
    m.posta,
    z.zupanija
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA'
order by
    mjesto_a asc;

/*5. Ispisati mjesta samo u BJELOVARSKO-BILOGORSKOJ županiji i rasporediti ih po
abecedi, obrnuti redoslijed*/
select
    m.mjesto_a,
    m.posta,
    z.zupanija
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA'
order by
    mjesto_a desc;

/*6. Ispisati jedinstvene poštanske brojeve u BJELOVARSKO-BILOGORSKOJ županiji*/
select
    distinct posta
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA';

/*7. Grupirati sve pošte u BJELOVARSKO-BILOGORSKOJ županiji i ispisati koliko mjesta se
veže uz određenu poštu, rasporediti po broju mjesta.*/
select
    posta,
    count(1) as broj_mjesta
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA'
group by
    posta
order by
    broj_mjesta desc;

/*8. Grupirati sve pošte u BJELOVARSKO-BILOGORSKOJ županiji i ispisati koliko mjesta se
veže uz određenu poštu, ispisati i mjesta rasporediti po broju mjesta.*/
select
    posta,
    mjesto_b,
    count(1) as broj_mjesta
from
    mjesta m, zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA'
group by
    posta
order by
    broj_mjesta desc; /* Ovaj SELECT vraća grešku jer ne
						može iz navedenog grupiranja,
						dohvatiti jedinstveno ime koje se
						veže uz poštanski broj.
						Obično, ono što se nalazi u
						GROUP BY naredbi možete
						dohvaćati */

/*9. Grupirati sve pošte u BJELOVARSKO-BILOGORSKOJ županiji i ispisati koliko mjesta se
veže uz određenu poštu, ispisati i mjesta rasporediti po broju mjesta.*/
select
    posta,
    mjesto_b,
    count(1) as broj_mjesta
from
    mjesta m, zupanije z
where
    m.zupanija = z.id and
    z.zupanija = 'BJELOVARSKO-BILOGORSKA'
group by
    posta,
    mjesto_b
order by
    broj_mjesta desc;

/*10. Koja županija u Hrvatskoj ima najviše mjesta*/
select
    z.zupanija,
    count(1) as broj_mjesta
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id
group by
    z.zupanija
order by
    broj_mjesta desc;

/*11. Ispišite županije koje imaju više od 500 mjesta*/
select
    z.zupanija,
    count(1) as broj_mjesta
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id
group by
    z.zupanija
having
    count(1) > 500
order by
    broj_mjesta desc;

/*12. Ispisati županije u Hrvatskoj i kraj svake navesti da li ima više ili manje od 500 mjesta*/
select
    z.zupanija,
    count(1) as broj_mjesta,
    case
        when count(1) > 500 then
            'vište od 500 mjesta'
        else
            'manje od 500 mjesta'
        end as velicina
from
    mjesta m,
    zupanije z
where
    m.zupanija = z.id
group by
    z.zupanija
order by
    broj_mjesta desc;
