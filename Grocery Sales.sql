use GrocerySales
--Who is the top-performing employee by number of sales?
select top 1 E.EmployeeId, E.EmployeeIName, COUNT(S.TransactionNumber) AS NumberOfSales
from employees E 
join sales S
on E.EmployeeId = S.SalesPersonID
GROUP BY
    E.EmployeeId,
    E.EmployeeIName
ORDER BY NumberOfSales desc

--Who is the employee with the highest total sales revenue?
SELECT top 1
    E.EmployeeId, E.EmployeeIName, SUM(S.totalprice) AS TotalSales
FROM employees AS E
JOIN sales AS S
ON E.EmployeeId = S.SalesPersonID
GROUP BY
    E.EmployeeId,
    E.EmployeeIName
ORDER BY TotalSales DESC

--Which customer has the highest number of purchases?
select top 1 C.CustomerID, C.CustomerName, COUNT(S.TransactionNumber) AS NumberOfSales
from customers C
join sales S
on C.CustomerID = S.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY NumberOfSales desc
--Which customer has the highest number of purchases?
select top 1 C.CustomerID, C.CustomerName, SUM(S.totalprice) AS TotalSales
from customers C
join sales S
on C.CustomerID = S.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY TotalSales desc
--Which city generates the most revenue?
SELECT top 1
    ci.CityName,
    SUM(S.totalprice) AS TotalRevenue
FROM cities ci
JOIN customers C ON ci.CityID = C.CityID
JOIN sales S ON C.CustomerID = S.CustomerID
GROUP BY
    ci.CityID,
    ci.CityName
ORDER BY TotalRevenue desc
--Who is the top-selling employee based on their hire date?

--Which month had the highest sales?
SELECT top 1
    YEAR(SalesDate) AS SalesYear,
    MONTH(SalesDate) AS SalesMonth,
    SUM(totalprice) AS MonthlySales
FROM
    sales
GROUP BY
    YEAR(SalesDate),
    MONTH(SalesDate)
ORDER BY
    MonthlySales DESC
--What are the top-selling products?
select top 5 P.ProductID, P.ProductName, SUM(S.totalprice) AS TotalRevenue 
from products P
join sales S
on P.ProductID = S.ProductID
group by P.ProductID, P.ProductName
order by TotalRevenue Desc

--What is the product with the highest price?
select top 5 P.ProductID, P.ProductName, SUM(P.Price) AS TotalPrice
From products P
group by P.ProductID,P.ProductName 
order by TotalPrice Desc
--Who was the top-selling employee during a specific period?
    
--Which product category generates the most revenue?

--Which city has the most customers?
select top 1 CI.CityID, CI.CityName, Count(C.CustomerID) as NumberOfCustomers
from cities CI 
join customers C
on CI.CityID =C.CityID
group by CI.CityID, CI.CityName
order by NumberOfCustomers desc

--Which city generates the most revenue?
select top 1 CI.CityID, CI.CityName, SUM(S.totalprice) AS TotalRevenue
from cities CI 
join customers C
on CI.CityID =C.CityID
join sales S
on C.CustomerID = S.CustomerID
group by CI.CityID, CI.CityName
order by TotalRevenue desc

--What are the best-selling products that are also listed as "allergic"?


--What is the total sales revenue on a specific date or over a specific period?
select top 1 S.SalesID, S.SalesDate, SUM(S.totalprice) AS TotalRevenue
from sales S
group by S.SalesID, S.SalesDate
order by TotalRevenue DESC
