#' Fit a logistic regression model with lasso
#'
#' Fit a logistic regression model with lasso using split-and-conquer approach.
#' Can deal with large sparse data matrices. Returns the combined estimator.
#'
#' @param k the desired number of subsets.
#' @param X observation matrix.
#' @param y response variable.
#' @param ncores the desired number of cores to execute code.
#'
#' @examples
#' n<-800
#' p<-2*n
#' mu<-matrix(rep(0,p),nrow=p)
#' sigma<-diag(1,nrow=p)
#' X<-mvrnorm(n,mu,sigma)
#' beta<-beta_generate(p,k=30,min=.2,max=.8)
#' y<-y_generate(beta,X)
#' SC_fun(k=4,X,y,ncores=2)
#'
#' @export
SC_fun<-function(k,X,y,ncores){
  n<-dim(X)[1]
  p<-dim(X)[2]
  w<-1

  cl <- makeCluster(ncores)
  registerDoParallel(cl)
  beta_dat = foreach(i=1:k,.packages = "glmnet") %dopar%{
    X_k<-X[(n/k*(i-1)+1):(n/k*i),]
    y_k<-y[(n/k*(i-1)+1):(n/k*i)]
    cvfit.update<-cv.glmnet(X_k,y_k,alpha=1,family="binomial",type.measure="class")
    sub_beta<-coef(cvfit.update,s=cvfit.update$lambda.1se)
    theta<-X_k%*%as.numeric(sub_beta)[-1]
    s<-exp(theta)/(1+exp(theta))^2
    return(c(as.numeric(sub_beta)[-1],s))
  }

  beta_dat<-data.frame(sapply(beta_dat, as.numeric))
  beta_data<-beta_dat[1:p,]
  Sigma<-beta_dat[(p+1):(p+n/k),]

  E_index<-as.numeric(apply(beta_data!=0,MARGIN=1,FUN=sum))
  E<-matrix(rep(0,p*p),nrow=p)
  E_index<-as.numeric(which(E_index>=w))
  E[cbind(E_index,E_index)]<-1
  A<-E[,E_index]

  beta_dat = foreach(i=1:k,.combine='+') %dopar%{
    s<-diag(c(Sigma[,i]))
    x<-X[(n/k*(i-1)+1):(n/k*i),]
    M1<-t(x[,E_index])%*%s%*%x[,E_index]
    beta_x<-beta_data[,i][E_index]
    M2<-M1%*%beta_x
    cbind(M1,M2)
  }
  M1<-beta_dat[,1:dim(A)[2]]
  M2<-beta_dat[,1+dim(A)[2]]
  subA<-A
  subA[E_index,]<-solve(M1)
  beta_c<-subA%*%M2
  stopCluster(cl)
  return(beta_c)
}
