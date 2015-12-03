### using R to do data analysis and modelling.


####now for the purpose of this project, we would exclude most of the betting variables, as they are not important right now.


```

liga <- laligadf[,c("Div","Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR","HTHG","HTAG","HTR","HS","AS","HST","AST",
                   "HC","AC","HF","AF","HY","AY","HR","AR","B365A","B365H","B365D")]


#the variables removed above manually were depending on their importance in any theoritical w.r.t. to this project. 
#we will further clean the data and add or remove depending on how influencing each variable is, and their importance 
#etc.
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
library(lubridate)
library(RJSONIO)
library(plyr)
library(data.table)
require(corrplot, quietly=TRUE)
require(fBasics, quietly=TRUE)
library(ROCR)
require(ggplot2, quietly=TRUE)
```


we will change the date variable from char to date format.



```{r}
str(liga)
summary(liga)
liga$Date <- ymd(liga$Date) #POSIXct format object, which works with both factors or characters

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
```


