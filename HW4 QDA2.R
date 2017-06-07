## HW4 Q3
## implement of QDA with seperate Gaussian model for each class 

qda2 = function( XTrain, yTrain, XTest, yTest){

  # Inputs:
  #   XTrain = training data frame
  #   yTrain = training labels of true classifications with indices 1 - K (where K is the number of classes)
  #   xTest = testing data frame
  #   yTest = testing response
  
  K = length(unique(yTrain)) # the number of classes  
  N = dim( XTrain )[1] # the number of observations
  p = dim( XTrain )[2] # the number of features 
  
  # Compute the class dependent mean vector and covariance matrices:
  PiK = list()
  MuHatK = list()
  SigmaHatK = list()
  for( ci in 1:K ){
    inds = yTrain == ci
    PiK[[ci]] = sum(inds)/N
    MuHatK[[ci]] = as.matrix( colMeans( XTrain[ inds, ] ) )
    SigmaHatK[[ci]] = cov( XTrain[ inds, ] )
  }

  # Compute parameters needed for classification by discriminant functions:
  
  SigmaHatK_Det = list()
  SigmaHatK_Inv = list()
  for( ci in 1:K ){
    SigmaHatK_Det[[ci]] = det(SigmaHatK[[ci]])
    SigmaHatK_Inv[[ci]] = solve(SigmaHatK[[ci]])  
  }
  
  # Classify Training data:
  #
  XTM = t(as.matrix( XTrain )) # dim= p x N 
  QDATrain = matrix( data=0, nrow=N, ncol=K ) #  training class discriminants
  for( ci in 1:K ){
    MU = matrix( MuHatK[[ci]], nrow=p, ncol=N ) # dim= p x N
    X_minus_MU = XTM - MU # dim= p x N
    SInv = SigmaHatK_Inv[[ci]] # dim= p x p
    SX = SInv %*% X_minus_MU # dim= ( p x N )
    for( si in 1:N ){
      QDATrain[si,ci] = -0.5 * log(SigmaHatK_Det[[ci]]) - 0.5 * t(X_minus_MU[,si]) %*% SX[,si] + PiK[[ci]]
    }
  }
  
  # Classify Testing data:
  #
  N = dim( XTest )[1] 
  XTM = t(as.matrix( XTest )) # dim= p x N 
  QDATest = matrix( data=0, nrow=N, ncol=K ) # testing class discriminants
  for( ci in 1:K ){
    MU = matrix( MuHatK[[ci]], nrow=p, ncol=N ) # dim= p x N
    X_minus_MU = XTM - MU # dim= p x N
    SInv = SigmaHatK_Inv[[ci]] # dim= p x p
    SX = SInv %*% X_minus_MU # dim= ( p x N )
    for( si in 1:N ){
      QDATest[si,ci] = -0.5 * log(SigmaHatK_Det[[ci]]) - 0.5 * t(X_minus_MU[,si]) %*% SX[,si] + PiK[[ci]]
    }
  }
  
  yHatTrain = apply( QDATrain, 1, which.max )
  errRateTrain = sum( yHatTrain != yTrain )/N
  

}



