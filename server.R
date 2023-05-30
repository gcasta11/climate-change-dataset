library(dplyr)
library(ggplot2)
library(plotly)
library(blsib)
install.packages("shinythemes")
library(shinythemes)

climate_df <- read.csv("Downloads/info_201_code/a4-climate-change-gcasta11/owid-co2-data.csv")
server <- function(input, output) {
  
  output$avg_coal_co2 <- renderPrint({
    avg_co2_coal_per_capita <- climate_df %>%
      group_by(country) %>%
      summarize(avg_coal_co2 = mean(coal_co2_per_capita, na.rm = TRUE))
    
    avg_co2_coal_per_capita
  })
  
  output$max_coal_co2 <- renderPrint({
    max_co2_coal_per_capita <- climate_df %>%
      filter(!is.na(coal_co2_per_capita)) %>%
      group_by(country) %>%
      summarize(max_coal_co2 = max(coal_co2_per_capita, na.rm = TRUE)) %>%
      pull(country)
    
    max_co2_coal_per_capita
  })
  
  output$min_coal_co2 <- renderPrint({
    min_co2_coal_per_capita <- climate_df %>%
      filter(!is.na(coal_co2_per_capita)) %>%
      group_by(country) %>%
      summarize(min_coal_co2 = min(coal_co2_per_capita, na.rm = TRUE)) %>%
      filter(min_coal_co2 == min(min_coal_co2)) %>%
      pull(country)
    
    min_co2_coal_per_capita
  })
  
  output$country_coal_co2_overtime <- renderPrint({
    changes_coal_co2_overtime <- climate_df %>%
      group_by(year) %>%
      arrange(year) %>%
      mutate(coal_co2_change = coal_co2_per_capita - lag(coal_co2_per_capita))
    
    changes_coal_co2_overtime
  })
  
  output$coal_co2_change <- renderPrint({
    country_coal_co2_overtime <- climate_df %>%
      group_by(year) %>%
      arrange(year) %>%
      mutate(coal_co2_change = coal_co2_per_capita - lag(coal_co2_per_capita)) %>%
      filter(!is.na(coal_co2_change)) %>%
      select(country, coal_co2_change)
    
    coal_co2_change <- country_coal_co2_overtime %>% pull(coal_co2_change)
    coal_co2_change
  })
  
  output$graph <- renderPlotly({
    x_axis_col <- input$x_axis_column
    
    plot <- ggplot(climate_df, aes(x = .data[[x_axis_col]], y = co2_emissions)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(x = "Country", y = "CO2 Emissions", title = "CO2 Emissions by Country") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      coord_flip() +
      transition_states(country, transition_length = 1, state_length = 0.5) +
      ease_aes('linear')
    
    ggplotly(plot)
  })

}



