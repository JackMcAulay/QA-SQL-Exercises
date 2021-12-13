USE world;

#Using COUNT, get the number of cities in the USA.
SELECT count(*) FROM city WHERE CountryCode = 'USA';

#Find out the population and life expectancy for people in Argentina.
SELECT Population, LifeExpectancy FROM country WHERE code = 'ARG';

#Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT Name, LifeExpectancy FROM country 
WHERE LifeExpectancy IS NOT NULL ORDER BY LifeExpectancy DESC LIMIT 1;

#Using JOIN ... ON, find the capital city of Spain.
SELECT city.name FROM city 
INNER JOIN country ON city.ID = country.Capital 
WHERE country.Name = 'Spain'; 

#Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT country.Name, countrylanguage.Language FROM countrylanguage
INNER JOIN country ON CountryCode =  country.Code
WHERE country.Region = 'Southeast Asia';

#Using a single query, list 25 cities around the world that start with the letter F.
SELECT * FROM city WHERE name LIKE 'F%' LIMIT 25;

#Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT count(*) FROM city
INNER JOIN country ON CountryCode =  country.Code
WHERE country.Code = 'CHN';

#Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT Name, Population FROM country 
WHERE Population != 0 ORDER BY Population ASC LIMIT 1; #NOT NULL didn't work, value was 0 not Null

#Using aggregate functions, return the number of countries the database contains.
SELECT count(*) FROM country;

#What are the top ten largest countries by area?
SELECT * FROM country ORDER BY SurfaceArea DESC LIMIT 10;

#List the five largest cities by population in Japan.
SELECT * FROM city WHERE CountryCode = 'JPN' ORDER BY Population DESC LIMIT 5;

#List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE country SET HeadOfState = 'Elizabeth II' WHERE HeadOfState = 'Elisabeth II';

SELECT Code, Name FROM country WHERE HeadOfState = 'Elizabeth II';

#List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT Name, Population/SurfaceArea FROM country 
WHERE Population/SurfaceArea != 0 ORDER BY Population/SurfaceArea LIMIT 10;

#List every unique world language.
SELECT DISTINCT Language FROM countrylanguage ORDER BY Language ASC; 

#List the names and GNP of the world's top 10 richest countries.
SELECT Name, GNP FROM country ORDER BY GNP DESC LIMIT 10;

#List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT country.Name, count(countrylanguage.Language) FROM country
INNER JOIN countrylanguage ON CountryCode =  country.Code
GROUP BY country.Name ORDER BY count(countrylanguage.Language) DESC LIMIT 10;

#List every country where over 50% of its population can speak German.
SELECT country.Name, countrylanguage.Percentage FROM country
INNER JOIN countrylanguage ON CountryCode =  country.Code
WHERE countrylanguage.Language = 'German' 
AND countrylanguage.Percentage >= 50;

#Which country has the worst life expectancy? Discard zero or null values.
SELECT Name, LifeExpectancy FROM country WHERE LifeExpectancy IS NOT NULL ORDER BY LifeExpectancy ASC LIMIT 1;

#List the top three most common government forms.
SELECT GovernmentForm, count(*) FROM country ORDER BY GovernmentForm desc;

#How many countries have gained independence since records began?
SELECT count(*) FROM country WHERE IndepYear IS NOT NULL;