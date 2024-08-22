# IMDb Top 1000 Movies Analysis (1920-2020)

## Project Overview

This project presents a Shiny application developed as a part of a data science initiative focused on exploring the top 1000 movies on IMDb, spanning from 1920 to 2020. My inspiration for this project stemmed from the lack of movies I know and have watched. The app will provide users with insights and recommendations based on the top 1000 IMDb movie data from 1920 to 2020. It will provide users with a general overview of the data and allow users to explore and analyze various aspects of the data including movie recommendations, gross profit of the movies over time, and scores of movies within each decade. Genre, release years, and ratings are among the variables that can be adjusted by the user for further analysis. The target audience for this project includes beginners in data science and individuals interested in movie analytics. The app makes it easy to visualize and understand trends in the movie industry over the last century.

### Key Features:

1. Movie recommendations based on user preferences
2. Gross profit analysis over time for different genres
3. Average ratings comparison across decades

## Data Source

The dataset's source is Kaggle: [IMDb Top 1000 Movies and TV Shows](https://www.kaggle.com/datasets/harshitshankhdhar/imdb-dataset-of-top-1000-movies-and-tv-shows/data)

## Data Dictionary

1. Overview: Provides a mini story/summary.
2. Poster_Link: Link of the poster that IMDb is using.
3. Series_Title: Name of the movie.
4. Released_Year: The year in which that movie released.
5. Certificate: Certificate earned by that movie.
6. Runtime: Total runtime of the movie.
7. Genre: The genre of the movie.
8. IMDb_Rating: Rating of the movie at the IMDb site.
9. Overview: Provides a mini story/summary.
10. Meta_score: Score earned by the movie.
11. Director: Name of the Director.
12. Stars: Name of the top 4 Stars (Star1, Star2, Star3, Star4) in the movie.
13. No_of_votes: Total number of votes.
14. Gross: Money earned by that movie.

## App Structure

The app consists of four main tabs:

1. **General Information**: Provides an overview of the project, its purpose, and a brief data dictionary.
2. **Movie Recommendations**: Allows users to filter and sort movies based on preferences.
3. **Gross Profit**: Visualizes average gross profit over time for a specific or all genres.
4. **Average Ratings**: Compares average IMDb ratings or meta scores across decades for a specific genre selected.

### Movie Recommendations

1. Select desired genres
2. Adjust release year range
3. Set IMDb rating range
4. Choose columns to display
5. Select sorting option and order (ascending or descending)

### Gross Profit

1. Choose a specific genre or "All genres"
2. Set IMDb rating range

### Average Ratings

1. Select a genre
2. Choose between IMDb Rating or Meta Score

## Technical Details

The backend logic for the data analysis functions is implemented in base R and the tidyverse package; the backend logic for visualizations and the app itself are rendered using Shiny's reactive capabilities, specifically the shiny and shinythemes packages. The front-end app is designed to be intuitive for users with little to no experience in data science, providing them with an accessible entry point into data exploration and analysis; the back-end is designed for functionality, robust error handling, and easy future reference, with clear readability through consistent spacing, tabbing, and well-structured code.
