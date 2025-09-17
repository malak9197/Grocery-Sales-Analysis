use GrocerySales
--Monthly total Sales--
select MONTH(S.SalesDate) Monthes, avg(S.totalprice) totalsales
from sales S
Where  MONTH(S.SalesDate) Is not null
group by MONTH(S.SalesDate) 
order by totalsales desc

--categories based on monthly total sales--
select MONTH(S.SalesDate) Monthes, Sum(S.totalprice) totalsales,
 C.CategoryName 
from categories C
join products P 
on P.CategoryID = C.CategoryID
join sales S
on S.ProductID = P.ProductID
Where  MONTH(S.SalesDate) Is not null AND C.CategoryName = 'Beverages'--name of category
group by MONTH(S.SalesDate), C.CategoryName
order by totalsales desc

--products based on total sales revenue.
select top 5 P.ProductID, P.ProductName, SUM(S.totalprice) AS TotalRevenue 
from products P
join sales S
on P.ProductID = S.ProductID
group by P.ProductID, P.ProductName
order by TotalRevenue Desc

--Analyze sales quantity and revenue to identify high-demand products--
SELECT TOP 5
    P.ProductName,
    SUM(S.Quantity) AS TotalQuantity,
    SUM(S.TotalPrice) AS TotalRevenue
FROM products AS P
JOIN sales AS S 
    ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalRevenue DESC;

--Segment customers based on their purchase frequency and total spend.
select top 5 C.CustomerID, C.CustomerName, COUNT(S.TransactionNumber) AS NumberOfSales, SUM(S.totalprice) AS TotalRevenue
from customers C
join sales S
on C.CustomerID = S.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY NumberOfSales desc

--
select top 5 C.CustomerID, C.CustomerName, COUNT(S.TransactionNumber) AS NumberOfSales, SUM(S.totalprice) AS TotalRevenue
from customers C
join sales S
on C.CustomerID = S.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
    Having COUNT(S.TransactionNumber) <10 And COUNT(S.TransactionNumber)>5
ORDER BY TotalRevenue DESC 

--Calculate total sales attributed to each salesperson.
SELECT 
    E.EmployeeId, E.EmployeeIName, SUM(S.totalprice) AS TotalSales
FROM employees AS E
JOIN sales AS S
ON E.EmployeeId = S.SalesPersonID
GROUP BY
    E.EmployeeId,
    E.EmployeeIName
ORDER BY TotalSales DESC

--Identify top-performing and underperforming sales staff.
SELECT
    E.EmployeeId, E.EmployeeIName,SUM(S.totalprice) AS TotalSales,year(E.HireDate) YearOfHiring, count(S.TransactionNumber) NumberOfSales
FROM employees AS E
JOIN sales AS S
ON E.EmployeeId = S.SalesPersonID
where S.SalesDate is not null And year(E.HireDate) > 2010
GROUP BY
    E.EmployeeId,
    E.EmployeeIName,
    year(E.HireDate)
ORDER BY TotalSales 

--Analyze sales trends based on individual salesperson contributions over time.
SELECT top 5
    E.EmployeeId, E.EmployeeIName,SUM(S.totalprice) AS TotalSales,year(E.HireDate) YearOfHiring, count(S.TransactionNumber) NumberOfSales
FROM employees AS E
JOIN sales AS S
ON E.EmployeeId = S.SalesPersonID
where S.SalesDate is not null And year(E.HireDate) = 2016
GROUP BY
    E.EmployeeId,
    E.EmployeeIName,
    year(E.HireDate)
ORDER BY TotalSales DESC

--Map sales data to specific cities to identify high-performing regions.
SELECT top 5
    ci.CityName, SUM(S.totalprice) AS TotalRevenue
FROM cities ci
JOIN customers C ON ci.CityID = C.CityID
JOIN sales S ON C.CustomerID = S.CustomerID
GROUP BY
    ci.CityID,
    ci.CityName
ORDER BY TotalRevenue desc

--Compare sales volumes between various geographical areas.
SELECT top 5
    ci.CityName, count(S.TransactionNumber) NumberOfSales
FROM cities ci
JOIN customers C ON ci.CityID = C.CityID
JOIN sales S ON C.CustomerID = S.CustomerID
GROUP BY
    ci.CityID,
    ci.CityName
ORDER BY NumberOfSales desc
