library(dplyr)
library(ggplot2)

setwd("/")
setwd("Users/ucaballero/Desktop/repositories/SEMINARIO/Survey analysis/")


survey <- read.csv("survey_cleanned_v2.csv",sep = ",", header = T)



prop.table(table(survey$indice,survey$trabaja),1)


ggplot(survey) +
  aes(x = indice, fill = factor(trabaja)) +
  geom_bar(position = "stack") +
  theme(axis.text.x = element_text(angle = 45))

ggplot(survey) +
  aes(x = indice, fill = factor(trabaja)) +
  geom_bar(position = "fill") +
  theme(axis.text.x = element_text(angle = 45))



chisq.test(table(survey$indice,survey$trabaja))


# H_0: Las categorias de indice y trabaja son independientes.
# H_A: Las categorias son dependientes.

# Regla: Aceptamos nuestras hipotesis nula cuando el p-value de nuestra prueba chis.test es menos a 0.05

# Conclusion: Según nuestro p-value rechazamos nuestra hipotesis nula, por la tanta las variables son dependientes.


##################### Variables categorica con numerica #####################


copy_survey <- survey

survey <- copy_survey

summary(survey)

prop.table(table(survey$estudia_grupo))
           
str(survey$estudia_grupo)
summary(survey$horas_dedicadas_clase)

##Esto es meramente descriptivo
qqnorm(survey$horas_dedicadas_clase)
qqline(survey$horas_dedicadas_clase)

#Comprobamos normalidad
shapiro.test(survey$horas_dedicadas_clase)


boxplot(survey$horas_dedicadas_clase)
survey[ survey$horas_dedicadas_clase > 17 , "horas_dedicadas_clase"] <- median(survey$horas_dedicadas_clase)

boxplot(survey$horas_dedicadas_clase)
qqnorm(survey$horas_dedicadas_clase)
qqline(survey$horas_dedicadas_clase)


shapiro.test(survey$horas_dedicadas_clase)
#H0: Nuestra distribución es normal
#H1: Nuestra distribución NO es normal

#Conclusion: Como el p-value es mayor a 0.05 no podemos rechazar la hipotesis nula de que nuestros datos son normales


Si_grupo <- survey %>% filter(estudia_grupo == "Sí") %>% select(horas_dedicadas_clase)
no_grupo <- survey %>% filter(estudia_grupo == "No") %>% select(horas_dedicadas_clase)


#SI GRUPO
boxplot(Si_grupo$horas_dedicadas_clase)
qqnorm(Si_grupo$horas_dedicadas_clase)
qqline(Si_grupo$horas_dedicadas_clase)
shapiro.test(Si_grupo$horas_dedicadas_clase)
#H0: Nuestra distribución es normal
#H1: Nuestra distribución NO es normal

#Conclusion: Como el p-value es mayor a 0.05 no podemos rechazar la hipotesis nula de que nuestros datos son normales

#NO GRUPO
boxplot(no_grupo$horas_dedicadas_clase)
qqnorm(no_grupo$horas_dedicadas_clase)
qqline(no_grupo$horas_dedicadas_clase)
shapiro.test(no_grupo$horas_dedicadas_clase)
#H0: Nuestra distribución es normal
#H1: Nuestra distribución NO es normal

#Conclusion: Como el p-value es mayor a 0.05 no podemos rechazar la hipotesis nula de que nuestros datos son normales


#Prueba de homocedasticidad


var.test(no_grupo$horas_dedicadas_clase,Si_grupo$horas_dedicadas_clase)

#Interpretación: 
  #Con un p-value = 0.1177, mayor de 0.05, no podemos rechazar la hipótesis nula. Por lo tanto suponemos homogeneidad de varianzas.



t.test( no_grupo$horas_dedicadas_clase,Si_grupo$horas_dedicadas_clase, # dos muestras 
        alternative = "two.sided", # contraste bilateral 
        paired = FALSE, # muestras independientes
        var.equal = TRUE ) # se supone homocedasticidad


#Interpretación: 
#Con un p-value = 0.9637, mayor de 0.05, no podemos rechazar la hipótesis nula. Por lo tanto suponemos que las medias de los grupos son iguales.









