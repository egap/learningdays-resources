

library(randomizr)
library(readxl)
library(writexl)
library(dplyr)

# read in data on the set of participants that will be the subjects in the experiment
# Lit les données de l'ensemble des participants qui seront les sujets de l'expérience.
participants <- read_excel("participants_list.xlsx")

# set "randomization seed" so that each time you run this code you get the same result
# Définit la "graine de randomisation" pour que vous obteniez le même résultat chaque fois que vous exécutez ce code. .
set.seed(42)

# randomize using the randomizr package function block_ra, set the probability of treatment to be 50% within each block
# Randomise à l'aide de la fonction block_ra du package randomizr et définit la probabilité de traitement à 50% pour chaque bloc.
participants <- 
  participants |> 
  mutate(treatment = block_ra(blocks = Gender, prob = 0.5))

# confirm balance across blocking covariate
# Confirme l'équilibre par rapport aux covariables de bloc.
participants |> count(Gender, treatment)

participants |> group_by(treatment) |> summarize(mean_female = mean(Gender == "F"))

# save the data to implement the experiment
# Enregistre les données pour mettre en œuvre l'expérience
write_xlsx(participants, path = "participants_with_randomization.xlsx")
