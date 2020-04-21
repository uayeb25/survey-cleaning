setwd("/")
setwd("Users/ucaballero/Desktop/repositories/Survey analysis/")


survey <- read.csv("survey.csv",header = T,sep = ",", encoding = "UTF-8")
column_names <- read.csv("column_names_tratados.csv",header = T,sep = ";")
!(names(survey) %in% c("Numero.de.cuenta"))
survey <- survey[,!(names(survey) %in% c("Numero.de.cuenta"))]

str(survey)
summary(survey)

survey
head(survey,2)
tail(survey,2)

column_names <- column_names[ !(column_names$translation == "") , !(names(column_names) %in% c("X")) ]
column_names$translation <- as.character(column_names$translation)
names(survey) <- column_names$translation

head(survey)


write.csv(survey,"survey_cleaned.csv",row.names = F)


#### DATAFRAMES 

names(mtcars) ##obtener los nombres de mis columnas
str(mtcars) ## regresa todas las columnas y sus tipos de datos. preview de los datos que hay en cada columna.
summary(mtcars) ## retorna un primer resumen estadistico dependiendo del tipo de dato.

mtcars$cyl <- as.factor(mtcars$cyl) ### convierte una columna a un factor.
summary(mtcars)





