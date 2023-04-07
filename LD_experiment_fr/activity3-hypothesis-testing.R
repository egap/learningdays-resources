# So you randomly-assigned a treatment and collected outcome measures. 
# How do you estimate the treatment effect?
# Vous avez attribué un traitement au hasard et collecté des mesures de résultats.
# Comment estimez-vous l'effet du traitement ?

# In this exercise, we will calculate our estimate of the average treatment effect.
# This is the first step toward conducting a hypothesis test, for example about
#   whether the treatment effect is distinguishable from zero.
# Dans cet exercice, nous calculerons notre estimation de l'effet moyen du traitement.
# Il s'agit de la première étape vers la réalisation d'un test d'hypothèse, par exemple savoir
# si l'effet du traitement est différent de zéro.

# ===
# Exercice 1 :


# === 
# Exercise 1:
# load the tidyverse package and the data from the last session
# You can use exactly the same code you used from the other exercise
# charger le package tidyverse et les données de la dernière session
# Vous pouvez utiliser exactement le même code que vous avez utilisé dans l'autre exercice

# Your code here, Votre code ici:

experiment_data <- read.csv("data_for_analysis.csv")

# === 
# Exercise 2:
# calculate the difference-in-means in the experiment
# calculer la différence de moyennes dans l'expérience

# Step 1: What is the name of the outcome variable? What is the name of the treatment variable?
# Inspect the data and work out what the variable names are.
# Étape 1: Quel est le nom de la variable de résultat? Quel est le nom de la variable de traitement?
# Inspectez les données et déterminez les noms des variables.

# Answer / Réponse:

# Step 2: calculate the mean outcome overall, to get yourself started
# Étape 2: calculez le résultat moyen global, pour commencer

mean(experiment_data$`NAME OF OUTCOME VARIABLE HERE`, na.rm = TRUE)

# There's a few parts of that command. First, there's the function mean(), which calculates, as you might have guessed, the average.
# The first argument you put in is the variable itself. To call a variable, as we did in activity 2, we need to say dataframename$variablename.
# Here the data frame name is experiment_data, and the variable name comes after the $. There's one more option here: na.rm.
# That means we want to remove any missing values. If someone forgets to fill out the outcome, we don't have any information for them.
# This turns out to be a problem! We can't learn what the treatment effect is if we don't know how some of the units respond to treatment.
# For now, we're going to remove these folks -- na.rm means remove NAs; NA is one way of saying a missing value.

# Il y a plusieurs parties dans cette commande. Premièrement, il y a la fonction mean(), qui calcule, comme vous l'avez peut-être deviné, la moyenne.
# Le premier argument que vous mettez est la variable elle-même. Pour appeler une variable, comme nous l'avons fait dans l'activité 2, nous devons dire dataframename$variablename.
# Ici, le nom du dataframe est experiment_data et le nom de la variable vient après le $. Il y a une autre option ici : na.rm.
# Cela signifie que nous voulons supprimer toutes les valeurs manquantes. Si quelqu'un oublie de remplir le résultat, nous n'avons aucune information pour lui.
# Cela s'avère être un problème! Nous ne pouvons pas savoir quel est l'effet du traitement si nous ne savons pas comment certaines des unités réagissent au traitement.
# Pour l'instant, nous allons supprimer ces personnes -- na.rm signifie supprimer les NA ; NA est une façon de dire une valeur manquante.

# Step 3: calculate the mean in the treatment group
# Next we'll get down to calculating the difference in means, which consists of two numbers: the mean outcome in treatment and the mean outcome in control.
# To calculate the mean outcome in treatment, we use the same command as in Step 2 but we do so for a *subset* of the data, in this case the treatment group.
# Replace the variable names and also the value for treatment. If you don't know which value represents treatment, go back to inspect the data and see what values it takes. 

# Étape 3 : calculer la moyenne dans le groupe de traitement
# Ensuite, nous nous attarderons sur le calcul de la différence de moyennes, qui se compose de deux nombres : le résultat moyen dans le groupe de traitement et le résultat moyen dans le groupe de contrôle.
# Pour calculer le résultat moyen du traitement, nous utilisons la même commande qu'à l'étape 2, mais nous le faisons pour un *sous-ensemble* des données, dans ce cas le groupe de traitement.
# Remplacez les noms des variables ainsi que la valeur pour le traitement. Si vous ne savez pas quelle valeur représente le traitement, revenez en arrière pour inspecter les données et voir quelles valeurs elles prennent.

mean(experiment_data$`NAME OF OUTCOME VARIABLE HERE`[experiment_data$`TREATMENT VARIABLE NAME` == VALUE], na.rm = TRUE)


# Step 4: Do the same but for the control group
# Etape 4 : Faites de même mais pour le groupe contrôle

# Step 5: Subtract the two numbers.
# That difference is the estimated treatment effect
# Étape 5 : Soustrayez les deux nombres.
# Cette différence est l'effet estimé du traitement

# Step 6: Interpret the result. 
# Look at the possible values of the outcome variable. 
# Now compare the estimated treatment effect to that scale. Does this seem to be a large or small difference?
# Étape 6 : Interprétez le résultat.
# Regardez les valeurs possibles de la variable de résultat.
# Comparez maintenant l'effet estimé du traitement à cette échelle. Cela semble-t-il être une grande ou une petite différence?

# Answer / Réponse: