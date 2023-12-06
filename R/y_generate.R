#' Create a response variable y
#'
#' Create a response variable y follows Bernoulli distribution with success probability
#' \eqn{p(X\beta)} given \eqn{X} and \eqn{\beta}.
#'
#' @param \eqn{\beta} coefficient vector.
#' @param X input matrix, each row is an observation.
#'
#' @examples
#' n<-100
#' p<-200
#' mu<-matrix(rep(0,p),nrow=p)
#' sigma<-diag(1,nrow=p)
#' X<-mvrnorm(n,mu,sigma)
#' beta<-beta_generate(p,k=30,min=.2,max=.8)
#' y_generate(beta,X)
#'
#' @export
y_generate<-function(beta,X){
  prob<-1/(1+exp(-X%*%beta))
  n<-dim(X)[1]
  y<-rbinom(n=n,size=1,prob=prob)
  return(y)
}
