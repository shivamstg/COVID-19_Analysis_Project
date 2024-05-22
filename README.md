# COVID-19 Data Analysis and Visualization Project
Unveiling Trends and Insights. In the face of the unprecedented challenges posed by the COVID-19 pandemic, this project undertakes a comprehensive exploration of the pandemic's impact worldwide.

## Project Description
The aim of this project is to analyze the spread of COVID-19 across the world and evaluate the effectiveness of vaccination drives conducted by various countries. By leveraging SQL for data analysis and Tableau for visualization, I have derived meaningful insights into the pandemic's impact and vaccination efficacy.

### Data Sources
The project uses three primary datasets:

  - Cases and Deaths Table: Contains information on COVID-19 cases and deaths worldwide.
  - Countries Table: Provides details about the countries included in the analysis.
  - Vaccination Table: Includes data on the number of COVID-19 vaccine doses administered globally.

### Problem Statement
The main objective is to understand the global spread of COVID-19 and assess the efficacy of vaccination campaigns. The project addresses the following questions:

  #### 1. Global Numbers
  - Total Cases Worldwide: What is the cumulative total number of COVID-19 cases worldwide?
  - Total Vaccinated People (At Least One Dose): How many individuals globally have received at least one dose of the COVID-19 vaccine?
  - Total Confirmed COVID-19 Deaths: What is the overall count of confirmed COVID-19-related deaths globally?
  - Percentage of Deaths Among Affected Individuals: What percentage of individuals affected by COVID-19 worldwide have succumbed to the virus?
  #### 2. Percent Population Infected per Country
  - Percentage of Population Infected: What percentage of the total population in each country has been infected by COVID-19?
  #### 3. Number of Vaccine Doses Given (or per Million People)
  - Total Number of Vaccine Doses Given: How many vaccine doses have been given till a given date per country?
  - Number of Vaccine Doses Given per Million Population: How many vaccine doses have been given till a given date per million people per country?
  #### 4. Total Death Count per Continent
  - COVID-19 Death Count per Continent: What is the total number of confirmed COVID-19-related deaths per continent?
  #### 5. Daily New Confirmed COVID-19 Cases (or per Million People)
  - 7-day Rolling Average of Daily New Confirmed Cases (Country-wise): What is the 7-day rolling average of daily new confirmed COVID-19 cases for each country?
  - 7-day Rolling Average of Daily New Confirmed Cases per 1 Million Population (Country-wise): What is the 7-day rolling average of daily new confirmed COVID-19 cases per 1 million population for each country?
  #### 6. Estimate of the Effective Reproduction Rate (R) of COVID-19
  - 7-day Rolling Average Reproduction Rate: What is the 7-day rolling average of the reproduction rate (R) of COVID-19?

### Data Analysis Using SQL
To answer the above questions, I formulated SQL queries and executed them on the respective tables. The results were then exported to Tableau for visualization.

### Tableau Dashboard
  - The Tableau dashboard includes the following visualizations:
  - Global Numbers: Displays world population, total people vaccinated, total cases, total deaths, and death percentage in a table format.
  - Total COVID-19 Deaths Per Continent: A bar chart showing the total number of confirmed COVID-19-related deaths per continent.
  - Percent Population Infected per Country: A map illustrating the percentage of the population infected with COVID-19 in each country.
  - COVID-19 Tracker (7-Day Moving Average): A line chart tracking the 7-day moving average of vaccine doses administered, confirmed cases, confirmed deaths, and the COVID-19 reproduction rate.

## Conclusion
This project highlights the importance of data analysis and visualization in understanding and combating the COVID-19 pandemic. By using SQL and Tableau, I have provided a comprehensive overview of the pandemic's global impact and the effectiveness of vaccination efforts.

Feel free to explore the Tableau Dashboard and the SQL queries in this repository. Thank you for visiting!

#### Visit the link below for the operation dashboard:
https://public.tableau.com/views/Covid-19VaccinationEfficacyAnalysis/Dashboard?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link
