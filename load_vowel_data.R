load_vowel_data <- function(doScaling=FALSE,doRandomization=FALSE){
  #
  # R code to load in the vowel data set from the book ESLII
  #
  # Output:
  #
  # res: list of data frames XT
  #
  #-----

  # Get the training data:
  #   
  XTrain  = read.csv("vowel_train.csv", header=TRUE)

  # Delete the column named "row.names":
  #
  XTrain$row.names = NULL

  # Extract the true classification for each datum
  # 
  labelsTrain = XTrain[,1] 

  # Delete the column of classification labels:
  #
  XTrain$y = NULL 
  
  #
  # We try to scale ALL features so that they have mean zero and a
  # standard deviation of one.
  #
  if( doScaling ){
    XTrain = scale(XTrain, TRUE, TRUE)
    means  = attr(XTrain,"scaled:center")
    stds   = attr(XTrain,"scaled:scale")
    XTrain = data.frame(XTrain)
  }

  #
  # Sometime data is processed and stored on disk in a certain order.  When doing cross validation
  # on such data sets we don't want to bias our results if we grab the first or the last samples.
  # Thus we randomize the order of the rows in the Training data frame to make sure that each
  # cross validation training/testing set is as random as possible.
  # 
  if( doRandomization ){
    nSamples    = dim(XTrain)[1] 
    inds        = sample( 1:nSamples, nSamples )
    XTrain      = XTrain[inds,]
    labelsTrain = labelsTrain[inds]
  }

  # Get the testing data:
  #
  XTest  = read.csv("vowel_test.csv", header=TRUE)

  # Delete the column named "row.names":
  #
  XTest$row.names = NULL

  # Extract the true classification for each datum
  # 
  labelsTest = XTest[,1] 

  # Delete the column of classification labels:
  #
  XTest$y = NULL 

  # Scale the testing data using the same transformation as was applied to the training data:
  # 
  if( doScaling ){
    XTest = t( apply( XTest, 1, '-', means ) ) 
    XTest = t( apply( XTest, 1, '/', stds ) ) 
  }

  return( list( XTrain, labelsTrain, XTest, labelsTest ) ) 
}

