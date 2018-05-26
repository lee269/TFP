library(here)
library(tidyverse)

tfp <- read_csv(here("data", "tfp.csv"))

ggplot(data=tfp, aes(x=Year, y=Productivity, colour = Sector)) +
  geom_line(aes(group = Sector)) + 
  geom_point(aes(group = Sector)) +
  facet_wrap( ~ Sector) +
  labs(x = "Year", y = "Index (2000 = 100)") + theme_gov()
  scale_x_discrete(breaks = seq(2000, 2016, 2)) + theme_gov()