# We are going to explore *how* to randomize treatment, using the data on Learning Days participants we used yesterday.
# Nous allons explorer *comment* randomiser le traitement, en utilisant les données sur les participants aux Learning Days que nous avons utilisées hier.
#
# In the experiment we conducted yesterday, the instructors randomized who got which treatment. 
# Today, you will do that step, exploring several different ways to do so.
# Dans l'expérience que nous avons menée hier, les instructeurs ont randomisé qui a reçu quel traitement.
# Aujourd'hui, vous rejouerez cette étape, en explorant plusieurs façons différentes de le faire.
#
# In the lecture we talked about several different ways to randomize, useful in different experimental settings.
# In this exercise, you will try out most of them.
# Dans le cours, nous avons parlé de plusieurs façons différentes de randomiser, utiles dans différents contextes expérimentaux.
# Dans cet exercice, vous en testerez la plupart.

# === 
# Exercise 1:
# load the data from the last session
# You can use exactly the same code you used from the other exercise
# charger les données de la dernière session
# Vous pouvez utiliser exactement le même code que vous avez utilisé dans l'autre exercice

# Your code here / Votre code ici:

experiment_data <- read.csv("data_for_analysis.csv")

# === 
# Exercise 2:
# randomize participants into two treatment conditions using simple randomization
# In this first exercise, we will walk you through how to randomize in detail. You can then adapt this code to randomize in other ways later in the session.
# randomiser les participants dans deux conditions de traitement en utilisant une randomisation simple
# Dans ce premier exercice, nous vous expliquerons en détail comment randomiser. Vous pouvez ensuite adapter ce code pour randomiser d'autres manières plus tard dans la session.

# Before you start, set a seed. Again, this is so that you can always replicate the result of your randomization:
# Avant de commencer, définissez une graine. Rappel, c'est pour que vous puissiez toujours reproduire le résultat de votre randomisation:

set.seed(YOU_CHOOSE_A_SEED_HERE)

# Now, we will take the experiment_data object, add a variable to it called treatment_simple, which will be a randomly-assigned treatment status randomized using simple randomization. Here's how:
# nous allons prendre l'objet experiment_data, y ajouter une variable appelée treatment_simple, qui sera un statut de traitement attribué de manière aléatoire et randomisé à l'aide d'une randomisation simple. 
experiment_data$treatment_simple <- rbinom(n = nrow(experiment_data), size = 1, prob = 0.5)

# Let's unpack what happened here. There are two parts, separated by <-. On the right starting with rbinom is what we're going to do -- randomize -- and on the left is where we are going to save the result. We always save the result to an "object." experiment_data is one object, which you inspected in the last exercise. The special thing we did here was that we saved the result not into experiment_data, but as a particular variable here representing the new randomization, and we called it treatment_simple.
# experiment_data$treatment_simple means the variable called treatment_simple within the data frame experiment_data. On the right-hand side, we use the rbinom *function*, which takes some inputs and then returns a binomial random variable. In this case we provided three inputs: the n, which is how many 0's and 1's we want; the size, which is that we want to take a draw of size 1 from the binomial distribution so it will be 0 and 1; and the probability of a 1 is 0.5 (the prob argument).
# To set the n argument, we used a handy function called nrow(), which calculates how many rows there are in a data frame. In this case, the number of 0's and 1's we wanted had to be the same as the number of rows in the data frame since each row is a respondent.
# Détaillons ce qui s'est passé. Il y a deux parties, séparées par <-. Sur la droite en commençant par rbinom se trouve ce que nous allons faire -- randomiser -- et sur la gauche se trouve l'endroit où nous allons enregistrer le résultat. Nous enregistrons toujours le résultat dans un "objet". experiment_data est un objet que vous avez inspecté dans le dernier exercice. La particularité que nous avons faite ici est que nous avons enregistré le résultat non pas dans experiment_data, mais en tant que variable particulière représentant ici la nouvelle randomisation, et nous l'avons appelée treatment_simple.
# experiment_data$treatment_simple désigne la variable appelée treatment_simple dans le dataframe experiment_data. Sur le côté droit, nous utilisons la *fonction* rbinom, qui prend quelques entrées et renvoie ensuite une variable aléatoire binomiale. Dans ce cas, nous avons fourni trois entrées: le n, qui correspond au nombre de 0 et de 1 que nous voulons; la taille, c'est-à-dire que nous voulons tirer un tirage de taille 1 de la distribution binomiale; et la probabilité d'un 1 est de 0,5 (l'argument prob).
# Pour définir l'argument n, nous avons utilisé une fonction pratique appelée nrow(), qui calcule le nombre de lignes dans un dataframe. Dans ce cas, le nombre de 0 et de 1 que nous voulions devait être le même que le nombre de lignes dans le dataframe puisque chaque ligne est un répondant.

# To summarize: we used a function to randomly assign 0's and 1's representing treatment and control, and we saved those into a new variable. That new variable is what you would use to allocate treatment -- to say that one person gets treatment and another person gets control.
# Pour résumer: nous avons utilisé une fonction pour attribuer au hasard des 0 et des 1 représentant le traitement et le contrôle, et nous les avons enregistrés dans une nouvelle variable. Cette nouvelle variable est ce que vous utiliseriez pour assigner le traitement -- pour dire qu'une personne reçoit le traitement et qu'une autre personne reçoit le contrôle.


# === 
# Exercise 2:
# check your randomization
# After you randomly assign, you want to be sure it worked. Do a few checks. In this case, there should be approximately, but not necessarily exactly, half of subjects assigned to treatment.
# vérifiez votre randomisation
# Après avoir assigné au hasard, vous voulez être sûr que cela a fonctionné. Faites quelques vérifications. Dans ce cas, il devrait y avoir environ, mais pas nécessairement exactement, la moitié des sujets affectés au traitement.

# Part A:
# inspect the data, and check that there are some people with treatment and some with control.
# inspectez les données et vérifiez qu'il y a des personnes sous traitement et d'autres sous contrôle.

# Can you see the variable you created, treatment_simple? Are there some treated and some control? Answer: 
# Pouvez-vous voir la variable que vous avez créée, treatment_simple? Y a-t-il des unités dans les groupes de traitement et des contrôle ? Réponse:

# Part B:
# Count the number of treated and control using the table function.
# Comptez le nombre d'unités traitées et de contrôle à l'aide de la fonction "table".

table(experiment_data$treatment_simple)

# How many are there in each group? Answer: 
# Combien y en a-t-il dans chaque groupe ? Réponse:

# === 
# Exercise 3:
# randomize participants into two treatment conditions using complete randomization
# Now you'll do the same thing as Exercise 1, but you will use complete random assignment instead of simple random assignment.
# randomiser les participants dans deux conditions de traitement en utilisant une randomisation complète
# Maintenant, vous allez faire la même chose qu'à l'exercice 1, mais vous utiliserez l'assignation aléatoire complète au lieu de l'assignation aléatoire simple.

# to do this, go back to the slides, and use the code you find there to set up the random assignment, which is slightly more complex than simple random assignment.
# here's a snippet to get you started, which helps with saving the data.
# pour ce faire, revenez aux slides et utilisez le code que vous y trouvez pour configurer l'assignation aléatoire, qui est légèrement plus complexe que l'assignation aléatoire simple.
# voici un extrait pour vous aider à démarrer, ce qui aide à enregistrer les données.

experiment_data$treatment_complete <-
  
# === 
# Exercise 4:
# check your complete randomization
# vérifiez votre randomisation complète

# Part A:
# inspect the data, and check that there are some people with treatment and some with control.
# inspectez les données et vérifiez qu'il y a des personnes sous traitement et d'autres sous contrôle.


# Can you see the variable you created, treatment_complete? Are there some treated and some control? Answer:
# Pouvez-vous voir la variable que vous avez créée, treatment_complete? Y a-t-il des unités de traitement et de contrôle? Réponse:

# Part B:
# Count the number of treated and control using the table function. There should be exactly the number of treated and control units as you set up in vec.
# Comptez le nombre d'unités de traitement et de contrôle à l'aide de la fonction "table". Il devrait y avoir exactement le nombre d'unités traitées et de contrôle que ce que vous avez configuré dans vec.

table(experiment_data$treatment_complete)

# How many are there in each group? Is that how many you expected? Answer:
# Combien y en a-t-il dans chaque groupe ? Qu'attendiez-vous ? Réponse:

# === 
# Exercise 5:
# using randomizr to do complete random assignment
# Now we are going to learn how to use the randomizr package in R, which allows you to do many common forms of random assignment easily.
# utiliser randomizr pour effectuer une assignation aléatoire complète
# Nous allons maintenant apprendre à utiliser le package randomizr dans R, qui vous permet d'effectuer facilement de nombreuses formes courantes d'assignation aléatoire.

# Step 1: load the randomizr package -- exactly like you did for tidyverse but with randomizr instead of tidyverse
# Étape 1: chargez le paquet randomizr -- exactement comme vous l'avez fait pour tidyverse mais avec randomizr au lieu de tidyverse

library(randomizr)

# Step 2: randomize using the function complete_ra
# Étape 2: randomiser à l'aide de la fonction complete_ra
experiment_data$treatment_complete2 <- complete_ra(N = nrow(experiment_data), prob = 0.5)

# Step 3: check whether it worked using the same techniques you used above (inspect and use table)
# Étape 3 : vérifiez si cela a fonctionné en utilisant les mêmes techniques que vous avez utilisées ci-dessus (inspectez et utilisez "table")

# === 
# Exercise 6: 
# using randomizr to do blocked random assignment
# Because you've now learned how to use randomizr, you can do more complex random assignment schemes more easily. Let's try block random assignment.
# As a reminder, blocked random assignment is where you take a set of blocks (also known as strata) and do mini-experiments within them. The blocks come from your data -- they might be variables representing gender or towns or a combination of multiple variables. We'll use the gender of participants here. In this case, block random assignment means that you will conduct two mini-experiments, one among women and one among men, but you'll do it all at once. 
# utiliser randomizr pour faire une assignation aléatoire bloquée
# Parce que vous avez maintenant appris à utiliser randomizr, vous pouvez faire plus facilement des schémas d'assignation aléatoire plus complexes. Essayons l'assignation aléatoire par bloc.
# Rappel, l'assignation aléatoire par bloc consiste à prendre un ensemble de blocs (également appelés strates) et à y faire des mini-expériences. Les blocs proviennent de vos données: il peut s'agir de variables représentant le sexe ou la ville, ou d'une combinaison de plusieurs variables. Nous utiliserons ici le sexe des participants. Dans ce cas, l'assignation aléatoire par bloc signifie que vous allez mener deux mini-expériences, une chez les femmes et une chez les hommes, mais vous allez tout faire en même temps.

# Step 1: identify the block variable. Inspect the data frame and find out what the name of the gender variable is. Note variables are "case sensitive", meaning if there are capital letters that's important to remember.
# Etape 1: identifiez la variable de bloc. Inspectez le data frame et trouvez le nom de la variable de genre. Les variables sont "sensibles à la casse", ce qui signifie qu'il faut se souvenir des majuscules.

# What is the variable named? Answer: 
# Quelle est la variable nommée? Réponse:

# Step 2: Randomize. To do this, you'll use the function block_ra, and the difference between block_ra and complete_ra is you have to tell block_ra what the block variable is. You won't need to tell it the N any more, because the software can figure that out from the block variable.
# Étape 2: Randomiser. Pour ce faire, vous utiliserez la fonction block_ra, et la différence entre block_ra et complete_ra est que vous devez lui dire quelle est la variable de bloc. Vous n'aurez plus besoin de lui dire le N, car le logiciel peut le comprendre à partir de la variable de bloc.

experiment_data$treatment_blocked <- block_ra(blocks = ??, prob = 0.5)

# Step 3: check the data using inspect and table. 
# Étape 3 : vérifiez les données en utilisant inspect et table.

# Are approximately the same number *within each block* treated? As in, are the same number of men treated as the number of women who are treated? (Note if there are odd numbers, of course it won't be exactly equal.) Answer: 
# Est-ce qu'environ le même nombre *dans chaque bloc* est traité? Comme dans, y a-t-il le même nombre d'hommes traités que le nombre de femmes qui sont traitées? (Notez que s'il y a des nombres impairs, bien sûr, ils ne seront pas exactement égaux.) Réponse:
