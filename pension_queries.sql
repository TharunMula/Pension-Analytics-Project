create database pension;
use pension;
select * from pension;
/*
 Average pension payout by region.
 Top 10 pensioners by payout.
 Identifying employees nearing retirement.
 Pension type and status distributions.
Bucketing pensions based on the newly calculated years_of_service to analyze
tenure vs. payout.
*/

select region, avg(monthly_pension) as payout from pension group by region;

select pensioner_id, monthly_pension as payout from pension order by payout desc limit 10;

SELECT 
    pensioner_id,
    name,
    retirement_date
FROM pension
WHERE retirement_date > CURRENT_DATE()
  AND retirement_date <= DATE_ADD(CURRENT_DATE(), INTERVAL 6 MONTH);


SELECT pension_type, pension_status, count(*) from pension group by pension_type, pension_status order by pension_type, pension_status;


SELECT 
    CASE 
        WHEN years_of_service < 10 THEN '0-9 years'
        WHEN years_of_service BETWEEN 10 AND 19 THEN '10-19 years'
        WHEN years_of_service BETWEEN 20 AND 29 THEN '20-29 years'
        WHEN years_of_service BETWEEN 30 AND 39 THEN '30-39 years'
        ELSE '40+ years'
    END AS service_bucket,
    COUNT(*) AS total_pensioners,
    AVG(monthly_pension * 12 * years_of_service) AS avg_total_payout
FROM pension GROUP BY service_bucket ORDER BY service_bucket;
