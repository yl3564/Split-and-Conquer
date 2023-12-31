% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SC_fun.R
\name{SC_fun}
\alias{SC_fun}
\title{Fit a logistic regression model with lasso}
\usage{
SC_fun(k, X, y, ncores)
}
\arguments{
\item{k}{the desired number of subsets.}

\item{X}{observation matrix.}

\item{y}{response variable.}

\item{ncores}{the desired number of cores to execute code.}
}
\description{
Fit a logistic regression model with lasso using split-and-conquer approach.
Can deal with large sparse data matrices. Returns the combined estimator.
}
\examples{
n<-800
p<-2*n
mu<-matrix(rep(0,p),nrow=p)
sigma<-diag(1,nrow=p)
X<-mvrnorm(n,mu,sigma)
beta<-beta_generate(p,k=30,min=.2,max=.8)
y<-y_generate(beta,X)
SC_fun(k=4,X,y,ncores=2)

}
