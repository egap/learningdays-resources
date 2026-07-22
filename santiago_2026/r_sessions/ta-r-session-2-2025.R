# R Session 2

# Primero, vamos a limpiar nuestro entorno de trabajo:

rm(list=ls())

# Luego, abrimos tidyverse y nuestros datos

library(tidyverse)
experiment_data <- read.csv("data_for_analysis.csv")

# Hoy vamos a usar randomización. 
# Por lo tanto, es importante usar set.seed antes para hacer 
# nuestros resultados replicables. 
# El número entre paréntesis no importa, pero siempre que corramos nuestro
# código con el mismo seed obtendremos los mismos resultados. 
# En este caso usaremos 123. 

_________(___)

# Con la misma lógica de la sesión anterior, vamos a usar mutate
# para crear en experiment_data una variable llamada treatment_simple.
# Básicamente estamos asignando un tratamiento en un experimento. 
# Vamos a usar rbinom (toma valores de una distribución binomial)
# Tres argumentos internos: n va a ser igual a n() (el número de observaciones
# en la base), size va a ser igual a 1 (un "try" por cada observación), y
# prob va a ser igual a 0.5 (0 o 1 con probabilidad 0.5). 

_______________ <- _______________ %>%
  ______(_____________________ = ______(n = __(), size = _, prob = ___))

# Qué pasa si size es igual a 100?
# Creemos experiment_data2 con el mismo código previo pero size = 100
# Veamos el resultado

__________________ <- _______________ %>%
  ______(_____________________ = ______(n = __(), size = ___, prob = ___))

# Volvamos a experiment_data. 
# Ahora, vamos a usar count para ver cuántas observaciones están bajo tratamiento
# y cuántas en el grupo de control

_____(_______________, _____________________)

# Calculando la media con summarise veremos lo mismo, 
# pero en términos de una proporción

_______________ %>% _________(_____(_____________________))

# Pregunta conceptual: mirando los datos de count, de dónde sale esa proporción?

# Y qué si yo quisiera 50% en tratamiento y 50% en control?
# Un modo de hacerlo es crear un vector con 50% de 0s y 50% de 1s, y que
# sumen el número de observaciones. En este caso, 12 0s y 12 1s. 
# El vector se llama treatment_statuses y se construye usando c()
# y dentro de eso, dos repeticiones con el comando rep. 
# El primer argumento es el valor, y el segundo la cantidad. 

_____________________ <- c(____(_,__), _____(_,__))

# Luego, en experiment_data creamos usando mutate una variable que 
# se llame treatment_complete. Usaremos sample con tres argumentos:
# el vector que ya creamos, size igual al número de observaciones (24),
# y replace = FALSE para que cada elemento se asigne a una observación.

_______________ <- _______________ %>%
  ______(______________________ = ______(_____________________, _____ = __, _______ = _____))

# Ahora repetimos el procedimiento de count y summarise anterior 
# para ver las diferencias

_______________ %>% _____(______________________ )

_______________ %>% _________(_____(______________________ ))

# Finalmente, vamos a trabajar con el paquete randomizr. 
# Instalamos y abrimos

install.packages("randomizr")
library(randomizr)

# Básicamente simplifica el proceso anterior. 

# Creamos experiment_data2 con experiment_data y una nueva variable
# llamada treatment_simple
# con el comando simple_ra y dos argumentos: N igual a n() (cantidad),
# y prob igual a 0.5.

__________________ <- _______________ %>%
  ______(_____________________ = ________(_ = __(), ___ = ___))

# Veamos con count qué pasó. Esto es equivalente a rbinom o a sample?

_____(__________________, _____________________)

# Ahora hagamos lo mismo, pero creando treatment_complete
# con el comando complete_ra y los mismos argumentos

__________________ <- _______________ %>%
  ______(______________________ = ___________(_ = __(), ____ = ___))

# Veamos con count qué pasó. Esto es equivalente a rbinom o a sample?

__________________ %>% _____(______________________ )

# Tres diseños más complejos. 
# Block randomization: asignación aleatoria dentro de subgrupos definidos
# por alguna/s característica/s previa/s. 
# Por ejemplo: tratamiento vs control entre varones y entre mujeres. 
# Creamos variable treatment_blocked usando block_ra, 
# con dos argumentos: prob siendo 0.5 y blocks siendo Gender. 

_______________ <- _______________ %>%
  ______(_______________________ = ________(______ = _______, ______ = ___))

# Observemos el resultado con count.  

_______________ %>% _____(_______________________)

# No cambia mucho. Ahora usemos table para ver cómo
# se cruzan Gender y treatment_blocked. 

_____(_______________$_______, _______________$_______________________)

# Luego, cluster randomization. Grupos de observaciones definidas por una
# o varias característica/s previa/s caen todas en tratamiento o todas en control.
# Por ejemplo, todas las observaciones del mismo país tienen la misma condición.
# Creamos treatment_cluster con cluster_ra, mismo argumento de probabilidad y otro
# argumento de clusters igual a HomeCountry. 

_______________ <- _______________ %>%
  ______(_______________________ = ____________(_______ = ___________, ____- = ___))

# Nuevamente, usamos una tabla para cruzar HomeCountry y treatment_Cluster

_____(_______________$______________, _______________$_______________________)

# Finalmente, block y cluster combinados. 
# Digamos que divido a las personas en salones en cada país con este código:

experiment_data <- experiment_data %>%
  mutate(Room = block_ra(blocks = HomeCountry, prob = 0.5))

# Ahora los tengo en salones, y voy a asignar mi tratamiento en cada país. 
# Esos salones son clusters... Pero los países son bloques.
# Primero, genero una variable que identifique la combinación de país y salón. 
# Ese será mi cluster (porque el paquete requiere que sea único por país).
# Usaremos este código:

experiment_data <- experiment_data %>%
  group_by(Gender, HomeCountry) %>%
  mutate(Room_Country = cur_group_id()) %>%
  ungroup()

# Luego, creamos treatment_bc en experiment_data usando
# block_and_cluster_ra con tres argumentos: prob igual a 0.5, 
# blocks siendo HomeCountry y clusters siendo Room_Country

_______________ <- _______________ %>%
  ______(_______________ = ________________________(______ = ____________, _______ = ________________, prob = ___))

# Usemos tablas para cruzar treatment_bc con HomeCountry y con Clusters. Qué vemos?

_____(_______________$______________, _______________$______________)
_____(_______________$______________, _______________$______________)
