
# $Id: verify_BAMS.R,v 1.1 2014/05/22 17:03:56 ytian Exp ytian $ 
# Verify the formula for the BAMS paper 

veri_BAMS <- function (lambda, delta, sigma) { 

nc=200000

x=rnorm(nc, 3, 3) 

noise=rnorm(nc, 0, sigma) 

y=lambda*(x+delta) + noise

model=lm(y~x) 

      A= model$coefficients[1]
      B = model$coefficients[2]
      Sigma = sd(model$residuals)

elambda = B 
edelta = A/B
esigma = Sigma 

out=data.frame(c(lambda, delta, sigma), c(elambda, edelta, esigma)) 
rownames(out) = c("lambda", "delta", "sigma")
colnames(out) = c("true", "est.")

write("\n Parameters: truth vs. estimated:", file="")
write("====================================", file="")
print(t(out), digits=4)


bias=mean(y-x) 
MSE = mean( (y-x)**2 ) 
cc = cor(y, x) 

ebias = (elambda - 1) * mean(x) + elambda * edelta 
eMSE = bias*bias + (elambda-1)^2 * var(x) + esigma*esigma
ecc = sqrt( elambda^2 * var(x) / (  elambda^2 * var(x) + esigma*esigma) ) 

out=data.frame(c(bias, MSE, cc), c(ebias, eMSE, ecc)) 
rownames(out) = c("bias", "MSE", "CC")
colnames(out) = c("true", "est.")

write("\n Metrics: conventional vs. derived:", file="")
write("====================================", file="")
print(t(out), digits=4)
 
}


#lambda=1.5 delta=2 sigma=4

veri_BAMS(1.5, 2, 4) 

veri_BAMS(0.5, 2, 3) 


#==================================================
# output
#> source("verify_BAMS.R")
#
# Parameters: truth vs. estimated:
#====================================
#     lambda delta sigma
#true  1.500 2.000 4.000
#est.  1.504 1.975 3.993
#
# Metrics: conventional vs. derived:
#====================================
#      bias   MSE     CC
#true 4.483 38.33 0.7485
#est. 4.483 38.33 0.7485
#
# Parameters: truth vs. estimated:
#====================================
#     lambda delta sigma
#true 0.5000 2.000 3.000
#est. 0.4946 2.042 2.998
#
# Metrics: conventional vs. derived:
#====================================
#        bias   MSE     CC
#true -0.5051 11.54 0.4438
#est. -0.5051 11.54 0.4438


