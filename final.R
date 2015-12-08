---
title: "soccerproject"
author: "Neeraj"
date: "Sunday, November 22, 2015"
output: html_document
---



```{r}
#install.packages("elastic")
library('elastic')

connect(es_port = 9200)
count(index='spainsoccer')
Search(index = "spainsoccer", size=1, id= 10 )$hits$hits #to get 10 id data for type= liga_data
laliga <- Search(index = "spainsoccer", size=3920, asdf = T) #dataframe
laligadf <- laliga$hits$hits$'_source'
ncol(laligadf)
nrow(laligadf)
colnames(laligadf)

#now for the purpose of this project, we would exclude most of the betting variables, as they are not important right 
#now.

liga <- laligadf[,c("Div","Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR","HTHG","HTAG","HTR","HS","AS","HST","AST",
                   "HC","AC","HF","AF","HY","AY","HR","AR","B365A","B365H","B365D")]


#the variables removed above manually were depending on their importance in any theoritical w.r.t. to this project. 
#we will further clean the data and add or remove depending on how influencing each variable is, and their importance 
#etc



```



Variables | Description
----------| -----------
`Div` | `League Division`
`Date` | `Match Date (dd/mm/yy)`
`HomeTeam` | `Home Team`
`AwayTeam` | `Away Team`
`FTHG` | `Full Time Home Team Goals`
`FTAG` | `Full Time Away Team Goals`
`FTR` | `Full Time Result (H=Home Win, D=Draw, A=Away Win)`
`HTHG` | `Half Time Home Team Goals`
`HTAG` | `Half Time Away Team Goals`
`HTR` | `Half Time Result (H=Home Win, D=Draw, A=Away Win)`
`HS` | `Home Team Shots`
`AS` | `Away Team Shots`
`HST` | `Home Team Shots on Target`
`AST` | `Away Team Shots on Target`
`HC` | `Home Team Corners`
`AC` | `Away Team Corners`
`HF` | `Home Team Fouls Committed`
`AF` | `Away Team Fouls Committed`
`HY` | `Home Team Yellow Cards`
`AY` | `Away Team Yellow Cards`
`HR` | `Home Team Red Cards`
`AR` | `Away Team Red Cards`
`B365H` | `Bet365 home win odds`
`B365D` | `Bet365 draw odds`
`B365A` | `Bet365 away win odds`


## Load the libraries.




```{r, echo=TRUE,eval=TRUE}
library(reshape2)
library(lubridate)
library(RJSONIO)
library(plyr)
library(dplyr)
library(data.table)
require(corrplot, quietly=TRUE)
require(fBasics, quietly=TRUE)
library(ROCR)
require(ggplot2, quietly=TRUE)
library(ltm)
library(gclus)
library(odds.converter)
library(caret)
library(rpart)
library(e1071)
library(randomForest)
library(gbm)
library(nnet)
library(MASS)
require(car, quietly=TRUE)
library(gbm)
library(kernlab)
```


we will change the date variable from char to date format.



```{r}
str(liga)
summary(liga)
#liga$Date <- ymd(liga$Date) #POSIXct format object, which works with both factors or characters

#first and foremost we will see if we have any missing values.
sapply(liga, function(x) sum(is.na(x)))

```



The summary shows we do not have ANY missing values, which is a good sign.





```{r}
#correlation plot

# for this purpose we will subset the  numeric variables first.

liga_num <- liga[ , c(5,6,8,9,11:25)] 
liga.cor <- cor(liga_num, use="pairwise", method="pearson")
# Order the correlations by their strength.
ord <- order(liga.cor[1,])
liga.cor <- liga.cor[ord, ord]
corrplot(liga.cor, mar=c(0,0,1,0))
liga.cor
rcor.test(liga_num, method = "pearson")

# heat map correlation
title <- "correlation heat map" 
corp <- qplot(x=Var1, y=Var2, data=melt(cor(liga_num, use="p")), fill=value, geom="tile") +  
      scale_fill_gradient2(limits=c(-1, 1))
corp <- corp + theme(axis.title.x=element_blank(), axis.text.x=element_blank()  
                     , axis.ticks=element_blank())
corp <- corp + ggtitle(title)  
corp  


#scatter plot matrix
dta.col <- dmat.color(liga.cor) # get colors
# reorder variables so those with highest correlation
# are closest to the diagonal
cpairs(liga_num, ord, panel.colors=dta.col, gap=.5,
main="Variables Ordered and Colored by Correlation" )
```

some of the variables are slightly correlated (however it depends on the threshold we choose to subset or accept a particular variable, based on correlation value.) We would as of now, retain all the variables.


## further exploring the data

```{r}

ggplot(liga, aes(x=FTR)) + geom_histogram(binwidth=5)

# explaining Betting variables are not linearly correlated as was assumed from correlation plot above.
ggplot(liga, aes(log(B365A),log(B365D), color=FTR)) + geom_point() + geom_smooth()  
ggplot(liga, aes(log(B365A),log(B365H), color=FTR)) + geom_point() + geom_smooth()  
```


- Also the general understanding from the first plot is that `Home` advantage is significant and plays good role in most cases in determining the winner, as full time results has more home wins than aways. 



## Creating derived new metrics, by executing operations on various columns, and cleaning data (removing redundant variables).

```{r}
#We create the target variable, `winner` for each match. This will be used in our model for prediction.

#liga$winner[liga$FTR=="H"]<- 1 #when home team wins
#liga$winner[liga$FTR=="A"]<- 0 #when away team wins
#liga$winner[liga$FTR=="D"]<- 2 #when neither team wins, game ends in draw.

liga<- liga[-1] #remove first column as it is irrelavant,we already understand that teams data is from Div1.

# we will use odds.converter package to convert the available Bet 365 home, away and draw odds for each match in to respective probabilities of home team winning, away team winning, or resulting a draw according Bet 365 officials.


liga$HomeWinodd <- odds.dec2prob(liga$B365H)
liga$AwayWinodd <- odds.dec2prob(liga$B365A)
liga$Drawodd <- odds.dec2prob(liga$B365D)
#now we can use betting data in two ways- we can either keep it and include in our model to estimate winning team once we know the betting estimates from the experts or we can exclude it from the current model and utilize it at the end to make comparison with our estimates for win, draw or loss.
liga$B365H <- NULL
liga$B365A <- NULL
liga$B365D<- NULL
```




```{r}

p <- ggplot(liga, aes(HR, AR),colour = factor(FTR)) + geom_point()
# With one variable
p + facet_grid(. ~ FTR)
```


- we will further explore this part through visualization. We see that away team wins when home teams concedes more foul which turns into red cards. The insights are little unexpected as well. First we see that, in away teams win, maximum number of players red carded was 2, where home team accounted for 3 for a lossing cause. Secondy, even if away team gets 2 red cards and home team gets 0, away team wins, which could be credited to two reasons, one, that away team was stringer than home team and therefore, red cards played little or no part in the match against wekaer opponents for them, or second, the red cards plaayers were subjected to came into play very ate in the game, that is, towards the end of the game.

- For home team winning, maximum cards away teams recieved were 4, and home team 2. However it is interesting to note that when away team got 4 cards in a game, which means out of 11 players, 4 were sent off, home team got NIL, so their team was more in the field and covered more and was able to dominate. 

- However for the game that ended in draw, away team got max 3 cards, while home team 2. Hence again, it could be cause away teams after getting their players sent off, approached a defensive mind set in to play and considered draw a favorable result for them. As they are involved in more red cards during draw than home teams, and it also makes sense, as the stadium and fans are behind home team,not away team. For away team, winning in such condition with players out from game is always tough. 



#create training and test dataset

```{r}
# now final selection of the variables.

d4 <- as.Date(liga$Date, "%d/%m/%y")
d4 <- strftime(d4, "%Y-%m-%d")
liga$Date <- d4

# dividing dataset into training, validation and testing dataset.
# we will want to predict results for current season correctly, so we will choose it as test dataset. Current season starts from month of august, hence we will subset this data.

liga_test <- subset(liga, Date > "2015-08-01" )
liga_train <- subset(liga, Date < "2015-08-01" )
liga_train <- liga_train[-c(1,2,3)]
liga_test <- liga_test[-c(1,2,3)]

```


## Pre-model building.

```{r}
library(colorspace)
numeric <- liga_train[-c(3,6)]

categoric <- liga_train[ "HTR"]

target  <- liga_train["FTR"]
require(Hmisc, quietly=TRUE)

# Principal Components Analysis (on numerics only).

pc <- prcomp(na.omit(numeric), scale=TRUE, center=TRUE, tol=0)
# Show the output of the analysis.
pc
# Summarise the importance of the components found.
summary(pc)

#Summary shows first 13 principal components are able to explain about 94% of the variability in the dataset.

# Display a plot showing the relative importance of the components.

plot(pc, main="")
title(main="Principal Components Importance")
axis(1, at=seq(0.7, ncol(pc$rotation)*1.2, 1.2), labels=colnames(pc$rotation), lty=0)

# Display a plot showing the two most principal components.
biplot(pc, main="")
title(main="Principal Components")

```





## Building the model.


```{r}
options(warn=-1)
# Reset the random number seed to obtain the same results each time.


# Build the Decision Tree model.

set.seed(12)
liga_dt <- rpart(FTR ~ .,
    data=liga_train,
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))


# Generate a textual view of the Decision Tree model.
print(liga_dt)
printcp(liga_dt)

# Plot the resulting Decision Tree. 
# We use the rpart.plot package.
library(rattle)
fancyRpartPlot(liga_dt, main="Decision Tree- FTR")

# List the rules from the tree using a Rattle support function.

asRules(liga_dt)
  


# Random Forest 

# The 'randomForest' package provides the 'randomForest' function.

# Build the Random Forest model.

liga_train$HTR <- as.factor(liga_train$HTR)
liga_train$FTR <- as.factor(liga_train$FTR)

start.time <- Sys.time() 
set.seed(1234)
liga_rf <- randomForest(formula = (FTR) ~ .,data = liga_train,ntree = 500, mtry = 3, 
                        importance = TRUE,na.action=na.roughfix, replace = FALSE)


end.time <- Sys.time()
time.taken2 <- end.time - start.time


# Generate textual output of 'Random Forest' model.

liga_rf

# List the importance of the variables.

rn <- round(importance(liga_rf), 2)
rn[order(rn[,3], decreasing=TRUE),]

# Plot the relative importance of the variables.

varImpPlot(liga_rf, main="")
title(main="Variable Importance Random Forest")

# Plot the error rate against the number of trees.

plot(liga_rf, main="")
legend("topright", c("OOB", "A", "D", "H"), text.col=1:6, lty=1:3, col=1:3)
title(main="Error Rates Random Forest")

# Display tree number 1.

printRandomForests(liga_rf, 1)

# Plot the OOB ROC curve.

require(verification)
aucc <- roc.area(as.integer(as.factor(liga_train$FTR))-1,
                 liga_rf$votes[,2])$A
roc.plot(as.integer(as.factor(liga_train$FTR))-1,
         liga_rf$votes[,2], main="")
legend("bottomright", bty="n",
       sprintf("Area Under the Curve (AUC) = %1.3f", aucc))
title(main="OOB ROC Curve Random Forest")



# Build a Support Vector Machine model.

start.time <- Sys.time() 
set.seed(567890)
liga_ksvm <- ksvm(FTR ~ .,
      data=liga_train,
      kernel="rbfdot",
      prob.model=TRUE)
end.time <- Sys.time()
time.taken3 <- end.time - start.time  
# Generate a textual view of the SVM model.

liga_ksvm

# Time taken: 1.22 secs

# Generalized Boosted Regression Models (gbm) model.


liga_train$HTR <- as.factor(liga_train$HTR)
liga_train$FTR <- as.factor(liga_train$FTR)
liga_gbm <- gbm(FTR~., data = liga_train, distribution= "multinomial",n.trees=100, shrinkage= 0.05,
                interaction.depth=3, cv.folds=3, verbose=FALSE,n.cores=1)
liga_gbm
best.iter <- gbm.perf(liga_gbm,method="OOB")
print(best.iter)
best.iter <- gbm.perf(liga_gbm,method="cv")
print(best.iter)
summary(liga_gbm, n.trees=1)
summary(liga_gbm, n.trees=best.iter)
print(pretty.gbm.tree(liga_gbm,1))
print(pretty.gbm.tree(liga_gbm,liga_gbm$n.trees))

gbm_pr <- predict.gbm(liga_gbm, liga_test, best.iter, 
                                  type="response")


#naive bayes.

liga_nb <- naiveBayes(FTR ~ ., data = liga_train, laplace = 3)
liga_nb

# Regression model - GLM

# Build a multinomial model using the nnet package.

# Summarise multinomial model using Anova from the car package.



# Build a Regression model.

start.time <- Sys.time()
set.seed(678)
liga_glm <- multinom(FTR ~ ., data=liga_train, trace=FALSE, maxit=1000)
end.time <- Sys.time() 
time.taken4 <- end.time - start.time  
# Generate a textual view of the Linear model.
mostImportantVariables <- varImp(liga_glm)
mostImportantVariables$Variables <- row.names(mostImportantVariables)
mostImportantVariables <- mostImportantVariables[order(-mostImportantVariables$Overall),]
print(head(mostImportantVariables))


liga_summary <- summary(liga_glm,Wald.ratios=TRUE)
liga_summary
cat(sprintf("Log likelihood: %.3f (%d df)", logLik(liga_glm)[1], attr(logLik(liga_glm), "df")))

cat('==== ANOVA ====')
print(Anova(liga_glm))

```







## Evaluate model performance. 


```{r}
liga_test$HTR <- as.factor(liga_test$HTR)
liga_test$FTR <- as.factor(liga_test$FTR)
# Generate an Error Matrix for the Decision Tree model.

# Obtain the response from the Decision Tree model.

liga_pr <- predict(liga_dt, newdata=liga_test, type="class")

# Generate the confusion matrix showing counts.
cm <- confusionMatrix(liga_pr, liga_test$FTR)
cm
#View(data.frame(cbind(as.matrix(liga_pr))[,1], as.matrix(liga_test$FTR))) #important.
overallcm <- cm$overall
overallcm
# Generate an Error Matrix for the Random Forest model.

# Obtain the response from the Random Forest model.


ligarf_pr <- predict(liga_rf, newdata=(liga_test))

# Generate the confusion matrix showing counts.
rfcm <- confusionMatrix(ligarf_pr, liga_test$FTR)
rfcm
#View(data.frame(cbind(as.matrix(ligarf_pr))[,1], as.matrix(liga_test$FTR))) #important.
overallrfcm <- cm$overall
overallrfcm
# Generate an Error Matrix for the SVM model.

# Obtain the response from the SVM model.

liga_kvsmpr <- predict(liga_ksvm, newdata=liga_test)

# Generate the confusion matrix showing counts.
kvsmcm <- confusionMatrix(liga_kvsmpr, liga_test$FTR)
kvsmcm
#View(data.frame(cbind(as.matrix(liga_kvsmpr))[,1], as.matrix(liga_test$FTR))) #important.
overallkvsm <- cm$overall
overallkvsm
# Generate an Error Matrix for the Linear model.

# Obtain the response from the Linear model.

gpr <- predict(liga_glm, newdata=liga_test)

# Generate the confusion matrix showing counts.
gcm <- confusionMatrix(gpr, liga_test$FTR)
gcm
#View(data.frame(cbind(as.matrix(gpr))[,1], as.matrix(liga_test$FTR))) #important.
overallg <- cm$overall
overallg


# naive bayes.
nb_pr <- predict(liga_nb, newdata=liga_test)
nb_pr
nbcm <- confusionMatrix(nb_pr, liga_test$FTR)
nbcm
#View(data.frame(cbind(as.matrix(nb_pr))[,1], as.matrix(liga_test$FTR))) #important.
overallnb <- nbcm$overall
overallnb
```




#tuning- cross validation for each model.

```{r}
library(snowfall)
sfInit (parallel=TRUE , cpus=5)



start.time <- Sys.time()  
set.seed(2) 
fit1 <- train(FTR ~ ., data = liga_train, method = "rpart", tuneLength = 30, 
      trControl = trainControl(method = "repeatedcv", repeats = 3))
end.time <- Sys.time()  
time.taken1 <- end.time - start.time

fit1
p1 <- predict(fit1, newdata=liga_test, type="raw")
cm1 <- confusionMatrix(p1, liga_test$FTR)
cm1 #tuning improved the performance of the decision tree. It is similar to random forest, multinom, and svm.


plot(fit1, metric= "Kappa")
sfStop()
sfInit (parallel=TRUE , cpus=5)
fit2 <- train(FTR ~ ., data = liga_train, method = "gbm",verbose = FALSE, trControl = trainControl(## 5-fold CV
                           method = "repeatedcv",
                           number =5,
                           ## repeated ten times
                           repeats = 5))
fit2
plot(fit2, metric="Kappa")
fit3 <- train(FTR ~ ., data = liga_train, method = "rf", trControl=trainControl(method="cv",number=5),
                prox=TRUE,allowParallel=TRUE)
fit3
ggplot(fit3, metric="Kappa")
fit4 <- train( FTR ~ ., data = liga_train, method = "nb", trControl = trainControl(method = "cv", number = 10)) 
fit4
plot(fit4, metric="Kappa")
fit5 <- train(FTR ~ ., data = liga_train, method = "svmLinear", tuneLength = 30, trControl =trainControl(method = "repeatedcv", repeats = 3))
fit5
#train(FTR ~ ., data = liga_train, method = "multinom", tuneLength = 10, trControl = cvCtrl)
sfStop()
```


- We tried to tune and see if our model was under or over fit. Cross validation procedure produced similar results as were seen from original model.


## Model Selection.


- We noticed that naive Bayes produced worst result of all. While the performance of `Random forest`, `SVM`, `Decision Tree` and `Multinoom` was same, we would select the best model based on that takes least time in conducting training the model over the train dataset.
We will calculate the time and determine the selection. For `decision tree` we will use the time for tuned model, instead oof original, since the new model produced accuracy = $1$.



```{r}
time.taken1
time.taken2
time.taken3
time.taken4
```



Model | Time-Taken
------|---------
`Decision tree` | `16.44866 secs (also on parallel execution)
`Random forest` | `10.41537 secs`
`SVM` | `19.81351 secs`
`Linear model (GLM-Multinom)` | ` 6.910282 secs`


> We will therefore use ` GLM (Multinomial model)`


```{r}
#glm.

liga_test$PredictedFTR <- as.matrix(gpr)
```



