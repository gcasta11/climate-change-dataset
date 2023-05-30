library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
install.packages("shiny themes")
library(shinythemes)

climate_df <- read.csv("Downloads/info_201_code/a4-climate-change-gcasta11/owid-co2-data.csv")
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
           p("In light of recent heat waves, melting ice caps, and an uptick in crude oil ",
             "production and fracking, global warming has been a very controversial and ",
             "divisive subject, in many countries. However, as consumers of media, we ",
             "are less liekly to receive direct facts, when it comes to global wamring. ",
             "This is because many industries are on a capitalistic pursuit, meanwhile ",
             "Earth's demise is simply seen as a byproduct, for these industries. "),
           p("It is important to be aware of what greenhouse gases are, and how they ",
             "Contribute to global warming as a whole. Carbon dioxide is a type of ",
             "greenhouse gas, which absorb infrared energy, and re-emit that energy ",
             "back towards the Earth and into space. Infrared light is what is ",
             "emitted from sunlight, which we then feel as heat on Earth. ",
             "Usually the amount of infrared light absorbed by the Earth is not ",
             "harmful, however, when CO2 and other greenhouse gases interact with it ",
             "that infrared energy is re-emitted in all directions, where it is then ",
             "returns to Earth as heat, contributing to global warming. Burning coal ",
             "is the largest source of carbon dioxide emisions. When we track how ",
             "much coal is burned per country, we are able to estimate how much harm ",
             "is being done to the Earth, from a global perspective."),
           p("The following values have been derived from Data on CO2 and Greenhouse ",
             "Gas Emissions. It is important to realize which countries are burning ",
             "the most coal, therein releasing the most CO2 into the atmosphere, ",
             "so we can accurately track who is causing this massive epidemic of ",
             "heat waves,forest fires, droughts, and melting ice caps. "),

           p("The average coal emissions per capital would be "),
           verbatimTextOutput("avg_coal_co2"),
           
           p("The country with the maximum coal CO2 emissions per capita is "),
           verbatimTextOutput("max_coal_co2"),
           
           p("The country with the maximum coal CO2 emissions per capita is "),
           verbatimTextOutput("min_coal_co2"),
           
           p("Changes in coal CO2 emissions over time vary from country to country. ",
           "The country with the largest uptick in carbon dioxide emission would be "),
           verbatimTextOutput("country_coal_co2_overtime"),
           
           p("The amout of CO2 emitted from the country above is "),
           verbatimTextOutput("coal_co2_change"),
          
           h2("Conclusion"),
           p("There are many ways to calculate the change of carbon emission ",
             "overtime. However, it is important to take note of how carbon emissions ",
             "have changed and increased over time, and who is causing these changes. ",
             "Knowing where and why these changes are occurring, might be the first step ",
             "in resolving this ongoing issue of climate change.")
  ),
  tabPanel("Visualization",
           sidebarLayout(
             sidebarPanel(
               h2(""),
               selectInput(
                 inputId = "x_axis_column",
                 label = "X-Axis",
                 choices = country,
                 selected = avg_co2_coal_per_capita
             )
           ),
           mainPanel(plotlyOutput("graph"))
           )
  )
)

