setwd("/")
setwd("Users/ucaballero/Desktop/repositories/SEMINARIO/Survey analysis/")

library(dplyr)

survey <- read.csv("survey.csv",header = T,sep = ",", encoding = "UTF-8")
notas <- read.csv("notas.csv", dec = ".", sep = ";")

survey <- inner_join(survey,notas, by=c("Numero.de.cuenta"="cuenta"))

my.names <- names(survey)
columnas_a_tratar <- my.names[!(my.names %in% c("Numero.de.cuenta"))]

df <- data.frame( columna.name = columnas_a_tratar)


write.csv(df,"column_names.csv",row.names = FALSE)


