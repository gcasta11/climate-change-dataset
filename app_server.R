library(dplyr)
climate_df <- read.csv("Downloads/info_201_code/a4-climate-change-gcasta11/owid-co2-data.csv")
View(climate_df)

avg_co2_coal_per_capita <- climate_df %>% 
  group_by(country) %>% 
  summarize(avg_coal_co2 = mean(coal_co2_per_capita, na.rm = TRUE))

  
max_co2_coal_per_capita <- climate_df %>% 
  filter(!is.na(coal_co2_per_capita)) %>% 
  group_by(country) %>% 
  summarize(max_coal_co2 = max(coal_co2_per_capita, na.rm = TRUE)) %>% 
  pull(country)

min_co2_coal_per_capita <- climate_df %>% 
  filter(!is.na(coal_co2_per_capita)) %>% 
  group_by(country) %>% 
  summarize(min_coal_co2 = min(coal_co2_per_capita, na.rm = TRUE)) %>% 
  filter(min_coal_co2 == min(min_coal_co2)) %>% 
  pull(country)


max_co2_coal_per_capita <- climate_df %>%
  filter(!is.na(coal_co2_per_capita)) %>%
  filter(coal_co2_per_capita == max(coal_co2_per_capita)) %>%
  select(country, population)


changes_coal_co2_overtime <- climate_df %>%
  group_by(year) %>%
  arrange(year) %>%
  mutate(coal_co2_change = coal_co2_per_capita - lag(coal_co2_per_capita))

country_coal_co2_overtime <- climate_df %>%
  group_by(year) %>%
  arrange(year) %>%
  mutate(coal_co2_change = coal_co2_per_capita - lag(coal_co2_per_capita)) %>%
  filter(!is.na(coal_co2_change)) %>%
  select(country, coal_co2_change)

country <- country_coal_co2_overtime %>% pull(country)
coal_co2_change <- country_coal_co2_overtime %>% pull(coal_co2_change)

ggplot(co2_data, aes(x = country, y = co2_emissions)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(x = "Country", y = "CO2 Emissions", title = "CO2 Emissions by Country") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip() +
  transition_states(country, transition_length = 1, state_length = 0.5) +
  ease_aes('linear')
 