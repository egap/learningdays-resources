# So you randomly-assigned a treatment and collected outcome measures. 
# How do you estimate the treatment effect?

# In this exercise, we will calculate our estimate of the average treatment effect.
# This is the first step toward conducting a hypothesis test, for example about
#   whether the treatment effect is distinguishable from zero.

# === 
# Exercise 1: load the tidyverse package and the data from the last session
# You can use exactly the same code you used from the other exercise

# Your code here:

experiment_data <- read.csv("data_for_analysis.csv")

# === 
# Exercise 2: calculate the difference-in-means in the experiment

# Step 1: What is the name of the outcome variable? What is the name of the treatment variable?
# Inspect the data and work out what the variable names are.

# Answer: 


# Step 2: calculate the mean outcome overall, to get yourself started

mean(experiment_data$`NAME OF OUTCOME VARIABLE HERE`, na.rm = TRUE)

# There's a few parts of that command. First, there's the function mean(), which calculates, as you might have guessed, the average. The first argument you put in is the variable itself. To call a variable, as we did in activity 2, we need to say dataframename$variablename. Here the data frame name is experiment_data, and the variable name comes after the $. There's one more option here: na.rm. That means we want to remove any missing values. If someone forgets to fill out the outcome, we don't have any information for them. This turns out to be a problem! We can't learn what the treatment effect is if we don't know how some of the units respond to treatment. For now, we're going to remove these folks -- na.rm means remove NAs; NA is one way of saying a missing value.

# Step 3: calculate the mean in the treatment group
# Next we'll get down to calculating the difference in means, which consists of two numbers: the mean outcome in treatment and the mean outcome in control.
# To calculate the mean outcome in treatment, we use the same command as in Step 2 but we do so for a *subset* of the data, in this case the treatment group.
# Replace the variable names and also the value for treatment. If you don't know which value represents treatment, go back to inspect the data and see what values it takes. 

mean(experiment_data$`NAME OF OUTCOME VARIABLE HERE`[experiment_data$`TREATMENT VARIABLE NAME` == VALUE], na.rm = TRUE)


# Step 4: Do the same but for the control group


# Step 5: Subtract the two numbers.
# That difference is the estimated treatment effect


# Step 6: Interpret the result. 
# Look at the possible values of the outcome variable. 
# Now compare the estimated treatment effect to that scale. Does this seem to be a large or small difference? 
# Answer: 