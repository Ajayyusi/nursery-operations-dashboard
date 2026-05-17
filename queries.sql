-- Nursery Operations Dashboard SQL Examples

-- Monthly Fees Collected
SELECT
    DATE_FORMAT(month, '%Y-%m') AS month,
    SUM(amount_paid) AS fees_collected,
    SUM(amount_due) AS fees_due,
    SUM(outstanding_amount) AS outstanding_amount
FROM payments
GROUP BY DATE_FORMAT(month, '%Y-%m')
ORDER BY month;

-- Active Students by Class Level
SELECT
    c.level,
    COUNT(s.student_id) AS active_students
FROM students s
JOIN classes c ON s.class_id = c.class_id
WHERE s.status = 'Active'
GROUP BY c.level
ORDER BY active_students DESC;

-- Attendance Rate
SELECT
    ROUND(
        SUM(CASE WHEN attendance_status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attendance_rate
FROM attendance;

-- Inquiry Conversion by Source
SELECT
    source,
    COUNT(*) AS total_inquiries,
    SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END) AS converted_inquiries,
    ROUND(SUM(CASE WHEN lead_status = 'Converted' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM leads
GROUP BY source
ORDER BY conversion_rate DESC;

-- Expenses by Category
SELECT
    expense_category,
    SUM(amount) AS total_expense
FROM expenses
GROUP BY expense_category
ORDER BY total_expense DESC;
