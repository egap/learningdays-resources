
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

difference_in_means(OUTCOME_VARIABLE_HERE ~ TREATMENT_VARIABLE_HERE, blocks = Gender, data = experiment_data)

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
