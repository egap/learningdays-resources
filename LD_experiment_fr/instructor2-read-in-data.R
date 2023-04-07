
library(dplyr)
library(readxl)
library(writexl)
library(readr)

treatment_responses <- read_excel("treatment_responses.xlsx")
control_responses <- read_excel("control_responses.xlsx")

responses <- 
  bind_rows(
    `treatment` = treatment_responses,
    `control` = control_responses,
    .id = "treatment_received"
  ) |> 
  rename(
    Name = `What is your name?`,
    state_of_world = `On a scale of 1-10 (1 being lowest, 10 being highest), how do you feel about the state of the world?`
  )

participants <- read_excel("participants_with_randomization.xlsx")

# join the responses to the participants list. if the names differ from the participants spreadsheet and the google form responses, you may have to manually munge
# Joint les réponses à la liste des participants. Si les noms sont différents entre l'Excel et le formulaire Google, vous devrez peut-être les ajuster manuellement.
responses <-
  participants |> 
  left_join(responses, by = "Name")

write_csv(responses, file = "data_for_analysis.csv")
