library(reshape2)
library(ggplot2)

tfp <- read.csv("S:/Analysis/Rstuff/tfp.csv", header = TRUE)

cn = c("sector", "series", 2000:2014)
colnames(tfp) <- cn

# Multiples!

tfp2 <- melt(tfp, id.vars = c("sector", "series"), variable.name = "year")

ggplot(data=tfp2, aes(x=year, y=value, colour = series)) +
  geom_line(aes(group = series)) +
  geom_point(aes(group = series)) +
  facet_wrap( ~ sector) +
  labs(x = "Year", y = "Index (2000 = 100)") +
  scale_x_discrete(breaks = seq(2000, 2016, 2)) 

ggplot(data=tfp2, aes(x=year, y=value, colour = sector)) +
  geom_line(aes(group = sector)) +
  geom_point(aes(group = sector)) +
  facet_wrap( ~ series)




# sector x different series
tfp2 <- tfp[which(tfp$sector == "Manufacturing"), ]
tfp2 <- melt(tfp2, id.vars = c("sector", "series"), variable.name = "year")

ggplot(data=tfp2, aes(x=year, y=value, colour = series)) +
  geom_line(aes(group = series)) +
  geom_point(aes(group = series))


# Prod x sector

tfp2 <- tfp[which(tfp$series == "Productivity"), ]
tfp2 <- melt(tfp2, id.vars = c("sector", "series"), variable.name = "year")

ggplot(data=tfp2, aes(x=year, y=value, colour = sector)) +
  geom_line(aes(group = sector)) +
  geom_point() 


