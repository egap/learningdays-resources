
# Welcome to R! In this first activity, we will help you get a flavor of basic data analysis in R.
# Goals: learn how to load data, inspect data to see what variables there are, and to conduct basic data summaries
# Bienvenue dans R! Dans cette première activité, nous allons vous donner un aperçu de l'analyse de données avec R.
# Objectifs: apprendre à charger les données, inspecter les données pour voir les variables, et les "résumer".

# Let's get started! Commençons!

# <- this is a comment in the code, starting with a #. We'll use these to provide instructions. 
# <- Ceci est un commentaire dans le code. Nous les utiliserons pour donner des informations.
# === 
# Exercise 1: download the data / télécharger les données

# First, you need to download the data. Follow the instructions from the instructors to place the .csv file
# in the directory where your R project is. You should see a file called "learningdays.Rproj" in the folder where you put the data.
# Tout d'abord, vous devez télécharger les données. Ecoutez les instructeurs pour placer le fichier .csv dans le répertoire
# où se trouve votre projet R. Vous devriez voir un fichier "learningdays.Rproj" dans le dossier où vous avez mis les données.

# Let's check if things are working: is the data in the folder where it should be?
# To do this, you can use the dir() function. 
# (A function is an R command. When you run a function, you provide inputs (sometimes none) and R does something and returns outputs.)
# The dir() function takes no inputs (that's why there is nothing inside the parentheses) and returns a list of the files in the *current folder/directory*.
# Vérifions si les choses fonctionnent : les données sont-elles dans le dossier où elles devraient être ?
# Pour ce faire, vous pouvez utiliser la fonction dir().
# (Une fonction est une commande R. Lorsque vous exécutez une fonction, vous fournissez des entrées (parfois aucune) et R fait quelque chose et renvoie des sorties.)
# La fonction dir() ne prend pas d'entrées (c'est pourquoi il n'y a rien à l'intérieur des parenthèses) et renvoie une liste des fichiers dans le répertoire/dossier actuel.

# In the exercises, starting with the line below, to run a command you can put your cursor on the line of code and press CTRL+ENTER (Windows) or COMMAND+ENTER (Mac)
# You can also copy-paste the line of code into the "Console". The console is in another part of the screen from this code (ask an instructor if you can't find it).
# Dans les exercices, à partir de la ligne ci-dessous, pour exécuter une commande, vous pouvez mettre votre curseur sur la ligne de code et appuyer sur CTRL+ENTER (Windows) ou COMMAND+ENTER (Mac)
# Vous pouvez également copier-coller la ligne de code dans la "Console". La console est dans une autre partie de l'écran.
dir()

# Question 1: is the data file you downloaded in the list that the function returned? If not, please consult an instructor. 
# Question 1: le fichier de données que vous avez téléchargé figure-t-il dans la liste renvoyée par la fonction? Si ce n'est pas le cas, appelez l'instructeur.
# Answer / Réponse

# ===
# Exercise 2: read in the data / lire les données

# With the packages loaded, we can now read in the data. That means R will read the file and then add it as an object to your "workspace" where we can analyze it.
# We can do this via the read_csv function, which takes a filename you provide and reads that file and creates an R data object, called a data frame.
# Avec les packages chargés, nous pouvons maintenant lire les données. Cela signifie que R va lire le fichier et l'ajouter en tant qu'objet à votre "workspace" où nous pouvons l'analyser.
# Nous pouvons le faire via la fonction read_csv, qui prend un nom de fichier en entrée, lit le fichier et crée un objet de données R, appelé un data frame.

experiment_data <- read.csv("data_for_analysis.csv")

# Question: find the "environment" tab in your RStudio window. Ask for help from an instructor or someone next to you if you don't see it. Does the object called experiment_data show up under environment?
# Question : trouvez l'onglet "environnement" dans RStudio. Demandez de l'aide à un instructeur ou à quelqu'un à côté de vous si vous ne le voyez pas. L'objet appelé experiment_data y apparaît-il ?

# Answer / Réponse:

# Now to step back for one moment to explain what we just did. There were three parts to what we typed: the function call -- read_csv("data_for_analysis.csv") -- which runs the read_csv function. Then there was <- which is how we give that object a name and save it. The third part is the name. So when you read that line of code, we're going to read in the data from the file data_for_analysis.csv and save it to the object named experiment_data.
# Maintenant, expliquons ce que nous venons de faire. Il y avait trois parties à ce que nous avons tapé : l'appel de fonction - read_csv("data_for_analysis.csv") - qui exécute la fonction read_csv. Ensuite, il y avait <- qui est la façon dont nous donnons un nom à cet objet et l'enregistrons. La troisième partie est le nom. Donc, lorsque vous lisez cette ligne de code, nous allons lire les données du fichier data_for_analysis.csv et les enregistrer dans l'objet nommé experiment_data.

# ===
# Exercise 3: inspect the data / inspecter les données

# Take a moment to look at the data itself. To do this, find the Environment tab and click once on the object experiment_data. That brings up the "data viewer." This is always a good place to start to see what's in the data.
# Prenez un moment pour regarder les données elles-mêmes. Pour ce faire, dans l'onglet Environnement et cliquez une fois sur l'objet experiment_data. Cela ouvre le "data viewer". C'est toujours un bon endroit pour commencer à voir ce qu'il y a dans les données.
# Question: what are the variable names in the data?
# Question : quels sont les noms de variables dans les données ?

# Answer / Réponse:

