# api.R
library(plumber)
library(dplyr)

# Cargar datos y entrenar modelo
titanic <- read.csv("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")
titanic$Age[is.na(titanic$Age)] <- median(titanic$Age, na.rm = TRUE)
titanic <- titanic %>% distinct()

# Convertir a factores
titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Sex <- as.factor(titanic$Sex)

modelo_log <- glm(Survived ~ Age + Fare + Pclass + Sex,
                  data = titanic,
                  family = binomial)

#* @post /predict
function(age, fare, pclass, sex){
  new_data <- data.frame(
    Age = as.numeric(age),
    Fare = as.numeric(fare),
    Pclass = factor(pclass, levels = levels(titanic$Pclass)),
    Sex = factor(sex, levels = levels(titanic$Sex))
  )
  prob <- predict(modelo_log, new_data, type="response")
  list(
    probability = prob,
    survived = ifelse(prob > 0.5, 1, 0)
  )
}

