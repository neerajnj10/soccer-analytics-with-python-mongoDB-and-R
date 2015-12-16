---
title: "Project Report"
author: "Neeraj"
output: 
  html_document: 
    highlight: tango
    theme: cerulean
---

> The entire code and step wise work is given here on github profile- [Socceranalytics](https://github.com/neerajnj10/soccer-analytics-with-python-mongoDB-and-R)

# Predicting the Laliga Men's Division -I Football season 2015/2016

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

![Football loves Big Data](http://www.kdnuggets.com/images/cartoon-football-world-cup-big-data.gif)


## Motivation & Overview.



>  Soccer (football) is one of the widely popular sports around the world celebrated and viewed probably more than any 
other sports. The proof of which comes from the report when `USA` beat `JAPAN` $5$-$2$ in Women's Football World cup 2015 and a record average audience of $25.4$ million fans in the United States alone, watched their team win it. The sports analytics is growing and widely gathering importance for business, betting and for improving the techniques and productivity by every club, every team. This project highlights similar analytics (both descriptive and predictive) with respect to spanish football league *La liga*. The spanish teams have been dominating the football world in recent times and therefore has made for a strong reason to learn about them and model them.

*Being a football fanatic, predicting the results of soccer matches poses a very interesting challenge to me and to most other soccer fans, pundits and bookmakers. However, just like stock-market prediction the problem is here that this is a non-deterministic problem. You cannot expect 100% accuracy in this problem as that would suggest that you can predict the future! During the development of my project, I tried out multiple machine learning techniques and subsequetly chose the best model that gave the optimal results.*



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



##CROSS-INDUSTRY STANDARD PROCESS: CRISP-DM

![CRISP-DM](http://www.sv-europe.com/eu/wp-content/uploads/2013/12/newcrispdiagram.gif)

We approached this data mining problem using the CRISP-DM methodology. According to CRISP-DM, a given data mining project has a life cycle consisting of six phases and the phase sequence is adaptive (i.e. the next phase in the sequence depends on the outcomes associated with the previos phase.)

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



## Business Understanding.

Laliga Div-I soccer is played every year starting summer and contnues for a calender year. It is the game of high adrenaline matches between some of the highly regarded teams in the world ( which comes from the fact that this league comprises best players in the world, best teams and usually end up qualifying most times for Champions league-the game for teams from different leagues.) In total $20$ teams fight for the domestic league title year round, each team playing 38 games, meeting the same team at home and again at away fixtures. Head to head wins usually are considered highly important at the end for determining the ultimate winner. For example- if a team that after 38 matches, is tied up with another team that earns same points, the winnder is decided by the head-to-head performance of these two teams with respect to goals scored and overall attributes. In addition, millions of people place their bets on the game.
**To make money, sportsbooks set the odds of games such that they reflect the likelihood of the outcome of the game.**
Sportsbooks make the most money when there is a balanced distribution of bettors betting for both teams, so they may alter the odds to encourage more bettors to pick a particular side. Bettors look to find inefficiencies in the odds, that is, odds that do not accurately reflect the likelihood of a game's outcome. *In long run if a bettor knows the true odds than the sportsbook does, he is said to have "edge",and can make money.* 


In this model building exercise, we will therefore aim to produce the probabilities of the win loss or draw, and make comparison with the betting odds (probabilities) set by the sportsbooks, and see how we fare. 
We would also like to developed a decision support system to support either sports bettors or sportsbooks in
order to

- help bettors make more intelligent bets on basketball games (to help bettors find "edge")

- help sportsbooks more efficiently set odds (to help sportsbooks reduce bettors' "edge")

For sports betting, a bettor can figure out if he/she has edge by comparing a sportsbooks odds to his/her own perception of what the odds should really be.
> These odds also correspond to the probability of winning, using the formulas
 win probability for plus odds = 100/(plus odds) + 100)
 win probabilities for minus odds = -(minus odds)/-(minus odds)+100
 
 
odd conversion from converters can allow us to create respective win probabilities. 
Note that these percentages do not add up to 100%. In the end, sportsbooks are interested in having a balanced amount of bets for both sides,  so they'll adjust the odds accordingly to provide an incentive for more bettors to bet on a particular side. Also, from the bettors' perspective, they'll set the odds slightly worse than the true odds:this is known as vigorish, which is the amount charged by a bookmaker for a bettor to make a bet.



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



## Tools and Technologies used for the project.

- **Python** 
- **NoSQL** (`mongoDB` & `elasticsearch`) 
- **R** 
- **Tableau**


`Pipelining BigData tools for the future ready & better Data Sciences`

This project is an `innovative` idea put at work on pipe-lining individual tools/languages and skills for extracting the maximum capabilities of each of them.  

> As we know *Python* is primarily a scripting language that is highly proficient with data extraction, manipulation and web development. Here we use it for capturing structured and unstructured data from the web and aligning it to a specific format that is easy to work with. This structured data is then forwarded to the NoSQL database connection with *mongoDB* for data management and updating as and when required. This data is communicated to *elasticsearch* which provides the defualt indexing to help searching the data faster. This data then further follows with *R* programming, by connecting the database from the other end to create a virtual pipeline flow. The data thus imported into R, would be used for performing explanatory data analysis and predictions, ranging from both descriptive data analysis to prescriptive analysis with focus on obtaining the summary statistics from multiple variables (principal variables) and applying the efficient and apt models after testing for accuracy. In addition, tableau, has been used ot explore the data at the initial stage and learn about the structure of the data.



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



## Data understanding

The data has been used from spain soccer database, that updates the data prediocally. The data contains informations such as goals scored by the home team, away team, fouls committed, corners taken, shots attempted and on target, as well as full time result which we would like to predict. All the variables originally obtained from the data soource is as follows: Note that data sets also contains betting odds from betting experts which we would later use for the comparison. 
The data is extensive and exhaustive and is suitabel for prediction purpose. It contains details for each team and various metrics associated with it. 

A very exhaustive search was performed to look for a dataset that would be applicable to this problem. I was looking for one that would be freely available on the internet and found just one website that provided this; http://www.football-data.co.uk/data.php

This website had datasets including fulltime and halftime results for up to 22 European league divisions from 20 seasons back to 1992/93. Also included for the major European football leagues were match statistics like shots on goal, corners, fouls, offsides, bookings, red card and referees. Betting odds for each match were also available from multiple betting websites.Although I had data for 20 seasons, I only used the data for 10 seasons from the 2005/06 -2015/16 as that provided a suitable and sufficient number of data-points to build the system upon.

The betting odds that are provided with each datapoint are used as 'ExpertPrediction'labelsso that I can evaluate my predictions with theirs. To convert the odds into predictions, I simply take the resultwith the lowest payoff and set that as the prediction.

```
Div = League Division
Date = Match Date (dd/mm/yy)
HomeTeam = Home Team
AwayTeam = Away Team
FTHG = Full Time Home Team Goals
FTAG = Full Time Away Team Goals
FTR = Full Time Result (H=Home Win, D=Draw, A=Away Win)
HTHG = Half Time Home Team Goals
HTAG = Half Time Away Team Goals
HTR = Half Time Result (H=Home Win, D=Draw, A=Away Win)

Match Statistics (where available)
Attendance = Crowd Attendance
Referee = Match Referee
HS = Home Team Shots
AS = Away Team Shots
HST = Home Team Shots on Target
AST = Away Team Shots on Target
HHW = Home Team Hit Woodwork
AHW = Away Team Hit Woodwork
HC = Home Team Corners
AC = Away Team Corners
HF = Home Team Fouls Committed
AF = Away Team Fouls Committed
HO = Home Team Offsides
AO = Away Team Offsides
HY = Home Team Yellow Cards
AY = Away Team Yellow Cards
HR = Home Team Red Cards
AR = Away Team Red Cards
HBP = Home Team Bookings Points (10 = yellow, 25 = red)
ABP = Away Team Bookings Points (10 = yellow, 25 = red)

Key to 1X2 (match) betting odds data:

B365H = Bet365 home win odds
B365D = Bet365 draw odds
B365A = Bet365 away win odds
BSH = Blue Square home win odds
BSD = Blue Square draw odds
BSA = Blue Square away win odds
BWH = Bet&Win home win odds
BWD = Bet&Win draw odds
BWA = Bet&Win away win odds
GBH = Gamebookers home win odds
GBD = Gamebookers draw odds
GBA = Gamebookers away win odds
IWH = Interwetten home win odds
IWD = Interwetten draw odds
IWA = Interwetten away win odds
LBH = Ladbrokes home win odds
LBD = Ladbrokes draw odds
LBA = Ladbrokes away win odds
PSH = Pinnacle Sports home win odds
PSD = Pinnacle Sports draw odds
PSA = Pinnacle Sports away win odds
SOH = Sporting Odds home win odds
SOD = Sporting Odds draw odds
SOA = Sporting Odds away win odds
SBH = Sportingbet home win odds
SBD = Sportingbet draw odds
SBA = Sportingbet away win odds
SJH = Stan James home win odds
SJD = Stan James draw odds
SJA = Stan James away win odds
SYH = Stanleybet home win odds
SYD = Stanleybet draw odds
SYA = Stanleybet away win odds
VCH = VC Bet home win odds
VCD = VC Bet draw odds
VCA = VC Bet away win odds
WHH = William Hill home win odds
WHD = William Hill draw odds
WHA = William Hill away win odds

Bb1X2 = Number of BetBrain bookmakers used to calculate match odds averages and maximums
BbMxH = Betbrain maximum home win odds
BbAvH = Betbrain average home win odds
BbMxD = Betbrain maximum draw odds
BbAvD = Betbrain average draw win odds
BbMxA = Betbrain maximum away win odds
BbAvA = Betbrain average away win odds



Key to total goals betting odds:

BbOU = Number of BetBrain bookmakers used to calculate over/under 2.5 goals (total goals) averages and maximums
BbMx>2.5 = Betbrain maximum over 2.5 goals
BbAv>2.5 = Betbrain average over 2.5 goals
BbMx<2.5 = Betbrain maximum under 2.5 goals
BbAv<2.5 = Betbrain average under 2.5 goals

GB>2.5 = Gamebookers over 2.5 goals
GB<2.5 = Gamebookers under 2.5 goals
B365>2.5 = Bet365 over 2.5 goals
B365<2.5 = Bet365 under 2.5 goals


Key to Asian handicap betting odds:

BbAH = Number of BetBrain bookmakers used to Asian handicap averages and maximums
BbAHh = Betbrain size of handicap (home team)
BbMxAHH = Betbrain maximum Asian handicap home team odds
BbAvAHH = Betbrain average Asian handicap home team odds
BbMxAHA = Betbrain maximum Asian handicap away team odds
BbAvAHA = Betbrain average Asian handicap away team odds

GBAHH = Gamebookers Asian handicap home team odds
GBAHA = Gamebookers Asian handicap away team odds
GBAH = Gamebookers size of handicap (home team)
LBAHH = Ladbrokes Asian handicap home team odds
LBAHA = Ladbrokes Asian handicap away team odds
LBAH = Ladbrokes size of handicap (home team)
B365AHH = Bet365 Asian handicap home team odds
B365AHA = Bet365 Asian handicap away team odds
B365AH = Bet365 size of handicap (home team)
```

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


## Data prepration.

During this porcess, I decided to explore the data and look at various insights that might support or reject for each metrics that must be used in the final dataset for prediction. The data was refined and further subsetted to only contain important variables. The aim of this project as mentioned before was to - predict the win, loss or draw for each team head to head when the half time results were known - and then to also predict when none of the half time results were known. What it does is it allos you make forecasting iteresting and develop two different type of results, owing to two different type of betting, one at the start of the game when we are not aware of anything except teams, and other when the half time results are available to us to modify our bets accordingly.

The final dataset looks something like this:

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

We kept betting odds int he dataset but later removed it, the purpose of this is to be able to use at the end and compare we our predicted models probabilities. 

Several other parameters and metrics could have been added, but I decided to keep it simple as for our first approach to it. Other metrics that would be later added, would be `weather`, `tarvel to different countries`, `weightage to the first four teams of each season to distinguish them from weaker teams as this should definitely affect the end-results`.

I utilized **python** to start with to scrape the data from wwebpage defined above, this data was tehn structured and turned into the structure that **mongoDB** allows reading, that is either **json** or **bson** which in python is similar to **dictionaries**. I further approached the mongoDB and made the pipeline connection with **elasticsearch**, where data was transferred from one databse to ddatabse, however elasticsearch is more than just a database, it allows for fast searching and querying of the data by reading through the index. It is actually really **FAST**. I further made platforming of data easy by dumping it into **R** that allows for final data analysis and modelling. The whole structure is made keeping in mind the implementation and scaling we would do for actual **big data.**

- here, we will use all the data at once in R, specially because we do not have too heav data that R can not deal, in otherwise big data scenario, we would want to dump only certain queries and chunks of data one at a time, in batches from elasticsearch to R.

Oen thins to note is majority of or data is used in training the model, one of the reason for that is, we want to predict only for current season which is 2015-2016, therefore keeping the current season data aside as *test-data*, majority of data was utilized in training. This can be a good thing, as we could then further make prediction for future seasons just by adding data to test set. 


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


## Modeling.

Since the overall business problem from phase1 was to predict Laliga Tournament that has mutiple class for classification (non-binary), I chose to apply following techniques for modeling: $I$- *Decision Tree*, $II$- *Random Forest*, $III$- *Naive Bayes*, $IV$- *Support Vector Machine*, $V$- *Gradient Boosting model*, $VI$- *Generalized linear regression*.

**A brief summary of the techniques we tried and our reasoning for including them:

- **Decision Tree** - Decision trees are good for interpretability and complex data. In addition I wanted to compare the performance of a single decision tree with bagged approach (random forest).

- **Random forest** - As we know it is bag of trees, built on several decision trees together. They are usuallu good indicators for classification and are also most widely and commonly use approach.

- **Naive Bayes** - It was utilized to keep the assessment fair ended and we did see good results from nb specially in our second model, where we did not know about the half time result. The result was good on training set but it showed drastic change in our validation/test set.

- **Support Vector Machine** - I wanted to take advantage of both linear as well as kernel approach provided in svm.. Interestingly linear and non-linear choices produced great results. In addition to performing linear classification, SVMs can efficiently perform a non-linear classification using what is called the kernel trick, implicitly mapping their inputs into high-dimensional feature spaces.  If the training data are linearly separable, we can select two hyperplanes in a way that they separate the data and there are no points between them, and then try to maximize their distance. The region bounded by them is called "the margin".


- **Gradient Boosting** - It is a handy technique implemented heavily in both regression as well classification, producing step wise results by building model on several weak predictor models, typically decision tree and esemblin to form a better model in the end by optimizing the loss-function.

- **Generalized Linear regression** - Generalized Linear Models (GLM) estimate regression models for outcomes following exponential distributions. In addition to the Gaussian (i.e. normal) distribution, these include Poisson, binomial, gamma, multinom and Tweedie distributions. Each serves a different purpose, and depending on distribution and link function choice, can be used either for prediction or classification. The fact that it allows multinomial classification makes it a very good contender for our model.


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



## Estimating Performance For Classification

####For classification models:

- overall **accuracy** can be used, but this may be problematic when the
classes are not balanced.

- the **Kappa** statistic takes into account the expected error rate:??? =k = O-E/1-E
where O is the observed accuracy and E is the expected accuracy under chance agreement

- A **"confusion matrix"** is a cross-tabulation of the observed and predicted
classes.



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


## K-Fold cross validation

Here, we randomly split the data into K distinct blocks of roughly equal
size.
-1 We leave out the first block of data and fit a model.
-2 This model is used to predict the held-out block
-3 We continue this process until we've predicted all K held-out blocks

The final performance is based on the hold-out predictions K is usually taken to be 5 or 10 and leave one out cross-validation has each sample as a block Repeated K-fold CV creates multiple versions of the folds and aggregates the results (I prefer this method).

## Repeated Training/Test Splits (aka leave-group-out cross-validation)

A random proportion of data (say 80%) are used to train a model while the remainder is used for prediction. This process is repeated many times and the average performance is used. These splits can also be generated using stratified sampling. With many iterations (20 to 100), this procedure has smaller variance than
K-fold CV, but is likely to be biased.

**We will utilize both the methodologies for validation.**


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


I also used data visualization techniques using the software Tableau to explore the importance of certain variables and also to determine what impact certain variables have on the target variable in addition to doing it in R software. Below are few visualization examples on how certain metric affect the game and are important in determining the match results.

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



![full team sheet](https://cloud.githubusercontent.com/assets/11197322/11610819/1cc2629c-9b7c-11e5-9cd7-08281653946a.png)

- We first start with the games won, drawn or lost by home team vs away teams for each year (over the entire dataset), head-to-head results.


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



![Average attempts made by both team](https://cloud.githubusercontent.com/assets/11197322/11610646/e6a2275a-9b77-11e5-8f8d-c4606f6cc694.png)


- when the away team wins, the average number shots attempted on goal(target) has been 5.2 in response to home team attempting around 3.9 on average. For home team winning the average shots on target has been 6.16 in response to 3.2 by away team. While game ending in favor of draw saw, 3.6 attempts on target by away team to 4.3 by home team. This shows home team needed to have more shots on target than away team for a favorable result.


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



![Red cards for each team](https://cloud.githubusercontent.com/assets/11197322/11610647/ed3a269e-9b77-11e5-931a-b59262cd026a.png)


- It shows distinct number of red cards gained by each team. If the red cards are more for home team, they usually end up lossing, but there is an exciting insights attached with it, which is when the team playing home is **strong** and has more red cards than away team (weaker team), they still end up winning, which shows the strength of the team in overall attempts to goals compensates for the fouls and red cards. Also, another interesting theory attached to it is that red cards could be made towards he end of the game, so it might not play such big part in determining the conclusion of the match (however in some occasions only)



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------



![distinction in goals](https://cloud.githubusercontent.com/assets/11197322/11610657/2e9ed4fe-9b78-11e5-8442-9f3ebf5726aa.png)

- If the average full time goals, for the away team is more than 2(on an average), historical data shows that team away team ends up winning, provided teh home team scores 1 or less. 
- If avergae full time goals is 2 or more home team and conversly about .50 for away team the home team wins.
- Chances of draw, as we could think of, is high when both team score same number of goals. Most times, it is 1.508 on average for both teams.


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

## Evaluation Phase

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------




**5- fold cross validation and repeats on cross-validation was used for the model training and pruning.**



### First Model
> In the first model, our predictor set or metric set includes the Half time goals, and half time results for both teams, this is ur first model, when we want to predict for a game while we know the half time results and performance of both teams.

In this phase the evaluation of all the above mentioned models was done,and finally the best model was chosen based on the performance on training (validation) using cross-validation/ tuning which was done as a bonus to confirm our understanding from the model. The cross-validation/tuning/resampling produced differing results that helped us in making picking the right model. 

- We used `accuracy` and `kappa` values as the main performance indicator(for multi class ROC values are usually not present and hence these are preferred.) The t-test and difference between the performance of each model was also carried out. These are given as follows:


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

**Decision tree**
- Accuracy

![dt](https://cloud.githubusercontent.com/assets/11197322/11836765/c927b024-a3aa-11e5-880e-8494c415eaf3.png)

- Kappa

![dt2](https://cloud.githubusercontent.com/assets/11197322/11836773/cf095e2a-a3aa-11e5-88fc-1e645c9644da.png)



**Random Forest**

-Accuracy

![rf](https://cloud.githubusercontent.com/assets/11197322/11836776/d3a47262-a3aa-11e5-95ed-085d40bd46a2.png)

- kappa

![rf2](https://cloud.githubusercontent.com/assets/11197322/11836780/d7f0a0ca-a3aa-11e5-8852-2ac0e1640dbd.png)


** Gradient Boosting model**

- Accuracy

![gbm](https://cloud.githubusercontent.com/assets/11197322/11836784/dcd069ea-a3aa-11e5-8746-42fbaac8a893.png)

- Kappa

![gbm2](https://cloud.githubusercontent.com/assets/11197322/11836789/e08d7ee2-a3aa-11e5-95d2-53b5fdf79e69.png)


**Naive Bayes**


- Accuracy

![nb](https://cloud.githubusercontent.com/assets/11197322/11836792/e667ab80-a3aa-11e5-8873-892f5932fbe6.png)

- Kappa

![nb2](https://cloud.githubusercontent.com/assets/11197322/11836793/e97c36d8-a3aa-11e5-8f28-e7fa686b9659.png)


- **BW plot for all models combined over re-sampled method.**

![results](https://cloud.githubusercontent.com/assets/11197322/11836796/edd22a30-a3aa-11e5-9026-348fc7b16750.png)


- **Dotplot**

![results2](https://cloud.githubusercontent.com/assets/11197322/11836799/f25f7a8a-a3aa-11e5-9f51-880f5dd634c2.png)

- **splom plot(scatter plot)**

![results3](https://cloud.githubusercontent.com/assets/11197322/11836805/f603e32e-a3aa-11e5-94da-6fe3a485b27d.png)


- **direct comparison** (difference plot)

![diff](https://cloud.githubusercontent.com/assets/11197322/11836806/f96a6bd2-a3aa-11e5-8366-6e9fda7cc3f9.png)


![diff2](https://cloud.githubusercontent.com/assets/11197322/11836807/fd8260c6-a3aa-11e5-8772-b74977a63769.png)


- SVM -Linear was selected as our final model to implement on test dataset based performances noted above, SVM produces Accuracy of mean $66.87%$ and kappa value as $46.84%$.

- On test set, the accuracy was noticed as $66.36%$ and kappa as $45.85%$ 

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


### Second model Evaluation

> In second model, we modify our predictors and remove the half time results and attributes to allow for prediction at the start of the game with out knowing the half time performances of each teams.

- hence both the model, allow for predictions with different requirements in mind while betting or while simplying using for other business values.

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


**Decision tree**

- Accuracy

![dtnew](https://cloud.githubusercontent.com/assets/11197322/11836821/1bf1468a-a3ab-11e5-82dd-be44302f7562.png)


- Kappa

![dtnew2](https://cloud.githubusercontent.com/assets/11197322/11836831/2e20e900-a3ab-11e5-8ab5-23e13de98466.png)


**Random Forest**

-Accuracy

![rfnew](https://cloud.githubusercontent.com/assets/11197322/11836833/3267f224-a3ab-11e5-9434-31b67de4bbf6.png)

- Kappa

![rfnew2](https://cloud.githubusercontent.com/assets/11197322/11836836/3668f062-a3ab-11e5-810d-b4070a1c060b.png)

**NAIVE BAYES**

-Accuracy

![nbnew](https://cloud.githubusercontent.com/assets/11197322/11836837/39faf5ea-a3ab-11e5-9c6f-35d706a8c8dd.png)

- Kappa

![nbnew2](https://cloud.githubusercontent.com/assets/11197322/11836839/3d31f90c-a3ab-11e5-803f-edc285146710.png)

** Gradient Boosting**

- Accuracy

![gbmnew](https://cloud.githubusercontent.com/assets/11197322/11836841/41866dd0-a3ab-11e5-8600-252e358a0119.png)

- Kappa

![gbmnew2](https://cloud.githubusercontent.com/assets/11197322/11836847/47e8f0a8-a3ab-11e5-90c3-335c28fc1e49.png)


- **BW plot for all models combined over re-sampled method.**

![resultnew](https://cloud.githubusercontent.com/assets/11197322/11836849/4b13e8dc-a3ab-11e5-8f6c-b9469a99d193.png)


- **Dotplot**

![resultnew2](https://cloud.githubusercontent.com/assets/11197322/11836851/4f08f090-a3ab-11e5-994c-c14aeda218c4.png)

- **splom plot(scatter plot)**

![resultnew3](https://cloud.githubusercontent.com/assets/11197322/11836853/51ace734-a3ab-11e5-9ebd-515a1e5b270a.png)


- **direct comparison** (difference plot)

![diffnew](https://cloud.githubusercontent.com/assets/11197322/11836857/556de760-a3ab-11e5-8d9d-5e4a1af69b2e.png)
![diffnew2](https://cloud.githubusercontent.com/assets/11197322/11836861/5917ec3a-a3ab-11e5-846a-57b1f2ff71de.png)

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

#### based on model results and comparison between the performance of the models amongst each other, SVM-Linear model performed significantly better than the remaining model and therefore was utilized for testing of final model. 


- SVM produced mean accuracy of $60.37%$ and kappa value of $33.72%$ for second model.
- Test set produced accuracy of $58.18%$ and kappa as $29.91%$



## Final results (briefly shown)

> - Note: Interestingly SVM-Linear was chosen for both the models, even with modified/replaced predictors.



```
 FTR p5 p5new PredictedFTRProbWhenHTRisknown.A PredictedFTRProbWhenHTRisknown.D PredictedFTRProbWhenHTRisknown.H
1   D  D     A                        0.3175107                       0.38527311                      0.297216146
2   A  D     A                        0.3539532                       0.40278740                      0.243259361
3   D  D     D                        0.2983670                       0.49595873                      0.205674279
4   D  A     H                        0.6413772                       0.22022013                      0.138402709
5   H  H     H                        0.1149321                       0.29441837                      0.590649528
6   A  A     A                        0.9388621                       0.05450384                      0.006634032
  PredictedFTRProbWhenHTRisUnknown.A PredictedFTRProbWhenHTRisUnknown.D PredictedFTRProbWhenHTRisUnknown.H
1                          0.3672793                          0.2605115                         0.37220919
2                          0.3918856                          0.2878935                         0.32022088
3                          0.3872056                          0.4117744                         0.20102002
4                          0.2738267                          0.3096866                         0.41648670
5                          0.3115845                          0.3400149                         0.34840060
6                          0.8488061                          0.1140005                         0.03719338
      B365H     B365A     B365D
1 0.2777778 0.4878049 0.2857143
2 0.1538462 0.6666667 0.2309469
3 0.5405405 0.2222222 0.2857143
4 0.2105263 0.5714286 0.2666667
5 0.4347826 0.3125000 0.3030303
6 0.4761905 0.2857143 0.2857143
```

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


## Plotting the comparison between our predicted class with that of actual class( this is indirect visualization of confusion matrix in a way.)


> first when HTR is known. (Our first model)

- Draw results account for more confusion here, and least by home team winning.


![cf1](https://cloud.githubusercontent.com/assets/11197322/11841180/890fd786-a3c9-11e5-9a77-6dc803cdcc3c.png)



> Now when HTR is unknown. (Our second model)

- Away results account for more confusion here, and least by home team winning.

![cf2](https://cloud.githubusercontent.com/assets/11197322/11841182/8be0bde0-a3c9-11e5-969b-14f793a1dfb0.png)


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

## Comparing probabilities (predicted vs Betting Experts Probabilities)

- We will discuss only two example, one for each model (for detailed comparison , please follow the link from Github to published page link.)

> When HTR is known. (first model)

![htrknown](https://cloud.githubusercontent.com/assets/11197322/11841598/6228df66-a3cc-11e5-929d-1ecb6c98c779.png)



- we will look at the "home" grid(home team winning at the end actually), where when betting experts predicted home win probabilities , it shows that we predicted some of the results to be loss for home team, in favor of  away team (as color indicates) and very little as  "draw" too, but despite that, on comparing the probability numbers, it shows our prediction probs are higher and hence more reliable. 




> When HTR is unknown(2nd model)

![htr](https://cloud.githubusercontent.com/assets/11197322/11841600/6521f57c-a3cc-11e5-9baa-1d6b2b3a0af5.png)



- we will look at the "home" grid(home team winning at the end actually), where when betting experts predicted home win probabilities , it shows that we predicted some of the results to be loss for home team, in favor of  away team (as color indicates) and very little as  "draw" too, but despite that, on comparing the probability numbers, it shows our prediction probs are higher and hence more reliable. 


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


- In practice, bettors will choose to make a bet depending on the amount of edge he feels he has over the sportsbook. Therefore, when evaluating whether the data model is useful, a better needs to only check how often he is right. If he is wrong about the outcome of the game, when he doesn't decide to bet, it won't matter since he has not laid any bet money.

In the end, to determine whether using our decision support system was effective, a bettor or a sportsbook should compare their long run profits from before they started using our system.  If it increases, this indicates that one of them was able to raise their *edge* over teh other. If no improvement is found, then bettors  and sportbooks should move to a different strategy.



-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

## Caveats-Cautions-Future Scope of the Project.

- A word of caution: this system's predictions and probability estimates should not be the be all end all system for sports bettors and sports books. Instead, this tool should be used as one of many tools, which as a whole can probably provide a more accurate and reliable picture about football games than this system can provide alone. In particular, we expect sports bettors and sportsbooks to have significant domain expertise, so when their beliefs and our system clash, we encourage them to take our results with a grain of salt.This approach to predicting football games can mitigate risk, and can prevent users from making unusual and potentially money losing decisions.

- The model is static right now and only make predict post-season, it will be intended to extend it real time so as to be able to predict beforehand or in real time with the matches ad update automatically.

- In the future,I expect to update the model yearly,so that it can be used to predict games for the future tournaments.
