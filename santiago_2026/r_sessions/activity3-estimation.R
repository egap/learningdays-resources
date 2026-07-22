# =========================
# English: Activity 3: Estimation
# Français: Activité 3: L'estimation
# Español: Actividad 3: Estimación
# Português: Atividade 3: Estimação
# =========================

# English: So you randomly-assigned a treatment and collected outcome measures.
# How do you estimate the treatment effect?

# Français: Vous avez attribué un traitement au hasard et collecté des mesures de résultats.
# Comment estimez-vous l'effet du traitement ?

# Español: Asignaste un tratamiento al azar y recopilaste medidas de resultado.
# ¿Cómo estimas el efecto del tratamiento?

# Português: Você atribuiu um tratamento aleatoriamente e coletou medidas de resultado.
# Como você estima o efeito do tratamento?

# English: In this exercise, we will calculate our estimate of the average treatment effect.
# This is the first step toward conducting a hypothesis test, for example about
# whether the treatment effect is distinguishable from zero.

# Français: Dans cet exercice, nous calculerons notre estimation de l'effet moyen du traitement.
# Il s'agit de la première étape vers la réalisation d'un test d'hypothèse, par exemple savoir
# si l'effet du traitement est différent de zéro.

# Español: En este ejercicio, calcularemos nuestra estimación del efecto promedio del tratamiento.
# Este es el primer paso para realizar una prueba de hipótesis, por ejemplo, sobre
# si el efecto del tratamiento es distinguible de cero.

# Português: Neste exercício, calcularemos nossa estimativa do efeito médio do tratamento.
# Este é o primeiro passo para realizar um teste de hipótese, por exemplo, sobre
# se o efeito do tratamento é diferente de zero.

# ===================================================================
# English: Exercise 1: Load the tidyverse package and the data from the last session
# You can use the same code you used from the other exercises

# Français: Exercice 1 : Chargez le package tidyverse et les données de la dernière session
# Vous pouvez utiliser le même code que vous avez utilisé dans les autre exercices

# Español: Ejercicio 1: Cargue el paquete tidyverse y los datos de la última sesión.
# Puede usar el mismo código que usó en los otros ejercicios.

# Português: Exercício 1: Carregue o pacote tidyverse e os dados da última sessão.
# Você pode usar o mesmo código que usou nos outros exercícios.
# ===================================================================

# English: Your code here:
# Français: Votre code ici:
# Español: Tu código aquí:
# Português: Seu código aqui:

experiment_data <- read.csv("data_for_analysis.csv")


# ===================================================================
# English: Exercise 2: Calculate the difference-in-means in the experiment
# Français: Exercice 2 : Calculez la différence de moyennes dans l'expérience
# Español: Ejercicio 2: Calcule la diferencia en medias en el experimento.
# Português: Exercício 2: Calcule a diferença nas médias no experimento.
# ===================================================================

# English: Step 1: What is the name of the outcome variable? What is the name of the treatment variable?
# Inspect the data and work out what the variable names are.

# Français: Étape 1: Quel est le nom de la variable de résultat? Quel est le nom de la variable de traitement?
# Inspectez les données et déterminez les noms des variables.

# Español: Paso 1: ¿Cuál es el nombre de la variable de resultado? ¿Cuál es el nombre de la variable de tratamiento?
# Inspeccione los datos y averigüe cuáles son los nombres de las variables.

# Português: Etapa 1: Qual é o nome da variável de resultado? Qual é o nome da variável de tratamento?
# Inspeccione os dados e descubra quais são os nomes das variáveis.

# English: Answer:
# Français: Réponse:
# Español: Respuesta:
# Português: Resposta:

# English: Step 2: Calculate the mean outcome overall, to get yourself started
# Français: Étape 2: Calculez le résultat moyen global, pour commencer
# Español: Paso 2: Calcule el resultado promedio en general, para comenzar
# Português: Etapa 2: Calcule o resultado médio geral, para começar

experiment_data %>%
  summarise(mean(OUTCOME_VARIABLE_HERE, na.rm = TRUE))

# English: There are a few parts in that command. First, we tell R to use the
# object experiment_data. Then we put in some pipes ("and then...") to let R
# know that something else is coming. Next we call the function "summarise".
# Summarise is like mutate from activity 2 - it is a powerful wrapper function
# from the tidyverse. Summarise collapses the data down into an aggregation or
# summary. You can put lots of different ways of aggregating or summarizing the
# data into summarise. In this case, we want to take the mean, or average, of
# the outcome variable of interest, using the function mean(). The first
# argument you put in mean() is the variable itself. Then there's one more
# option here: na.rm. That means we want to remove any missing values. If
# someone forgets to fill out the outcome, we don't have any information for
# them. This turns out to be a problem! We can't learn what the treatment
# effect is if we don't know how some of the units respond to treatment. For
# now, we're going to remove these folks -- na.rm means remove NAs; NA is one
# way of saying a missing value.

# Français: Il y a plusieurs parties dans cette commande. Premièrement, nous
# indiquons que nous allons utiliser l'objet experiment_data. Puis nous
# utilisons des tuyaux ("pipes", "et puis...") pour inqiquer que nous voulons
# faire plus d'actions. Puis nous utilisons la fonction "summarise". Summarise
# est comme "mutate" dans l'activite precedent - c'est une fonction puissante
# et générale venant du tidyverse. "Summarise" crée un résumé des données. Vous
# pouvez mettre plusieurs fonctions qui aggregent ou résument les données dans
# la fonction de summarise. Dans ce cas, nous voulons le moyenne de la variable
# qui nous interesse, en utilisant la fonction "mean()". Le premier argument
# que vous mettez dans la fonction "mean()" est la variable elle-même. Puis il
# y a une autre option ici : na.rm. Cela signifie que nous voulons supprimer
# toutes les valeurs manquantes. Si quelqu'un oublie de remplir le résultat,
# nous n'avons aucune information pour lui. Cela s'avère être un problème! Nous
# ne pouvons pas savoir quel est l'effet du traitement si nous ne savons pas
# comment certaines des unités réagissent au traitement. Pour l'instant, nous
# allons supprimer ces personnes -- na.rm signifie supprimer les NA ; NA est
# une façon de dire une valeur manquante.

# Español: Hay algunas partes en ese comando. Primero, le decimos a R que use
# el objeto experiment_data. Luego ponemos algunas tuberías (llamados "pipes",
# "y luego...") para que R sepa que viene algo más. Luego llamamos a la función
# "summarise". Summarise es como mutate de la actividad 2: es una poderosa
# función de envoltura del tidyverse. Summarise colapsa los datos en una
# agregación o resumen. Puede poner muchas formas diferentes de agregar o
# resumir los datos en summarise. En este caso, queremos tomar la media, o
# promedio, de la variable de resultado de interés, usando la función mean().
# El primer argumento que pones en mean() es la variable en sí. Luego hay una
# opción más aquí: na.rm. Eso significa que queremos eliminar cualquier valor
# faltante. Si alguien olvida completar el resultado, no tenemos información
# sobre ellos. ¡Esto resulta ser un problema! No podemos aprender cuál es el
# efecto del tratamiento si no sabemos cómo algunas de las unidades responden
# al tratamiento. Por ahora, vamos a eliminar a estas personas: na.rm significa
# eliminar NA; NA es una forma de decir un valor faltante.

# Português: Há algumas partes nesse comando. Primeiro, dizemos ao R para usar
# o objeto experiment_data. Em seguida, colocamos alguns pipes ("e então...")
# para que o R saiba que algo mais está chegando. Em seguida, chamamos a função
# "summarise". Summarise é como mutate da atividade 2 - é uma poderosa função
# de envoltório do tidyverse. Summarise colapsa os dados em uma agregação ou
# resumo. Você pode colocar muitas maneiras diferentes de agregar ou resumir os
# dados em summarise. Neste caso, queremos tirar a média, ou média, da variável
# de resultado de interesse, usando a função mean(). O primeiro argumento que
# você coloca em mean() é a própria variável. Então há mais uma opção aqui:
# na.rm. Isso significa que queremos remover quaisquer valores ausentes. Se
# alguém esquecer de preencher o resultado, não temos informações sobre eles.
# Isso acaba sendo um problema! Não podemos aprender qual é o efeito do
# tratamento se não soubermos como algumas das unidades respondem ao
# tratamento. Por enquanto, vamos remover essas pessoas - na.rm significa
# remover NA; NA é uma maneira de dizer um valor ausente.

# English: Step 3: Calculate the mean in the treatment group
# Next we'll get down to calculating the difference in means, which consists of
# two numbers: the mean outcome in treatment and the mean outcome in control.
# First, to calculate the mean outcome in treatment, we use the same command as
# in Step 2 but we do so for a *subset* of the data, in this case the treatment
# group. Replace the variable names and also the value for treatment. If you
# don't know which value represents treatment, go back to inspect the data and
# see what values it takes.

# Français: Étape 3 : Calculer la moyenne dans le groupe de traitement
# Ensuite, nous calculons la différence des moyennes, qui se compose de deux
# nombres : le résultat moyen dans le groupe de traitement et le résultat moyen
# dans le groupe de contrôle. Pour calculer le résultat moyen du traitement,
# nous utilisons la même commande qu'à l'étape 2, mais nous le faisons pour un
# *sous-ensemble* des données, dans ce cas le groupe de traitement. Remplacez
# les noms des variables ainsi que la valeur pour le traitement.

# Español: Paso 3: Calcular la media en el grupo de tratamiento
# A continuación, pasamos a calcular la diferencia de medias, que consta de dos
# números: la media de resultado en el tratamiento y la media de resultado en
# el control. Primero, para calcular el resultado medio en el tratamiento,
# usamos el mismo comando que en el Paso 2, pero lo hacemos para un
# *subconjunto* de los datos, en este caso el grupo de tratamiento. Reemplace
# los nombres de las variables y también el valor para el tratamiento.

# Português: Passo 3: Calcular a média no grupo de tratamento
# Em seguida, vamos calcular a diferença nas médias, que consiste em dois
# números: a média do resultado no tratamento e a média do resultado no
# controle. Primeiro, para calcular o resultado médio no tratamento, usamos o
# mesmo comando do Passo 2, mas o fazemos para um *subconjunto* dos dados,
# neste caso o grupo de tratamento. Substitua os nomes das variáveis e também o
# valor para o tratamento.

experiment_data %>%
  filter(TREATMENT_VARIABLE_HERE==??) %>%
  summarise(mean(OUTCOME_VARIABLE_HERE, na.rm=TRUE))

# English: Step 4: Do the same but for the control group
# Français: Étape 4 : Faites de même mais pour le groupe de contrôle
# Español: Paso 4: Haga lo mismo pero para el grupo de control
# Português: Passo 4: Faça o mesmo para o grupo de controle

# English: Your code here:
# Français: Votre code ici:
# Español: Su código aquí:
# Português: Seu código aqui:

# English: Step 5: Subtract the mean for the control group from the mean for the treatment group.
# That difference is the estimated treatment effect

# Français: Étape 5 : Soustrayez les deux nombres.
# Cette différence est l'effet estimé du traitement

# Español: Paso 5: Reste los dos números.
# Esa diferencia es el efecto estimado del tratamiento

# Português: Passo 5: Subtraia os dois números.
# Essa diferença é o efeito estimado do tratamento

# English: Step 6: Interpret the result.
# Look at the possible values of the outcome variable.
# Now compare the estimated treatment effect to that scale. Does this seem to be a large or small difference?

# Français: Étape 6 : Interprétez le résultat.
# Regardez les valeurs possibles de la variable de résultat.
# Comparez maintenant l'effet estimé du traitement à cette échelle. Est-ce une différence importante ou faible ?

# Español: Paso 6: Interprete el resultado.
# Mire los posibles valores de la variable de resultado.
# Ahora compare el efecto estimado del tratamiento con esa escala. ¿Le parece una diferencia grande o pequeña?

# Português: Passo 6: Interprete o resultado.
# Olhe os possíveis valores da variável de resultado.
# Agora compare o efeito estimado do tratamento com essa escala. Parece ser uma diferença grande ou pequena?

# English: Answer:
# Français: Réponse :
# Español: Respuesta:
# Português: Resposta:

# ===============================================================================================
# English: Exercise 3: Analyze as if complete and simple randomization was used
# Français: Exercise 3: Analyser comme si la randomisation complète et simple ont été utilisé
# Español: Exercise 3: Analizar como si se hubiera utilizado una aleatorización completa y simple
# Português: Exercise 3: Analisar como se a randomização completa e simples tivesse sido usada
# ===============================================================================================

# English: We will now explore several different estimation procedures.
# Français: Nous allons maintenant explorer plusieurs procédures d'estimation.
# Español: Ahora exploraremos varios procedimientos de estimación.
# Português: Vamos agora explorar vários procedimentos de estimação.

# English: Here, we're going to prove to ourselves that different answer strategies yield different *answers*.
# Français: Ici, nous allons nous prouver que différentes stratégies de réponse produisent des *réponses* différentes.
# Español: Aquí, vamos a demostrarnos a nosotros mismos que diferentes estrategias de respuesta producen diferentes *respuestas*.
# Português: Aqui, vamos provar para nós mesmos que diferentes estratégias de resposta produzem diferentes *respostas*.

# English: As we learned in the estimation lecture, what answer strategy is the "best" depends on the *data strategy*.
# Now we will reinforce the idea that these choices matter, and change what answer you get.

# Français: Comme nous l'avons appris dans le cours sur l'estimation, la "meilleure" stratégie dépend de la stratégie de données.
# Maintenant, nous allons renforcer l'idée que ces choix importent et changent la réponse que vous obtenez.

# Español: Como aprendimos en la clase de estimación, qué estrategia de respuesta es la "mejor" depende de la estrategia de datos.
# Ahora reforzaremos la idea de que estas elecciones importan y cambian la respuesta que obtienes.

# Português: Como aprendemos na aula de estimação, qual estratégia de resposta é a "melhor" depende da estratégia de dados.
# Agora vamos reforçar a ideia de que essas escolhas importam e mudam a resposta que você obtém.

# English: Step 1: first load the estimatr package
# Français: Étape 1 : d'abord, charger le package estimatr
# Español: Paso 1: primero cargue el paquete estimatr
# Português: Passo 1: primeiro carregue o pacote estimatr

install.packages('estimatr') # run only once, then comment out / executez une fois, puis mettez # au debut de la ligne / ejecutar solo una vez, luego comentar / execute apenas uma vez, depois comente
library(estimatr)

# English: Step 2: Analyze using the lm_robust function, which runs a difference-in-means for you and calculates standard errors
# Français: Étape 2: Analyser en utilisant la fonction lm_robust, qui exécute une différence des moyennes et calcule l'erreur type
# Español: Paso 2: Analice usando la función lm_robust, que ejecuta una diferencia en medias y calcula errores estándar
# Português: Passo 2: Analise usando a função lm_robust, que executa uma diferença em médias e calcula erros padrão

difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, data = experiment_data)

# English: Step 3: Compare to your difference-in-means estimate from exercise 2.
# Français: Étape 3: Comparez à votre estimation de différence des moyennes à partir de l'exercise 2.
# Español: Paso 3: Compare con su estimación de diferencia en medias del ejercicio 2.
# Português: Etapa 3: Compare com sua estimativa de diferença em médias do exercício 2.

# English: Question: Do you get the same number? If not, check with your instructor.
# Français: Question: Obtenez-vous le même nombre ? Si ce n'est pas le cas, vérifiez avec votre instructeur.
# Español: Pregunta: ¿Obtuviste el mismo número? Si no, consulte con su instructor.
# Português: Pergunta: Você obteve o mesmo número? Se não, verifique com seu instrutor.

# English: Answer:
# Français: Réponse :
# Español: Respuesta:
# Português: Resposta:

# English: Step 4: Now analyze as if it is a blocked experiment
# Français: Étape 4: Analysez maintenant comme s'il s'agissait d'une expérience randomisée par bloc (ou stratifiée)
# Español: Paso 4: Ahora analice como si fuera un experimento aleatorizado en bloques (o estratificado)
# Português: Etapa 4: Agora analise como se fosse um experimento aleatorizado em blocos (ou estratificado)

lm_robust(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, fixed_effects = ~Gender, data = experiment_data)

# English: Question: Do you get the same answer in the Estimate column and the Std. Error column?
# Français: Question: Obtenez-vous la même réponse dans la colonne "Estimate" et la colonne "Std. Error" ?
# Español: Pregunta: ¿Obtienes la misma respuesta en la columna "Estimate" y la columna "Std. Error"?
# Português: Pergunta: Você obteve a mesma resposta na coluna "Estimate" e na coluna "Std. Error"?

# English: Answer:
# Français: Réponse :
# Español: Respuesta:
# Português: Resposta:

# English: Remember, you should choose based on your data strategy!
# Français: N'oubliez pas, vous devez choisir en fonction de votre stratégie de données !
# Español: Recuerde, debe elegir según su estrategia de datos.
# Português: Lembre-se, você deve escolher com base em sua estratégia de dados!
