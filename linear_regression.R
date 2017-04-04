#
# very simple introduction to "regression" as a machine learning framework for prediction
# coded by rick dale for cogs 105
#
# first, let's get some data. these were discussed in class. they are
# hypothetical data from netflix... IMAGINARY data... for our exercise
# but inspired by real trends
#

# first, more experience installing and loading some libraries we need
install.packages('RCurl') 
library(RCurl)

# load the data from the internet
dataFromWeb = getURL("https://raw.githubusercontent.com/racdale/simple-regression-demo/master/imaginary_netflix_data.txt", ssl.verifypeer = FALSE)

# load the data to create a data frame
netflixData = read.csv(text=dataFromWeb,sep="\t",quote = "")

# let's look for relationships visually
plot(netflixData$age,netflixData$documentary)
plot(netflixData$age,netflixData$drama)
# do you see a relationship?

# regression is a method for making a MODEL that relates variables of interest
# let's try this simply, with just two variables... 
# we specify a formula: what is predicted ~ what will be predicting, for example
regressionModel = lm(drama~age,data=netflixData)
# this says "predict drama from age"
regressionModel 
# this says that with each YEAR of age increase, we predict DRAMA RATINGS to go up by... .06 or so...
# intercept is the rating that someone of age 0 would give to dramas (not very sensible to interpret, of course)

# let's add this regression line to our data
plot(netflixData$age,netflixData$drama)
abline(regressionModel)
# easy and cool!

# let's suppose you get someone's age.. using this 
# model we can PREDICT what they might think of dramas:
predict(regressionModel,newdata=data.frame(age=40)) # 40 year old
predict(regressionModel,newdata=data.frame(age=60)) # 60 year old

# here's something cool... let's predict AGE by moving ratings!?
# cf. those websites that claim they can predict your age or gender from various question
# responses... here's a simple example of how you might actually be able to do this
# with movie data
ageModel = lm(age~drama+documentary+action+romance,data=netflixData)
# this uses MANY variables to predict age... how does the model do?
plot(netflixData$age,predict(ageModel),xlab='Actual age',ylab='Predicted age')

# once you get it running, do this:
###### questions for lab #######
# 1. Across all people, which movie genre seems to be most liked, based on mean? 
# 2. What is the predicted DRAMA rating for 50 year olds?
# 3. CHALLENGE: what is the predicted rating for ACTION movies for an 18 year old?




