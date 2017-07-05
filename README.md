# QDA-Implementation
QDA algorithm implementation in R
Discriminant Analysis is used to determine which variables discriminate between two or more naturally occurring groups.

QDA is Quadratic Discriminant Analysis. This algorithm is similar to Linear Discriminant Analysis(LDA), which assumes data is normally distributed. Unlike LDA however, in QDA there are no such assumptions and the covariance matrix is different for different classes in the data. 
I implemented the algorithm in R and tested on Vowel dataset from Statistical Learning Data Sets.
Load_Vowel_Data.r is mainly used to load the training and testing data. I have scaled and randomized the data.
QDA2.r has QDA function. The quadratic descriminant function should be of form: δk(x)=−1/2log|Σk|−1/2(x−μk)T Σ−1k (x−μk)+logπk
I calculated the individual mean and covariance matrices. The πk is prior probability with respect to class.
After finding the δk(x), i have calculated the miss classification error rate for train and test data.
