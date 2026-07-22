##############################################
# Learning Days Latin America 2025           #
# ############################################


# -----------Declaracion de diseño---------------#

library(randomizr) # Para DeclareDesign
library(fabricatr) # Para DeclareDesign
library(estimatr) # Para DeclareDesign
library(DeclareDesign)

library(tidyverse)

rm(list=ls())

# ------------- Diseño aleatorio completo -------------- #
# Diseño
  # N=150
  # Tamaño del efecto esperado: 0.15 SD.

# 1. Modelo
###################
# potential_outcomes: funcion de fabricatr
model <- 
  declare_model(
    N = 1000,
    potential_outcomes(Y ~ runif(1, 0, 0.5) * Z + rnorm(N))) 

# 2. Pregunta
####################
inquiry <-
  declare_inquiry(ATE = mean(Y_Z_1) - mean(Y_Z_0))

# 3. Estrategia de los datos
#####################################
# reveal_outcomes: funcion de fabricatr
# complete_rs: funcion de randomizr
# complete_ra: funcion de randomizr

data_strategy <-
  declare_sampling(S = complete_rs(N = N, n = 150), filter = S == 1) +
  declare_assignment(Z = complete_ra(N)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) 

# 4. Estrategia de respuesta
###################################
# difference_in_means: funcion de estimatr
# Ver: https://declaredesign.org/r/estimatr/articles/mathematical-notes.html

answer_strategy <-
  declare_estimator(Y ~ Z, .method = difference_in_means, inquiry = "ATE")

# Declaracion
######################
declaration_2.1 <- model + inquiry + data_strategy + answer_strategy
data<-draw_data(declaration_2.1)
data

# Notar la diferencia
mean(data$Y_Z_1) - mean(data$Y_Z_0)
summary(lm(Y~Z,data=data))
mean(data$Y[data$Z==1]) - mean(data$Y[data$Z==0])

# Diagnostico 1
######################
diagnose_design(declaration_2.1,sims=100)

# Diagnostico 2
########################
program_diagnosands  <- 
  declare_diagnosands(
    success = mean(estimate > 0.10 & p.value < 0.05 & estimand > 0.10)
  )

declaration_2.1 |> 
diagnose_design(diagnosands=program_diagnosands,sims=100)






