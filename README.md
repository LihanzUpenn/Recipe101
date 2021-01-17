# RecipeRec.com Project Outline

## Motivation and Problems Solved
Due to the unexpected rise of COVID-19 in Feb 2020, people all over the world had to choose to spend a large portion of their time at home. This phenomenon caused more and more people, especially females, to try various food recipes online to get relaxed during the WFH period. Also, cooking can become a new common topic to help them maintain their social activities and get the sense of belonging.	

According to our observation, we found that users of recipe-recommendation websites drastically increased during the past few months. Thus, we choose the food recipe website as a focus of our project. Instead of covering all recipes online, we will study bakery recipes in particular, since it is by far the most popular category and has quite a lot of data to deal with. 

## demo

1. Homepage
With the URL (/login), users can access the login page. This page is mainly responsible for the login function. Username and password are required to be entered for the login function. After a successful login, the web page will be rerouted to the homepage, URL(/home). A link to the registration page (/register) is provided for new users. Credentials will be stored in the local storage after login and will not be deleted until the user chooses to log out. The user will be able to access the homepage as long as his credential is saved in the cookies.
<img width="1408" alt="homepage" src="https://user-images.githubusercontent.com/67878225/104827534-c1e8d900-582c-11eb-99c6-eb8865eecc75.png">

2. Search Page
With the URL(/search), users can access the search page. The search page provides three options for users to search for recipes. For the ﬁrst option, users can enter up to four ingredients and search recipes based on these ingredients. For each ingredient entered, the website will provide 5 recipes. For the second option, users are given three choices, easy, medium, or hard to do recipe search based on cooking level. For the last option, users can choose a cooking time between zero to a time greater than 3.5 hours and search recipes base on the time. All recipes returned will be listed with a name, a keyword, a total time cost, and a button to learn more. By clicking the button ’LEARN MORE’, users will be rerouted to a single recipe page to get more information about the chosen recipe and some of the webˆas recommendations.

![searchOptions](https://user-images.githubusercontent.com/67878225/104827733-0ffedc00-582f-11eb-849a-9ff75ee34695.gif)

3.Single Recipe Page
With the URL format in (/learnmore/?id=author= totaltime=), user can access the single recipe page of a speciﬁc recipe. On this page, all detailed information about the recipe will be provided including a name, an id, an author, a table of ingredients, and a list of cooking directions. Two of the websiteˆas main recommendation functions are embedded in this page. Recommended recipes based on the same author and similar cooking times are listed. A list of recommended recipes based on 90% matching ingredients is provided. Users can choose to favorite or dislike the recipe. Favoriting a recipe will create a relation between the recipe and the user, and it will be stored in the database. Disliking a recipe will result in deleting the relation of the two.

![recipe page](https://user-images.githubusercontent.com/67878225/104827737-1db46180-582f-11eb-86f7-2ee4bec51ca2.gif)

4. Best Author Page
With the URL (/best), users can access the best author page of the web. On the mounding of the page, a list of top 20 recipe authors with ranking, author, and average rating will be provided. Users can further click an author name to display his recipe lists on the right of the page. By clicking on the recipe in the list, the user can learn more about the recipe on the single recipe page. Furthermore, with the URL(/collection), users can access the collection page. All userˆas favorite recipes saved in the database will be fetched and listed on the page. 

![AuthorRanking](https://user-images.githubusercontent.com/67878225/104827751-53f1e100-582f-11eb-8797-ead6fc42be4d.gif)




## Data Sources

1. [Recipe Ingredients](https://www.kaggle.com/kanaryayi/recipe-ingredients-and-reviews?select=clean_recipes.csv) 
2. [Recipe Reviews](https://www.kaggle.com/kanaryayi/recipe-ingredients-and-reviews?select=reviews.csv)
3. [Spoonacular API](https://spoonacular.com/food-api/docs#Search-Recipes-Complex)

## ERD

## Data Preperation


## Instruction for building it Locally

In order to run the app locally, 

Server:
Start the server first. Go to /final project/server. Then, type npm install, and then npm start. You will see  the message "Server listening on PORT 8080" if the server started successfully.

Front end:
Go to /final project/client and type 'npm install'. Then, type 'npm start' and use 
localhost:3000/login to access our website. 

You can use the username and password we provided or create a new one by going the register page
username: Lihanz
passwaord: abc123

NOTE:

If you counter a problem with the project dependency tree. For me, I previously installed a differernt version of  eslint locally, this might cause the problem. Simply go to /final project/client/node_modules/eslint and delete the file (or other conflict files you might have), then run "npm start" again.

## Depencies:
Client:
"@material-ui/core": "^4.11.0",
    "@material-ui/icons": "^4.9.1",
    "@material-ui/lab": "^4.0.0-alpha.56",
    "@testing-library/jest-dom": "^4.2.4",
    "@testing-library/react": "^9.3.2",
    "@testing-library/user-event": "^7.1.2",
    "antd": "^3.26.20",
    "axios": "^0.21.0",
    "bootstrap": "^4.4.1",
    "bootstrap-icons": "^1.1.0",
    "clsx": "^1.1.1",
    "jquery": "^3.5.1",
    "material-ui": "^0.20.2",
    "materialize-css": "^1.0.0-rc.2",
    "mdbootstrap": "^4.19.1",
    "mocha": "^7.2.0",
    "popper.js": "^1.16.1",
    "prop-types": "^15.7.2",
    "react": "^16.12.0",
    "react-bootstrap": "^1.0.0-beta.16",
    "react-dom": "^16.12.0",
    "react-dropdown": "^1.6.4",
    "react-router-dom": "^5.1.2",
    "react-script": "^2.0.5",
    "react-scripts": "^3.4.0",
    "selenium-webdriver": "^4.0.0-alpha.5"

Server:
 "body-parser": "^1.19.0",
    "cors": "^2.8.5",
    "express": "^4.17.1",
    "mysql": "^2.17.1"

- - - - - -  - - - - - -  - - - - - -  - - - - - -  - - - - - - 

In order to connect to our mysql database, we used the following credentials:

 host: "cis550-proj.cwbivagne6aq.us-east-1.rds.amazonaws.com",
  port: "3306",
  user: "wenyax",
  password: "rootroot",
  database: "project",


