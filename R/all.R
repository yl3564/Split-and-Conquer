#' Fit a logistic regression model with lasso using glmnet() function
#'
#' Fit a logistic regression model with lasso using glmnet() function. Returns
#' the computing time and misclassification rate in a vector form.
#'
#' @param X input matrix.
#' @param y response variable.
#'
#' @export
all<-function(X,y){
  t1<-proc.time()
  cvfit<-cv.glmnet(X,y,alpha=1,family="binomial",type.measure="class")
  pred.cvfit<-predict(cvfit, newx=X, type="class", s="lambda.1se")
  MR<-sum(abs(y-as.numeric(pred.cvfit)))/length(y)
  t2<-proc.time()
  t<-as.numeric((t2-t1)[3])
  return(c(t,MR))
}
