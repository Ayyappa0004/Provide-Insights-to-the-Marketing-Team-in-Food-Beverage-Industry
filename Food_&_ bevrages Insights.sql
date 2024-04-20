/*1. Demographic Insights
a. Who prefers energy drink more? (male/female/non-binary?)*/
WITH CTE AS (
    SELECT 
        CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END AS Total_Male,
        CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END AS Total_Female,
        CASE WHEN Gender = 'Non-binary' THEN 1 ELSE 0 END AS Total_Non_binary
    FROM dim_repondents
)
SELECT Age,
    SUM(Total_Male) AS Total_Males,
    SUM(Total_Female) AS Total_Females,
    SUM(Total_Non_binary) AS Total_Non_binary
FROM CTE;

/* b. Which age group prefers energy drinks more?*/
select Age, count(*) as Age_Prefrences
from dim_repondents
group by Age
order by Age_Prefrences desc;

/* c. Which type of marketing reaches the most Youth (15-30)?*/
SELECT s.Marketing_channels, COUNT(*) AS ReachCount_Youth
FROM fact_survey_responses s
JOIN dim_repondents r ON s.Respondent_ID = r.Respondent_ID
WHERE r.Age = '19-30' 
GROUP BY s.Marketing_channels
ORDER BY ReachCount_Youth desc;


/*2. Consumer Preferences:
a. What are the preferred ingredients of energy drinks among respondents?*/
select Ingredients_expected as Ingredients, count(*) as Total_ingredients_preferred
from fact_survey_responses
group by Ingredients_expected
order by Total_ingredients_preferred desc;

/*b. What packaging preferences do respondents have for energy drinks?*/
 select Packaging_preference as Packagings, count(*) as Total_preferred_package
from fact_survey_responses
group by Packaging_preference
Order by Total_preferred_package desc;



/*3. Competition Analysis
a. Who are the current market leaders?*/
select Current_brands as Brands, count(*) as Market_leaders
from fact_survey_responses
group by Brands
Order by market_leaders desc;

/*b. What are the primary reasons consumers prefer those brands over ours*/
select Reasons_for_choosing_brands as brands,Count(*) as Reasons_prefer_brands
from fact_survey_responses
group by Reasons_for_choosing_brands
Order by Reasons_prefer_brands DESC;





/*4. Marketing Channels and Brand Awareness:
a. Which marketing channel can be used to reach more customers?*/
select Marketing_channels, count(*) as best_marketing_channels
from fact_survey_responses
group by Marketing_channels
order by best_marketing_channels desc;



/*5. Brand Penetration: 
# a. What do people think about our brand? (overall rating)*/
select Brand_perception, count(*) as Brand_rating
from fact_survey_responses
group by Brand_perception
order by Brand_rating desc;

select Taste_experience, count(*) as Taste_rating
from fact_survey_responses
group by Taste_experience
order by Taste_rating desc;

/* b. Which cities do we need to focus more on?*/
SELECT c.City, c.Tier, COUNT(r.Respondent_ID) AS Count_of_Response,
ROUND((COUNT(r.Respondent_ID)/10000*100), 1) AS Percentage_of_Response
FROM dim_cities c
JOIN dim_repondents r
ON c.city_id=r.city_id
GROUP BY c.City, c.Tier
ORDER BY Count_of_Response DESC;



/*6. Purchase Behavior:
a. Where do respondents prefer to purchase energy drinks?*/
SELECT Purchase_location, COUNT(Respondent_ID) AS Count_of_Response
FROM fact_survey_responses
GROUP BY Purchase_location
ORDER BY Count_of_Response DESC;

/*b. What are the typical consumption situations for energy drinks among
respondents?*/
SELECT Typical_consumption_situations, COUNT(Respondent_ID) AS Count_of_Response
FROM fact_survey_responses
GROUP BY Typical_consumption_situations
ORDER BY Count_of_Response DESC;

/*c. What factors influence respondents' purchase decisions, such as price range and
limited edition packaging?*/
SELECT Limited_edition_packaging,
COUNT(Respondent_ID) AS Count_of_Response
FROM fact_survey_responses
GROUP BY Limited_edition_packaging
ORDER BY Count_of_Response DESC;

SELECT Price_range, COUNT(Respondent_ID) AS
Count_of_Response
FROM fact_survey_responses
GROUP BY Price_range
ORDER BY Count_of_Response DESC;



/*7. Product Development

a. Which area of business should we focus more on our product development?
(Branding/taste/availability)*/
SELECT Reasons_for_choosing_brands, COUNT(Respondent_ID) AS Count_of_Response
FROM fact_survey_responses
WHERE Current_brands="CodeX"
GROUP BY Reasons_for_choosing_brands
ORDER BY Count_of_Response DESC;

