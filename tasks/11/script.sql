CREATE SCHEMA istochnik;  

CREATE SCHEMA nashabaza;  
DROP TABLE IF EXISTS istochnik.tablesource;
CREATE TABLE istochnik.tablesource (
lineid bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
npokazatelid bigint NOT NULL, -- номер показателя
vperiodtype varchar(1) NOT NULL, -- период отчетности
dtstartdate date NOT NULL, -- дата начала отчетного периода
dtenddate date NOT NULL, -- дата конца отчетного периода
vterritoryid varchar(10) NOT NULL, -- ID территории в формате (ID региона _ ID отделения)
nvalue decimal(32,4) NOT NULL -- значение показателя
)

INSERT INTO istochnik.tablesource
(npokazatelid,vperiodtype,dtstartdate,dtenddate,vterritoryid,nvalue)
VALUES
(2588,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'55_4789',45.64),
(2589,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'55_4889',88.34),
(3600,'m',CAST('2023-06-01' as date),CAST('2023-07-31' as date),'55_4889',81.51),
(3600,'q',CAST('2023-01-01' as date),CAST('2023-03-31' as date),'55_4889',64.42),
(4719,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'55_4889',47.33),
(8543,'m',CAST('2023-05-01' as date),CAST('2023-07-31' as date),'42_1550',20.24),
(8543,'m',CAST('2023-08-01' as date),CAST('2023-09-30' as date),'42_1550',03.15),
(8543,'m',CAST('2023-07-01' as date),CAST('2023-08-31' as date),'55_4789',86.06),
(4719,'q',CAST('2023-06-01' as date),CAST('2023-09-30' as date),'55_4789',69.97),
(3600,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'55_4789',42.88),
(3600,'m',CAST('2023-05-01' as date),CAST('2023-03-31' as date),'55_4789',25.79),
(2588,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'16_8647',08.60),
(2589,'q',CAST('2023-03-01' as date),CAST('2023-06-30' as date),'55_4789',81.51),
(2589,'q',CAST('2023-03-01' as date),CAST('2023-06-30' as date),'55_4789',64.42),
(2589,'q',CAST('2023-03-01' as date),CAST('2023-06-30' as date),'16_8647',47.33),
(2589,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'55_4789',20.24),
(2589,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'16_8647',03.15),
(2589,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'16_8647',86.06),
(2589,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'16_8647',69.87),
(2589,'m',CAST('2023-05-01' as date),CAST('2023-06-30' as date),'55_4789',41.98);

DROP TABLE IF EXISTS nashabaza.ourtable;
CREATE TABLE nashabaza.ourtable (
propid bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
ncanonid int NOT NULL, -- номер показателя
dtreportdate date NOT NULL, -- дата конца отчетного периода
nterotdelenie int NOT NULL, -- ID региона
nterpodrazdel int NOT NULL, -- ID отделения
vprocent decimal(6,4) NOT NULL -- Значение показателя
);

INSERT INTO nashabaza.ourtable
(ncanonid,dtreportdate,nterotdelenie,nterpodrazdel,vprocent)
VALUES
(2588,CAST('2023-06-30' as date),55,4789,45.64),
(2589,CAST('2023-06-30' as date),55,4889,88.34),
(3600,CAST('2023-07-31' as date),55,4889,81.51),
(4719,CAST('2023-06-30' as date),55,4889,47.33),
(8543,CAST('2023-07-31' as date),42,1550,20.24),
(8543,CAST('2023-08-31' as date),55,4789,83.06),
(3600,CAST('2023-06-30' as date),55,4789,42.88),
(3600,CAST('2023-03-31' as date),55,4789,25.79),
(2588,CAST('2023-06-30' as date),16,8647,08.60),
(2589,CAST('2023-06-30' as date),55,4789,20.24),
(2589,CAST('2023-06-30' as date),16,8647,03.15),
(2589,CAST('2023-06-30' as date),16,8647,86.06),
(2589,CAST('2023-06-30' as date),16,8647,69.87),
(2589,CAST('2023-06-30' as date),55,4789,41.98);