setwd("/")
setwd("Users/ucaballero/Desktop/repositories/Survey analysis/")


survey <- read.csv("survey.csv",header = T,sep = ",", encoding = "UTF-8")

my.names <- names(survey)
columnas_a_tratar <- my.names[!(my.names %in% c("Numero.de.cuenta"))]

df <- data.frame( columna.name = columnas_a_tratar)


write.csv(df,"column_names.csv",row.names = FALSE)


