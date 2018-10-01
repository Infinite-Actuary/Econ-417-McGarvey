# Principles of Econometrics, Hill, 5th Edition
# Problem 6.27 (pg 307)

# install & load dependencies
# install.packages('car', 'lmtest')
library(car)
library(lmtest)

# load data
load(file = '~/R/data/cps5_small.rdata')# load data

# use observations for which years of education exceeds 7
data <- cps5_small[cps5_small$educ > 7, ]# N = 1178

# generate regression variables
lwage <- log(data$wage)
educ <- data$educ
exper <- data$exper
educ2 <- educ^2
exper2 <- exper^2
educ_exper <- educ*exper

# a) estimate the model ln(WAGE) = beta1 + beta2*EDUC + beta3*EXPER + e
# jointly test the claims about the marginal effects of EDUC & EXPER

# create simple model
model <- lm(lwage ~ educ + exper)
summary(model)

linearHypothesis(model, c('educ = 0.112', 'exper = 0.008'), test = 'F')
qf(0.95, df1 = 2, df2 = 1175)
# F = 0.3892 < 3.003383 => fail to reject H0
# there is no evidence to dispute the claim made about the marginal effects of educ & exper

# b) use RESET to test the adequacy of the model. Perform a test with the squares of the predictions
resettest(model, power = 2, type = 'fitted')
qf(0.95, df1 = 1, df2 = 1174)
# F = 6.4242 > 3.849392 => reject H0
# we concluded that the squares of the predictions have significant explanatory power, hence the model is inadequate

# now we perform a test with the squares and cubes of the predictions
resettest(model, power = 2:3, type = 'fitted')
qf(0.95, df1 = 2, df2 = 1173)
# F = 4.5415 > 3.003396 => reject H0
# we conclude the squares and cubes of the predictions have significant explanatory power, hence the model is inadequate

# c) estimate the model ln(WAGE) = beta1 + beta2*EDUC + beta3*EXPER + beta4*EDUC^2 + beta5*EXPER^2 + beta6*EDUC*EXPER + e
fit <- lm(lwage ~ educ + exper + educ2 + exper2 + educ_exper)
s <- summary(fit)
s

# jointly test the claims about the marginal effects of EDUC & EXPER at the following levels:
# i.   EDUC = 10, EXPER = 5
# ii.  EDUC = 14, EXPER = 24
# iii. EDUC = 18, EXPER = 40

# d(lwage)/d(educ)  = beta2 + 2*beta4*EDUC  + beta6*EXPER = 2.269e-01 + 2*-3.287e-03*EDUC  + -6.730e-04*EXPER
# d(lwage)/d(exper) = beta3 + 2*beta5*EXPER + beta6*EDUC  = 4.079e-02 + 2*-4.814e-04*EXPER + -6.730e-04*EDUC

# i.
s$coefficients[2,1] + 2*s$coefficients[4,1]*10 + s$coefficients[6,1]*5# 0.158 vs 0.112
s$coefficients[3,1] + 2*s$coefficients[5,1]*5 + s$coefficients[6,1]*10# 0.029 vs 0.008

# H0: beta2 + 2*beta4*EDUC  + beta6*EXPER = 0.112 & beta3 + 2*beta5*EXPER + beta6*EDUC = 0.008
linearHypothesis(fit, c('educ + 20*educ2 + 5*educ_exper = 0.112','exper + 10*exper2 + 10*educ_exper = 0.008'), test = 'F')
qf(0.95, df1 = 2, df2 = 1172)
# F = 16.039 > 3.003403 => reject H0

# ii.
s$coefficients[2,1] + 2*s$coefficients[4,1]*14 + s$coefficients[6,1]*24# 0.119 vs 0.112
s$coefficients[3,1] + 2*s$coefficients[5,1]*24 + s$coefficients[6,1]*14# 0.008 vs 0.008

# H0: beta2 + 2*beta4*EDUC  + beta6*EXPER = 0.112 & beta3 + 2*beta5*EXPER + beta6*EDUC = 0.008
linearHypothesis(fit, c('educ + 28*educ2 + 24*educ_exper = 0.112','exper + 48*exper2 + 14*educ_exper = 0.008'), test = 'F')
qf(0.95, df1 = 2, df2 = 1172)
# F = 0.5803 > 3.003403 => fail to reject H0

# iii.
s$coefficients[2,1] + 2*s$coefficients[4,1]*18 + s$coefficients[6,1]*40# 0.082 vs 0.112
s$coefficients[3,1] + 2*s$coefficients[5,1]*40 + s$coefficients[6,1]*18# -0.010 vs 0.008

# H0: beta2 + 2*beta4*EDUC  + beta6*EXPER = 0.112 & beta3 + 2*beta5*EXPER + beta6*EDUC = 0.008
linearHypothesis(fit, c('educ + 36*educ2 + 40*educ_exper = 0.112','exper + 80*exper2 + 18*educ_exper = 0.008'), test = 'F')
qf(0.95, df1 = 2, df2 = 1172)
# F = 13.638 > 3.003403 => reject H0

# d) use RESET to test the adequacy of the model
# perform the test with the squares of the predicitions
resettest(fit, power = 2, type = 'fitted')
qf(0.95, df1 = 1, df2 = 1171)
# F = 0.15596 < 3.849412 => fail to reject H0
# we conclude that the squares of the predictions do not have significant explanatory power
# the test does not suggest the model is inadequate

# perform the test with the squares and cubes of the predictions
resettest(fit, power = 2:3, type = 'fitted')
qf(0.95, df1 = 2, df2 = 1170)
# F = 1.8963 < 3.003416 => fail to reject H0
# conclude squares and cubes of the predictions do not have significant explanatory power
# the test does not suggest the model is inadequate

# e) how would you respond to the claim about the marginal effects of EDUC & EXPER?
# the claim is not true for all levels of education and experience
# the medians are EDUC = 14 & EXPER = 23 which approximate the values tested in c.ii
# so the claim is not reasonable when education & experience are either
# much greater or much less than the median levels