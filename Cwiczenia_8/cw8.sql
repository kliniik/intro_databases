--zadanie1
WITH --definiujemy dwa CTA (ommon table expression)
TempEmployeeInfo AS (
    SELECT firstname, lastname, businessentityid
    FROM person.person ),

HighestPayment AS (
    SELECT businessentityid, MAX(rate) AS MaxRate
    FROM humanresources.employeepayhistory
    GROUP BY businessentityid )


SELECT TempEmployeeInfo.firstname, TempEmployeeInfo.lastname, TempEmployeeInfo.businessentityid, HighestPayment.MaxRate
FROM TempEmployeeInfo
JOIN HighestPayment ON TempEmployeeInfo.businessentityid = HighestPayment.businessentityid;


--zadanie2
WITH
CustomerInfo AS (
    SELECT customerid, territoryid
    FROM sales.customer ),

SalesPersonInfo AS (
    SELECT 
        --w tabeli salesperson nie ma bezposrednich pól imię i nazwisko, więc
        --wycinam je z tabeli person
        CONCAT(person.person.firstname, ' ', person.person.lastname) AS SalesPersonName,
        salesperson.territoryid
    FROM sales.salesperson
    JOIN 
        sales.salesterritory ON sales.salesperson.territoryid = sales.salesterritory.territoryid
    JOIN
        person.person ON sales.salesperson.businessentityid = person.person.businessentityid ) 


SELECT 
    CustomerInfo.customerid, 
    CustomerInfo.territoryid, 
    SalesPersonInfo.SalesPersonName
FROM CustomerInfo
JOIN SalesPersonInfo ON CustomerInfo.territoryid = SalesPersonInfo.territoryid;
