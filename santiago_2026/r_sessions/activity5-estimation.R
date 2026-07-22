# =====================================
# English: Activity 5: Estimation 2
# Français: Activité 5: L'estimation 2
# Español: Actividad 5: Estimación 2
# Português: Atividade 5: Estimação 2
# =====================================

# English: We will now explore several different estimation procedures.
# Français: Nous allons maintenant explorer différentes procédures d'estimation.
# Español: Ahora exploraremos varios procedimientos de estimación diferentes.
# Português: Agora vamos explorar vários procedimentos de estimação diferentes.

# English: Here, we're going to prove to ourselves that different answer strategies yield different *answers*.
# Français: Ici, nous allons montrer que différentes stratégies d'estimation produisent des *réponses* différentes.
# Español: Aquí, vamos a demostrar que diferentes estrategias de respuesta producen diferentes *respuestas*.
# Português: Aqui, vamos provar que diferentes estratégias de resposta produzem diferentes *respostas*.

# English: As we learned in the estimation lecture, what answer strategy is the "best" depends on the *data strategy*.
# Now we will reinforce the idea that these choices matter, and change what answer you get.

# Français: Comme nous l'avons appris dans le cours sur l'estimation, la "meilleure" stratégie dépend de la stratégie de données.
# Maintenant, nous allons renforcer l'idée que ces choix importent et changent la réponse que vous obtenez.

# Español: Como aprendimos en la lección de estimación, qué estrategia de respuesta es la "mejor" depende de la *estrategia de datos*.
# Ahora vamos a reforzar la idea de que estas elecciones importan y cambian la respuesta que obtienes.

# Português: Como aprendemos na aula de estimação, qual estratégia de resposta é a "melhor" depende da *estratégia de dados*.
# Agora vamos reforçar a ideia de que essas escolhas importam e alteram a resposta que você obtém.

# =====================================
# English: Exercise 1: load the data from the first session
# You can use exactly the same code you used from the other exercise

# Français: Exercice 1: charger les données de la première session
# Vous pouvez utiliser exactement le même code que celui que vous avez utilisé pour l'autre exercice

# Español: Ejercicio 1: cargar los datos de la primera sesión
# Puedes usar exactamente el mismo código que usaste en el otro ejercicio

# Português: Exercício 1: carregar os dados da primeira sessão
# Você pode usar exatamente o mesmo código que usou no outro exercício
# =====================================

# English: Your code here /
# Français: votre code ici /
# Español: Tu código aquí /
# Português: Seu código aqui /

experiment_data <- read.csv("data_for_analysis_2023.csv")


# =====================================
# English: Exercise 2: analyze as if complete randomization was chosen
# Français: Exercise 2: analyser comme si une randomisation complète avait été choisie
# Español: Ejercicio 2: analizar como si se hubiera elegido una randomización completa
# Português: Exercício 2: analisar como se uma randomização completa tivesse sido escolhida
# =====================================

# English: Step 1: first load the estimatr package
# Français: Étape 1: d'abord, charger le package estimatr
# Español: Paso 1: primero, carga el paquete estimatr
# Português: Passo 1: primeiro, carregue o pacote estimatr

library(estimatr)

# English: Step 2: analyze using the lm_robust function, which runs a difference-in-means for you and calculates standard errors
# Français: Étape 2: analyser en utilisant la fonction lm_robust, qui exécute une différence des moyennes et calcule l'erreur type
# Español: Paso 2: analizar utilizando la función lm_robust, que ejecuta una diferencia de medias y calcula los errores estándar
# Português: Passo 2: analise usando a função lm_robust, que executa uma diferença de médias e calcula os erros-padrão

difference_in_means(state_of_world ~ treatment, data = experiment_data)

lm(state_of_world ~ treatment, data = experiment_data)


# English: Step 3: compare to your difference-in-means estimate from hypothesis testing.
# Français: Étape 3: comparez à votre estimation de différence des moyennes à partir de l'activité "tests d'hypothèse".
# Español: Paso 3: compara con tu estimación de diferencia de medias del test de hipótesis.
# Português: Passo 3: compare com a sua estimativa de diferença de médias do teste de hipóteses.

# English: Question: do you get the same number? If not, check with your instructor.
# Français: Question: Obtenez-vous le même nombre ? Si ce n'est pas le cas, vérifiez avec votre instructeur.
# Español: Pregunta: ¿obtuviste el mismo número? Si no es así, verifica con tu instructor.
# Português: Pergunta: você chegou ao mesmo número? Se não, verifique com seu instrutor.

# English: Answer /
# Français: Réponse /
# Español: Respuesta /
# Português: Resposta /

# English: Step 4: now analyze as if it is a blocked experiment
# Français: Étape 4: Analysez maintenant comme s'il s'agissait d'une expérience randomisée par bloc (ou stratifiée).
# Español: Paso 4: ahora analiza como si fuera un experimento en bloques (o estratificado).
# Português: Passo 4: agora analise como se fosse um experimento em blocos (ou estratificado).

difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, blocks = Gender, data = experiment_data)

# English: Question: do you get the same answer in the Estimate column and the Std. Error column?
# Français: Question: obtenez-vous la même réponse dans la colonne "Estimate" et la colonne "Std. Error"?
# Español: Pregunta: ¿obtienes la misma respuesta en la columna "Estimación" y la columna "Error Estándar"?
# Português: Pergunta: você chegou na mesma resposta na coluna "Estimativa" e na coluna "Erro padrão"?

# English: Answer /
# Français: Réponse /
# Español: Respuesta /
# Português: Resposta /

# English: Remember, you should choose based on your data strategy!
# Français: N'oubliez pas, vous devez choisir en fonction de votre stratégie de données!
# Español: Recuerda, debes elegir en función de tu estrategia de datos!
# Português: Lembre-se, você deve escolher com base na sua estratégia de dados!
