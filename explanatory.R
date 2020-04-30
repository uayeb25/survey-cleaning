library(dplyr)
library(caret)
library(ggplot2)

setwd("/")
setwd("Users/ucaballero/Desktop/repositories/SEMINARIO/Survey analysis/")

survey <- read.csv("survey_cleanned_v2.csv",sep = ",", header = T)


survey$mal_rendimiento <- "0"
survey[ survey$nota <= 4 ,"mal_rendimiento"] <- "1"

prop.table(table(survey$mal_rendimiento))

features <- c(
  "internet_permanente",
  "foraneo",
  "indice",
  "clases_matriculadas",
  "uv",
  "jornada",
  "perfil",
  "expositor",
  "mal_rendimiento"
)

set <- survey[, names(survey) %in% features ]

set$mal_rendimiento <- as.factor(set$mal_rendimiento)


model <- glm(mal_rendimiento ~ ., data = set, family = "binomial")

importances <- varImp(model)
importances$col <- row.names(importances)
importances <- importances %>% arrange(-Overall)
importances


ggplot(set) +
  aes(x = uv, fill = factor(mal_rendimiento)) +
  geom_bar(position = "stack") +
  theme(axis.text.x = element_text(angle = 45)) +
  scale_fill_manual(values=c("#999999","#E69F00"))



