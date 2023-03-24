# We will now explore several different estimation procedures. 

# Here, we're going to prove to ourselves that different answer strategies yield different *answers*. 

# As we learned in the estimation lecture, what answer strategy is the "best" depends on the *data strategy*. 
# Now we will reinforce the idea that these choices matter, and change what answer you get.

# === 
# Exercise 1: load the data from the first session
# You can use exactly the same code you used from the other exercise

# Your code here:

experiment_data <- read.csv("data_for_analysis.csv")

# === 
# Exercise 2: analyze as if complete randomization was chosen

# Step 1: first load the estimatr package

library(estimatr)

# Step 2: analyze using the lm_robust function, which runs a difference-in-means for you and calculates standard errors

difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, data = experiment_data)

# Step 3: compare to your difference-in-means estimate from hypothesis testing. 

# Question: do you get the same number? If not, check with your instructor.

# Answer: 

# Step 4: now analyze as if it is a blocked experiment

difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, blocks = Gender, data = experiment_data)

# Question: do you get the same answer in the Estimate column and the Std. Error column? 

# Answer: 

# Remember, you should choose based on your data strategy!