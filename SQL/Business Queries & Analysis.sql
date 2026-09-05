--1. Workforce Overview 
--How many employees are currently in the company? 
select count(*) as total_employees
from hr_data;

--Which department has the largest workforce?
select department , count(*) as larg_department
from hr_data
group by department 
order by larg_department desc
limit 1;

--Which job roles have the highest number of employees?
 select jobrole , count(*) as high_employees
 from hr_data 
 group by jobrole
 order by high_employees desc
 limit 1;
 
--Is the workforce balanced between male and female employees? 
select gender , count(*) as  total_employees,
ROUND( count(*) * 100.00 / (select count(*)from hr_data) , 2) as percent
from hr_data 
group by gender
order by total_employees desc;

--Which age group dominates the organization?
select age_category count as dominates
from hr_data
group by age_category
order by dominates desc;

--2. Attrition Analysis (Highest Priority) 
--What percentage of employees leave the company?
select count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data;

--Which department loses the most employees?
select department,count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data
group by  department
order by leave_employees;

--Which job roles have the highest resignation rate? 
select  jobrole,count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data
group by  jobrole
order by leave_employees desc;

--Which age group leaves the company most often?
select   age_category,count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data
group by  age_category
order by leave_employees desc;

--Is employee turnover higher among males or females?
select    gender,count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data
group by  gender
order by leave_employees desc;

--Does marital status affect employee retention? 
select    maritalstatus,count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data
group by  maritalstatus
order by leave_employees desc;

--Does frequent business travel lead to higher attrition?
select    businesstravel,count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as leave_employees,
round(sum(case when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate
from hr_data
group by  businesstravel
order by leave_employees desc;

--3. Salary & Compensation 
--Which department has the highest average salary?
select department, round(avg(monthlyincome) ,2) as average_salary
from hr_data
group by department
order by average_salary desc;

--Which job roles receive the highest compensation? 
select jobrole, round(avg(monthlyincome),2) as average_salary
from hr_data
group by jobrole
order by average_salary desc;

--Who are the highest-paid employees?
select  employeeid, department,jobrole,  monthlyincome
from hr_data
group by employeeid
order by monthlyincome desc
limit 10;

--How are employees distributed across salary ranges?
select case
            when monthlyincome < 30000 then 'low salary'
			when monthlyincome between 30000 and 60000 then 'medium salary'
			when monthlyincome between 60001 and 100000 then 'high salary'
			else 'very high salary'
			end as salary_range,
      count(*) as total_employees	
from hr_data
group by salary_range
order by salary_range desc;
        		
--4. Promotion Analysis 
--How long do employees wait before promotion?
select jobrole,round(avg(yearssincelastpromotion),2) as average_years_since_promotion
from hr_data
group by jobrole
order by average_years_since_promotion;

--Which employees may be overdue for promotion?
select 
       employeeid,
	   jobrole,
	   department,
	   yearsatcompany,
	   yearssincelastpromotion,
	   joblevel,
	   monthlyincome
from hr_data	
where yearssincelastpromotion >=5
and attrition = 'No'
order by yearssincelastpromotion desc;
	   
-- Which department has the longest promotion cycle?
SELECT
    Department,
    ROUND(AVG(YearsSinceLastPromotion), 2) AS Average_Years_Since_Promotion
FROM hr_data
GROUP BY Department
ORDER BY Average_Years_Since_Promotion DESC;
 
--5. Employee Experience
--Which department has the lowest job satisfaction?
select department ,jobssatisfaction, as low_job_sattisfaction
from hr_data
group by department
order by;

--Which department has poor workplace satisfaction?
SELECT
    Department,
    ROUND(AVG(EnvironmentSatisfaction), 2) AS Average_Workplace_Satisfaction
FROM hr_data
GROUP BY Department
ORDER BY Average_Workplace_Satisfaction ASC;

--Which employees report poor work-life balance? 
SELECT EmployeeID,
       JobRole,
	   Department,
	   WorkLifeBalance,
	   JobSatisfaction,
	   YearsAtCompany,
	   MonthlyIncome
FROM hr_data
WHERE WorkLifeBalance IN (1, 2) 
ORDER BY WorkLifeBalance ASC;

--Which departments have weaker employee relationships? 
SELECT Department,
ROUND(AVG(JobInvolvement), 2) AS Average_Job_Involvement 
FROM hr_data
GROUP BY Department
ORDER BY Average_Job_Involvement ASC;

--6. Performance Analysis 
--How many employees are High, Medium, and Low performers?
SELECT
    PerformanceRating_Label AS Performance_Level,
    COUNT(*) AS Total_Employees
FROM hr_data
GROUP BY PerformanceRating_Label
ORDER BY Total_Employees DESC;

--Which department performs best?
select department,  round(avg(performancerating),2) as avg_perfroms_rating
from hr_data
group by department
order by avg_perfroms_rating desc;

--Are high-performing employees paid more? 
select 
      performancerating_label as performance_level,
	  count(*) as total_employees,
	  round(avg(monthlyincome),2) as avg_monthly_income
from hr_data
group by performance_level
order by avg_monthly_income;

--Are high performers leaving the company?
select performancerating_label as performance_level,
       count(*) as total_employees,
	  sum(case 
	          when attrition = 'Yes' then 1 else 0 end) as employees_leaving,
	  round(sum(case 
	              when attrition = 'Yes' then 1 else 0 end)*100 / count(*),2) as attrition_rate	
from hr_data
group by performance_level
order by attrition_rate desc;

--How experienced is the workforce?
select experience_level,
count(*) as total_employees,
round(count(*)*100/(select count(*)from hr_data),2) as Percentage
from hr_data
group by experience_level
order by total_employees desc;

--How long do employees stay? 
select count(*) as total_employees,
       round(avg(yearsatcompany) ,2) as avg_years_at_company,
	   min(yearsatcompany) as min_years,
	   max(yearsatcompany) as max_years
from hr_data;

--Do new employees leave more frequently?
 select case when yearsatcompany <= 2 then 'new employees' else 'Established employees' end as Tenure_Group,
count(*) as total_employees,
sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
round(sum(case when attrition = 'Yes' then 1 else 0 end) *100 / count(*),2) as attrition_rate
from hr_data
group by Tenure_Group
order by attrition_rate desc;

--8. Education Analysis 
--What is the education profile of employees? 
select 
         education_label as edcation_level,
         count(*) as total_employees,
         round(count(*)*100/(select count(*)from hr_data),2) as Percentage
from hr_data
group by education_label
order by  total_employees desc;

--Does education level affect employee turnover? 
select education_label as education_level,
       count(*) as total_employees,
	   sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
	   round(sum(case when attrition = 'Yes' then 1 else 0 end)*100/count(*),2) as attrition_rate
from hr_data
group by education_label
order by attrition_rate desc;

--10. Executive Business Insights 
--Which department has the highest attrition and the lowest job satisfaction?
select department,
       count(*) as total_employees,
	   sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
	   round(sum(case when attrition = 'Yes' then 1 else 0 end)*100/count(*),2) as attrition_rate,
	   round(avg(jobsatisfaction),2) as avg_job_satisfaction
from hr_data
group by department
order by attrition_rate desc,avg_job_satisfaction asc;

--Which employees are at the highest risk of leaving?
select employeeid,
       department,
	   jobrole,
	   yearsatcompany,
	   monthlyincome,
	   jobsatisfaction,
	   worklifebalance,
	   environmentsatisfaction,
	   jobinvolvement,
	   (case when jobsatisfaction <= 2 then 1 else 0  end +
	    case when worklifebalance <= 2 then 1 else 0  end +
	    case when environmentsatisfaction <= 2 then 1 else 0  end +
	    case when yearsatcompany <= 2 then 1 else 0  end +
        case when jobinvolvement <= 2 then 1 else 0  end ) as risk_score
from hr_data
where attrition = 'No'
order by risk_score desc;

--Which department needs salary adjustment?
select department,
       round(avg(monthlyincome),2) as avg_monthly_income
from hr_data 
group by department
order by avg_monthly_income asc;

--Which employees should be promoted first?
select employeeid,
       department,
	   jobrole,
	   joblevel,
	   performancerating
	   yearsatcompany,
	   monthlyincome,
	   jobsatisfaction,
	   jobinvolvement,
	   yearssincelastpromotion,
	   (
         case when performancerating >= 4 then 2 else 0 end +
		 case when yearsatcompany >= 3 then 1 else 0 end +
		 case when jobinvolvement >= 5 then 1 else 0 end +
		 case when yearssincelastpromotion >= 3 then 1 else 0 end 
	   ) as promotion_score
from hr_data	   
where attrition = 'No'
order by promotion_score desc,
         performancerating desc,
		 yearssincelastpromotion desc;

--Which department has the best overall performance while maintaining low attrition?
select department,
	   	round(avg(performancerating),2) as avg_performance,
		count(*) as total_employees,
	   sum(case when attrition = 'Yes' then 1 else 0 end) as employees_left,
	   round(sum(case when attrition = 'Yes' then 1 else 0 end)*100/count(*),2) as attrition_rate
from hr_data
group by department
order by avg_performance desc,attrition_rate asc;
