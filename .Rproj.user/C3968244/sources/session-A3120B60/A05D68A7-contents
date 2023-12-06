#' Create a sparse beta
#'
#' Create a sparse beta in matrix form with non-zero entries randomly drawn from
#' uniform distribution.
#'
#' @param p the desired number of columns.
#' @param k the desired number of non-zero entries.
#' @param min lower limit of the distribution.
#' @param max upper limit of the distribution.
#'
#' @examples
#' beta_generate(p=1000,k=30,min=.2,max=.8)
#'
#' @export
beta_generate<-function(p,k,min,max){
  index<-sample(c(1:p),k)
  beta<-matrix(rep(0,p),nrow=p)
  beta[index]<-round(runif(k,min,max),2)
  return(beta)
}
