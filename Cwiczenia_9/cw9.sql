--zadanie1
--krok 1
EXPLAIN ANALYZE(
SELECT
c.customerid,
c.personid,
c.storeid,
c.territoryid,
soh.salesorderid,
soh.orderdate,
soh.duedate,
soh.shipdate
FROM sales.customer c
INNER JOIN sales.salesorderheader soh ON c.customerid = soh.customerid
WHERE c.territoryid = 5)

--krok 2
CREATE INDEX idx_customerid ON sales.customer (customerid);
CREATE INDEX idx_territoryid ON sales.customer (territoryid);
CREATE INDEX idx_orderdate ON sales.salesorderheader (orderdate);

EXPLAIN ANALYZE(
SELECT
c.customerid,
c.personid,
c.storeid,
c.territoryid,
soh.salesorderid,
soh.orderdate,
soh.duedate,
soh.shipdate
FROM sales.customer c
INNER JOIN sales.salesorderheader soh ON c.customerid = soh.customerid
WHERE c.territoryid = 5)


--zadanie2
--a
BEGIN TRANSACTION; --rozpoczęcie transakcji

UPDATE production.product
SET listprice = listprice * 1.1
WHERE productid = 680;

COMMIT; --zatwierdzenie transakcji

--b
BEGIN TRANSACTION;

DELETE FROM production.product
WHERE productid = 707; 

ROLLBACK; --wycofanie transakcji

--c??