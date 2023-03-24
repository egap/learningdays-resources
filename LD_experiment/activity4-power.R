# One of the most important choices in designing an experiment is the sample size.

# To decide on a sample size, we want to know how likely it is that we will be able to detect an effect if there is one.
# That's the task of power analysis. 
# In this exercise, we will explore how the power changes with key inputs to the power analysis to get a feeling for what affects power and also what we need to know before we start the power analysis.

# === 
# Exercise 1: calculate the statistical power using the EGAP power calculator
# 
# Go to the EGAP Power Calculator - https://egap.shinyapps.io/power-app
# 
# You have four options in the calculator, which we'll explain now:
# 1. Significance level. This is usually left at the standard value of 0.05 (which is related to the choice of a 95% confidence interval)
# 2. Treatment effect size. What effect size do you *expect*? This is a guess! But it can be an educated guess based on past studies. Often it's useful to think conservatively (i.e., smaller magnitude that what from past studies or what you hope for). 
# 3. Standard deviation of the outcome variable. Think about the control group and ask what is the standard deviation of your outcome? This is a measure of the variability of the outcome. An normally-distributed outcome with a mean of zero a standard deviation of 5 will often have values as large as -10 and 10. But one with a standard deviation of 1 will typically have values between only -4 and 4. What will it be? This also a guess. This matters because the power is related to both the treatment effect size and the standard deviation. If the standard deviation is small, it is easier to detect any treatment effect all else equal. If it's larger, you might only be able to detect a large effect size. 
# 4. Power target. This is like the significance level, it's typically fixed, so you can leave it at 80%, which means that you want to have an 80% probability of detecting a true effect. 
# 5. Maximum number of subjects. This is just defining how wide the x-axis on the graph is.

# Question: Imagine you expect an effect size of 1 on an outcome with a standard deviation in the control group of 1. What power would you have if the sample size was 100? What about 500?

# Answer: 

# === 
# Exercise 2: does power increase if you increase the expected effect size?

# Change the effect size to be double what you started with. Question: what is the power now for a sample size of 100? What about 500? Did these numbers increase or decrease?

# Answer:

# Question: Is it possible to change the expected effect size in this way in your experiment?

# Answer:

# === 
# Exercise 3: does power increase if you increase the standard deviation of the outcome?

# Now change the standard deviation of the outcome to be double the original size. Question: what is the power now for a sample size of 100? What about 500? Did these numbers increase or decrease?

# Answer:


# === 
# Exercise 4: what is the minimum detectable effect size?

# Take a look at the graph, and find where the blue curve crosses the red line. That point is the smallest sample size (x axis) where there is at least 80% power (y axis), which is the threshold we set in the options. Now we want to reverse the question: we want to know what is the smallest *effect size* that we can detect when the sample size is fixed at a sample size of 500. To find this, you will have to change the effect size around several times to find the *smallest* effect size number you select where the place where the blue line (power) crosses the threshold of 80% power is at a sample size of 500. It may be easier if you change the maximum number of subjects to 1000 to make things easier to see.

# Question: what is the smallest effect size detectable for N = 500?

# Answer: 

