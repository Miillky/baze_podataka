/*Sintaksa*/
SELECT polja
FORM table1
INNER JOIN table2
ON table1.column = table2.column; -- navedemo polja koja se povezuju

/*13. Povežite tablice MJESTA i ZUPANIJE*/
select
    m.mjesto_a,
    m.posta,
    m.mjesto_b,
    z.zupanija
from
    mjesta m inner join
    zupanije z on m.zupanija = z.id;

/*14. Povežite tablice MJESTA, ZUPANIJE i PRIREZI*/
select
    m.mjesto_a,
    m.posta,
    m.mjesto_b,
    z.zupanija,
    p.mjesto,
    p.iznos
from
    mjesta m inner join
    zupanije z on m.zupanija = z.id
inner join
    prirezi p on m.mjesto_a = p.mjesto
order by p.iznos desc;

/*SINTAKSA LEFT JOIN*/
SELECT columns
FROM table1
LEFT [OUTER] JOIN table2
ON table1.column = table2.column;

/*15. Povežite tablice MJESTA i POSTE za županije Bjelovarsko-Bilogorsku*/
select
    *
from
    mjesta m
left join
    poste p
on
    m.mjesto_a = p.mjesto_a and
    m.posta = p.posta
where
    m.zupanija = 14;

/*RIGHT JOIN*/
select
    m.mjesto_a as m_mjesto,
    m.posta as m_posta,
    p.mjesto_a as p_mjesto,
    p.posta as p_posta
from
    poste p
right join
    mjesta m
on
    p.mjesto_a = m.mjesto_a and
    p.posta = p.posta
where
    m.zupanija = 14;

/*FULL JOIN*/
/*SINTAKSA*/
SELECT coulmns
FROM table1
FULL[OUTER] JOIN table2
ON table1.column = table2.coumn;

/*FULL JOIN*/
select
    m.mjesto_a as m_mjesto,
    m.posta as m_posta,
    p.mjesto_a as p_mjesto,
    p.posta as p_posta
from
    mjesta m
full join
    poste p
on
    p.mjesto_a = m.mjesto_a and
    m.posta = p.posta where
    m.zupanija = 14;
