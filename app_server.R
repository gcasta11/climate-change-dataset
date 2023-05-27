library(dplyr)
climate_df <- read.csv("~/Downloads/info_201_code/a4-climate-change-gcasta11/owid-co2-data.csv")
View(climate_df)

avg_co2_coal_per_capita <- climate_df %>% 
  group_by(country) %>% 
  summarize(avg_coal_co2 = mean(coal_co2_per_capita, na.rm = TRUE))

  
max_co2_coal_per_capita <- climate_df %>% 
  group_by(country) %>% 
  summarize(max_coal_co2 = max(coal_co2_per_capita, na.rm = TRUE)) %>% 
  pull(country)

min_co2_coal_per_capita <- climate_df %>%
  filter(!is.na(coal_co2_per_capita)) %>%
  summarize(min_coal_co2 = min(coal_co2_per_capita)) %>%
  filter(coal_co2_per_capita == min_coal_co2) %>%
  pull(country)


max_co2_coal_per_capita <- climate_df %>%
  filter(!is.na(coal_co2_per_capita)) %>%
  filter(coal_co2_per_capita == max(coal_co2_per_capita)) %>%
  select(country, population)


changes_coal_co2_overtime <- climate_df %>%
  group_by(year) %>%
  arrange(year) %>%
  mutate(coal_co2_change = coal_co2_per_capita - lag(coal_co2_per_capita))

 