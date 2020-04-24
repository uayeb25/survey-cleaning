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

summary(survey)


