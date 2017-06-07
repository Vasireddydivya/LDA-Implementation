## QDA results using MASS package from R. 

library(MASS) # this has functions for lda and qda 

source("load_vowel_data.R")

out         = load_vowel_data( FALSE )
XTrain      = out[[1]]
labelsTrain = out[[2]] 
XTest       = out[[3]]
labelsTest  = out[[4]] 

qdam = qda( XTrain, labelsTrain ) # TRAIN A QDA MODEL


##predTrain = predict( qdam, XTrain ) # make predictions on the training data
##tpLabels  = as.double( predTrain$class ) 

##numCC      = sum( (tpLabels - labelsTrain) == 0 )
##numICC     = length(tpLabels)-numCC 
##eRateTrain = numICC / length(tpLabels) 

predTest = predict( qdam, XTest )  # make predictions on the test data
tpLabels = as.double( predTest$class ) 

numCC     = sum( (tpLabels - labelsTest) == 0 )
numICC    = length(tpLabels)-numCC 
eRateTest = numICC / length(tpLabels) ## misclassification error

