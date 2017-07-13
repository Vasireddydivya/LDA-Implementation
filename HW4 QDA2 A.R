## QDA results using own QDA2 function
## R code reference Chap4 R code zip package

source("load_vowel_data.R")
source("QDA2.R")


out    = load_vowel_data( TRUE, FALSE )
XTrain = out[[1]]
yTrain = out[[2]] 
XTest  = out[[3]]
yTest  = out[[4]] 

alphas = 1
err_rate_train = c()
err_rate_test = c()
for( apha in alphas ){
  print( sprintf("Creating RDA classifier for alpha= %10.6f",apha) )  
  out = qda2( XTrain, yTrain, XTest, yTest )
  err_rate_train = c(err_rate_train, out[[1]])
  err_rate_test = c(err_rate_test, out[[2]])
}
err_rate_test
