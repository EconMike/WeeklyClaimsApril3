#load packages

library(tidyverse)
library(readxl)
library(ggplot2)
library(lubridate)
library(cowplot)
library(ggpmisc)
library(ggthemes)


## Two plots
#set directory
setwd("C:/YOUR DIRECTORY/Weekly Claims")

#load data file
#UI claims seasonal adjusted
dfo<-read_excel("DOL_data.xlsx", sheet = "UISA")

#convert DATE variable to Date format
dfo$DATE<-as.Date(dfo$DATE)
str(dfo)
tail(dfo)

a<-ggplot(dfo, aes(x=DATE, y=Claims)) + 
  geom_bar(stat = "identity",fill = "Black")+
  scale_y_continuous(labels = scales::label_number_si())+
  scale_x_date(breaks = as.Date(c("2020-03-07", "2021-04-10")),date_breaks = "12 weeks", date_labels = "%b%Y")+
  theme_economist()+
  labs(title = "Initial claims for unemployment insurance", subtitle="Weekly since March 7,2020, seasonally adjusted",
       caption = "Source:Department of Labor")+
  xlab("") +ylab("")+theme(plot.title=element_text(size = 12),
                           plot.caption = element_text(hjust = 0, size = 12),
                           plot.subtitle = element_text(size=10,hjust = 0),
                           axis.text.x = element_text(size = 10)
  )+
  annotate(geom = "text", x = as.Date("2021-03-06") , y = 100, label = "Week Ending\n April 10: 576K",hjust = "Right", vjust=-2)+
  annotate("segment", x = as.Date("2021-04-10"), xend = as.Date("2021-04-10"), y = 1800000, yend = 900000)


#continued claims

df<-read_excel("DOL_data.xlsx", sheet = "ContClaims")

str(df)
head(df)   
#convert DATE variable to data
df$DATE<-as.Date(df$DATE)

b<-ggplot(df, aes(x=DATE, y=CC)) + 
  geom_bar(stat = "identity",fill = "Black")+
  scale_y_continuous(labels = scales::label_number_si())+
  scale_x_date(breaks = as.Date(c("2020-03-07", "2021-04-03")),date_breaks = "12 weeks", date_labels = "%b%Y")+
  theme_economist()+
  labs(title = "Continuing Claims for Unemployment Insurance",subtitle="Weekly since March 7,2020, seasonally adjusted")+ 
  xlab("") +ylab("")+theme(plot.title=element_text(size = 12), plot.subtitle = element_text(size=10,hjust = 0),
                           axis.text.x = element_text(size = 10))+
  annotate(geom = "text", x = as.Date("2021-03-03") , y = 100, label = "Week Ending\n April 3: 3.7M",hjust = "Right", vjust=-2)+
  annotate("segment", x = as.Date("2021-04-03"), xend = as.Date("2021-04-03"), y = 7000000, yend = 5000000)



plot_grid(a, b)

ggsave("T2woClaimsApril15.png")
