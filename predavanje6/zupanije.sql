--------------------------------------------------------
--  File created - Friday-January-17-2020
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ZUPANIJE
--------------------------------------------------------

  CREATE TABLE "ZUPANIJE"
   (	"ID" NUMBER(2),
	"ZUPANIJA" VARCHAR2(26)
   )
Insert into ZUPANIJE (ID,ZUPANIJA) values (1,'GRAD ZAGREB');
Insert into ZUPANIJE (ID,ZUPANIJA) values (2,'ZAGREBAČKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (3,'DUBROVAČKO-NERETVANSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (4,'SPLITSKO-DALMATINSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (5,'ŠIBENSKO-KNINSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (6,'ZADARSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (7,'OSJEČKO-BARANJSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (8,'VUKOVARSKO-SRIJEMSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (9,'VIROVITIČKO-PODRAVSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (10,'POŽEŠKO-SLAVONSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (11,'BRODSKO-POSAVSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (12,'MEĐIMURSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (13,'VARAŽDINSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (14,'BJELOVARSKO-BILOGORSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (15,'SISAČKO-MOSLAVAČKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (16,'KARLOVAČKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (17,'KOPRIVNIČKO-KRIŽEVAČKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (18,'KRAPINSKO-ZAGORSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (19,'PRIMORSKO-GORANSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (20,'ISTARSKA');
Insert into ZUPANIJE (ID,ZUPANIJA) values (21,'LIČKO-SENJSKA');
--------------------------------------------------------
--  Constraints for Table ZUPANIJE
--------------------------------------------------------

  ALTER TABLE "ZUPANIJE" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ZUPANIJE" MODIFY ("ZUPANIJA" NOT NULL ENABLE);
