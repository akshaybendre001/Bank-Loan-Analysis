Select * from financial_loan 
Select count(id) as Total_loan_Applications from financial_loan

--1. Total Loan Applications 


--Month to Date 
Select count(id) as MTD_Total_loan_Applications from financial_loan
where Month(issue_date) = 12 and Year(issue_date) = 2021

--Previous Month To Date 
Select count(id) as PMTD_Total_loan_Applications from financial_loan 
where Month(issue_date) = 11 and Year(issue_date) = 2021

--2. Total Funded Amount of bank to customers or lenders 

Select sum(loan_amount) as MTD_Total_Funded_Amount from financial_loan
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--previous month to date total funded amount 

Select sum(loan_amount) as PMTD_Total_Funded_Amount from financial_loan
where month(issue_date) = 11 and YEAR(issue_date) = 2021

Select * from financial_loan 

--3. Total Loan Re-payment Recieved 

Select sum(total_payment) as Total_Amount_Recieved from financial_loan
-- with the help of this repayments with interests the banks make huge amount of profits 

--MTD 
Select SUM(total_payment) as MTD_Total_Amount_Recieved from financial_loan
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--PMTD 
Select SUM(total_payment) as PMTD_Total_Amount_Recieved from financial_loan
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

--4. Average Interest Rate 

Select AVG(int_rate) as Average_Interest_Rate from financial_loan
--need to multiply by 100 to get the perfect number 

Select AVG(int_rate) * 100 as Average_Interest_Rate from financial_loan

--use of round() function 

Select ROUND(AVG(int_rate),2) as Rounded_AVG_Interest_Rate from financial_loan

Select ROUND(AVG(int_rate),4) * 100 as Rounded_AVG_Interest_Rate from financial_loan

--MTD Average Interest Rate 

Select Round(AVG(int_rate),4)* 100 as MTD_Average_Interest_Rate from financial_loan
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--PMTD Average Interest Rate 

Select Round(Avg(int_rate),4) * 100 as PMTD_Average_Interest_Rate from financial_loan
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

-- So, Higher the interest rate means more the beneficial for the bank but not so beneficial for the customers 
-- as the banks make profits based on the interest rates 

Select * from financial_loan

--5. Average Debt-to-Income Ratio of customers 

Select Round(AVG(dti),4) * 100 as Average_DTI from financial_loan

--MTD
Select ROUND(Avg(dti),4) * 100 as MTD_Average_DTI from financial_loan
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--PMTD
Select Round(Avg(dti), 4) * 100 as PMTD_Average_DTI from financial_loan
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021 

--Ideal dti should be below 36% 

--6. Good Loan 

Select 
	(COUNT(Case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100 / Count(id)) as Good_Loan_percentage
	from financial_loan

-- count of good loan 

Select count(id) as Good_Loan_Applications from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

/* 
Select count(id) as Good_Loan_Applications from financial_loan 
where loan_status IN('Fully Paid','Current')
*/

--funded amount for good loan 
Select * from financial_loan

Select SUM(loan_amount) AS Good_Loan_Funded_amount from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

--good loan total recieved amount 

Select SUM(total_payment) as Good_Loan_Recieved_amount from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

--As we can observe here bank has made profit in good_loan recieved amount 

--7. Bad loan 

Select 
	(COUNT(case when loan_status = 'Charged Off' then id end)* 100.0 / count(loan_status)) as Bad_Loan_percentage
	from financial_loan


Select COUNT(id) as Bad_Loan_Applications from financial_loan
where loan_status = 'Charged Off'

--funded amount for bad loan 
Select SUM(loan_amount) as Bad_Loan_Funded_amount from financial_loan
where loan_status = 'Charged Off'

--amount recieved for bad loan 
Select SUM(total_payment) as Bad_Loan_Amount_recieved from financial_loan
where loan_status = 'Charged Off'

--This is a negative sign for the banks as their amount lended is not even recovered 

--8. Loan Status


Select loan_status, 
		count(id) as Total_loan_Applications,
		Sum(total_payment) as Total_Amount_Recieved,
		Sum(loan_amount) as Total_Funded_Amount,
		Avg(int_rate * 100) as Interest_Rate,
		Avg(dti) as DTI
		from financial_loan
		group by loan_status

--charged off is something the bank should worry about as they are loosing their money there...

-- for current loan 
Select * from financial_loan

Select loan_status, 
		SUM(total_payment) as MTD_Total_Amount_Recieved,
		SUM(loan_amount) as MTD_Total_Funded_Amount
		from financial_loan
		where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021
		group by loan_status

-- for previous month 

Select loan_status, 
		SUM(total_payment) as PMTD_Total_Amount_Recieved, 
		SUM(loan_amount) as PMTD_Total_Funded_Amount
		from financial_loan
		where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021
		group by loan_status



-- DASHBOARD 2: OVERVIEW 

Select MONTH(issue_date) as Month_Number,
		DATENAME(MONTH,issue_date) as Month_Name,
		COUNT(id) as Total_Loan_Applications,
		SUM(total_payment) as Total_Recieved_Amount,
		SUM(loan_amount) as Total_Funded_Amount
		from financial_loan
		group by MONTH(issue_date), DATENAME(MONTH,issue_date)
		order by MONTH(issue_date)



-- maximum recieved amount wrt address state
--2. Regional analysis wrt state 

Select address_state,
		COUNT(id) as Total_Loan_Applications,
		SUM(total_payment) as Total_Recieved_Amount,
		SUM(loan_amount) as Total_Funded_Amount
		from financial_loan
		group by address_state
		order by SUM(total_payment) Desc

Select * from financial_loan

--3. Loan Term Analysis

Select 
	term,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) as Total_Recieved_Amount,
	SUM(loan_amount) as Total_Funded_Amount
	from financial_loan
	group by term
	order by term

-- 4. Emp length

Select 
	emp_length,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) as Total_Recieved_Amount,
	SUM(loan_amount) as Total_Funded_Amount
	from financial_loan
	group by emp_length
	order by COUNT(id) Desc

--5. wrt Purpose

Select 
	purpose,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) as Total_Recieved_Amount,
	SUM(loan_amount) as Total_Funded_Amount
	from financial_loan
	group by purpose
	order by COUNT(id) Desc

--6. Home Ownership 

Select 
	home_ownership,
	COUNT(id) as Total_Loan_Applications,
	SUM(total_payment) as Total_Recieved_Amount,
	SUM(loan_amount) as Total_Funded_Amount
	from financial_loan
	group by home_ownership
	order by COUNT(id) Desc

Select * from financial_loan

Select count(id) from financial_loan

-- DASHBOARD 3: DETAILS


