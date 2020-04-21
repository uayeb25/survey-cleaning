#install.packages("dplyr")

library(dplyr)

setwd("/")
setwd("Users/ucaballero/Desktop/repositories/Survey analysis/")


survey <- read.csv("survey_cleaned.csv", sep = ",", header = T)

df_perc <- as.data.frame(prop.table(table(survey$jornada)))
df_perc <- df_perc %>% arrange(-Freq)

df_perc

boxplot(df_perc$Freq)
hist(df_perc$Freq)
qqnorm(df_perc$Freq)


df_perc[df_perc$Var1 %in% c("Mañana, Tarde, Noche","Mañana, Noche") , "categoria"] <- "Jornada Completa"
df_perc[df_perc$Var1 %in% c("Tarde","Noche") , "categoria"] <- "Unica Jornada"
df_perc[df_perc$Var1 %in% c("Tarde, Noche") , "categoria"] <- "Doble Jornada"

df_perc <- df_perc %>% select(Var1,categoria)

survey <- left_join(survey,df_perc,by=c("jornada"="Var1"))

survey <- survey[,!(names(survey) %in% c("jornada"))]

names(survey)[length(names(survey))] <- "jornada"
prop.table(table(survey$jornada))


##### Ejemplos de como funcionan los boxplots

survey$jornada <- as.character(survey$jornada)
survey[4,"jornada"] <- "Mañana"
df_perc <- rbind(df_perc, data.frame(Var1=c("YY"),Freq=.99))
boxplot(df_perc$Freq)