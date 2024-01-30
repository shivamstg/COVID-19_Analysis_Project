--Countries' information Table
SELECT top (1000) *
FROM CovidProject..covidCountries

--COVID cases and death Table
SELECT top (1000) *
FROM CovidProject..CovidDeaths
ORDER by 3,4

--COVID Vaccinations Table
SELECT top (1000) *
FROM CovidProject..CovidVaccinations
ORDER by 3,4


--***QUESTIONS***

--### 1. Global Numbers
--**a. Total Cases ₹Worldwide:**
--   - What is the cumulative total number of COVID-19 cases worldwide?

--**b. Total Vaccinated People (At Least One Dose):**
--   - How many individuals globally have received at least one dose of the COVID-19 vaccine?

--**c. Total Confirmed COVID-19 Deaths:**
--   - What is the overall count of confirmed COVID-19-related deaths globally?

--**d. Percentage of Deaths Among Affected Individuals:**
--   - What percentage of individuals affected by COVID-19 worldwide have succumbed to the virus?

--**ANSWER**
with t2 as (SELECT location, max(cast(people_vaccinated as bigint)) as peopleVaccinated
FROM CovidProject..CovidVaccinations
where continent is not null
group by location)

SELECT (SELECT sum(population)
		FROM CovidProject..covidCountries
		where continent is not null) as WorldPopulation
		, (select SUM(peopleVaccinated)
		from t2) as totalPeopleVaccinated
		, SUM(new_cases) as totalCases
		, SUM(new_deaths) as totalDeaths
		, ROUND((SUM(new_deaths)*100.0/SUM(new_cases)),3) as DeathPercentage
FROM CovidProject..CovidDeaths cd
WHERE cd.continent is not null

--### 2. Map - Percent Population Infected per Country
--**a. Percentage of Population Infected:**
--   - What percentage of the total population in each country has been infected by COVID-19?

--**ANSWER**
SELECT cd.location
	--, sum(cast(new_cases as int)) as peopleInfected
	, ROUND((sum(cast(new_cases as int))*100.0/MAX(cc.population)),3) as percentPopinfected
FROM CovidProject..CovidDeaths cd
join CovidProject..covidCountries cc ON cd.iso_code=cc.iso_code and cd.location=cc.location
where cd.continent is not null
GROUP BY cd.location
ORDER by 1



--### 3. Number of People Who Completed Initial COVID-19 Vaccination
--**a. Total Number of Fully Vaccinated Individuals:**
--   - How many individuals have received all doses prescribed by the initial COVID-19 vaccination protocol globally?

--**b. Percentage of Fully Vaccinated Individuals Relative to Population:**
--   - What percentage of each country's total population has completed the initial COVID-19 vaccination protocol?

--**ANSWER**
SELECT cv.location
	, max(cast(people_fully_vaccinated as bigint)) as peopleFullyVaccinated
	, (max(cast(people_fully_vaccinated as bigint))*100.0/MAX(cc.population)) as percentPopFullyVaccinated
FROM CovidProject..CovidVaccinations cv
join CovidProject..covidCountries cc ON cv.iso_code=cc.iso_code and cv.location=cc.location
where cv.continent is not null and cv.people_fully_vaccinated is not null
GROUP BY cv.location
ORDER by 1 asc

--### 3(modified). Number of Vaccine doses given (or per Million People
--**a. Total Number of Vaccine Doses given:**
--   - How many vaccine doses have been given till a given date per country?

--**ANSWER**
--using CTE
with totVacDoses1 as (
SELECT cv.continent
	, cv.location
	, date
	, new_vaccinations
	, SUM(Convert(bigint, new_vaccinations)) OVER(Partition By cv.location Order by cv.location, cv.date) as RollingSumNewVaccine
FROM CovidProject..CovidVaccinations cv
JOIN CovidProject..covidCountries cc on cv.location=cc.location and cv.iso_code=cc.iso_code
WHERE cv.continent is not null
)

select continent,location, MAX(RollingSumNewVaccine) as totalVaccineDoses
from totVacDoses1
group by continent, location
order by 1,2


--**b. Number of Vaccine dose given per million population:**
--   - How many vaccine doses have been given till a given date per Hundred people per country?

SELECT cv.continent
	, cv.location
	, date
	, new_vaccinations
	, SUM(Convert(bigint, new_vaccinations)) OVER(Partition By cv.location Order by cv.location, cv.date) as RollingSumNewVaccine
	, SUM(Convert(bigint, new_vaccinations)) OVER(Partition By cv.location Order by cv.location, cv.date)*100.0/population as RollingSumNewVaccinePer100
FROM CovidProject..CovidVaccinations cv
JOIN CovidProject..covidCountries cc on cv.location=cc.location and cv.iso_code=cc.iso_code
WHERE cv.continent is not null
ORDER by 2,3

--### 4. Total Death Count per Continent
--**a. COVID-19 Death Count per Continent:**
--   - What is the total number of confirmed COVID-19-related deaths per continent?

--total covid deaths per continent per country (by two methonds: sum and max)(done for drill down effect in tableau)

--**ANSWER**
--SUM
SELECT continent, location, sum(new_deaths) as TotalCovidDeaths
FROM CovidProject..CovidDeaths
WHERE continent is not null
GROUP BY continent, location
having sum(new_deaths) is not null
order by 2,1

--### 5. Daily New Confirmed COVID-19 Cases (or per Million People)
--**a. 7-day Rolling Average of Daily New Confirmed Cases (Country-wise):**
--   - What is the 7-day rolling average of daily new confirmed COVID-19 cases for each country?
--COVID cases and death Table

--**ANSWER**
SELECT continent
	, location
	, date
	, new_cases
	, Round((
		AVG(new_cases)
		OVER(
			Partition By location
			Order by location, date
			Rows between 6 PRECEDING AND CURRENT ROW
		)
	),3) as SevenDayMovAvgNewCases
FROM CovidProject..CovidDeaths
WHERE continent is not null
order by 2,3

--**b. 7-day Rolling Average of Daily New Confirmed Cases per 1 Million Population (Country-wise):**
--   - What is the 7-day rolling average of daily new confirmed COVID-19 cases per 1 million population for each country?

--**ANSWER**
SELECT cd.continent
	, cd.location
	, cd.date
	, cd.new_cases
	, cc.population
	, Round((
		AVG(cd.new_cases)
		OVER(
			Partition By cd.location
			Order by cd.location, cd.date
			Rows between 6 PRECEDING AND CURRENT ROW
		)
	)*1000000/cc.population,3) as weeklyMovAvgNewCasesPer1Millon
FROM CovidProject..CovidDeaths cd
JOIN CovidProject..covidCountries cc ON cd.iso_code=cc.iso_code and cd.location=cc.location
WHERE cd.continent is not null
order by 2,3

--### 6. Estimate of the Effective Reproduction Rate (R) of COVID-19
--**a. 7-day Rolling Average Reproduction Rate:**
--   - What is the 7-day rolling average of the reproduction rate (R) of COVID-19? (The average number of new infections caused by a single infected individual)

--**ANSWER**
SELECT continent
	, location
	, date
	, reproduction_rate
	, ROUND((
		AVG(CAST(reproduction_rate AS decimal(20,6)))
		OVER(
			PARTITION BY location
			ORDER BY location, date
			ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
		)
	),3) AS weeklyMovAvgReproductionRate
FROM CovidProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date