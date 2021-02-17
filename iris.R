library(dplyr)
library(caret)
#library(RSNNS)
#library(frbs)
#library(FSinR)
#library(forecast)
#library(tidyverse)

print("Prueba de tidyverse con dplyr: \n")
print(iris %>% group_by(Species) %>% select(Petal.Length) %>% summarise(mean(Petal.Length, na.rm = T)))

n <- .8*nrow(iris)
iris_train <- iris[1:n,]
iris_test <- iris[(n+1):nrow(iris),]

model <- train(x = iris_train[,-5], y = iris_train[,5],
               method = "qda",
               preProcess = c("center", "scale"),
               tuneLength = 10,
               trControl = trainControl(method = "cv"))

res <- predict(model,newdata = iris_test)

print(paste0("Accuracy : ", mean(res == iris_test$Species)))