# We will now explore several different estimation procedures. 
# Nous allons maintenant explorer différentes procédures d'estimation.

# Here, we're going to prove to ourselves that different answer strategies yield different *answers*.
# Ici, nous allons montrer que différentes stratégies d'estimation produisent des *réponses* différentes.

# As we learned in the estimation lecture, what answer strategy is the "best" depends on the *data strategy*. 
# Now we will reinforce the idea that these choices matter, and change what answer you get.
# Comme nous l'avons appris dans le cours sur l'estimation, la "meilleure" stratégie dépend de la stratégie de données.
# Maintenant, nous allons renforcer l'idée que ces choix importent et changent la réponse que vous obtenez.

# === 
# Exercise 1: load the data from the first session
# You can use exactly the same code you used from the other exercise
# Exercice 1: charger les données de la première session
# Vous pouvez utiliser exactement le même code que celui que vous avez utilisé pour l'autre exercice

# Your code here / votre code ici:

experiment_data <- read.csv("data_for_analysis.csv")

# === 
# Exercise 2: analyze as if complete randomization was chosen
# Exercise 2: analyser comme si une randomisation complète avait été choisie

# Step 1: first load the estimatr package
# Étape 1: d'abord, charger le package estimatr
library(estimatr)

# Step 2: analyze using the lm_robust function, which runs a difference-in-means for you and calculates standard errors
# Étape 2: analyser en utilisant la fonction lm_robust, qui exécute une différence des moyennes et calcule l'erreur type
difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, data = experiment_data)

# Step 3: compare to your difference-in-means estimate from hypothesis testing. 
# Étape 3: comparez à votre estimation de différence des moyennes à partir de l'activité "tests d'hypothèse".
# Question: do you get the same number? If not, check with your instructor.
# Question: Obtenez-vous le même nombre ? Si ce n'est pas le cas, vérifiez avec votre instructeur.

# Answer / Réponse:

# Step 4: now analyze as if it is a blocked experiment
# Étape 4: Analysez maintenant comme s'il s'agissait d'une expérience randomisée par bloc (ou stratifiée).

difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, blocks = Gender, data = experiment_data)

# Question: do you get the same answer in the Estimate column and the Std. Error column? 
# Question: obtenez-vous la même réponse dans la colonne "Estimate" et la colonne "Std. Error"?
# Answer / Réponse:

# Remember, you should choose based on your data strategy!
# N'oubliez pas, vous devez choisir en fonction de votre stratégie de données !
