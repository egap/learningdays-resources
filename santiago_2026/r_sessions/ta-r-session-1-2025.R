# R Session 1

# Primero, vamos a limpiar nuestro entorno de trabajo:

rm(list=ls())

# Luego, vamos a ver en qué carpeta estamos trabajando. 
# Esto es el working directory.

getwd()

# En nuestro working directory deben estar los datos que vamos a usar. 
# Ahora hay dos opciones: o ponemos nuestros datos en el WD que tenemos, 
# o cambiamos de WD.

# Para cambiar:

# setwd("Directorio/Carpeta/Subcarpeta")

# Una vez que nos aseguramos de que nuestros datos data_for_analysis.csv 
# están en nuestro WD, vamos a sumarlos a nuestro entorno en un objeto 
# que se llame experiment_data. Lo vamos a hacer con el comando read.csv. 

____________ <- ________("data_for_analysis.csv")

# Ahora que nuestros datos están cargados, vamos a instalar
# una serie de paquetes que necesitamos. Los paquetes son básicamente
# listas de funciones, datos y documentación. 
# Este paquete, que incluye varios, se llama "tidyverse". 
# Instalamos con el comando install.packages, y abrimos con el comando library.
# En el primer caso, "tidyverse" va con comillas. En el segundo, sin.

_______________ (_________)

________(_________)

# Ahora, vamos a crear tres variables nuevas en experiment_data:
# tea (ya tienen el código debajo)
# coffee (su valor es 1)
# colombian (1 si HomeCountry es igual a Colombia, 0 si no)
# Para esta última se usa el comando "ifelse".

__________ <- __________ %>% 
  _________(tea = c(0,1,0,1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1),
            _______ = ______,
         ______ = ______(_________ == _________, ___, __))

# Y si queremos contar los 0s y 1s en la variable tea?
# Usamos count. El primer argumento es el nombre de la base, 
# y el segundo el de la variable.

___________(_________, ___________)

# Repetimos el ejercicio, pero para contar las observaciones que 
# pertenecen a Colombia (usar la variable colombian que ya creamos)

___________(_________, ___________)

# Ahora me interesa ver cuál es la media de la variable "tea". 
# Para eso, uso mean sobre esa variable. 
# Puedo llamarla usando el nombre de la base de datos y de la variable
# separadas por el signo $. 
# Nota: se agrega el na.rm = T para que R saque los missing values, 
# dado que no permiten el cálculo de la media. 

_______(______$____, na.rm = T)

# Opcional: puedo hacer lo mismo con sd, min y max para obtener esos valores. 

_______(______$____, na.rm = T)

_______(______$____, na.rm = T)

_______(______$____, na.rm = T)


# Y si quiero hacer todo junto?
# En ese caso, conviene llamar la base de datos con el "pipe operator"
# y usar summarise con los cuatro valores (mean, sd, min, max).
# También vamos a poner nombres: Media, SD, Mínimo y Máximo. 

__________ %>% 
  ____________(_____ = ___(tea, na.rm = T),
               _____ = ___(tea, na.rm = T),
               _____ = ___(tea, na.rm = T),
               _____ = ___(tea, na.rm = T))

# Ahora calculemos la media de tea, treatment y colombian. 
# Mismo procedimiento.
# Las llamaremos Media_tea, Media_tre y Media_col

__________ %>% 
  __________(______ = _____(____, na.rm = T),
             ____ = ____(____, na.rm = T),
             ____ = ____(____, na.rm = T))

# Ahora vamos a crear un objeto llamado summary, 
# que va a tener resultados de cálculos hechos a partir de experiment_data.
# Vamos a obtener la media de "tea" por país y género. 
# Para eso, usamos primero group_by con las variables HomeCountry y Gender
# Luego, usamos summarise para crear Media_tea igual que antes

_______ <- __________ %>% 
  _______(_______, _______) %>% 
  _______(_______ = _______(_______, na.rm = T))

# Esto también se puede hacer solo para mujeres y solo para hombres
# por separado. Para eso vamos a crear dos objetos: experiment_data_F y
# experiment_data_M. Primero, usaremos filter para quedarnos solo con observaciones
# con gender igual a F en el primer caso e igual a M en el segundo.
# Luego se procede como anteriormente. 

_______________ <- ______________ %>% 
  ______(_______ == "__") %>% 
  _________(_____________) %>% 
  __________(__________ = ______(____, na.rm = T))

_______________ <- ______________ %>% 
  ______(_______ == "__") %>% 
  _________(_____________) %>% 
  __________(__________ = ______(____, na.rm = T),
             ___________ = ______(__________, na.rm = T))
