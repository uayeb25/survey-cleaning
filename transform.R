#install.packages("dplyr")

library(dplyr)

setwd("/")
setwd("Users/ucaballero/Desktop/repositories/SEMINARIO/Survey analysis/")


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

################ NA treatment


summary(survey)
na.summay <- c()

for( myname in names(survey)){
  print(myname)
  
  s <- as.data.frame(prop.table(table(is.na(survey[,myname]))))
  operacion <- s %>% filter(Var1 == TRUE) %>% select(Freq)
  
  df_temp <- data.frame( 
    column.name=c(myname),  
    na.percentage = ifelse( length(operacion$Freq) == 0, 0, operacion$Freq[1] )
  )
  
  na.summay <- rbind(na.summay,df_temp)

  
}

na.summay %>% arrange(-na.percentage) %>% filter(na.percentage > 0)

# survey$anios_beca remplazar por ceros, por que son estudiantes sin scholarship
survey[is.na(survey$anios_beca),"anios_beca"] <- 0

# numero_periodos_matriculado

x <- survey %>% filter(!is.na(numero_periodos_matriculado))
media <- median(x$numero_periodos_matriculado)

survey %>% filter(is.na(numero_periodos_matriculado))
survey <- survey %>% filter( !(Timestamp == "3/28/2020 15:47:06") )

table(is.na(survey$numero_periodos_matriculado))
survey[ is.na(survey$numero_periodos_matriculado) , "numero_periodos_matriculado" ] <- media
table(is.na(survey$numero_periodos_matriculado))


table(survey$otras_opciones_estudio)


####### Limpiar columnas que solo tengan un valor de nivel y las binarias que obtienes 3 niveles

level_one <- c()
si_no <- c()
for (myname in names(survey)) {
  
  unique_values <- unique(survey[,myname])
  
  if( length(unique_values) == 1 ){
    level_one <- c(level_one,myname)
  }else{
    
    validations <- sum(unique(survey[,myname]) %in% c("No","Sí",""))
    if( validations == 3 ){
      si_no <- c(si_no,myname)
    }
    
  }
  
  
}

#### Eliminando las variables con un unico nivel
survey <- survey[, !(names(survey) %in% level_one) ]

### Imputar con No, las variables YESNO con valores vacios

for (col in si_no) {
  survey[ survey[,col] == "" ,col] <- "No"
}


##muy poca informacion 
survey <- survey[, !(names(survey) %in% c("reprobado_mas_de_dos","beca")) ]


write.csv(survey,"survey_cleanned_v2.csv",row.names = F)



##### Ejemplos de como funcionan los boxplots

#survey$jornada <- as.character(survey$jornada)
#survey[4,"jornada"] <- "Mañana"
#df_perc <- rbind(df_perc, data.frame(Var1=c("YY"),Freq=.99))
#boxplot(df_perc$Freq)