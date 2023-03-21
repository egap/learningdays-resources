

library(randomizr)
library(readxl)
library(writexl)
library(dplyr)

# read in data on the set of participants that will be the subjects in the experiment
participants <- read_excel("participants_list.xlsx")

# set "randomization seed" so that each time you run this code you get the same result
set.seed(42)

# randomize using the randomizr package function block_ra, set the probability of treatment to be 50% within each block
participants <- 
  participants |> 
  mutate(treatment = block_ra(blocks = Gender, prob = 0.5))

# confirm balance across blocking covariate
participants |> count(Gender, treatment)

participants |> group_by(treatment) |> summarize(mean_female = mean(Gender == "F"))

# save the data to implement the experiment
write_xlsx(participants, path = "participants_with_randomization.xlsx")
