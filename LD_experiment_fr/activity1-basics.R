
# Welcome to R! In this first activity, we will help you get a flavor of basic data analysis in R.
# Goals: learn how to load data, inspect data to see what variables there are, and to conduct basic data summaries

# Let's get started! C'est parti!

# <- this is a comment in the code, starting with a #. We'll use these to provide instructions. 

# === 
# Exercise 1: download the data

# First, you need to download the data. Follow the instructions from the instructors to place the .csv file in the directory where your R project is. You should see a file called "learningdays.Rproj" in the folder where you put the data.

# Let's check if things are working: is the data in the folder where it should be?
# To do this, you can use the dir() function. 
# (A function is an R command. When you run a function, you provide inputs (sometimes none) and R does something and returns outputs.)
# The dir() function takes no inputs (that's why there is nothing inside the parentheses) and returns a list of the files in the *current folder/directory*.

# In the exercises, starting with the line below, to run a command you can put your cursor on the line of code and press CTRL+ENTER (Windows) or COMMAND+ENTER (Mac)
# You can also copy-paste the line of code into the "Console". The console is in another part of the screen from this code (ask an instructor if you can't find it).
dir()

# Question 1: is the data file you downloaded in the list that the function returned? If not, please consult an instructor. 

# Answer: 

# ===
# Exercise 2: read in the data

# With the packages loaded, we can now read in the data. That means R will read the file and then add it as an object to your "workspace" where we can analyze it.
# We can do this via the read_csv function, which takes a filename you provide and reads that file and creates an R data object, called a data frame.

experiment_data <- read.csv("data_for_analysis.csv")

# Question: find the "environment" tab in your RStudio window. Ask for help from an instructor or someone next to you if you don't see it. Does the object called experiment_data show up under environment?

# Answer: 

# Now to step back for one moment to explain what we just did. There were three parts to what we typed: the function call -- read_csv("data_for_analysis.csv") -- which runs the read_csv function. Then there was <- which is how we give that object a name and save it. The third part is the name. So when you read that line of code, we're going to read in the data from the file data_for_analysis.csv and save it to the object named experiment_data.

# ===
# Exercise 3: inspect the data

# Take a moment to look at the data itself. To do this, find the Environment tab and click once on the object experiment_data. That brings up the "data viewer." This is always a good place to start to see what's in the data.

# Question: what are the variable names in the data?

# Answer: 

