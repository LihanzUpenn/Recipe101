-- Switch to project Database
use project;

-- After user entering the name of 1 ingredient, we use string 
-- pattern matching and group concatenation to find recipes containing given ingredient
-- Schema: RecipeID, RecipeName, RecipePhoto, Author,  Directions, Total_Time 
WITH ingred_name AS(
    SELECT recipeID, GROUP_CONCAT(ingredient SEPARATOR ',') ings
    FROM ingredient_recipe
    GROUP BY recipeID
)
SELECT IR.RecipeID, `Recipe Name`, `Recipe Photo`, Author,  Directions, Total_Time 
FROM recipes_cleaned RC JOIN ingred_name IR ON RC.recipeID=IR.recipeID
WHERE ings LIKE '%$user_input_ingredient$%'
LIMIT 5;

-- Search recipe based on cooking time
-- Schema: recipeID, recipeName, recipePhoto, author, directions, total_time
SELECT RecipeID, Recipe Name, Recipe Photo, Author, Directions, Total_Time
FROM recipes_cleaned
WHERE Total_Time BETWEEN $user_enter_lower_time$ AND $user_enter_upper_time$
LIMIT 20;

-- MOST COMPLEX QUERY
-- Recommends recipes based on cooking difficulty using following steps:
-- 1. Find users with lower averaged ratings than population rating
-- 2. Find recipes the above users rated above their personal average
-- 3. Group selected recipes based on cooking time and number of ingredients used 
-- Schema: recipeID, recipeName, RecipePhoto, author, directions, total_time
WITH avg_rating AS (
	    SELECT avg(rate) FROM reviews_cleaned
), negative_user AS(
	SELECT profileID, avg(rate) as user_avg_rate
    FROM (SELECT profileID, rate FROM reviews_cleaned) AS RC
    GROUP BY profileID
    HAVING avg(rate)<=(SELECT * FROM avg_rating)
), recipe_ratings AS(
	SELECT RecipeID, avg(Rate) as avg_rate
    FROM reviews_cleaned RC RIGHT JOIN negative_user NU 
        ON RC.profileID=NU.profileID AND RC.rate>NU.user_avg_rate
    GROUP BY RecipeID
), recipe_difficulty AS(
	SELECT DISTINCT RR.RecipeID, 
		   CASE WHEN Total_Time<30 AND COUNT(IR.ingredient)<10 THEN 'easy'
			    WHEN Total_Time<30 AND COUNT(IR.ingredient)<20 THEN 'medium'
                ELSE 'hard' END as difficulty,
		   RR.avg_rate AS rating
    FROM recipe_ratings RR 
		    JOIN recipes_cleaned RC ON RR.recipeID=RC.recipeID
		    RIGHT JOIN ingredient_recipe IR ON RR.recipeID=IR.recipeID
    GROUP BY RR.RecipeID, RC.Total_Time, RR.avg_rate
)
	    SELECT *
    FROM recipe_difficulty RD LEFT JOIN recipes_cleaned RC ON RD.recipeID=RC.recipeID
    WHERE difficulty= 'hard'
    ORDER BY rating DESC LIMIT 10;

-- Select recipes from same writer and can be finished within similar time
-- Schema: (recipeID, recipeName, RecipePhoto, author, directions, total_time)
SELECT RecipeID, `Recipe Name`, `Recipe Photo`, Author, Directions, Total_Time
FROM recipes_cleaned
WHERE Author = $user_select_recipe_author$ AND Total_Time 
    BETWEEN $user_select_Time$-80 AND $user_select_Time$+80
LIMIT 20;

-- Finds top 20 authors with the highest averaged ratings
-- Schema: (author, averaged_rating)
SELECT a.Author, avg(b.Rate) 
FROM recipes_cleaned a JOIN reviews_cleaned b
ON a.RecipeID = b.RecipeID
GROUP BY a.Author
ORDER BY avg(b.Rate) DESC
LIMIT 20 ;

-- Recommend similar recipes 
-- After user selects a recipe, returns other recipes with 90% overlapping ingredients
-- Return top 10 recipes with highest averaged ratings
-- Schema: (RecipeID, RecipeName,  RecipePhoto)
WITH ingredients AS(
    SELECT ingredient
    FROM ingredient_recipe 
    WHERE RecipeID=$user_enter_recipeID$
), similar_ingredient_num AS(
    SELECT FLOOR(COUNT(*)*0.9) 
    FROM ingredients
), similar_recipe AS(
    SELECT RecipeID
	FROM ingredient_recipe
	GROUP BY recipeID
	HAVING 
	    COUNT(ingredient in (SELECT * FROM ingredients))>=
	    (SELECT * 
	    FROM similar_ingredient_num)
), reviews_avg AS(
    SELECT RecipeID, avg(rate) as avg_rate
    FROM reviews_cleaned 
    GROUP BY RecipeID
)
SELECT DISTINCT SR.recipeID as ID, SC.`Recipe Name` as RecipeName, 
    SC.`Recipe Photo` as RecipePhoto
FROM similar_recipe SR 
		 LEFT JOIN recipes_cleaned SC ON SR.recipeID=SC.recipeID
		 LEFT JOIN reviews_avg RC ON SR.recipeID=RC.recipeID
	WHERE SR.recipeID!=$user_enter_recipeID$
	GROUP BY SR.recipeID, SC.`Recipe Name`, SC.`Recipe Photo`, RC.avg_rate
ORDER BY avg_rate DESC LIMIT 10;