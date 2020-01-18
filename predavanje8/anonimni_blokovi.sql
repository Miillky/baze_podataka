-- primjer enaonimnog bloka Hello world!
SET SERVEROUTPUT ON
BEGIN
	dbms_output.put_line('Hello World !');
END;

SET SERVEROUTPUT ON -- omogućava prikaz poruka na standardni output (Script Output)

BEGIN -- započinjemo execution section

dbms_output.put_line('Hello World !') -- na standardni output šaljemo string Hello World!

END; -- završavamo execution blok

--izvršavanje anonimnih blokova tako da selekiramo kod i stisnemo ctrl+enter ili zelenu strelicu ili kliknemo na ikonocu skripte sa strelicom ili sa F5
SET SERVEROUTPUT ON
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;

--primjer anonimbog bloka, zbrajanje
SET SERVEROUTPUT ON
DECLARE
    number1 number :=1;
    number2 number :=2;
    suma number;
BEGIN
    suma := number1 + number2;
    DBMS_OUTPUT.PUT_LINE('Suma brojava 1 i 2 = ' || suma);
END;

--ako se dogodi greška unutar anonimnog bloka, ona se može dodatno obraditi u EXCEPTION bloku.
--Oracle ima skupinu grešaka koje se mogu preduhitriti
--Npr. ako dijelimo sa 0 tada Oracle vraća grešku ORA-01476: sivisor i equal to zero
--Primjer obrade greške "dijeljeno s 0" Greška se može dohvatiti ili preko ključne riječi ZERO_DIVIDE
SET SERVEROUTPUT ON
DECLARE
number1 number := 1;
number2 number := 0;
kvocijent number;
BEGIN
    kvocijent := number1 / number2;
    DBMS_OUTPUT.PUT_LINE('Kvocijent brojeva' || number1 || 'i' || number2 || '=' || kvocijent);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Dijeljenje s 0 nije dopuštena operacija!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Dogodila se greška koju nismo predvidjeli!');
END;

-- za svaku grešku oracle generira SQLCODE i SQLERRM. Ovo su ORACLE varijable koje se mogu koristiti u kodu
SET SERVEROUTPUT ON
DECLARE
number1 number := 1;
number2 number := 0;
kvocijent number;
BEGIN
    kvocijent := number1 / number2;
    DBMS_OUTPUT.PUT_LINE('Kvocijent brojeva' || number1 || 'i' || number2 || ' = ' || kvocijent);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1476 THEN
            DBMS_OUTPUT.PUT_LINE('Dijeljenje s 0 nije dopuštena operacija!');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Dogodila se greška koju nismo predvidjeli!');
        END IF;
END;

-- ugniježdeni blovi - bitno je paziti na vidljivost variajbli
-- number1 i number2 su vidljive u cijelom bloku dok je varijabla number3 vidljiva samo u unutarnjem bloku
DECLARE
    number1 number;
    number2 number;
BEGIN
    number1 :=1;
    DECLARE
        number3 number;
    BEGIN
        number2 := 2;
        number3 := 3;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Dogodila greška');
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Dogodila se greška!');
END;

-- dbms_output
-- View -> Dbms Output -> Zeleni križić -> (Odabir baze)