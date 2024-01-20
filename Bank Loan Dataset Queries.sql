-- Count the total number of applications in the 'Bank Loan' table.
SELECT 
	COUNT(id) AS Total_Applications 
FROM [Bank Loan];

-- Count the total number of applications in the 'Bank Loan' table for the month of December.
SELECT 
	COUNT(id) AS Total_Applications 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 12;

-- Count the total number of applications in the 'Bank Loan' table for the month of November.
SELECT 
	COUNT(id) AS Total_Applications 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 11;

-- Calculate the total funded amount in the 'Bank Loan' table.
SELECT 
	SUM(loan_amount) AS Total_Funded_Amount 
FROM [Bank Loan];

-- Calculate the total funded amount in the 'Bank Loan' table for the month of December.
SELECT 
	SUM(loan_amount) AS Total_Funded_Amount 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 12;

-- Calculate the total funded amount in the 'Bank Loan' table for the month of November.
SELECT 
	SUM(loan_amount) AS Total_Funded_Amount 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 11;

-- Calculate the total amount collected in the 'Bank Loan' table.
SELECT 
	SUM(total_payment) AS Total_Amount_Collected 
FROM [Bank Loan];

-- Calculate the total amount collected in the 'Bank Loan' table for the month of December.
SELECT 
	SUM(total_payment) AS Total_Amount_Collected 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 12;

-- Calculate the total amount collected in the 'Bank Loan' table for the month of November.
SELECT 
	SUM(total_payment) AS Total_Amount_Collected 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 11;

-- Calculate the average interest rate as a percentage in the 'Bank Loan' table.
SELECT 
	AVG(int_rate)*100 AS Avg_Int_Rate 
FROM [Bank Loan];

-- Calculate the average interest rate as a percentage in the 'Bank Loan' table for the month of December.
SELECT 
	AVG(int_rate)*100 AS MTD_Avg_Int_Rate 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 12;

-- Calculate the average interest rate as a percentage in the 'Bank Loan' table for the month of November.
SELECT 
	AVG(int_rate)*100 AS PMTD_Avg_Int_Rate 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 11;

-- Calculate the average Debt-to-Income ratio as a percentage in the 'Bank Loan' table.
SELECT 
	AVG(dti)*100 AS Avg_DTI 
FROM [Bank Loan];

-- Calculate the average Debt-to-Income ratio as a percentage in the 'Bank Loan' table for the month of December.
SELECT 
	AVG(dti)*100 AS MTD_Avg_DTI 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 12;

-- Calculate the average Debt-to-Income ratio as a percentage in the 'Bank Loan' table for the month of November.
SELECT 
	AVG(dti)*100 AS PMTD_Avg_DTI 
FROM [Bank Loan] 
WHERE MONTH(issue_date) = 11;

-- Calculate the percentage of good loans (Fully Paid or Current) in the 'Bank Loan' table.
SELECT 
	(COUNT
		(CASE WHEN loan_status = 'Fully Paid' 
				OR
			loan_status = 'Current' THEN id 
		END) * 100.0) / 
			COUNT(id) 
	AS Good_Loan_Percentage 
FROM [Bank Loan];

-- Count the number of good loan applications (Fully Paid or Current) in the 'Bank Loan' table.
SELECT 
	COUNT(id) AS Good_Loan_Applications 
FROM [Bank Loan] 
WHERE loan_status = 'Fully Paid' OR 
	loan_status = 'Current';

-- Calculate the total funded amount for good loans (Fully Paid or Current) in the 'Bank Loan' table.
SELECT 
	SUM(loan_amount) AS Good_Loan_Funded_Amount 
FROM [Bank Loan] 
WHERE loan_status = 'Fully Paid' OR 
	loan_status = 'Current';

-- Calculate the total amount received for good loans (Fully Paid or Current) in the 'Bank Loan' table.
SELECT 
	SUM(total_payment) AS Good_Loan_Amount_Received 
FROM [Bank Loan] 
WHERE loan_status = 'Fully Paid' OR 
	loan_status = 'Current';

-- Calculate the percentage of bad loans (Charged Off) in the 'Bank Loan' table.
SELECT 
	(COUNT
		(CASE WHEN loan_status = 'Charged Off' THEN id 
			END) * 100.0) / 
				COUNT(id) 
	AS Bad_Loan_Percentage 
FROM [Bank Loan];

-- Count the number of bad loan applications (Charged Off) in the 'Bank Loan' table.
SELECT 
	COUNT(id) AS Bad_Loan_Applications 
FROM [Bank Loan] 
WHERE loan_status = 'Charged Off';

-- Calculate the total funded amount for bad loans (Charged Off) in the 'Bank Loan' table.
SELECT 
	SUM(loan_amount) AS Bad_Loan_Funded_Amount 
FROM [Bank Loan] 
WHERE loan_status = 'Charged Off';

-- Calculate the total amount received for bad loans (Charged Off) in the 'Bank Loan' table.
SELECT 
	SUM(total_payment) AS Bad_Loan_Amount_Received 
FROM [Bank Loan] 
WHERE loan_status = 'Charged Off';

-- Generate a summary of loan statistics grouped by loan status in the 'Bank Loan' table.
SELECT
    loan_status,
    COUNT(id) AS Loan_Count,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM [Bank Loan]
GROUP BY loan_status;

-- Generate a summary of loan statistics grouped by loan status for the month of December in the 'Bank Loan' table.
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM [Bank Loan]
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

-- Generate a monthly summary of loan applications, funded amount, and amount received in the 'Bank Loan' table.
SELECT 
    MONTH(issue_date) AS Month_Number, 
    DATENAME(MONTH, issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- Generate a summary of loan statistics grouped by state in the 'Bank Loan' table.
SELECT 
    address_state AS State_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
GROUP BY address_state
ORDER BY address_state;

-- Generate a summary of loan statistics grouped by term in the 'Bank Loan' table.
SELECT 
    term AS Term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
GROUP BY term
ORDER BY term;

-- Generate a summary of loan statistics grouped by employment length in the 'Bank Loan' table.
SELECT 
    emp_length AS Employee_Length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
GROUP BY emp_length
ORDER BY emp_length;

-- Generate a summary of loan statistics grouped by purpose in the 'Bank Loan' table.
SELECT 
    purpose AS Purpose, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
GROUP BY purpose
ORDER BY purpose;

-- Generate a summary of loan statistics grouped by home ownership status in the 'Bank Loan' table.
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
GROUP BY home_ownership
ORDER BY home_ownership;

-- Generate a summary of loan statistics for a specific purpose (Grade A) in the 'Bank Loan' table.
SELECT 
    purpose AS Purpose, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan]
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;