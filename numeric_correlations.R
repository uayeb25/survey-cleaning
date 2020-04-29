library(dplyr)
library(ggplot2)
library(corrplot)
library(factoextra)

setwd("/")
setwd("Users/ucaballero/Desktop/repositories/SEMINARIO/Survey analysis/")

survey <- read.csv("survey_cleanned_v2.csv",sep = ",", header = T)



numeric_corr <- survey %>% select(disenio,progra,bd,analisis,servidores)


str(numeric_corr)


boxplot(numeric_corr$disenio)
boxplot(numeric_corr$progra)
boxplot(numeric_corr$bd)
boxplot(numeric_corr$analisis)
boxplot(numeric_corr$servidores)

numeric_corr %>% filter(disenio == 4)
numeric_corr %>% filter(bd == 4)
numeric_corr %>% filter(analisis == 4)


x <- cor(numeric_corr, method = c("pearson", "kendall", "spearman"))

x

corrplot(x, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)


res <- prcomp(numeric_corr,scale=F)


fviz_eig(res)

fviz_pca_ind(res,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

fviz_pca_var(res,
             col.var = "contrib", # Color by contributions to the PC
            
             repel = TRUE     # Avoid text overlapping
)

fviz_pca_biplot(res, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                col.ind = "#696969"  # Individuals color
)


k2 <- kmeans(res$x[,1:2], centers = 2, nstart = 25)


fviz_cluster(k2, data = res$x[,1:2])

k2$cluster


cbind(survey,k2$cluster)









