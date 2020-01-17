/*

Zadatak.
Na postojeću tablicu MJESTA1
ID NOT NULL NUMBER(6)
MJESTO_A NOT NULL VARCHAR2(128)
POSTA NUMBER(5)
MJESTO_B NOT NULL VARCHAR2(26)
ZUPANIJA NOT NULL NUMBER(2)

Dodat ćemo dva nova polja u tablicu MJESTA1:
CREATED vrijeme kada je zapis u tablici nastao i
UPDATED vrijeme kada je zapis promijenjen
Ako su oba vremena ista tada podatak nije nikad mijenjan
Potrebno je kreirati trigger-e tako da se automatski unosi sljedeća sekvenca za polje ID i
zapisuju vremena u navedena polja

Desni klik na tablicu mjesta1 -> column -> add -> Coulmn Name -> CREATE - Data type -> Timestamp
Desni klik na tablicu mjesta1 -> column -> add -> Coulmn Name -> UPDATED - Data type -> Timestamp

*/

insert into mjesta1
    (id, mjesto_a, posta, mjesto_b, zupanija, created, updated)
values
    (6939, 'Kamenmost', 21260, 'Impotski', 4, systimestamp, systimestamp);

--kreiramo sekvencu
/*
Desni klik na Sequences -> New Sequence ->
	Name: SEQ_MJESTA1
	Start With: 6940
	Increment: 1
	Min Value: 6940
	Max Value 999999
	Cache: Cache
	Cache Size: 20
	Cycle: <Not Specified>
	Order: <Not Specified>
*/

-- ako nismo system user moramo dodati useru privilages da izradi trigger sa
GRANT CREATE ANY TRIGGER TO moj_username;

--sada možemo kreirati trigger
/*
Desni klik na Triggers -> New Trigger... ->
	Name: TRIG_MJESTA1_BI
	Base Type: TABLE,
	Base Object: MJESTA1,
	Timing: BEFORE
	Selected Events: INSERT
	Statement Level: Checked
*/

CREATE OR REPLACE TRIGGER TRIG_MJESTA1_BI
BEFORE INSERT ON MJESTA1
BEGIN
  NULL;
END;

-- U trigger-u svako polje u tablici na kojoj trigger tjeluje dohaćamo sa :new.ime_polja
/*
Završeni trigger za za TRIG_MJESTA1_BI
Nakon toga u istom tabu moramo pokrenut Compile
*/
CREATE OR REPLACE TRIGGER TRIG_MJESTA1_BI
BEFORE INSERT ON MJESTA1
    FOR EACH ROW
        WHEN (new.ID IS NULL)
BEGIN
    SELECT
        SEQ_MJESTA1.NEXTVAL
    INTO
        :new.ID
    FROM dual;

    SELECT
        SYSTIMESTAMP
    INTO
        :new.UPDATED
    FROM dual;

    SELECT
        SYSTIMESTAMP
    INTO
        :new.CREATED
    FROM dual;
END;
/*Za*/

INSERT INTO mjesta1 (MJESTO_A, POSTA, MJESTO_B, ZUPANIJA)
VALUES ('Vrana', 51557, 'Cres', 18);

-- kada imamo trigger nema potrebe više pisati insert-ove s ID-em i s audit poljima updated i created.
-- Trigger i sequence-a to naprave za nas.

select * from mjesta1 order by id desc;

-- trigger za update
/*
Desni klik na Triggers -> New Trigger... ->
	Name: TRIG_MJESTA1_AU
	Base Type: TABLE,
	Base Object: MJESTA1,
	Timing: BEFORE
	Selected Events: UPDATE
	Selected Coulumns: -
	Statement Level: Checked
*/

CREATE OR REPLACE TRIGGER TRIG_MJESTA1_AU
BEFORE DELETE ON MJESTA1
BEGIN
  NULL;
END;

/*
Završeni trigger za za TRIG_MJESTA1_BI
Nakon toga u istom tabu moramo pokrenut Compile
*/
CREATE OR REPLACE TRIGGER TRIG_MJESTA1_AU
BEFORE UPDATE ON MJESTA1
REFERENCING NEW AS NEWER OLD AS OLDER
FOR EACH ROW
BEGIN
  :NEWER.UPDATED := SYSTIMESTAMP;
END;

UPDATE MJESTA1 SET MJESTO_A = 'Vrana1' WHERE ID = 6940;

select * from mjesta1 order by id desc;

--trigere možemo enable-ati ili disable-ati
-- desni klik na trigger -> disable... ili enable...

/*Sintaksa za kreiranje triggera*/
CREATE [OR REPLACE] TRIGGER trigger_name
BEFORE INSERT ili AFTER INSERT ili BEFORE UPDATE ili AFTER UPDATE ili BEFORE DELETE ili AFTER DELETE
	ON table_name
	[FOR EACH ROW]
DECLARE
	-- variable declarations
BEGIN
	-- trigger code
EXCEPTION
	WHEN ...
	-- exception handling
END;