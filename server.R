server <- function(input, output) {
  
  # Filter dataset based on selected year
  filtered_df <- reactive({
    iris_df %>% filter(Year == input$year)
  })
  
  # Calculate mean of selected variable
  mean_value <- reactive({
    mean(filtered_df()[[input$variable]])
  })
  
  # Calculate median of selected variable
  median_value <- reactive({
    median(filtered_df()[[input$variable]])
  })
  
  output$scatterplot <- renderPlotly({
    plot_ly(filtered_df(), x = ~Sepal.Length, y = ~get(input$variable), color = ~Species,
            colors = c("red", "blue", "green")[input$color], type = "scatter", mode = "markers") %>%
      layout(title = "Iris Dataset", xaxis = list(title = "Sepal Length"), yaxis = list(title = input$variable))
  })
  
  output$description <- renderPrint({
    description <- "I included this chart to explore the relationship between Sepal Length and a selected variable in the Iris dataset. By choosing a variable from the dropdown menu, you can observe how it varies with respect to Sepal Length. The color slider allows you to highlight different species in the dataset. Additionally, the year slider enables you to focus on data from a specific year."
    cat(description)
  })
  
  output$mean <- renderPrint({
    paste("Mean of", input$variable, ":", mean_value())
  })
  
  output$median <- renderPrint({
    paste("Median of", input$variable, ":", median_value())
  })
  
  output$scatterplot <- renderPlotly({
    # Filter dataset based on selected year
    filtered_df <- iris %>% filter(Species == input$variable)
    
    # Create scatter plot based on selected variable and color
    plot_ly(filtered_df, x = ~Sepal.Length, y = ~get(input$variable), color = ~Species,
            colors = c("red", "blue", "green")[input$color], type = "scatter", mode = "markers") %>%
      layout(title = "Iris Dataset", xaxis = list(title = "Sepal Length"), yaxis = list(title = input$variable))
  })
  
  output$description <- renderPrint({
    description <- "I included this chart to explore the relationship between Sepal Length and a selected variable in the Iris dataset. By choosing a variable from the dropdown menu, you can observe how it varies with respect to Sepal Length. The color slider allows you to highlight different species in the dataset. Additionally, the year slider enables you to focus on data from a specific year."
    cat(description)
  })
}

