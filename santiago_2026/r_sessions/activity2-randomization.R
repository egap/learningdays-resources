# ====================================
# English: Activity 2: Randomization
# Français: Activité 2: Randomisation
# Español: Actividad 2: Randomización
# Português: Atividade 2: Randomização
# ====================================

# English: We are going to explore *how* to randomize treatment, using the data on Learning Days participants we used yesterday.
# In the experiment we conducted yesterday, the instructors randomized who got which treatment.
# Today, you will do that step, exploring several different ways to do so.
# In the lecture we talked about several different ways to randomize, useful in different experimental settings.
# In this exercise, you will try out most of them.

# Français: Nous allons explorer *comment* randomiser le traitement, en utilisant les données des participants des Learning  Days que nous avons utilisées hier.
# Dans l'expérience que nous avons menée hier, les instructeurs ont randomisé qui a reçu quel traitement.
# Aujourd'hui, vous allez effectuer cette étape, en explorant plusieurs façons différentes de le faire.
# Dans le cours, nous avons parlé de plusieurs façons différentes de faire une randomisation, utiles dans différents contextes expérimentaux.
# Dans cet exercice, vous allez en essayer la plupart.

# Español: Vamos a explorar *cómo* randomizar el tratamiento, utilizando los datos de los participantes de los Learning Days que usamos ayer.
# En el experimento que realizamos ayer, los instructores randomizaron quién recibió qué tratamiento.
# Hoy, harás ese paso, explorando varias formas diferentes de hacerlo.
# En la clase hablamos de varias formas diferentes de randomizar, útiles en diferentes entornos experimentales.
# En este ejercicio, probarás la mayoría de ellas.

# Português: Vamos explorar *como* randomizar o tratamento, usando os dados dos participantes dos Learning Days que usamos ontem.
# No experimento que realizamos ontem, os instrutores randomizaram quem recebeu qual tratamento.
# Hoje, você fará essa etapa, explorando várias maneiras diferentes de fazê-lo.
# Na aula, falamos sobre várias maneiras diferentes de randomizar, úteis em diferentes ambientes experimentais.
# Neste exercício, você experimentará a maioria deles.


# ========================================================================
# English: Exercise 1: Load the data from the last session
# You can use exactly the same code you used from the other exercise
# Français: Exercice 1: Chargez les données de la dernière session
# Vous pouvez utiliser exactement le même code que celui que vous avez utilisé pour l'autre exercice
# Español: Ejercicio 1: Cargue los datos de la última sesión
# Puede usar exactamente el mismo código que usó para el otro ejercicio
# Português: Exercício 1: Carregue os dados da última sessão
# Você pode usar exatamente o mesmo código que usou para o outro exercício
# ========================================================================

# English: Your code here:
# Français: Votre code ici:
# Español: Tu código aquí:
# Português: Seu código aqui:

experiment_data <- read.csv("data_for_analysis.csv")

# ========================================================================
# English: Exercise 2: Randomize participants into two treatment conditions using simple randomization
# In this first exercise, we will walk you through how to randomize in detail. You can then adapt this code to randomize in other ways later in the session.
# Before you start, set a seed. Again, this is so that you can always replicate the result of your randomization.
# It's a way of "fixing" your randomisation.
# Put any numbers in the parenteheses below, for example "123"

# Français: Exercice 2: Randomisez les participants en deux conditions de traitement en utilisant une randomisation simple
# Dans ce premier exercice, nous allons vous expliquer en détail comment randomiser. Vous pouvez ensuite adapter ce code pour randomiser de différentes manières plus tard dans la session.
# Avant de commencer, définissez une graine. Encore une fois, c'est pour que vous puissiez toujours reproduire le résultat de votre randomisation.
# C'est une façon de "corriger" votre randomisation.
# Mettez n'importe quel nombre entre les parenthèses ci-dessous, par exemple "123"

# Español: Ejercicio 2: Randomice a los participantes en dos condiciones de tratamiento utilizando una randomización simple
# En este primer ejercicio, le explicaremos cómo randomizar en detalle. Luego puede adaptar este código para randomizar de otras maneras más adelante en la sesión.
# Antes de comenzar, establezca una semilla. Nuevamente, esto es para que siempre pueda replicar el resultado de su randomización.
# Es una forma de "arreglar" su randomización.
# Coloque cualquier número entre los paréntesis a continuación, por ejemplo "123"

# Português: Exercício 2: Randomize os participantes em duas condições de tratamento usando randomização simples
# Neste primeiro exercício, explicaremos como randomizar em detalhes. Você pode então adaptar este código para randomizar de outras maneiras mais tarde na sessão.
# Antes de começar, defina uma semente. Novamente, isso é para que você possa sempre replicar o resultado da sua randomização.
# É uma forma de "corrigir" sua randomização.
# Coloque qualquer número entre os parênteses abaixo, por exemplo "123"
# ========================================================================

set.seed(YOU_CHOOSE_A_SEED_HERE)

# English: The next step to start is to load the tidyverse. Remember, we need to load the tidyverse in every R session when we want to use it.
# Français: Maintenant nous allons charger le tidyverse. Nous devons charger le paquet dans chaque session R ou nous allons l'utiliser.
# Español: El siguiente paso para comenzar es cargar el tidyverse. Recuerde, necesitamos cargar el tidyverse en cada sesión de R cuando queremos usarlo.
# Português: O próximo passo para começar é carregar o tidyverse. Lembre-se de que precisamos carregar o tidyverse em cada sessão R quando queremos usá-lo.

library(tidyverse)

# English: Now, we will take the experiment_data object, add a variable to it called treatment_simple, which will be a randomly-assigned treatment status randomized using simple randomization. Here's how:
# Français: Nous allons prendre l'objet experiment_data, y ajouter une variable appelée treatment_simple, qui sera un statut de traitement attribué de manière aléatoire et randomisé à l'aide d'une randomisation simple.
# Español: Ahora, tomaremos el objeto experiment_data, le agregaremos una variable llamada treatment_simple, que será un estado de tratamiento asignado al azar y randomizado usando una randomización simple. Así es como:
# Português: Agora, pegaremos o objeto experiment_data, adicionaremos uma variável a ele chamada treatment_simple, que será um status de tratamento atribuído aleatoriamente e randomizado usando randomização simples. Aqui está como:

experiment_data <- experiment_data %>%
  mutate(treatment_simple = rbinom(n = n(), size = 1, prob = 0.5))

# English: Let's unpack what happened here. In the first line, we are telling R to use the object experiment_data, and to write over the old object experiment_data.
# In the second line we're telling R that we want to mutate or modify the dataset. We create a new variable called treatment_simple within the data frame experiment_data.
# To create that new variable we use the rbinom *function*, which takes some inputs and then returns a binomial random variable.
# In this case we provided three inputs: the n, which is how many 0's and 1's we want; the size, which is that we want to take a draw of size 1 from the binomial distribution so it will be 0 and 1; and the probability of a 1 is 0.5 (the prob argument).
# To set the n argument, we used a handy function called n(), which calculates how many rows there are in a data frame. In this case, the number of 0's and 1's we wanted had to be the same as the number of rows in the data frame since each row is a respondent.
# To summarize: we used a function to randomly assign 0's and 1's representing treatment and control, and we saved those into a new variable. That new variable is what you would use to allocate treatment -- to say that one person gets treatment and another person gets control.

# Français: Décomposons ce qui s'est passé ici. Dans la première ligne, nous disons à R d'utiliser l'objet experiment_data et d'écrire sur l'ancien objet experiment_data.
# Dans la deuxième ligne, nous disons à R que nous voulons muter ou modifier l'ensemble de données. Nous créons une nouvelle variable appelée treatment_simple dans le data frame experiment_data.
# Pour créer cette nouvelle variable, nous utilisons la fonction rbinom, qui prend quelques entrées puis renvoie une variable aléatoire binomiale.
# Dans ce cas, nous avons fourni trois entrées: le n, qui est le nombre de 0 et de 1 que nous voulons; la taille, qui est que nous voulons prendre un tirage de taille 1 de la distribution binomiale donc ce sera 0 et 1; et la probabilité d'un 1 est de 0,5 (l'argument prob).
# Pour définir l'argument n, nous avons utilisé une fonction pratique appelée n(), qui calcule le nombre de lignes dans un data frame. Dans ce cas, le nombre de 0 et de 1 que nous voulions devait être le même que le nombre de lignes dans le data frame puisque chaque ligne est un répondant.
# Pour résumer: nous avons utilisé une fonction pour attribuer au hasard des 0 et des 1 représentant le traitement et le contrôle, et nous les avons enregistrés dans une nouvelle variable. Cette nouvelle variable est ce que vous utiliseriez pour allouer le traitement - pour dire qu'une personne reçoit un traitement et qu'une autre personne reçoit un contrôle.

# Español: Veremos lo que sucedió aquí. En la primera línea, le estamos diciendo a R que use el objeto experiment_data y que sobrescriba el antiguo objeto experiment_data.
# En la segunda línea le estamos diciendo a R que queremos mutar o modificar el conjunto de datos. Creamos una nueva variable llamada treatment_simple dentro del marco de datos experiment_data.
# Para crear esa nueva variable usamos la función rbinom, que toma algunas entradas y luego devuelve una variable aleatoria binomial.
# En este caso proporcionamos tres entradas: el n, que es cuántos 0 y 1 queremos; el tamaño, que es que queremos tomar un sorteo de tamaño 1 de la distribución binomial, por lo que será 0 y 1; y la probabilidad de un 1 es 0.5 (el argumento prob).
# Para establecer el argumento n, usamos una función práctica llamada n(), que calcula cuántas filas hay en un marco de datos. En este caso, el número de 0 y 1 que queríamos tenía que ser el mismo que el número de filas en el marco de datos ya que cada fila es un encuestado.
# Para resumir: usamos una función para asignar aleatoriamente 0 y 1 que representan el tratamiento y el control, y los guardamos en una nueva variable. Esa nueva variable es la que usaría para asignar el tratamiento, para decir que una persona recibe tratamiento y otra persona recibe control.

# Português: Vamos entender o que aconteceu aqui. Na primeira linha, estamos dizendo ao R para usar o objeto experiment_data e sobrescrever o antigo objeto experiment_data.
# Na segunda linha, estamos dizendo ao R que queremos mutar ou modificar o conjunto de dados. Criamos uma nova variável chamada treatment_simple dentro do quadro de dados experiment_data.
# Para criar essa nova variável, usamos a função rbinom, que leva algumas entradas e depois retorna uma variável aleatória binomial.
# Neste caso, fornecemos três entradas: o n, que é quantos 0 e 1 queremos; o tamanho, que é que queremos fazer um sorteio de tamanho 1 da distribuição binomial, então será 0 e 1; e a probabilidade de um 1 é 0,5 (o argumento prob).
# Para definir o argumento n, usamos uma função prática chamada n(), que calcula quantas linhas existem em um quadro de dados. Neste caso, o número de 0 e 1 que queríamos tinha que ser o mesmo que o número de linhas no quadro de dados, já que cada linha é um respondente.
# Para resumir: usamos uma função para atribuir aleatoriamente 0 e 1 que representam o tratamento e o controle, e os salvamos em uma nova variável. Essa nova variável é a que você usaria para alocar o tratamento - para dizer que uma pessoa recebe tratamento e outra pessoa recebe controle.


# =============================================================================
# English: Exercise 2: Check your randomization
# After you randomly assign, you want to be sure it worked. Do a few checks. In this case, there should be approximately, but not necessarily exactly, half of subjects assigned to treatment.
# Part A:
# Inspect the data, and check that there are some people with treatment and some with control.
# Can you see the variable you created, treatment_simple? Are there some treated and some control? Answer:
# Part B:
# Count the number of treated and control using the count function.

# Français: Exercice 2: Vérifiez votre randomisation
# Après avoir attribué au hasard, vous voulez être sûr que cela a fonctionné. Faites quelques vérifications. Dans ce cas, il devrait y avoir environ, mais pas nécessairement exactement, la moitié des sujets assignés au traitement.
# Partie A:
# Inspectez les données et vérifiez qu'il y a des personnes avec un traitement et d'autres avec un contrôle.
# Pouvez-vous voir la variable que vous avez créée, treatment_simple? Y a-t-il des traitements et des contrôles? Réponse:
# Partie B:
# Comptez le nombre de traitements et de contrôles à l'aide de la fonction count.

# Español: Ejercicio 2: Verifique su aleatorización
# Después de asignar al azar, querrá asegurarse de que funcionó. Haga algunas comprobaciones. En este caso, debe haber aproximadamente, pero no necesariamente exactamente, la mitad de los sujetos asignados al tratamiento.
# Parte A:
# Inspeccione los datos y verifique que hay algunas personas con tratamiento y algunas con control.
# ¿Puedes ver la variable que creaste, tratamiento_simple? ¿Hay algunos tratados y algunos controles? Respuesta:
# Parte B:
# Cuente el número de tratados y controles usando la función count.

# Português: Exercício 2: Verifique sua randomização
# Depois de atribuir aleatoriamente, você deseja ter certeza de que funcionou. Faça algumas verificações. Neste caso, deve haver aproximadamente, mas não necessariamente exatamente, metade dos sujeitos atribuídos ao tratamento.
# Parte A:
# Inspecione os dados e verifique se há algumas pessoas com tratamento e algumas com controle.
# Você pode ver a variável que criou, tratamento_simple? Existem alguns tratados e alguns controles? Resposta:
# Parte B:
# Conte o número de tratados e controles usando a função count.
# =============================================================================

experiment_data %>% count(treatment_simple)

# English: How many are there in each group? Answer:
# Français: Combien y en a-t-il dans chaque groupe ? Réponse:
# Español: ¿Cuántos hay en cada grupo? Respuesta:
# Português: Quantos há em cada grupo? Resposta:

# =============================================================================
# English: Exercise 3: Randomize participants into two treatment conditions using complete randomization
# Now you'll do the same thing as Exercise 1, but you will use complete random assignment instead of simple random assignment.
# Run the code below and inspect the variable in the data frame

# Français: Exercice 3: Randomisez les participants en deux conditions de traitement en utilisant une randomisation complète
# Maintenant, vous ferez la même chose que l'exercice 1, mais vous utiliserez une affectation aléatoire complète au lieu d'une affectation aléatoire simple.
# Exécutez le code ci-dessous et inspectez la variable dans le cadre de données

# Español: Ejercicio 3: Randomice a los participantes en dos condiciones de tratamiento utilizando una asignación aleatoria completa
# Ahora hará lo mismo que en el Ejercicio 1, pero utilizará una asignación aleatoria completa en lugar de una asignación aleatoria simple.
# Ejecute el código a continuación e inspeccione la variable en el marco de datos

# Português: Exercício 3: Randomize os participantes em duas condições de tratamento usando randomização completa
# Agora você fará a mesma coisa que o Exercício 1, mas usará atribuição aleatória completa em vez de atribuição aleatória simples.
# Execute o código abaixo e inspecione a variável no quadro de dados
# =============================================================================

treatment_statuses <- c(rep(1,13), rep(0,14))

experiment_data <- experiment_data %>%
  mutate(treatment_complete = sample(treatment_statuses, size = 27, replace = FALSE))

# =============================================================================
# English: Exercise 4: Check your complete randomization
# Part A:
# Inspect the data, and check that there are some people with treatment and some with control.
# Can you see the variable you created, treatment_complete? Are there some treated and some control? Answer:
# Part B:
# Count the number of treated and control using the count function. There should be exactly the number of treated and control units as you set up in vec.

# Français: Exercice 4: Vérifiez votre randomisation complète
# Partie A:
# Inspectez les données et vérifiez qu'il y a des personnes avec un traitement et d'autres avec un contrôle.
# Pouvez-vous voir la variable que vous avez créée, treatment_complete? Y a-t-il des traitements et des contrôles? Réponse:
# Partie B:
# Comptez le nombre de traitements et de contrôles à l'aide de la fonction count. Il devrait y avoir exactement le nombre d'unités traitées et de contrôle que vous avez configuré dans vec.

# Español: Ejercicio 4: Verifique su aleatorización completa
# Parte A:
# Inspeccione los datos y verifique que hay algunas personas con tratamiento y algunas con control.
# ¿Puedes ver la variable que creaste, tratamiento_completo? ¿Hay algunos tratados y algunos controles? Respuesta:
# Parte B:
# Cuente el número de tratados y controles usando la función count. Debe haber exactamente el número de unidades tratadas y de control que configuró en vec.

# Português: Exercício 4: Verifique sua randomização completa
# Parte A:
# Inspecione os dados e verifique se há algumas pessoas com tratamento e algumas com controle.
# Você pode ver a variável que criou, tratamento_completo? Existem alguns tratados e alguns controles? Resposta:
# Parte B:
# Conte o número de tratados e controles usando a função count. Deve haver exatamente o número de unidades tratadas e de controle que você configurou em vec.
# =============================================================================

experiment_data %>% count(treatment_complete)

# English: How many are there in each group? Is that how many you expected? Answer:
# Français: Combien y en a-t-il dans chaque groupe ? Est-ce le nombre que vous attendiez ? Réponse:
# Español: ¿Cuántos hay en cada grupo? ¿Es eso lo que esperabas? Respuesta:
# Português: Quantos há em cada grupo? É isso que você esperava? Resposta:

# =============================================================================
# English: Exercise 5: Using randomizr to do complete random assignment
# Now we are going to learn how to use the randomizr package in R, which allows you to do many common forms of random assignment easily.
# Step 1: load the randomizr package -- exactly like you did for tidyverse but with randomizr instead of tidyverse

# Français: Exercice 5: Utilisation de randomizr pour effectuer une affectation aléatoire complète
# Maintenant, nous allons apprendre à utiliser le package randomizr dans R, qui vous permet d'effectuer facilement de nombreuses formes courantes d'affectation aléatoire.
# Étape 1: chargez le package randomizr - exactement comme vous l'avez fait pour tidyverse mais avec randomizr au lieu de tidyverse

# Español: Ejercicio 5: Usando randomizr para hacer asignación aleatoria completa
# Ahora vamos a aprender cómo usar el paquete randomizr en R, que le permite hacer muchas formas comunes de asignación aleatoria fácilmente.
# Paso 1: cargue el paquete randomizr - exactamente como lo hizo para tidyverse pero con randomizr en lugar de tidyverse

# Português: Exercício 5: Usando randomizr para fazer atribuição aleatória completa
# Agora vamos aprender como usar o pacote randomizr no R, que permite fazer muitas formas comuns de atribuição aleatória facilmente.
# Passo 1: carregue o pacote randomizr - exatamente como você fez para tidyverse mas com randomizr em vez de tidyverse
# =============================================================================

install.packages('randomizr') # English: Run this only once if you don't have randomizr installed, then comment it out / Français: executez cette code une fois si vous n'avez pas installe randomizr, puis mettez un # au debut de la ligne / Español: jecuta este código solo una vez si no tienes randomizr instalado, luego coméntalo poniendo un # al principio de la línea. / Português: Execute este código apenas uma vez se você não tiver o randomizr instalado, depois comente-o colocando um # no início da linha.

library(randomizr)

# English: Step 2: randomize using the function complete_ra
# Français: Étape 2: randomiser à l'aide de la fonction complete_ra
# Español: Paso 2: aleatorizar usando la función complete_ra
# Português: Etapa 2: randomizar usando a função complete_ra

experiment_data <- experiment_data %>%
  mutate(treatment_complete2 = complete_ra(N = n(), prob = 0.5))

# English: Step 3: check whether it worked using the same techniques you used above (inspect and use count)
# Français: Étape 3: vérifiez si cela a fonctionné en utilisant les mêmes techniques que vous avez utilisées ci-dessus (inspectez et utilisez "count")
# Español: Paso 3: verifique si funcionó usando las mismas técnicas que usó anteriormente (inspeccione y use count)
# Português: Etapa 3: verifique se funcionou usando as mesmas técnicas que você usou acima (inspecione e use count)

# =============================================================================
# English: Exercise 6: Using randomizr to do blocked random assignment
# Because you've now learned how to use randomizr, you can do more complex random assignment schemes more easily. Let's try block random assignment.
# As a reminder, blocked random assignment is where you take a set of blocks (also known as strata) and do mini-experiments within them. The blocks come from your data -- they might be variables representing gender or towns or a combination of multiple variables. We'll use the gender of participants here. In this case, block random assignment means that you will conduct two mini-experiments, one among women and one among men, but you'll do it all at once.
# Step 1: identify the block variable. Inspect the data frame and find out what the name of the gender variable is. Note variables are "case sensitive", meaning if there are capital letters that's important to remember.

# Français: Exercice 6: Utilisation de randomizr pour effectuer une affectation aléatoire bloquée
# Parce que vous avez maintenant appris à utiliser randomizr, vous pouvez effectuer des schémas d'affectation aléatoire plus complexes plus facilement. Essayons l'affectation aléatoire par blocs.
# Pour rappel, l'affectation aléatoire par blocs consiste à prendre un ensemble de blocs (également appelés strates) et à effectuer des mini-expériences à l'intérieur. Les blocs proviennent de vos données - ils peuvent être des variables représentant le sexe ou les villes ou une combinaison de plusieurs variables. Nous utiliserons ici le sexe des participants. Dans ce cas, l'affectation aléatoire par blocs signifie que vous effectuerez deux mini-expériences, une chez les femmes et une chez les hommes, mais vous le ferez tout en même temps.
# Étape 1: identifiez la variable de bloc. Inspectez le cadre de données et découvrez quel est le nom de la variable de sexe. Notez que les variables sont "sensibles à la casse", ce qui signifie que si elles contiennent des majuscules, il est important de s'en souvenir.

# Español: Ejercicio 6: Usando randomizr para hacer asignación aleatoria en bloques
# Debido a que ahora ha aprendido a usar randomizr, puede hacer esquemas de asignación aleatoria más complejos con más facilidad. Intentemos la asignación aleatoria por bloques.
# Como recordatorio, la asignación aleatoria por bloques es donde tomas un conjunto de bloques (también conocidos como estratos) y haces mini experimentos dentro de ellos. Los bloques provienen de sus datos: pueden ser variables que representan el género o las ciudades o una combinación de múltiples variables. Usaremos el género de los participantes aquí. En este caso, la asignación aleatoria por bloques significa que realizará dos mini experimentos, uno entre mujeres y otro entre hombres, pero lo hará todo a la vez.
# Paso 1: identifique la variable de bloque. Inspeccione el marco de datos y descubra cuál es el nombre de la variable de género. Tenga en cuenta que las variables son "sensibles a mayúsculas y minúsculas", lo que significa que si hay letras mayúsculas, es importante recordarlo.

# Português: Exercício 6: Usando randomizr para fazer atribuição aleatória em blocos
# Porque você agora aprendeu a usar o randomizr, você pode fazer esquemas de atribuição aleatória mais complexos com mais facilidade. Vamos tentar a atribuição aleatória por blocos.
# Como lembrete, a atribuição aleatória de blocos é onde você pega um conjunto de blocos (também conhecidos como estratos) e faz mini-experimentos dentro deles. Os blocos vêm dos seus dados - eles podem ser variáveis que representam gênero ou cidades ou uma combinação de várias variáveis. Usaremos o gênero dos participantes aqui. Neste caso, a atribuição aleatória de blocos significa que você fará dois mini-experimentos, um entre mulheres e outro entre homens, mas fará tudo de uma vez.
# Passo 1: identifique a variável de bloco. Inspect o quadro de dados e descubra qual é o nome da variável de gênero. Observe que as variáveis são "sensíveis a maiúsculas e minúsculas", o que significa que se houver letras maiúsculas, é importante lembrar.
# =============================================================================

# English: What is the variable named? Answer:
# Français: Quel est le nom de la variable ? Réponse:
# Español: ¿Cómo se llama la variable? Respuesta:
# Português: Qual é o nome da variável? Resposta:

# =============================================================================
# English: Step 2: Randomize. To do this, you'll use the function block_ra, and the difference between block_ra and complete_ra is you have to tell block_ra what the block variable is. You won't need to tell it the N any more, because the software can figure that out from the block variable.
# Français: Étape 2: Randomiser. Pour ce faire, vous utiliserez la fonction block_ra. La différence entre block_ra et complete_ra est que vous devez lui dire quelle est la variable de bloc. Vous n'aurez plus besoin de lui dire le N, car le logiciel peut le comprendre à partir de la variable de bloc.
# Español: Paso 2: Aleatorizar. Para hacer esto, utilizará la función block_ra, y la diferencia entre block_ra y complete_ra es que debe decirle a block_ra cuál es la variable de bloque. Ya no necesitará decirle el N, porque el software puede averiguarlo a partir de la variable de bloque.
# Português: Passo 2: Aleatorizar. Para fazer isso, você usará a função block_ra, e a diferença entre block_ra e complete_ra é que você terá que dizer ao block_ra qual é a variável de bloco. Você não precisará mais dizer a ele o N, porque o software pode descobrir isso a partir da variável de bloco.
# =============================================================================

experiment_data <- experiment_data %>%
  mutate(treatment_blocked = block_ra(blocks = ??, prob = 0.5))

# =============================================================================
# English: Step 3: check the data using inspect and count
# Français: Étape 3 : vérifiez les données en utilisant inspect et count
# Español: Paso 3: verifique los datos usando inspect y count
# Português: Passo 3: verifique os dados usando inspect e count
# =============================================================================

# English: Put your code here
# Français: Mettez votre code ici
# Español: Pon tu código aquí
# Português: Coloque seu código aqui

# =============================================================================
# English: Are approximately the same number *within each block* treated? As in, are the same number of men treated as the number of women who are treated? (Note if there are odd numbers, of course it won't be exactly equal.)
# Français: Y a-t-il à peu près le même nombre *dans chaque bloc* traité ? Autrement dit, y a-t-il autant d'hommes traités que de femmes traitées ? (Notez que s'il y a des nombres impairs, bien sûr, il n'y aura pas exactement le même nombre.)
# Español: ¿Hay aproximadamente el mismo número *dentro de cada bloque* tratado? Como en, ¿son tratados el mismo número de hombres que el número de mujeres que son tratadas? (Tenga en cuenta que si hay números impares, por supuesto, no será exactamente igual).
# Português: Existem aproximadamente o mesmo número *dentro de cada bloco* tratado? Como, são tratados o mesmo número de homens que o número de mulheres que são tratadas? (Observe que se houver números ímpares, é claro que não será exatamente igual).
# =============================================================================

# English: Answer:
# Français: Réponse:
# Español: Respuesta:
# Português: Resposta:
