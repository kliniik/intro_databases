--zadanie1 

--funkcja obliczająca n-ty wyraz ciągu
CREATE OR REPLACE FUNCTION fib(n int)
RETURNS int AS $$
DECLARE
    F int;
    f1 int := 0;
    f2 int := 1;
    i int := 0;
BEGIN
    IF n <= 0 THEN F := 0;
    ELSIF n = 1 THEN F := n;
    ELSE
        WHILE i < n - 1 LOOP
            F := f1 + f2;
            f1 := f2;
            f2 := F;
            i := i + 1;
        END LOOP;
    END IF;
    RETURN F;
END;
$$ LANGUAGE plpgsql;

--funkcja wypisująca ciąg
CREATE OR REPLACE FUNCTION fib_seq(n int)
RETURNS SETOF int AS $$
DECLARE
    count int := 0;
BEGIN   
    WHILE count < n LOOP
        RETURN NEXT fib(count); --return next do zwaracania zestawu danych
        count := count + 1;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fib_seq(10);

--zadanie2
CREATE FUNCTION upper_lastname()
RETURNS TRIGGER AS $$
BEGIN
    NEW.lastname := UPPER(NEW.person.lastname);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER upper_trig
BEFORE UPDATE ON person.person   
FOR EACH ROW                
EXECUTE FUNCTION upper_lastname();
--zanim wprowadzisz dane, wykonaj funkcję = zmień dane przed zapisem


--zadnie3
CREATE FUNCTION tax()
RETURNS TRIGGER AS $$
DECLARE 
    old_rate decimal;
    new_rate decimal;
    max_change decimal := 0.3;
BEGIN
    old_rate := OLD.TaxRate;
    new_rate := NEW.TaxRate;

    IF ABS((new_rate - old_rate)/old_rate) > max_change THEN
        RAISE EXCEPTION 'zmiana wartości w polu TaxRate przekracza 30%%';
        --dwa znaki %, bo pojedynczy może być zinterpretowany jako znacznik specjalny
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TaxRateMonitorng
BEFORE UPDATE ON sales.salestaxrate
FOR EACH ROW
EXECUTE FUNCTION tax();