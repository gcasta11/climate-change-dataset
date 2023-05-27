library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)

my_theme <- bs_theme(
  bootswatch_theme = "cerulean",
  navbar_color = "#337ab7",
  navbar_link_color = "white",
  navbar_brand_color = "pink"
)

# Define UI
ui <- navbarPage(
  theme = my_theme,
  "A4 Climate Change",
  tabPanel("Exploring the Data",
           h1("Introduction to Climate Change"),
           p("Global warming has continued to be a great inhibitor for the safety ",
             "and well being of the entire planet. However, living in a capitalistic ",
             "society has proven to denote the quality of life that many global citizens ",
             "are continuing to notice. Heat waves are now stronger than ever, ice caps are ",
             "melting to expose new archaic diseases, and in spite of the danger that so many ",
             "humans find themselves in, the largest capitalistic societies continue to ",
             "govern how much pollution and greenhouse gases are emitted into the atmosphere. ",
             "Climate specialists continue to warn policy makers over the imminent dangers, ",
             "even so, there is a large sector of the world that continue to believe ",
             "that there is insufficient evidence to conclude that global warming is a ",
             "valid and current concern."),
           h2("The Dataset"),
           p("The dataset, Data on CO2 and Greenhouse Gas Emissions, by Our World Data, ",
             "was created in hopes of comparing how emissions are changing, per country, ",
             "in order to explore how much progress each country is making towards reducing ",
             "emissions. Every country in this dataset includes features that describe the CO2 ",
             "emissions of each country per year, emissions by sector, carbon and energy ",
             "efficiency, and the type of CO2 emission from the production of coal, oil, ",
             "gas, and cement. This feature is inclusive of average emissions ",
             "per person, over time, and in global trade transactions. Emissions by sector ",
             "include what sectors of export contribute to the most emissions, like ",
             "transportation, electricity, agricultural, and land usage. Carbon and energy ",
             "efficiency have to do with the energy per unit of gross domestic product, ",
             "or GDP."),
           p("Our World Data is an organization of thousands of researchers who pride ",
             "themselves in conducting research on topics that have the possibility of ",
             "making progress against important problems, in order to bring awareness ",
             "and education for everyone. This specific dataset was collected by the use of ",
             "different organizations such as Berkley Earth, IPCC, Climate Action Tracker ",
             "and many other resources, all cited on ourworldindata.org."),
           h2("Summary Statistics"),
           p("The average "),
           verbatimTextOutput("mean"),
           verbatimTextOutput("median")
  ),
  tabPanel("Visualization",
           sidebarLayout(
             sidebarPanel(
               selectInput("variable", "Select a variable:", choices = c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width")),
               sliderInput("color", "Select a color:", min = 1, max = 3, value = 1),
               sliderInput("year", "Select a year:", min = 1950, max = 2022, value = 2000)
             ),
             
             mainPanel(
               plotlyOutput("scatterplot"),
               br(),
               verbatimTextOutput("description")
             )
           )
  )
)

