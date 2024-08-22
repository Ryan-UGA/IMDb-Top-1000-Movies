# Loading in the data ####
library(tidyverse)
movies<-read_csv("imdb_top_1000.csv",na=c("NULL","NA","PrivacySupressed"))%>%
  lapply(trimws)%>%
  as_tibble()

movies$Released_Year<-as.integer(movies$Released_Year)
movies$IMDB_Rating<-as.double(movies$IMDB_Rating)
movies$Gross<-as.numeric(movies$Gross)
movies$Meta_score<-as.numeric(movies$Meta_score)

movies<-movies%>%
  mutate(Released_Decade=case_when(
    Released_Year %in% 1920:1929 ~ "1920s",
    Released_Year %in% 1930:1939 ~ "1930s",
    Released_Year %in% 1940:1949 ~ "1940s",
    Released_Year %in% 1950:1959 ~ "1950s",
    Released_Year %in% 1960:1969 ~ "1960s",
    Released_Year %in% 1970:1979 ~ "1970s",
    Released_Year %in% 1980:1989 ~ "1980s",
    Released_Year %in% 1990:1999 ~ "1990s",
    Released_Year %in% 2000:2009 ~ "2000s",
    Released_Year %in% 2010:2019 ~ "2010s",
    Released_Year %in% 2020:2024 ~ "2020s"
  ))

movie_recommendations<-function(genres,min_year=1920,max_year=2020,min_rating=7.6,
                                max_rating=9.3,col_names,order_by="Released_Year",
                                descending=F) {
  data<-movies
  data <- data%>%
    filter(Genre1 %in% genres | Genre2 %in% genres | Genre3 %in% genres)
  data<-data%>%
    filter((Released_Year >= min_year) & (Released_Year <= max_year))
  data<-data%>%
    filter((IMDB_Rating >= min_rating) & (IMDB_Rating <= max_rating))
  
  frame<-as.data.frame(data[,col_names],drop=F)
  if (!(order_by %in% colnames(frame))) {
    return(frame)
  }
  if (descending==T) {
    frame%>%
      arrange(desc(across(all_of(order_by))))%>%
      return()
  }
  else if (descending==F) {
    frame%>%
      arrange(across(all_of(order_by)))%>%
      return()
  }
}

gross_profit<-function(genre="All genres",min_rating=7.6,max_rating=9.3) {
  data<-movies
  if (genre!="All genres") {
    data<-data%>%
      filter(Genre1==genre | Genre2==genre | Genre3==genre)
  }
  
  data<-data%>%
    filter(!(is.na(Gross)))
  
  data<-data%>%
    filter((IMDB_Rating >= min_rating) & (IMDB_Rating <= max_rating))
  
  data<-data %>%
    group_by(Released_Year) %>%
    summarise(Mean=mean(Gross,na.rm=T))
  
  data<-data%>%
    filter(!(is.na(Released_Year)))
  
  ggplot(data = data,mapping = aes(x = Released_Year,y = Mean))+
  geom_line(color="blue")+
  scale_y_continuous(breaks=scales::extended_breaks(n=5),
                     labels=scales::label_comma(accuracy=1))+
  labs(x="Time",y="Gross")+
  ggtitle(paste("Gross versus time for",str_to_lower(genre)))
}

get_gross_instances<-function(genre,min_rating,max_rating) {
  data<-movies
  if (genre!="All genres") {
    data<-data%>%
      filter(Genre1==genre | Genre2==genre | Genre3==genre)
  }
  
  data<-data%>%
    filter(!(is.na(Gross)))
  
  data<-data%>%
    filter((IMDB_Rating >= min_rating) & (IMDB_Rating <= max_rating))
  
  data<-data %>%
    group_by(Released_Year) %>%
    summarise(Mean=mean(Gross,na.rm=T))
  
  data<-data%>%
    filter(!(is.na(Released_Year)))
  
  message <- "Please note there needs to be at least 2 data points for the graph
  to work. Each data point is an average gross for a year.\n Here are the number
  of data points:"
  
  return(paste(message,as.character(nrow(data))))
}

avg_bar<-function(genre="All genres",response="IMDb_Rating") {
  data<-movies
  if (genre!="All genres") {
    data<-data%>%
      filter(Genre1==genre | Genre2==genre | Genre3==genre)
  }
  
  if (nrow(data)==0) {
    return("There is no data with the provided filters. Please try again.")
  }
  
  if (response=="IMDb_Rating") {
    data<-data%>%
      filter(!(is.na(Released_Decade)))
    
    data %>%
      group_by(Released_Decade) %>%
      summarise(Mean=mean(IMDB_Rating,na.rm=T))%>%
      ggplot(mapping=aes(x=Released_Decade,y=Mean))+
      geom_col(fill="red",color="blue")+
      coord_flip()+
      ggtitle("Released decade and average IMDb rating")+
      labs(x="Released decade",y="Average IMDb rating")+
      geom_text(aes(label=round(Mean,2)),hjust=-0.1,size=3.0)
  }
  else if (response=="Meta_score") {
    data<-data%>%
      filter(!(is.na(Released_Decade)))
    
    data %>%
      group_by(Released_Decade) %>%
      summarise(Mean=mean(Meta_score,na.rm=T))%>%
      ggplot(mapping=aes(x=Released_Decade,y=Mean))+
      geom_col(fill="red",color="blue")+
      coord_flip()+
      ggtitle("Released decade and average meta score")+
      labs(x="Released decade",y="Average meta score")+
      geom_text(aes(label=round(Mean,2)),hjust=-0.1,size=3.0)
  }
}
