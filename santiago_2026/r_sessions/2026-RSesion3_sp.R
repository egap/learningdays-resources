# ===========================================================================
# Sesión 3: Pruebas de hipótesis, Estimación y Potencia estadística
# Objetivos: (1) Probar la hipótesis de que el tratamiento no tuvo efecto,
#                en un experimento con asignación aleatoria completa y
#                con asignación por bloques.
#            (2) Estimar el efecto promedio del tratamiento en ambos diseños.
#            (3) Hacer un análisis de potencia estadística.
# ===========================================================================

# ===========================================================================
# Importar y configurar
# ===========================================================================

# Limpieza del entorno de trabajo
rm(list = ls())

# Cargamos las librerías necesarias
# install.packages("tidyverse")
# install.packages("randomizr")
# install.packages("estimatr")
library(tidyverse)
library(randomizr)
library(estimatr)
library(coin)

# Directorio de trabajo con nuestra base de datos
# La base de datos debe estar en nuestra carpeta: data_for_analysis.csv
setwd("C:/Ruta/A/Tu/Carpeta")

# Importamos la misma base de la Sesión 2
experiment_data <- read.csv("data_for_analysis.csv")

# Nuestra variable de resultado (Y) es state_of_world.
# El tratamiento ya asignado está en la columna treatment (1 = tratado).
experiment_data <- experiment_data %>%
  mutate(Y = state_of_world)

# Para que los resultados sean reproducibles:
set.seed(123)


# ===========================================================================
# 1. Pruebas de hipótesis
# ===========================================================================

# La hipótesis nula: el tratamiento no tuvo ningún efecto para nadie.
# El valor p responde: si la hipótesis nula fuera cierta, ¿qué tan a menudo
# veríamos una diferencia de medias tan grande como la observada, solo por
# el azar de la asignación?

# En nuestra base, exactamente 12 de 24 recibieron el tratamiento:
experiment_data %>% count(treatment)

# Paso 1: la diferencia de medias observada
diferencia_observada <- with(
  experiment_data,
  mean(Y[treatment == 1]) - mean(Y[treatment == 0])
)
diferencia_observada

# Paso 2: si el tratamiento no tuviera ningún efecto, Y sería igual con
# cualquier asignación. Repetimos la asignación completa 5000 veces y
# calculamos la diferencia de medias que produce solo el azar:
diferencias_bajo_nula <- replicate(5000, {
  asignacion_nueva <- complete_ra(N = 24, m = 12)
  with(
    experiment_data,
    mean(Y[asignacion_nueva == 1]) - mean(Y[asignacion_nueva == 0])
  )
})

# Paso 3: el valor p es la proporción de diferencias simuladas que son tan
# grandes (en valor absoluto) como la observada:
mean(abs(diferencias_bajo_nula) >= abs(diferencia_observada))

# Podemos ver la distribución del azar y dónde cae nuestra diferencia:
hist(
  diferencias_bajo_nula,
  main = "Diferencias de medias si el tratamiento no tuviera efecto",
  xlab = "Diferencia de medias bajo la hipótesis nula"
)
abline(v = diferencia_observada, col = "red", lwd = 2)

# Paso 4: Mas facil

set.seed(12345)
experiment_data$treatmentF <- factor(experiment_data$treatment)
p_facil <- oneway_test(
  Y ~ treatmentF,
  data = experiment_data,
  distribution = approximate(nresample = 1000),
  alternative = "less"
)

# Paso 5: Large sample approximation

p_facil_clt <- oneway_test(
  Y ~ treatmentF,
  data = experiment_data,
  distribution = "asymptotic",
  alternative = "less"
)

# Paso 6: Large sample approximation, test of the weak null
t.test(Y ~ treatmentF, data = experiment_data)
lm_robust(Y ~ treatmentF, data = experiment_data) %>%
  tidy() %>%
  select(term, p.value) %>%
  filter(term == "treatmentF1")

# ---------------------------------------------------------------------------
# 📝 EJERCICIO: Prueba de hipótesis con el diseño por bloques
#
# En este experimento la asignación se hizo por bloques según Gender:
# la mitad de las mujeres y la mitad de los hombres recibieron tratamiento.
table(experiment_data$Gender, experiment_data$treatment)
#
# 2. Calculen el valor p como en el Paso 4:

experiment_data$GenderF <- factor(experiment_data$Gender)
p_facil_clt_blk <- oneway_test(
  Y ~ treatmentF | GenderF,
  data = experiment_data,
  distribution = "asymptotic",
  alternative = "less"
)
p_facil_clt_blk
pvalue(p_facil_clt)


# ---------------------------------------------------------------------------

# ===========================================================================
# 2. Estimación del efecto promedio del tratamiento
# ===========================================================================

# ---------------------------------------------------------------------------
# 2a. Diseño con asignación aleatoria completa
# ---------------------------------------------------------------------------

# El estimador más simple: la diferencia de medias entre grupos.
# Primero calculamos el promedio de Y en cada grupo:
experiment_data %>%
  group_by(treatment) %>%
  summarise(promedio_Y = mean(Y))

# La función difference_in_means() calcula esa misma diferencia y además
# reporta el error estándar, el intervalo de confianza y el valor p
# (columna "Pr(>|t|)", comparen con el valor p de la sección 1):
estimacion_completa <- difference_in_means(
  Y ~ treatment,
  data = experiment_data
)
estimacion_completa

# ---------------------------------------------------------------------------
# 2b. Diseño con asignación aleatoria por bloques
# ---------------------------------------------------------------------------

# Cuando el diseño es por bloques, el estimador debe respetar los bloques:
# se calcula la diferencia de medias DENTRO de cada bloque y luego se
# promedian esas diferencias (ponderando por el tamaño del bloque).
estimacion_bloques <- difference_in_means(
  Y ~ treatment,
  blocks = Gender,
  data = experiment_data
)
estimacion_bloques

# ---------------------------------------------------------------------------
# 📝 EJERCICIO: Comparar los dos estimadores
#
# 1. Comparen las dos estimaciones (columna "Estimate"). ¿Son iguales o
#    diferentes? ¿Por qué?

# 2. Comparen los dos errores estándar (columna "Std. Error"). ¿Cuál es
#    más pequeño? (Los bloques suelen reducir el error estándar cuando la
#    variable de bloque predice la variable de resultado.)

# ---------------------------------------------------------------------------

# ===========================================================================
# 3. Análisis de potencia estadística
# ===========================================================================

# La potencia es la probabilidad de detectar un efecto (es decir, de
# rechazar la hipótesis nula de que no hay efecto) cuando el efecto
# verdadero existe. Antes de recolectar datos, preguntamos: con nuestro
# tamaño de muestra, ¿qué tan probable es detectar el efecto que esperamos?

# Imaginen que estamos PLANEANDO un experimento nuevo como el de ayer:
# 12 personas en tratamiento y 12 en control. Supongamos que el efecto
# verdadero es de 2 puntos (delta = 2) y que la desviación estándar de Y
# es de 2.5 (sd = 2.5):
power.t.test(n = 12, delta = 2, sd = 2.5, sig.level = 0.05)

# ¿Cuántas personas POR GRUPO necesitaríamos para una potencia de 80%?
power.t.test(delta = 2, sd = 2.5, sig.level = 0.05, power = 0.80)

# ---------------------------------------------------------------------------
# 📝 EJERCICIO: Potencia y tamaño del efecto
#
# 1. En la sección 2 estimamos un efecto de 3 puntos. Si el efecto
#    verdadero fuera de ese tamaño (delta = 3), ¿cuál sería la potencia
#    con n = 12 por grupo?

# 2. Con delta = 3, ¿cuántas personas por grupo se necesitan para una
#    potencia de 80%?

# 3. ¿Qué pasa con la potencia si el efecto es pequeño (delta = 1)?

# ---------------------------------------------------------------------------
