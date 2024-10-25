# Libraries
library(rio)
library(tidyverse)
library(dplyr)
library(dlookr)
library(ggplot2)
library(writexl)

# Knowing the data
dt <- import("DATA/USING/cpnac2023.sav")

###
# -----------
# Variables with labels
labels_list <- sapply(dt, function(x) attr(x, "labels"))
labels_list <- labels_list[!sapply(labels_list, is.null)]
# -----------
###

hist(dt$cp_distancia_1)
hist(dt$cp_distancia_2)

# cp_k408
# Extrae las etiquetas de los datos usando `attr`
# labels_cp_k408 <- attr(dt$cp_k408, "labels") # AL NO TENER LABELS USAREMOS EL MÉTODO DE ABAJO

# Define los niveles y las etiquetas manualmente para la variable cp_k408
dt$cp_k408 <- factor(dt$cp_k408,
                     levels = c(1, 2, 3, 4),
                     labels = c("Común", "Mejorada", "Híbrida Nacional", "Híbrida Internacional"))

# Crea el gráfico con ggplot2
ggplot(dt, aes(x = cp_k408)) +
    geom_bar(fill = "gray70", color = "black") +  # Color neutro para las barras
    labs(x = "Tipo de Semilla", y = "Frecuencia", title = "Semilla de más uso") +  # Etiquetas de ejes y título
    theme_minimal()  # Tema minimalista

# Crea el gráfico, omitiendo los valores NA
ggplot(dt, aes(x = cp_k408)) +
    geom_bar(fill = "gray70", color = "black") +
    scale_x_discrete(drop = TRUE) +  # Ignora los valores NA en el eje x
    labs(x = "Tipo de Semilla", y = "Frecuencia", title = "Semilla de más uso") +
    theme_minimal()
