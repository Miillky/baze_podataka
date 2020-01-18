NUMBER(4,2) -- 4 znamenke 2 decimalna vrijednost
-- 25.21 -> 25.21
-- 24.157 -> 25.16
-- 125.15 -> error jer je više od 4 znamenke

NUMBER(5,-2)
-- 12345.678 -> 12300
-- 156.456 -> 200 -> kad je 5 od 156 zaokruži jedinicu na 2

-- ako deklariramo varijablu samo kao number tada će varijabla obuhvatiti sve brojeve i ponašati se kao varijabla s floatin point-om
-- varijabla se može deklarirat i kao konstanta
c_broj constant number default 8;

DECLARE
c_pi constant number default 3.14;
porvrsina number;
radijus number := 2;
BEGIN
    porvrsina := power(radijus, 2) * c_pi;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Dogodila se greška koju nismo predvidjeli!');
END;

-- PLS_INTEGER tip podataka - zauzimaju manje prostora i brži su jer kodiste hardware aritmetiku umjesto software aritmetiku kao number
-- posebno ih je dobro koristiti u petljama
DECLARE
    I_number pls_integer := 15.54;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Broj je ' || I_number);
END;

-- Character - služi za spremanje alfanumeričkih znakova Interno u bazi služe za spremanj imena tablica, polja SQL-ova i PL/SQL-ova
-- CHAR(broj_znakova) - maksimalna veličina 32767 byte-a / 4 = 8191 znakova, ako se ne definira veličina maksimalna vrijednost je 1
DECLARE
    l_char char := 'AB';
BEGIN
    dbms_output.put_line('Tekst je ' || l_char);
END; -- greška jer je broj znakova za char 1 dok mi imamo 2 AB

--najčešće korišten character tip podataka je varchar2 nema defaultnu vrijednost i mora se definirati veličina
DECLARE
    l_char char := 'AB';
BEGIN
    dbms_output.put_line('Tekst je ' || l_char);
END; -- Greška jer se mora zadat range varchara

-- za spremanje podataka najčešće treba koristit varchar2

--generiranje novog reda u tekstu
next_new_line varchar2(2) := char(10) || chr(13);
next_line varchar2(2) := chr(10);

-- CLOB tip podataka sprema do 4GB karaktera

-- DateTime
-- Postavke - Tools -> Preferences -> Database -> NLS

SELECT current_timestamp, systimestamp FROM dual;

-- ispis vremena
DECLARE
    l_today_date DATE := SYSDATE;
    l_today_timestamp TIMESTAMP(6) := SYSTIMESTAMP;
    l_today_timezone TIMESTAMP WITH TIME ZONE := SYSTIMESTAMP;
BEGIN
    dbms_output.put_line('l_today_date ' || l_today_date);
    dbms_output.put_line('l_today_timestamp ' || l_today_timestamp);
    dbms_output.put_line('l_today_timetzone ' || l_today_timezone);
END;

-- date - tip varijble sprema datum bez vremenske komponente
DECLARE
	l_date date;
BEGIN
	l_date := to_date('26.11.2018 13:15:00', 'DD.MM.YYYY. HH24:MI:SS');
	dbms_output.put_line('Datum je ' || l_date);
END;

-- iz datuma možemo izvući bilo koju komponentu na sljedeći način
select to_char(sysdate, 'MONTH mon MM') as month from dual;

-- timestamp - tip podataka može sadržavati datum i vrijeme
-- U timestamp se mogu definirati i dijelovi sekunde koji će se prikazivati. Default-na vrijednost je 6, a može ići do 9
select systimestamp(9) from dual;

-- timestamp varijable se koriste ukoliko nam je bitna preciznost vremna u protivnom se koriste varijvle date
-- sysdate, systimestamp, current_timestamp, to_date, to_timestamp - su ugrađene oracle funkcije za rad s datumskim/vremenskim varijablama
DECLARE
    l_tmpstp timestamp(3);
BEGIN
    l_tmpstp := to_timestamp('26.11.2018. 13:15:23.12346', 'DD.MM.YYYY. HH24:MI:SS.FF');
    dbms_output.put_line('Vrijeme je ' || l_tmpstp);
END;

--boolean - TRUE, FALSE i NULL -> koristi se kod provjere uvjeta npr. da li je pronađena neka vrijednost u tablici
DECLARE
 l_boolean BOOLEAN := TRUE;
BEGIN
    if(l_boolean) then
        dbms_output.put_line('Točno');
    else
        dbms_output.put_line('Netočno');
    end if;
END;

-- RECORD
DECLARE
    TYPE r_klijent IS RECORD(
        ime varchar2(40),
        prezime varchar2(40),
        datum_rodjenja date,
        adresa varchar2(250)
    );
    l_new_line varchar(1) := chr(10);
    l_marko r_klijent;
BEGIN
    l_marko.ime := 'Marko';
    l_marko.prezime := 'Marković';
    l_marko.datum_rodjenja := to_date('26.11.1993', 'DD.MM.YYYY');
    l_marko.adresa := 'Trg Eugena Kvaternika 4 43000 Bjelovar';
    dbms_output.put_line(
        'Klijent:' || l_new_line ||
        l_marko.ime || '' || l_marko.prezime || l_new_line ||
        l_marko.adresa || l_new_line ||
        l_marko.datum_rodjenja
    );
END;

/* %type - U Oracle-u, deklaracija varijabli se može
referencirati na prethodno deklarirane varijable
preko operatora %type. Ovo je često korištena
opcija jer na taj način promjena parent varijable
mijenja sve varijable koje su s %type s njom
povezane. Najčešće se varijable na ovaj način
povezuju s poljima u tablicama.
Ovo je jako bitno povezati jer ukoliko se
promijeni polje na tablici ono će se automatski
reflektirati na sve deklarirane varijable pa neće
dolaziti do pucanja programa radi različito
definiranih varijabli. */
DECLARE
    I_prva number(5,2) := 3.14;
    I_duga I_prva%type := 2.71;
    I_ID mjesta.id%type := 55555;
BEGIN
    dbms_output.put_line('Varijabla I_prva ='|| I_prva);
    dbms_output.put_line('Varijabla I_duga ='|| I_duga);
    dbms_output.put_line('Varijabla I_ID ='|| I_ID);
END;

/*
%rowtype pomoću %rowtype možemo cijeli zapis u tablicu pretvoriti u record. Na taj način lakše
kreiramo i pristupamo varijablama koje su direktno povezane s cijelim zapisom u tablici.
Prednost ovog načina jest što ne moramo paziti na izmjenu varijabli ukoliko se izmjeni tablica.
*/

DECLARE
    r_mjesta mjesta%ROWTYPE;
BEGIN
    r_mjesta.mjesto_a := 'Mikanovici';
    r_mjesta.mjesto_b := 'Đakovo';
    r_mjesta.posta    := '32450';
    dbms_output.put_line(
        r_mjesta.mjesto_a || ' ' || r_mjesta.posta || ' ' || r_mjesta.mjesto_b);
END;


DECLARE
	type namesarray IS VARRAY(31) OF VARCHAR2(15);
	names namesarray;
BEGIN
	names := namesarray('mmarkovic');
	FOR i in 1 .. total LOOP
		EXECUTE IMMEDIATE 'CREATE USER '||names(i)||' IDENTIFIED BY '||'koliko99';
		EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO ' || names(i) ;
		EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO ' || names(i);
		EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE TO ' || names(i);
		EXECUTE IMMEDIATE 'GRANT CREATE TRIGGER TO ' || names(i);
		EXECUTE IMMEDIATE 'ALTER USER ' || names(i) || ' default tablespace USERS QUOTA 500M ON
		USERS';
		EXECUTE IMMEDIATE 'create table ' || names(i) || '.PRIREZI' || ' as select * from
		TADAMOVIC.PRIREZI';
		EXECUTE IMMEDIATE 'create table ' || names(i) || '.MJESTA' || ' as select * from
		TADAMOVIC.PRIREZI';
		EXECUTE IMMEDIATE 'create table ' || names(i) || '.PRIREZI' || ' as select * from
		TADAMOVIC.PRIREZI';
	END LOOP;
END;

