library(tidyverse) #loading the tidyverse package

# Read in data (make sure read_csv not read.csv!)

gapminder_data <- read_csv("gapminder_data.csv")
gapminder_data

# Summarize ------------------------------------------------
# to add a header in RStudio, use Cmd/Ctrl+Shift+R or
# go to Code > Insert Section Header

# What is the mean life expectancy

summarize(gapminder_data, mean(lifeExp))

#Ctrl/CMD-shift-m for pipe
#writing to console
gapminder_data_summarized <- gapminder_data %>%
  summarize(averageLifeExp = mean(lifeExp))
gapminder_data_summarized

# save to object
gapminder_data %>%
  summarize(averageLifeExp = mean(lifeExp))


# What is the mean life expectancy for the most recent year

# What is the max year?

gapminder_data %>% 
  summarize(recent_year = max(year))

# get max year in filter()

gapminder_data %>% 
  filter(year == 2007) %>% 
  summarize(average = mean(lifeExp))

# the hard way to filter without pipe
summarize(filter(gapminder_data, year == 2007),
          average = mean(lifeExp))

# What is the earlist year in the dataset?
# summarize average GDP for the earliest year in the dataset
gapminder_data %>% 
  filter(year == min(year)) %>% 
  summarize(average = mean(gdpPercap))

# Grouping------------------------------------------------------
# What is the mean life expectancy for each year

grouped_data <- gapminder_data %>% 
  group_by(year) %>% 
  summarize(average = mean(lifeExp))

# What is the mean life expectancy for each continent
gapminder_data %>% 
  group_by(year, continent) %>% 
  summarize(average = mean(lifeExp))

# What is the mean life expectancy AND mean GDP per capita for each continent

gapminder_data %>% 
  group_by(continent) %>% 
  summarize(
    meanlifeExp = mean(lifeExp),
    maxlifeExp = max(lifeExp),
    meangdpPercap = mean(gdpPercap)
  )

# Mutate --------------------------------------------------------------------

gapminder_data %>% 
  mutate(double_year = year * 2, .before = pop)

# What is the GDP (not per capita)?

# by multiplying pop x gdpPercap

gapminder_data %>% 
  mutate(gdp = pop * gdpPercap)

# Make a new column for population in millions
gapminder_data %>% 
  mutate(popInMillions = pop/1000000, .before =continent) %>% 
  glimpse()

mysummary <- gapminder_data %>% 
  group_by(country) %>% 
  filter(continent == "Asia") %>% 
  mutate(gdp = pop * gdpPercap) %>% 
  summarize(meanGDP = mean(gdp))

view(mysummary)

mysummary <- mysummary %>% 
  mutate(meanGDPInMillions = meanGDP / 1000000)

# Select ----------------------------------------------------------------------

# select()" choose a subset of columns from a dataset

gapminder_data %>% 
  select(pop, year)
  
gapminder_data %>% 
  select(-continent)

# Create a tibble with only country, continent 
# year, lifeExp

gapminder_data %>% 
  select(country, continent, year, lifeExp)

#select helper function: starts_with()

gapminder_data %>% 
  select(year, starts_with("c"))

# select columns with names ending in "p"
# using ends_with()

gapminder_data %>% 
  select(year, ends_with("p"))

# Reshaping -------------------------------------------------------------------

#pivot_wider()

gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, 
              values_from = lifeExp,
              names_prefix = "yr")

# Joins -----------------------------------------------------------------------

co2_data <- read_csv("co2-un-data.csv", skip =1 ) %>% 
  rename(country = '...2', year = Year)
view(co2_data)

joined <- left_join(gapminder_data, co2_data,
                    by = c("country", "year"))

view(joined)

left_join(gapminder_data, co2_data, by = "country")

