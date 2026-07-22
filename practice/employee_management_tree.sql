WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Start with the top-level manager (someone with no reports_to)
    SELECT 
        employee_id,
        first_name,
        last_name,
        title,
        reports_to,
        1 AS management_level,
        CAST(first_name || ' ' || last_name AS VARCHAR(255)) AS employee_path
    FROM employees
    WHERE reports_to IS NULL

    UNION ALL

    -- Recursive member: Find employees who report to someone already in the hierarchy
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.title,
        e.reports_to,
        eh.management_level + 1,
        CAST(eh.employee_path || ' -> ' || e.first_name || ' ' || e.last_name AS VARCHAR(255))
    FROM employees e
    JOIN EmployeeHierarchy eh ON e.reports_to = eh.employee_id
)
SELECT 
    management_level,
    employee_path,
    title
FROM EmployeeHierarchy
ORDER BY management_level, employee_path;