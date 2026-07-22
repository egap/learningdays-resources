# ===========================================================================
# English: Activity 1: The basics
# Français: Activité 1: Les bases
# Español: Actividad 1: Los fundamentos
# Português: Atividade 1: Os fundamentos
# ===========================================================================

# English: Welcome to R! In this first activity, we will help you get a flavor of basic data analysis in R.
# Goals: learn how to load data, inspect data to see what variables there are, and to conduct basic data summaries

# Français: Bienvenue dans R! Dans cette première activité, nous allons vous donner un aperçu de l'analyse de données avec R.
# Objectifs: apprendre à charger les données, inspecter les données pour voir les variables, et les "résumer".

# Español: Bienvenido a R! En esta primera actividad, le ayudaremos a tener una idea del análisis de datos básicos en R.
# Objetivos: aprender a cargar datos, inspeccionar los datos para ver qué variables hay y realizar resúmenes básicos de datos.

# Português: Bem-vindo ao R! Nesta primeira atividade, ajudaremos você a ter uma ideia da análise básica de dados no R.
# Objetivos: aprender a carregar dados, inspecionar dados para ver quais variáveis existem e realizar resumos básicos de dados.

# Let's get started! Commençons! ¡Empecemos! Vamos começar!

# <- English: This is a comment in the code, starting with a #. We'll use these to provide instructions.
# <- Français: Ceci est un commentaire dans le code. Nous les utiliserons pour donner des informations.
# <- Español: Este es un comentario en el código. Los usaremos para dar instrucciones.
# <- Português: Este é um comentário no código. Usaremos estes para fornecer instruções.

# ===========================================================================
# English: Exercise 1: Getting started
# Français: Exercice 1: Pour commencer
# Español: Ejercicio 1: Empezando
# Português: Exercício 1: Começando
# ===========================================================================

# English: You have downloaded the relevant files and data to do our first R exercise. Great!
# Français: Vous avez téléchargé les fichiers et les données nécessaires pour notre premier exercice R. Super !
# Español: Has descargado los archivos y datos relevantes para hacer nuestro primer ejercicio de R. ¡Genial!
# Português: Você baixou os arquivos e dados relevantes para fazer nosso primeiro exercício de R. Ótimo!

# English: Let's check if things are working: do you see all of the relevant files in your "directory"?
# To do this, you can use the dir() function.
# (A function is an R command. When you run a function, you provide inputs (sometimes none) and R does something and returns outputs.)
# The dir() function takes no inputs (that's why there is nothing inside the parentheses) and returns a list of the files in the *current folder/directory*.

# Français: Vérifions si les choses fonctionnent : voyez-vous tous les fichiers pertinents dans votre "répertoire" (directory) ?
# Pour ce faire, vous pouvez utiliser la fonction dir().
# (Une fonction est une commande R. Lorsque vous exécutez une fonction, vous fournissez des entrées (parfois aucune) et R fait quelque chose et renvoie des sorties.)
# La fonction dir() ne prend pas d'entrées (c'est pourquoi il n'y a rien à l'intérieur des parenthèses) et renvoie une liste des fichiers dans le répertoire/dossier actuel.

# Español: Veamos si las cosas funcionan: ¿ves todos los archivos relevantes en tu "directorio"?
# Para hacer esto, puede usar la función dir().
# (Una función es un comando R. Cuando ejecuta una función, proporciona entradas (a veces ninguna) y R hace algo y devuelve salidas).
# La función dir() no toma entradas (por eso no hay nada dentro de los paréntesis) y devuelve una lista de los archivos en el *directorio actual*.

# Português: Vamos verificar se as coisas estão funcionando: você vê todos os arquivos relevantes no seu "diretório"?
# Para fazer isso, você pode usar a função dir().
# (Uma função é um comando R. Quando você executa uma função, fornece entradas (às vezes nenhuma) e o R faz algo e retorna saídas).
# A função dir() não recebe entradas (é por isso que não há nada entre parênteses) e retorna uma lista dos arquivos no *diretório atual*.

# English: In the exercises, starting with the line below, to run a command you can put your cursor on the line of code and press CTRL+ENTER (Windows) or COMMAND+ENTER (Mac)
# You can also copy-paste the line of code into the "Console". The console is in another part of the screen from this code (ask an instructor if you can't find it).

# Français: Dans les exercices, à partir de la ligne ci-dessous, pour exécuter une commande, vous pouvez mettre votre curseur sur la ligne de code et appuyer sur CTRL+ENTER (Windows) ou COMMAND+ENTER (Mac)
# Vous pouvez également copier-coller la ligne de code dans la "Console". La console est dans une autre partie de l'écran.

# Español: En los ejercicios, a partir de la línea a continuación, para ejecutar un comando, puede colocar el cursor en la línea de código y presionar CTRL+ENTER (Windows) o COMMAND+ENTER (Mac)
# También puede copiar y pegar la línea de código en la "Consola". La consola está en otra parte de la pantalla.

# Português: Nos exercícios, a partir da linha abaixo, para executar um comando, você pode colocar o cursor na linha de código e pressionar CTRL+ENTER (Windows) ou COMMAND+ENTER (Mac)
# Você também pode copiar e colar a linha de código no "Console". O console está em outra parte da tela.

dir()

# English: Question 1: Is the data file that we work with sin the list that the function returned? If not, please consult an instructor.
# Français: Question 1: Le fichier de données que vous avez téléchargé figure-t-il dans la liste renvoyée par la fonction? Si ce n'est pas le cas, appelez l'instructeur.
# Español: Pregunta 1: ¿El archivo de datos con el que trabajamos está en la lista que devolvió la función? Si no es así, consulte a un instructor.
# Português: Pergunta 1: O arquivo de dados com o qual trabalhamos está na lista que a função retornou? Se não, consulte um instrutor.

# Answer / Réponse / Respuesta / Resposta:

# =============================================
# English: Exercise 2: Reading in the data
# Français: Exercice 2: Importer les données
# Español: Ejercicio 2: Importando los datos
# Português: Exercício 2: Importando os dados
# =============================================

# English: With the packages loaded, we can now read in the data. That means R will read the file and then add it as an object to your "workspace" where we can analyze it.
# We can do this via the read_csv function, which takes a filename you provide and reads that file and creates an R data object, called a data frame.

# Français: Avec les packages chargés, nous pouvons maintenant importer les données. Cela signifie que R va lire le fichier et l'ajouter en tant qu'objet à votre "workspace" où nous pouvons l'analyser.
# Nous pouvons le faire via la fonction read_csv, qui prend un nom de fichier en entrée, lit le fichier et crée un objet de données R, appelé un data frame.

# Español: Con los paquetes cargados, ahora podemos leer los datos. Eso significa que R leerá el archivo y luego lo agregará como un objeto a su "espacio de trabajo" donde podemos analizarlo.
# Podemos hacer esto a través de la función read_csv, que toma un nombre de archivo que proporciona y lee ese archivo y crea un objeto de datos R, llamado marco de datos.

# Português: Com os pacotes carregados, agora podemos ler os dados. Isso significa que o R lerá o arquivo e, em seguida, o adicionará como um objeto ao seu "espaço de trabalho", onde podemos analisá-lo.
# Podemos fazer isso por meio da função read_csv, que recebe um nome de arquivo que você fornece e lê esse arquivo e cria um objeto de dados R, chamado data frame.

experiment_data <- read.csv("data_for_analysis.csv")

# English: 3 parts to the line of code above ^
# Français: 3 parties à la ligne de code ci-dessus ^
# Español: 3 partes de la línea de código anterior ^
# Português: 3 partes da linha de código acima ^

# English: Question: find the "environment" tab in your RStudio window.
# Ask for help from an instructor or someone next to you if you don't see it.
# Does the object called experiment_data show up under environment?

# Français: Question : trouvez l'onglet "environnement" dans votre fenêtre RStudio.
# Demandez de l'aide à un instructeur ou à quelqu'un à côté de vous si vous ne le voyez pas.
# L'objet appelé experiment_data y apparaît-il ?

# Español: Pregunta: encuentre la pestaña "entorno" en su ventana de RStudio.
# Pida ayuda a un instructor o a alguien a su lado si no lo ve.
# ¿Aparece el objeto llamado experiment_data en el entorno?

# Português: Pergunta: encontre a guia "ambiente" na sua janela RStudio.
# Peça ajuda a um instrutor ou a alguém ao seu lado se você não a vir.
# O objeto chamado experiment_data aparece no ambiente?

# Answer / Réponse / Respuesta / Resposta:

# English: Now let's step back for one moment to explain what we just did.
# There were three parts to what we typed: the function call -- read_csv("data_for_analysis.csv") -- which runs the read_csv function.
# Then there was <- which is how we give that object a name and save it.
# The third part is the name.
# So when you read that line of code, we're going to read in the data from the file data_for_analysis.csv and save it to the object named experiment_data.

# Français: Maintenant, expliquons ce que nous venons de faire.
# Il y avait trois parties à ce que nous avons tapé : l'appel de fonction - read_csv("data_for_analysis.csv") - qui exécute la fonction read_csv.
# Ensuite, il y avait <- qui est la façon dont nous donnons un nom à cet objet et l'enregistrons. La troisième partie est le nom.
# Donc, lorsque vous lisez cette ligne de code, nous allons lire les données du fichier data_for_analysis.csv et les enregistrer dans l'objet nommé experiment_data.

# Español: Ahora retrocedamos un momento para explicar lo que acabamos de hacer.
# Hubo tres partes en lo que escribimos: la llamada a la función - read_csv ("data_for_analysis.csv") - que ejecuta la función read_csv.
# Luego estaba <- que es cómo le damos a ese objeto un nombre y lo guardamos.
# La tercera parte es el nombre.
# Así que cuando lees esa línea de código, vamos a leer los datos del archivo data_for_analysis.csv y guardarlos en el objeto llamado experiment_data.

# Português: Agora vamos dar um passo atrás por um momento para explicar o que acabamos de fazer.
# Havia três partes no que digitamos: a chamada de função - read_csv ("data_for_analysis.csv") - que executa a função read_csv.
# Então havia <- que é como damos a esse objeto um nome e o salvamos.
# A terceira parte é o nome.
# Então, quando você lê essa linha de código, vamos ler os dados do arquivo data_for_analysis.csv e salvá-los no objeto chamado experiment_data.

# ===================================================================
# English: Exercise 3: Inspect the data
# Français: Exercice 3 : Inspecter les données
# Español: Ejercicio 3: Inspeccionar los datos
# Português: Exercício 3: Inspecionar os dados
# ===================================================================

# English: Take a moment to look at the data itself. To do this, find the Environment tab and click once on the object experiment_data. That brings up the "data viewer." This is always a good place to start to see what's in the data.
# Question: what are the variable names in the data?

# Français: Prenez un moment pour regarder les données elles-mêmes. Pour ce faire, trouvez l'onglet Environnement et cliquez une fois sur l'objet experiment_data. Cela ouvre le "data viewer". C'est toujours un bon endroit pour commencer à voir ce qu'il y a dans les données.
# Question : quels sont les noms des variables dans les données ?

# Español: Tómese un momento para mirar los datos en sí. Para hacer esto, encuentre la pestaña Entorno y haga clic una vez en el objeto experiment_data. Esto abre el "visor de datos". Este es siempre un buen lugar para empezar a ver qué hay en los datos.
# Pregunta: ¿cuáles son los nombres de las variables en los datos?

# Português: Reserve um momento para olhar os dados em si. Para fazer isso, encontre a guia Ambiente e clique uma vez no objeto experiment_data. Isso abre o "visualizador de dados". Este é sempre um bom lugar para começar a ver o que há nos dados.
# Pergunta: quais são os nomes das variáveis nos dados?

# Answer / Réponse / Respuesta / Resposta:

#gender, local, treatment, block id, stade of world

# ===================================================================
# English: Exercise 4: install the tidyverse and load packages
# Français: Exercice 4 : installer le tidyverse et charger les paquets
# Español: Ejercicio 4: instalar el tidyverse y cargar paquetes
# Português: Exercício 4: instalar o tidyverse e carregar pacotes
# ===================================================================

# English: Now let's load the tidyverse package. A "package" in R is a collection of functions (commands), data, and documentation that is like a toolkit.
# The tidyverse is a family of packages that are designed to work together.
# We're going to start by installing it.
# It has to download, so you must be connected to wifi.
# This can take a while if the internet is slow!

# Français: D'abord nous installons le paquet tidyverse. Un "paquet" R est une collection de fonctions (commandes), données, et documentation qui fonctionnent comme une boîte à outils.
# Le tidyverse est une famille de paquets qui fonctionnent bien ensemble.
# Commençons avec l'installation.
# Le paquet doit être téléchargé, vous devez donc être connecté au wifi.
# Cette étape peut prendre du temps si le wifi est faible!

# Español: Ahora vamos a cargar el paquete tidyverse. Un "paquete" en R es una colección de funciones (comandos), datos y documentación que es como un kit de herramientas.
# El tidyverse es una familia de paquetes que están diseñados para trabajar juntos.
# Vamos a empezar por instalarlo.
# Tiene que descargar, así que debe estar conectado al wifi.
# ¡Esto puede llevar un tiempo si el internet es lento!

# Português: Agora vamos carregar o pacote tidyverse. Um "pacote" em R é uma coleção de funções (comandos), dados e documentação que é como um kit de ferramentas.
# O tidyverse é uma família de pacotes que são projetados para trabalhar juntos.
# Vamos começar instalando-o.
# Tem que baixar, então você deve estar conectado ao wifi.
# Isso pode levar um tempo se a internet for lenta!

# install.packages("tidyverse") # install all the packages in the tidyverse family / installez tous les paquets du tidyverse / instala todos los paquetes de tidyverse / instala todos os pacotes da família tidyverse

# English: Question: What message do you see in the R console when the tidyverse has installed?
# Français: Question: Quel est le message qui s'affiche lorsque le package tidyverse est installé ?
# Español: Pregunta: ¿Qué mensaje ves en la consola R cuando se ha instalado el tidyverse?
# Português: Pergunta: Que mensagem você vê no console R quando o tidyverse foi instalado?

# English: Now let's load the tidyverse package. To do this, you use another function "library()" that makes all the resources from the package available to you in your R session.
# Even after a package has been installed, you need to use the library() function to load it in each R session when you want to use its resources.

# Français: Maintenant chargeons le paquet tidyverse. Nous devrons utiliser une autre fonction "library()" qui met à votre disposition toutes les ressources du paquet dans votre session R.
# Même si vous avez déjà installé un paquet, vous devrez utiliser la fonction "library()" pour charger le paquet dans chaque session R quand vous voulez utiliser ces ressources.

# Español: Ahora vamos a cargar el paquete tidyverse. Para hacer esto, utilizas otra función "library()" que hace que todos los recursos del paquete estén disponibles para ti en tu sesión de R.
# Incluso después de que un paquete haya sido instalado, necesitas usar la función library() para cargarlo en cada sesión de R cuando quieras usar sus recursos.

# Português: Agora vamos carregar o pacote tidyverse. Para fazer isso, você usa outra função "library()" que torna todos os recursos do pacote disponíveis para você na sua sessão R.
# Mesmo depois que um pacote tenha sido instalado, você precisa usar a função library() para carregá-lo em cada sessão R quando quiser usar seus recursos.

library(tidyverse)

# English: If the tidyverse has installed correctly, you should be able to load it using library().
# If the tidyverse will not load, please ask an instructor or neighbor for help.
# Question: What message do you see in the R console when you load the tidyverse using library()?

# Français: Si le tidyverse est bien installé, vous devriez être capable de le charger avec "library()".
# Si le tidyverse ne charge pas, demandez de l'aide à un instructeur ou un voisin.
# Question: Quel message voyez-vous dans la console R quand vous chargez le tidyverse avec "library()"?

# Español: Si el tidyverse se ha instalado correctamente, deberías ser capaz de cargarlo usando library().
# Si el tidyverse no se carga, por favor pide ayuda a un instructor o vecino.
# Pregunta: ¿Qué mensaje ves en la consola R cuando cargas el tidyverse usando library()?

# Português: Se o tidyverse foi instalado corretamente, você deve ser capaz de carregá-lo usando library().
# Se o tidyverse não carregar, por favor, peça ajuda a um instrutor ou vizinho.
# Pergunta: Que mensagem você vê no console R quando carrega o tidyverse usando library()?

# Answer / Réponse / Respuesta / Resposta:


# ===================================================================
# English: Exercise 5: modify data
# Français: Exercice 5 : modifier les données
# Español: Ejercicio 5: modificar los datos
# Português: Exercício 5: modificar os dados
# ===================================================================

# English: Next we will learn how to manipulate, or modify, a data frame. This is helpful if you want to create a new variable, or change an existing variable.
# We are going to manipulate our data frame by modifying it and then writing over the original.

# Français: Maintenant nous apprenons comment manipuler, ou modifier, les données. C'est utile si vous voulez créer une nouvelle variable, ou modifier une variable actuelle.
# Nous allons manipuler les données en les modifiant et puis en redéfinissant les données originales.

# Español: A continuación vamos a aprender cómo manipular, o modificar, un data frame. Esto es útil si quieres crear una nueva variable, o cambiar una variable existente.
# Vamos a manipular nuestro data frame modificándolo y luego escribiendo sobre el original.

# Português: Em seguida, vamos aprender como manipular, ou modificar, um data frame. Isso é útil se você quiser criar uma nova variável, ou mudar uma variável existente.
# Vamos manipular nosso data frame modificando-o e depois escrevendo sobre o original.

experiment_data %>%  # start with the experiment_data dataset and then... \ commençons avec les données experiment_data et puis... \ comencemos con el conjunto de datos experiment_data y luego... \ comece com o conjunto de dados experiment_data e depois...
  mutate(coffee = 1, # mutate it by adding a new variable called coffee that takes a value of 1 for everyone \ ajoutons une nouvelle variable appelée "coffee" qui prend la valeur 1 pour tout le monde \ mutar agregando una nueva variable llamada "coffee" que toma un valor de 1 para todos \ mutar adicionando uma nova variável chamada "coffee" que toma um valor de 1 para todos
         tea = c(0, 1, 0, 1, 0, 1, 0, 1, 10, 11, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1),  # mutate it by adding a new variable called tea that takes a value of 0, 1, 10, or 11 \ ajoutons une nouvelle variable appelée "tea" qui prend les valeurs 0, 1, 10, ou 11 \ mutar agregando una nueva variable llamada "tea" que toma un valor de 0, 1, 10, o 11 \ mutar adicionando uma nova variável chamada "tea" que toma um valor de 0, 1, 10, ou 11
         ivoirien = if_else(local == 1, 1, 0)) # mutate by adding a new variable ivoirien that takes a value of 1 if local equals 1 \ ajoutons une nouvelle variable "ivoirien" qui prend la valeur 1 si "local" == 1, ou 0 sinon \ mutar agregando una nueva variable "ivoirien" que toma un valor de 1 si "local" == 1, o 0 si no \ mutar adicionando uma nova variável "ivoirien" que toma um valor de 1 se "local" == 1, ou 0 se não

# English: Once we run those lines of code we see that there are new columns on the far right called coffee, tea, and cote_divoire. That's great!
# However, for this new column to be saved in our dataset, we also need to write over the original data object.

# Français: Quand nous avons exécuté ces lignes de code nous voyons deux nouvelles colonnes à droite appelées coffee, tea, et cote_divoire. Super !
# Mais si nous souhaitons enregistrer la modification, nous devons redéfinir l'objet des données originales.

# Español: Una vez que ejecutamos esas líneas de código vemos que hay nuevas columnas a la derecha llamadas coffee, tea, y cote_divoire. ¡Eso es genial!
# Sin embargo, para que esta nueva columna se guarde en nuestro conjunto de datos, también necesitamos escribir sobre el objeto de datos original.

# Português: Uma vez que executamos essas linhas de código vemos que há novas colunas à direita chamadas coffee, tea, e cote_divoire. Isso é ótimo!
# No entanto, para que essa nova coluna seja salva em nosso conjunto de dados, também precisamos escrever sobre o objeto de dados original.

# English: What is the difference between this line of code and the one above?
# Français: Quelle est la différence entre cette ligne de code et la précédente ?
# Español: ¿Cuál es la diferencia entre esta línea de código y la de arriba?
# Português: Qual é a diferença entre esta linha de código e a de cima?

experiment_data <- experiment_data %>% # the arrow <- assigns the new modified version of experiment_data to the name experiment_data \ la flèche <- assigne la nouvelle version modifiée de experiment_data au nom experiment_data \ la flecha <- asigna la nueva versión modificada de experiment_data al nombre experiment_data \ a seta <- atribui a nova versão modificada de experiment_data ao nome experiment_data
  mutate(coffee = 1,
         tea = c(0,1,0,1,0,1,0,1,10,11,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1),
         ivoirien = if_else(local == 1, 1, 0))

# English: Now our modification (the new columns) is saved to the dataset, and we can use the new variables going forward.
# Français: Maintenant notre modification (la nouvelle colonne) est enregistrée dans les données, et nous pouvons utiliser les nouvelles variables dans les prochaines étapes.
# Español: Ahora nuestra modificación (las nuevas columnas) se guarda en el conjunto de datos, y podemos usar las nuevas variables en el futuro.
# Português: Agora nossa modificação (as novas colunas) é salva no conjunto de dados, e podemos usar as novas variáveis no futuro.

# English: After you have created or modified a variable, it's a good idea to inspect it. You can do this by visually inspecting the data in the Environment tab, but it's often useful to count up different values of your variable.
# A quick way to count up the values of a variable is the function "count()".

# Français: Après avoir créé ou modifié une variable, c'est une bonne idée de l'inspecter. Vous pouvez le faire en inspectant visuellement les données dans l'onglet "Environment", mais il est souvent utile de compter les différentes valeurs de votre variable.
# Un moyen rapide de compter les valeurs d'une variable est la fonction "count()".

# Español: Después de haber creado o modificado una variable, es una buena idea inspeccionarla. Puede hacer esto inspeccionando visualmente los datos en la pestaña "Environment", pero a menudo es útil contar los diferentes valores de su variable.
# Una forma rápida de contar los valores de una variable es la función "count()".

# Português: Depois de criar ou modificar uma variável, é uma boa ideia inspecioná-la. Você pode fazer isso inspecionando visualmente os dados na guia "Environment", mas muitas vezes é útil contar os diferentes valores de sua variável.
# Uma maneira rápida de contar os valores de uma variável é a função "count()".

experiment_data %>% count(coffee) # take the experiment_data and then count the values of the variable coffee / prenez experiment_data et puis comptez les valeurs de la variable coffee / tome experiment_data y luego cuente los valores de la variable coffee / pegue experiment_data e depois conte os valores da variável coffee
experiment_data %>% count(tea)
experiment_data %>% count(ivoirien)

# English: Question: How many units take each value in the variable tea?
# Français: Question: Combien d'unités y a-t-il pour chaque valeur de la variable "tea" ?
# Español: Pregunta: ¿Cuántas unidades toman cada valor en la variable tea?
# Português: Pergunta: Quantas unidades tomam cada valor na variável tea?

# Your answer here / Votre réponse ici / Su respuesta aquí / Sua resposta aqui

# English: Finally, you may be wondering about a new command. What does the "%>%" symbol mean?
# These are called "pipes" and they tell R to do keep working on a sequence of steps. You can read them as "and then..." because they lead into the next action you want to do.

# Français: Finalement, avez-vous noté une nouvelle commande ? Quel est le sens de "%>%" ?
# Ce sont des "tuyaux" ("pipes") et ils signalent à R qu'il faut continuer avec une séquence d'étapes. Vous pouvez les lire comme "et puis..." parce qu'ils nous dirigent vers la prochaine action que vous voulez effectuer.

# Español: Finalmente, puede preguntarse sobre un nuevo comando. ¿Qué significa el símbolo "%>%"?
# Estos se llaman "pipes" y le dicen a R que siga trabajando en una secuencia de pasos. Puede leerlos como "y luego..." porque conducen a la siguiente acción que desea realizar.

# Português: Finalmente, você pode estar se perguntando sobre um novo comando. O que significa o símbolo "%>%"?
# Eles são chamados de "pipes" e dizem ao R para continuar trabalhando em uma sequência de etapas. Você pode lê-los como "e então..." porque eles levam à próxima ação que você deseja fazer.

# ============================================
# English: Exercise 6: summarize data
# Français: Exercice 6 : résumer les données
# Español: Ejercicio 6: resumir datos
# Português: Exercício 6: resumir dados
# ============================================

# English: Another common task in data analysis is to summarize data. You may want to know the average value of a variable, the maximum, or the variance.
# R has another powerful wrapper function to help you calculate these kind of summary statistics: summarise().
# Let's start with an example: let's take the mean and standard deviation of the variable tea.

# Français: Une autre tâche courante dans l'analyse des données consiste à résumer les données. Vous voudrez peut-être connaître la valeur moyenne d'une variable, la valeur maximum ou la variance.
# R dispose également d'une autre fonction utile qui peut vous aider à calculer des statistiques récapitulatives : summarise().
# Commençons par un exemple : calculons la moyenne et l'écart type de la variable tea.

# Español: Otra tarea común en el análisis de datos es resumir los datos. Es posible que desee conocer el valor promedio de una variable, el máximo o la varianza.
# R tiene otra función de envoltura poderosa para ayudarlo a calcular este tipo de estadísticas resumidas: summarise().
# Comencemos con un ejemplo: tomemos la media y la desviación estándar de la variable tea.

# Português: Outra tarefa comum na análise de dados é resumir os dados. Você pode querer saber o valor médio de uma variável, o máximo ou a variância.
# O R possui outra função de invólucro poderosa para ajudá-lo a calcular esse tipo de estatística resumida: summarise().
# Vamos começar com um exemplo: vamos pegar a média e o desvio padrão da variável tea.

experiment_data %>%
  summarise(mean(tea, na.rm = T),
            sd(tea, na.rm = T))

# English: We see that the mean of tea is 1.29 and the standard deviation is 2.70.
# We can also give those statistics names that are easier to read and use.

# Français: Nous voyons que la moyenne de tea est de 1.29 et l'écart type est de 2.70
# Nous pouvons également assigner des noms à ces statistiques qui sont plus faciles à lire et à utiliser.

# Español: Vemos que la media de tea es 1.29 y la desviación estándar es 2.70.
# También podemos dar nombres a esas estadísticas que son más fáciles de leer y usar.

# Português: Vemos que a média do chá é 1,29 e o desvio padrão é 2,70.
# Também podemos dar nomes a essas estatísticas que são mais fáceis de ler e usar.

experiment_data %>%
  summarise(Tea_mean = mean(tea, na.rm = T),
            Tea_sd = sd(tea, na.rm = T))

# English: Question: What are the mean, max, and min of the variable cote_divoire?
# Français: Question: Quels sont la moyenne, le maximum, et le minimum de la variable ivoirien?
# Español: Pregunta: ¿Cuáles son la media, el máximo y el mínimo de la variable cote_divoire?
# Português: Pergunta: Qual é a média, o máximo e o mínimo da variável cote_divoire?

# Your code here / Votre code ici / Su código aquí / Seu código aqui

# ===================================================
# English: Exercise 7: filter the data
# Français: Exercice 7 : filtrer les données
# Español: Ejercicio 7: filtrar los datos
# Português: Exercício 7: filtrar os dados
# ===================================================

# English: The last thing we'll learn now is how to filter the data, or look at only a subset of the observations.
# This is useful if we want to know something about a subset of the observations and is often used in combination with summarise().
# Let's start by filtering on Gender so that we are only looking at female participants in the experiment.

# Français: La dernière chose que nous allons apprendre est comment filtrer les données, c'est-à-dire ne regarder qu'un sous-ensemble d'observations.
# Cette fonction est utile si l'on veut savoir quelque chose sur un sous-ensemble d'observations et est souvent utilisée en combinaison avec summarise().
# Commençons par filtrer sur le genre afin de ne prendre en compte que les femmes qui ont participé à l'expérience.

# Español: Lo último que aprenderemos ahora es cómo filtrar los datos, o mirar solo un subconjunto de las observaciones.
# Esto es útil si queremos saber algo sobre un subconjunto de las observaciones y se usa a menudo en combinación con summarise().
# Comencemos filtrando por género para que solo estemos mirando a las participantes femeninas en el experimento.

# Português: A última coisa que aprenderemos agora é como filtrar os dados, ou olhar apenas um subconjunto das observações.
# Isso é útil se quisermos saber algo sobre um subconjunto das observações e é frequentemente usado em combinação com summarise().
# Vamos começar filtrando por gênero para que estejamos apenas olhando para as participantes femininas no experimento.

experiment_data %>%
  filter(Gender == "F")

# English: You should see only 10 out of the 24 observations in the dataset print out, and they all have "F" under the variable Gender.
# This code has "filtered" the data so that it only kept observations where Gender=="F".

# Français: Vous devriez voir uniquement 10 sur les 24 observations dans les données, et toutes les observations imprimées contiennent "F" dans la variable "Gender".
# Ce code a filtré les données pour garder uniquement les observations pour lesquelles Gender=="F".

# Español: Debería ver solo 10 de las 24 observaciones en el conjunto de datos que se imprimen, y todas tienen "F" en la variable Género.
# Este código ha "filtrado" los datos para que solo mantenga las observaciones donde Género == "F".

# Português: Você deve ver apenas 10 das 24 observações no conjunto de dados que são impressas, e todas têm "F" na variável Gênero.
# Este código "filtrou" os dados para que apenas mantivesse as observações em que Gênero == "F".

# English: We can also use count() and summarise() to run summarizing functions only on this group.
# This is where the "pipes" get really useful.
# Let's start by counting the values of the variable tea for female participants only.

# Français: Nous pouvons également utiliser "count()" et "summarise()" pour appliquer des fonctions de synthèse seulement sur cette groupe.
# Les tuyaux ("pipes") sont tres utiles dans cette étape.
# Commençons en comptant les valeurs de la variable "tea" pour les femmes uniquement.

# Español: También podemos usar count() y summarise() para ejecutar funciones de resumen solo en este grupo.
# Aquí es donde las "pipes" son realmente útiles.
# Comencemos contando los valores de la variable té solo para las participantes femeninas.

# Português: Também podemos usar count() e summarise() para executar funções de resumo apenas neste grupo.
# Aqui é onde os "pipes" são realmente úteis.
# Vamos começar contando os valores da variável chá apenas para as participantes femininas.

experiment_data %>%
  filter(Gender == "F") %>%
  count(tea)

# English: Questions: How many women in the data want tea (tea equals 1)? How many women in the data do not want tea (tea equals 0)?
# Français: Questions: Combien de femmes veulent du thé (tea == 1)? Combien de femmes ne veulent pas de thé (tea == 0)?
# Español: Preguntas: ¿Cuántas mujeres en los datos quieren té (té es igual a 1)? ¿Cuántas mujeres en los datos no quieren té (té es igual a 0)?
# Português: Perguntas: Quantas mulheres nos dados querem chá (chá é igual a 1)? Quantas mulheres nos dados não querem chá (chá é igual a 0)?

# Answer / Réponse / Respuesta / Resposta:

# English: We can also use filter() with summarise().
# Please modify the code below to calculate the mean of tea only for *men*.

# Français: Nous pouvons également utiliser "filter()" avec "summarise()".
# Modifiez le code suivant pour calculer la moyenne de la variable "tea" pour les *hommes* uniquement.

# Español: También podemos usar filter() con summarise().
# Modifique el código a continuación para calcular la media de té solo para *hombres*.

# Português: Também podemos usar filter() com summarise().
# Modifique o código abaixo para calcular a média de chá apenas para *homens*.

experiment_data %>%
  filter(Gender == ??) %>%
  summarise(tea_mean = ??) # who has the correct code here? / qui a le bon code ici? / ¿quién tiene el código correcto aquí? / quem tem o código correto aqui?

# English: Question: What is the mean of tea for men in the data?
# Français: Question: Quelle est la moyenne de la variable "tea" pour les hommes dans les données?
# Español: Pregunta: ¿Cuál es la media de té para los hombres en los datos?
# Português: Pergunta: Qual é a média de chá para os homens nos dados?

# Answer / Réponse / Respuesta / Resposta:
