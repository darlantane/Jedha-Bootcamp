-- In which sector do we have the most companies?

SELECT 
GICS_Sector, COUNT(*)

FROM NYSE.nyse
GROUP BY GICS_Sector
ORDER BY COUNT(*) DESC
LIMIT 1;

-- What is the top 5 Californian cities with the most companies in the NYSE?

SELECT
Address_of_Headquarters, COUNT(*)

FROM NYSE.nyse
WHERE Address_of_Headquarters LIKE '%California'
GROUP BY Address_of_Headquarters
ORDER BY COUNT(*) DESC
LIMIT 5;

-- What is the top 5 companies that made the most profit in 2015?

SELECT
C.Security,
I.Net_Income,
For_year

FROM NYSE.Indicators as I

JOIN `NYSE.Companies` as C on I.Ticker_Symbol = C.Ticker_symbol

WHERE For_year = 2015
ORDER BY Net_Income DESC
LIMIT 5;

-- And cumulatively between 2013 and 2016?

SELECT
security,
SUM(Net_income),

FROM NYSE.Indicators, NYSE.Companies
WHERE For_year BETWEEN 2013 AND 2016
GROUP BY Security
ORDER BY SUM(Net_Income) DESC
LIMIT 5;

-- Which companies are less healthy? We will calculate this by performing a ratio between assets (Total_Assets) and liabilities (Total_Liabilities). We will also round the results to three decimal places.

SELECT
Security,
ROUND(AVG(Total_Assets/Total_Liabilities), 3) as Health

FROM NYSE.Indicators, NYSE.Companies
GROUP BY Security
ORDER BY Health;

-- Which companies have the most after-tax income (Net_income) with long-term debt of less than $1,000,000?

SELECT
Security,
After_Tax_ROE
Long_Term_Debt

FROM NYSE.Indicators, NYSE.Companies
WHERE Long_Term_Debt < 1000000
ORDER BY After_Tax_ROE DESC
LIMIT 5


