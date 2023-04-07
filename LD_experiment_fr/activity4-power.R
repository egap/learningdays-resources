# One of the most important choices in designing an experiment is the sample size.
# L'un des choix les plus importants dans la conception d'une expérience est la taille de l'échantillon.

# To decide on a sample size, we want to know how likely it is that we will be able to detect an effect if there is one.
# That's the task of power analysis. 
# In this exercise, we will explore how the power changes with key inputs to the power analysis to get a feeling for what affects power and also what we need to know before we start the power analysis.

# Pour décider d'une taille d'échantillon, nous voulons savoir quelle est la probabilité que nous puissions détecter un effet s'il y en a un.
# C'est l'analyse de puissance.
# Dans cet exercice, nous explorerons comment la puissance change avec les entrées clés pour avoir une idée de ce qui affecte la puissance et aussi ce que nous devons savoir avant de commencer l'analyse de puissance.

# === 
# Exercise 1:
# calculate the statistical power using the EGAP power calculator
# calculer la puissance statistique à l'aide du calculateur de puissance EGAP
#
# Go to the EGAP Power Calculator, accédez au calculateur de puissance EGAP - https://egap.shinyapps.io/power-app
# 
# You have four options in the calculator, which we'll explain now:
# 1. Significance level. This is usually left at the standard value of 0.05 (which is related to the choice of a 95% confidence interval)
# 2. Treatment effect size. What effect size do you *expect*? This is a guess! But it can be an educated guess based on past studies. Often it's useful to think conservatively (i.e., smaller magnitude that what from past studies or what you hope for). 
# 3. Standard deviation of the outcome variable. Think about the control group and ask what is the standard deviation of your outcome? This is a measure of the variability of the outcome. An normally-distributed outcome with a mean of zero a standard deviation of 5 will often have values as large as -10 and 10. But one with a standard deviation of 1 will typically have values between only -4 and 4. What will it be? This also a guess. This matters because the power is related to both the treatment effect size and the standard deviation. If the standard deviation is small, it is easier to detect any treatment effect all else equal. If it's larger, you might only be able to detect a large effect size. 
# 4. Power target. This is like the significance level, it's typically fixed, so you can leave it at 80%, which means that you want to have an 80% probability of detecting a true effect. 
# 5. Maximum number of subjects. This is just defining how wide the x-axis on the graph is.
#
# Vous avez quatre options dans le calculateur, que nous allons vous expliquer maintenant:
# 1. Niveau de significance. Ceci est généralement laissé à la valeur standard de 0,05 (qui est liée au choix d'un intervalle de confiance à 95%).
# 2. Taille de l'effet du traitement. Quelle taille d'effet *attendez-vous*? C'est une supposition! Mais cela peut être une supposition éclairée basée sur des études antérieures. Il est souvent utile de penser de manière conservatrice (c'est-à-dire une taille d'effet plus petite que celle des études antérieures ou de ce que vous espérez).
# 3. Écart type de la variable de résultat. Pensez au groupe de contrôle et demandez vous quel est l'écart type de votre résultat? Il s'agit d'une mesure de la variabilité du résultat. Un résultat normalement distribué avec une moyenne de zéro et un écart type de 5 aura souvent des valeurs aussi grandes que -10 et 10. Mais un résultat avec un écart type de 1 aura généralement des valeurs entre seulement -4 et 4. Ceci aussi une supposition. Cela est important car la puissance est liée à la fois à la taille de l'effet du traitement et à l'écart type. Si l'écart type est faible, il est plus facile de détecter un effet de traitement toutes choses égales par ailleurs. S'il est plus grand, vous ne pourrez peut-être détecter qu'une grande taille d'effet.
# 4. Cible de puissance. C'est comme le niveau de significance, elle est généralement fixe, vous pouvez donc la laisser à 80 %, ce qui signifie que vous voulez avoir une probabilité de 80 % de détecter un véritable effet.
# 5. Nombre maximum de sujets. Il s'agit simplement de définir la largeur de l'axe des x sur le graphique.

# Question: Imagine you expect an effect size of 1 on an outcome with a standard deviation in the control group of 1. What power would you have if the sample size was 100? What about 500?
# Question: Imaginez que vous vous attendiez à une taille d'effet de 1 sur un résultat avec un écart type dans le groupe de contrôle de 1. Quelle puissance auriez-vous si la taille de l'échantillon était de 100? de 500?

# Answer / Réponse:


# === 
# Exercise 2:
# does power increase if you increase the expected effect size?
# la puissance augmente-t-elle si vous augmentez la taille d'effet attendue ?

# Change the effect size to be double what you started with. Question: what is the power now for a sample size of 100? What about 500? Did these numbers increase or decrease?
# Modifiez la taille de l'effet pour le doubler. Question: quelle est la puissance actuelle pour un échantillon de 100? de 500? Ces chiffres ont-ils augmenté ou diminué?

# Answer / Réponse:

# Question: Is it possible to change the expected effect size in this way in your experiment?
# Question: Est-il possible de modifier la taille de l'effet attendu de cette manière dans votre expérience?

# Answer/ Réponse:

# === 
# Exercise 3:
# does power increase if you increase the standard deviation of the outcome?
# la puissance augmente-t-elle si vous augmentez l'écart type du résultat?

# Now change the standard deviation of the outcome to be double the original size. Question: what is the power now for a sample size of 100? What about 500? Did these numbers increase or decrease?
# Modifiez maintenant l'écart type du résultat pour le doubler. Question: quelle est la puissance actuelle pour un échantillon de 100? de 500? Ces chiffres ont-ils augmenté ou diminué?

# Answer / Réponse:


# === 
# Exercise 4:
# what is the minimum detectable effect size?
# quelle est la taille minimale d'un effet détectable ?

# Take a look at the graph, and find where the blue curve crosses the red line. That point is the smallest sample size (x axis) where there is at least 80% power (y axis), which is the threshold we set in the options.
# Now we want to reverse the question: we want to know what is the smallest *effect size* that we can detect when the sample size is fixed at a sample size of 500.
# To find this, you will have to change the effect size around several times to find the *smallest* effect size number you select where the place where the blue line (power) crosses the threshold of 80% power is at a sample size of 500.
# It may be easier if you change the maximum number of subjects to 1000 to make things easier to see.
# Jetez un œil au graphique et trouvez où la courbe bleue croise la ligne rouge. Ce point est la plus petite taille d'échantillon (axe x) où il y a au moins 80% de puissance (axe y), c'est le seuil que nous avons défini dans les options.
# Maintenant, nous voulons inverser la question: nous voulons savoir quelle est la plus petite *taille d'effet* que nous pouvons détecter lorsque la taille de l'échantillon est fixée à une taille d'échantillon de 500.
# Pour le trouver, vous devrez modifier la taille de l'effet plusieurs fois pour trouver la *plus petite* taille d'effet pour que l'endroit où la ligne bleue (puissance) franchit le seuil de 80% de puissance est à une taille d'échantillon de 500.
# Cela peut être plus facile si vous modifiez le nombre maximum de sujets à 1000 pour rendre les choses plus faciles à voir.

# Question: what is the smallest effect size detectable for N = 500?
# Question : quelle est la plus petite taille d'effet détectable pour N = 500 ?

# Answer / Réponse:

