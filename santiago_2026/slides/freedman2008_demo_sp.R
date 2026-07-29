# ===========================================================================
# Demostración: Freedman (2008), "Randomization does not justify logistic
# regression", Statistical Science 23(2):237-249.
#
# El punto: en un experimento aleatorizado con resultado binario, el
# COEFICIENTE de Z en la regresión logística ajustada por covariables es un
# estimador sesgado de la diferencia marginal de log-odds
#     delta = logit(media(Y_Z_1)) - logit(media(Y_Z_0)),
# y ese sesgo NO disminuye al crecer N (no-colapsabilidad del odds ratio:
# el coeficiente apunta al efecto CONDICIONAL en la covariable, no al
# marginal). En cambio, el estimador "plug-in" de Freedman --- promediar
# las probabilidades predichas del MISMO modelo ajustado bajo Z=1 y Z=0 y
# tomar la diferencia de log-odds --- sí es consistente. La logística SIN
# covariables está saturada, así que reproduce exactamente la diferencia
# de log-odds observada y tampoco tiene este sesgo.
#
# Para que el sesgo sea visible, la covariable debe predecir FUERTEMENTE
# el resultado: aquí prob(Y=1) = plogis(1*Z + 2*x2) con x2 ~ Normal(0,1).
# (Con un efecto débil de la covariable, como 0.05 en la escala de
# probabilidad, la brecha condicional-marginal es ~0.001: invisible.)
# ===========================================================================

library(randomizr)
library(ggplot2)

set.seed(20260729)

# ---------------------------------------------------------------------------
# Una realización de los datos, para ver los tres estimadores una vez
# ---------------------------------------------------------------------------

una_simulacion <- function(N) {
  x2 <- rnorm(N)
  ## Resultados potenciales en la escala logit: efecto condicional = 1
  Y0 <- rbinom(N, 1, plogis(0 + 2 * x2))
  Y1 <- rbinom(N, 1, plogis(1 + 2 * x2))
  Z <- complete_ra(N, m = floor(N / 2))
  Y <- Z * Y1 + (1 - Z) * Y0

  ## El estimando: diferencia MARGINAL de log-odds en esta muestra
  delta <- qlogis(mean(Y1)) - qlogis(mean(Y0))

  ## Estimador 1: logística sin covariables (saturada)
  glm_sin <- glm(Y ~ Z, family = binomial)

  ## Estimador 2: coeficiente de la logística ajustada por x2
  glm_con <- glm(Y ~ Z + x2, family = binomial)

  ## Estimador 3: plug-in de Freedman con el MISMO modelo ajustado:
  ## predecimos la probabilidad de cada unidad bajo Z=1 y bajo Z=0,
  ## promediamos, y tomamos la diferencia de log-odds
  p1 <- mean(predict(glm_con, newdata = data.frame(Z = 1, x2 = x2), type = "response"))
  p0 <- mean(predict(glm_con, newdata = data.frame(Z = 0, x2 = x2), type = "response"))

  c(
    estimando = delta,
    logit_sin_cov = coef(glm_sin)[["Z"]],
    logit_coef_ajustado = coef(glm_con)[["Z"]],
    freedman_plugin = qlogis(p1) - qlogis(p0)
  )
}

## Con N = 1000: el coeficiente ajustado queda lejos del estimando;
## los otros dos quedan cerca
round(una_simulacion(N = 1000), 3)

# ---------------------------------------------------------------------------
# ¿El sesgo disminuye con N? Repetimos el experimento 1000 veces por cada N
# ---------------------------------------------------------------------------

sesgo_por_N <- function(N, sims = 1000) {
  res <- replicate(sims, una_simulacion(N))
  ## sesgo = promedio de (estimación - estimando) sobre las simulaciones
  sesgos <- rowMeans(res[-1, ] - rep(res["estimando", ], each = 3))
  data.frame(N = N, estimador = names(sesgos), sesgo = sesgos, row.names = NULL)
}

los_N <- c(100, 250, 500, 1000, 2000)
resultados <- do.call(rbind, lapply(los_N, sesgo_por_N))

## La tabla: el coeficiente ajustado se queda en ~0.4 aunque N crezca 20 veces
tabla <- reshape(resultados, idvar = "N", timevar = "estimador", direction = "wide")
names(tabla) <- sub("sesgo\\.", "", names(tabla))
print(tabla, digits = 2, row.names = FALSE)

# ---------------------------------------------------------------------------
# La gráfica: sesgo contra tamaño de muestra
# ---------------------------------------------------------------------------

etiquetas <- c(
  logit_coef_ajustado = "Coeficiente logit ajustado por x2",
  freedman_plugin = "Plug-in de Freedman (mismo modelo)",
  logit_sin_cov = "Logit sin covariables (saturado)"
)
resultados$estimador <- factor(resultados$estimador,
  levels = names(etiquetas), labels = etiquetas
)

## Colores de Okabe-Ito (seguros para daltonismo); la forma del punto
## distingue las series además del color
colores <- c("#D55E00", "#0072B2", "gray30")

g <- ggplot(resultados, aes(x = N, y = sesgo, color = estimador, shape = estimador)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray60") +
  geom_line(linewidth = 0.8) +
  geom_point(size = 3) +
  scale_x_log10(breaks = los_N) +
  scale_color_manual(values = colores) +
  labs(
    x = "Tamaño de muestra N (escala logarítmica)",
    y = "Sesgo (estimación - estimando)",
    color = NULL, shape = NULL,
    title = "El sesgo del coeficiente logit ajustado no disminuye con N",
    subtitle = "Estimando: diferencia marginal de log-odds. 1000 simulaciones por cada N.",
    caption = "Freedman (2008): la aleatorización no justifica la regresión logística."
  ) +
  theme_minimal(base_size = 16) +
  theme(
    legend.position = "bottom",
    legend.direction = "vertical",
    panel.grid.minor = element_blank()
  )

print(g)

ggsave("freedman2008_bias_vs_N.png", g, width = 9, height = 6.5, dpi = 150)
