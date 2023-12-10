# Split-and-Conquer Approach

* This R package realizes the Split-and-Conquer Approach proposed by Xueying Chen and Min-ge Xie ([2014](#ref-SC)) 
on logistic regression model using lasso. It can substantially reduce computing time and computer memory 
requirements for dataset that is too large to fit into a single computer or too expensive for a computationally intensive data analysis.  
* This R package contains 4 functions. The *SC_fun()* function outputs estimators using the split-and-conquer approach. The other three functions are designed to generate beta and response variables, facilitating ease of use, simulation, and comparison for users.  
* We make several simulations in vignette.Rmd in vignnettes file, comparing computing time and misclassification rate in
different scenarios.




## References

<div id="refs" class="references">

<div id="ref-SC">

Xueying Chen and Min-ge Xie. 2014. "A Split-and-Conquer Approach for Analysis
of Extraordinarily Large Data." *Statistica Sinica* 24: 1655–1684.
<https://doi.ordoihttp://dx.doi.org/10.5705/ss.2013.088>.
