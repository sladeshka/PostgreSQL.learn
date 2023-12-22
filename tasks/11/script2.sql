-- paragraph 1
-- paragraph 2 For what?
-- paragraph 3
DROP FUNCTION IF EXISTS checkSourceTable;
CREATE OR REPLACE FUNCTION 
    checkSourceTable(maxDate DATE default null) 
RETURNS text
LANGUAGE plpgsql
AS 
$$
DECLARE
    istochnik integer;
    nashabaza integer;
BEGIN
    IF maxDate != null
    THEN
        maxDate = CURRENT_DATE;
    END IF;
    istochnik := (SELECT count(*) FROM istochnik.tablesource);
    nashabaza := (SELECT count(*) FROM nashabaza.ourtable);
    IF istochnik != nashabaza 
    THEN
        INSERT INTO 
            nashabaza.ourtable
            (
                propid,
                ncanonid,
                dtreportdate,
                nterotdelenie,
                nterpodrazdel,
                vprocent
            )
        OVERRIDING SYSTEM VALUE
        SELECT
            S.lineid,
            S.npokazatelid,
            S.dtenddate,
            (regexp_split_to_array(S.vterritoryid, '_'))[1]::integer  AS TT,
            (regexp_split_to_array(S.vterritoryid, '_'))[2]::integer  AS TT,
            S.nvalue
        FROM istochnik.tablesource AS S--, nashabaza.ourtable AS O;
        WHERE dtreportdate = maxDate
        ON CONFLICT (propid) DO NOTHING;
        RETURN 'Данные изменены';
    END if;

    RETURN 'Данные на последнюю дату отчета синхронизированы';
END
$$;
SELECT checkSourceTable(CURRENT_DATE);

