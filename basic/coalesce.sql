-- look at the Employees that might not have a reports to manager

SELECT 
    FirstName, 
    LastName, 
    COALESCE(ReportsTo::text, 'Top Level Manager') AS Manager_ID
FROM Employees;