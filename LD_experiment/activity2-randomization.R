# We are going to explore *how* to randomize treatment, using the data on Learning Days participants we used yesterday.
# 
# In the experiment we conducted yesterday, the instructors randomized who got which treatment. 
# Today, you will do that step, exploring several different ways to do so.
# 
# In the lecture we talked about several different ways to randomize, useful in different experimental settings.
# In this exercise, you will try out most of them.

# === 
# Exercise 1: load the data from the last session
# You can use exactly the same code you used from the other exercise

# Your code here:

experiment_data <- read.csv("data_for_analysis.csv")

# === 
# Exercise 2: randomize participants into two treatment conditions using simple randomization
# In this first exercise, we will walk you through how to randomize in detail. You can then adapt this code to randomize in other ways later in the session.

# Before you start, set a seed. Again, this is so that you can always replicate the result of your randomization:

set.seed(YOU_CHOOSE_A_SEED_HERE)

# Now, we will take the experiment_data object, add a variable to it called treatment_simple, which will be a randomly-assigned treatment status randomized using simple randomization. Here's how:

experiment_data$treatment_simple <- rbinom(n = nrow(experiment_data), size = 1, prob = 0.5)

# Let's unpack what happened here. There are two parts, separated by <-. On the right starting with rbinom is what we're going to do -- randomize -- and on the left is where we are going to save the result. We always save the result to an "object." experiment_data is one object, which you inspected in the last exercise. The special thing we did here was that we saved the result not into experiment_data, but as a particular variable here representing the new randomization, and we called it treatment_simple. experiment_data$treatment_simple means the variable called treatment_simple within the data frame experiment_data. On the right-hand side, we use the rbinom *function*, which takes some inputs and then returns a binomial random variable. In this case we provided three inputs: the n, which is how many 0's and 1's we want; the size, which is that we want to take a draw of size 1 from the binomial distribution so it will be 0 and 1; and the probability of a 1 is 0.5 (the prob argument). To set the n argument, we used a handy function called nrow(), which calculates how many rows there are in a data frame. In this case, the number of 0's and 1's we wanted had to be the same as the number of rows in the data frame since each row is a respondent.

# To summarize: we used a function to randomly assign 0's and 1's representing treatment and control, and we saved those into a new variable. That new variable is what you would use to allocate treatment -- to say that one person gets treatment and another person gets control.

# === 
# Exercise 2: check your randomization
# After you randomly assign, you want to be sure it worked. Do a few checks. In this case, there should be approximately, but not necessarily exactly, half of subjects assigned to treatment.

# Part A: inspect the data, and check that there are some people with treatment and some with control. 

# Can you see the variable you created, treatment_simple? Are there some treated and some control? Answer: 

# Part B: Count the number of treated and control using the table function.

table(experiment_data$treatment_simple)

# How many are there in each group? Answer: 

# === 
# Exercise 3: randomize participants into two treatment conditions using complete randomization
# Now you'll do the same thing as Exercise 1, but you will use complete random assignment instead of simple random assignment.

# to do this, go back to the slides, and use the code you find there to set up the random assignment, which is slightly more complex than simple random assignment.
# here's a snippet to get you started, which helps with saving the data.
experiment_data$treatment_complete <-
  
# === 
# Exercise 4: check your complete randomization

# Part A: inspect the data, and check that there are some people with treatment and some with control. 

# Can you see the variable you created, treatment_complete? Are there some treated and some control? Answer: 

# Part B: Count the number of treated and control using the table function. There should be exactly the number of treated and control units as you set up in vec. 

table(experiment_data$treatment_complete)

# How many are there in each group? Is that how many you expected Answer: 

# === 
# Exercise 5: using randomizr to do complete random assignment
# Now we are going to learn how to use the randomizr package in R, which allows you to do many common forms of random assignment easily.

# Step 1: load the randomizr package -- exactly like you did for tidyverse but with randomizr instead of tidyverse

library(randomizr)

# Step 2: randomize using the function complete_ra

experiment_data$treatment_complete2 <- complete_ra(N = nrow(experiment_data), prob = 0.5)

# Step 3: check whether it worked using the same techniques you used above (inspect and use table)


# === 
# Exercise 6: using randomizr to do blocked random assignment
# Because you've now learned how to use randomizr, you can do more complex random assignment schemes more easily. Let's try block random assignment.
# As a reminder, blocked random assignment is where you take a set of blocks (also known as strata) and do mini-experiments within them. The blocks come from your data -- they might be variables representing gender or towns or a combination of multiple variables. We'll use the gender of participants here. In this case, block random assignment means that you will conduct two mini-experiments, one among women and one among men, but you'll do it all at once. 

# Step 1: identify the block variable. Inspect the data frame and find out what the name of the gender variable is. Note variables are "case sensitive", meaning if there are capital letters that's important to remember.

# What is the variable named? Answer: 

# Step 2: Randomize. To do this, you'll use the function block_ra, and the difference from block_ra and complete_ra is you have to tell it what the block variable is. You won't need to tell it the N any more, because the software can figure that out from the block variable.

experiment_data$treatment_blocked <- block_ra(blocks = ??, prob = 0.5)

# Step 3: check the data using inspect and table. 

# Are approximately the same number *within each block* treated? As in, are the same number of men treated as the number of women who are treated? (Note if there are odd numbers, of course it won't be exactly equal.) Answer: 

