source("Functions.R")

library(shiny)
library(shinythemes)

purpose <- "The app will provide users with insights and recommendations based 
on the top 1000 IMDb movie data from 1920 to 2020. It will provide users with a
general overview of the data and allow users to explore and analyze various 
aspects of the data including movie recommendations, gross profit of the movies
over time, and scores of movies within each decade. Genre, release years, and ratings 
are among the variables that can be adjusted by the user for further analysis."

overview <- "This dataset is from Kaggle, and the link to the data source on
Kaggle is provided below. Below also lists a brief data dictionary with all the
attributes with respective descriptions. Please keep in mind that not all 
attributes are used in this app, but further analysis and exploration can be
done by others with access to the data."

poster_link <- "Poster_Link: Link of the poster that IMDb is using."
series_title <- "Series_Title: Name of the movie."
released_year <- "Released_Year: The year in which that movie released."
certificate <- "Certificate: Certificate earned by that movie."
runtime <- "Runtime: Total runtime of the movie."
genre <- "Genre: The genre of the movie."
imdb_rating <- "IMDb_Rating: Rating of the movie at the IMDb site."
overview <- "Overview: Provides a mini story/summary."
meta_score <- "Meta_score: Score earned by the movie."
director <- "Director: Name of the Director."
stars <- "Stars: Name of the top 4 Stars (Star1, Star2, Star3, Star4) in the movie."
votes <- "No_of_votes: Total number of votes."
gross <- "Gross: Money earned by that movie."

link <- "https://www.kaggle.com/datasets/harshitshankhdhar/imdb-dataset-of-top-1000-movies-and-tv-shows/data"

unique_genres <- unique(c(movies$Genre1,movies$Genre2,movies$Genre3))
unique_genres <- unique_genres[unique_genres!=""]

ui <- fluidPage(theme=shinytheme("cerulean"),
                navbarPage("1920-2020 IMDb Top 1000 Movies",
                           
                           tabPanel("General Information",
                                    titlePanel("STAT 6365 Final Project"),
                                    mainPanel(
                                      h3("Purpose/scope of the project"),
                                      h5(purpose),
                                      
                                      h3("Link to data source on Kaggle"),
                                      h5(a("Data Source - Top 1000
                                       Movies by IMDB Rating",
                                           href=link)),
                                      
                                      h3("Brief Data Dictionary"),
                                      h5(overview),
                                      h5(poster_link),
                                      h5(series_title),
                                      h5(released_year),
                                      h5(certificate),
                                      h5(runtime),
                                      h5(genre),
                                      h5(imdb_rating),
                                      h5(overview),
                                      h5(meta_score),
                                      h5(director),
                                      h5(stars),
                                      h5(votes),
                                      h5(gross)
                                    )
                           ),
                           
                           tabPanel("Movie Recommendations",
                                    titlePanel("What Movies Should You Watch?"),
                                    sidebarPanel(
                                      h2("Please filter these inputs below."),
                                      
                                      checkboxGroupInput("table_genres",
                                                         h4("1. Select the genres
                                                            you would like
                                                            to examine."),
                                                         choices=unique_genres,
                                                         selected="Drama"
                                      ),
                                      
                                      sliderInput("released_years",
                                                  h4("2. Release years"),
                                                  min=1920,max=2020,step=1,
                                                  value=c(1920,2020),
                                                  ticks=T,dragRange=T,sep=""
                                      ),
                                      
                                      sliderInput("imdb_rating",
                                                  h4("3. IMDb Rating"),
                                                  min=7.6,max=9.3,step=0.1,
                                                  value=c(7.6,9.3),
                                                  ticks=T,dragRange=T
                                      ),
                                      
                                      h2("Please filter the output options below."),
                                      
                                      checkboxGroupInput("col_names",
                                                         h4("4. Select columns you
                                                         would like to see."),
                                                         choices=colnames(movies)
                                                         [c(2:6,10:13,18:20)],
                                                         selected=colnames(movies)
                                                         [c(2,3,6,11)]
                                      ),
                                      
                                      helpText("Please keep in mind that for the
                                               order by to work, the column chosen
                                               in question 5 below must be
                                               selected in the columns displayed
                                               in question 4 above. If not, the
                                               data will be outputted with no
                                               ordering even if an option is
                                               selected for question 5."),
                                      
                                      radioButtons("order_by",
                                                   h4("5. What would you like to
                                                      order results by?"),
                                                   choices=colnames(movies)
                                                   [c(2:6,10:13,18:20)],
                                                   selected=colnames(movies)[3]
                                      ),
                                      
                                      radioButtons("descending",
                                                   h4("6. Would you like the results
                                                   to be in ascending or
                                                   descending order?"),
                                                   choices=c("Ascending"=F,
                                                             "Descending"=T)
                                      )
                                    ),
                                    
                                    mainPanel(tableOutput("movie_table")
                                    )
                           ),
                           
                           tabPanel("Gross Profit",
                                    
                                    titlePanel("Average gross profit over time
                                    for each genre"),
                                    
                                    sidebarPanel(
                                      h2("Please filter these inputs below."),
                                      
                                      radioButtons("gross_genre",
                                                         h4("1. Select the genre
                                                            you would like
                                                            to examine."),
                                                         choices=c(unique_genres,
                                                                   "All genres")
                                      ),
                                      
                                      sliderInput("imdb_rating2",
                                                  h4("2. IMDb Rating"),
                                                  min=7.6,max=9.3,step=0.1,
                                                  value=c(7.6,9.3),
                                                  ticks=T,dragRange=T
                                      )
                                    ),
                                    
                                    mainPanel(plotOutput("gross_profit_plot")),
                                    
                                    mainPanel(textOutput("get_gross_rows"))
                           ),
                           
                           tabPanel("Average Ratings",
                                    
                                    titlePanel("Average meta scores or IMDb
                                               rating by decade"),
                                    
                                    sidebarPanel(
                                      h2("Please filter the input below."),
                                      
                                      radioButtons("ratings_genre",
                                                   h4("1. Select the genre
                                                            you would like
                                                            to examine."),
                                                   choices=c(unique_genres)
                                      ),
                                      
                                      h2("Please filter the response variable."),
                                      
                                      radioButtons("response",
                                                   h4("2. Select which variable
                                                      you would like to examine"),
                                                   choices=c("IMDb_Rating",
                                                             "Meta_score")
                                      )
                                    ),
                                    
                                    mainPanel(plotOutput("average_rating_bar"))
                             
                           )
                           
                )
)

server <- function(input,output) {
  output$movie_table <- renderTable({
    table <- movie_recommendations(genres=input$table_genres,
                                   min_year=input$released_years[1],
                                   max_year=input$released_years[2],
                                   min_rating=input$imdb_rating[1],
                                   max_rating=input$imdb_rating[2],
                                   col_names=input$col_names,
                                   order_by=input$order_by,
                                   descending=input$descending)
    table
  })
  
  output$gross_profit_plot <- renderPlot({
    gross_profit(genre=input$gross_genre,min_rating=input$imdb_rating2[1],
                 max_rating=input$imdb_rating2[2])
  })
  
  output$get_gross_rows <- renderText({
    get_gross_instances(genre=input$gross_genre,min_rating=input$imdb_rating2[1],
                        max_rating=input$imdb_rating2[2])
  })
  
  output$average_rating_bar <- renderPlot({
    avg_bar(genre=input$ratings_genre,response=input$response)
  })
}

shinyApp(ui=ui,server=server)