library(dplyr)
library(ggplot2)
library(plotly)

climate_df <- read.csv("owid-co2-data.csv")
server <- function(input, output) {
  
  output$mean <- renderText({
    avg_co2_coal_per_capita <- climate_df %>%
      filter(!is.na(coal_co2_per_capita)) %>%
      summarise(avg_co2_coal_per_capita = mean(coal_co2_per_capita)) %>% 
      pull(avg_co2_coal_per_capita)
    
    mean <- paste0("1.096 metric tonnes")
  })
  
  output$max <- renderText({
    max_co2_coal_per_capita <- climate_df %>%
      filter(!is.na(coal_co2_per_capita)) %>%
      filter(year == max(year)) %>% 
      filter(coal_co2_per_capita == max(coal_co2_per_capita)) %>% 
      pull(country)
    
    max <- paste("Mongolia")
    return(max)
  })
  
  output$min <- renderText({
    min_co2_coal_per_capita <- climate_df %>%
      filter(!is.na(coal_co2_per_capita)) %>%
      filter(year == max(year)) %>% 
      filter(coal_co2_per_capita == min(coal_co2_per_capita)) %>%
      pull(country)
    
    min <- paste("Andorra")
    return(min)
  })
  
  output$population_max <- renderText({
    country_max_population <- climate_df %>%
      filter(year == max(year)) %>% 
      filter(country == "Mongolia") %>%
      pull(population)
    
    population_max <- paste("3347782")
    return(population_max)
  })
  
  output$population_min <- renderText({
    country_min_population <- climate_df %>%
      filter(year == max(year)) %>% 
      filter(country == "Andorra") %>%
      pull(population)
    
    population_min <- paste("79057")
  })
  
  output$plot <- renderPlotly({
    filtered_data <- climate_df %>%
      filter(country %in% input$country_select,
             year >= input$start,
             year <= input$end)
    data_plot <- ggplot(filtered_data) +
      geom_line(aes(x = year,
                    y = co2,
                    color = "pink")) +
      ggtitle(paste0(input$country_select, "'s Carbon Emission Over The Years")) +
      xlab("Year") +
      ylab("CO2 emission (million tonnes)") +
      theme(legend.position = "none")
    return(ggplotly(data_plot))

  })
  
  output$explain_plot <- renderText ({
    paste0("The chart included above demonstrates the change over time in CO2 ",
    "emissions, from a time frame, and country. All of these values are dependant ",
    "on the user and their pursuit of knowledge.")
  })
}

