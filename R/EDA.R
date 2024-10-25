# Libraries
library(rio)
library(tidyverse)
library(dplyr)
library(dlookr)
library(ggplot2)
library(writexl)
library(markdown)
library(descr)

# Knowing the data
dt <- import("DATA/USING/cpnac2023.sav")

###
# -----------
# Variables with labels
labels_list <- sapply(dt, function(x) attr(x, "labels"))
labels_list <- labels_list[!sapply(labels_list, is.null)]
# -----------
###

dlookr::describe(dt)

# -------
# cp_k412
# ------
View(dt)
dim(dt)

pdd <- dt %>% 
  select(cp_k412, ual_prov, fact_exp_fin) %>% 
  na.omit(cp_k412)

unique(is.na(pdd$cp_k412))
unique(is.na(pdd$ual_prov))
unique(is.na(pdd$fact_exp_fin))

pdd$cp_k412 <- factor(pdd$cp_k412,
                     levels = c(1, 2, 3, 4, 5, 6),
                     labels = c("Sequía", "Helada","Plagas","Enfermedades","Inundación","Otra"))
summary(pdd$cp_k412)
unique(pdd$cp_k412)
attr(pdd$cp_k412, 'labels')
View(pdd)
dim(pdd)

# Calcular las frecuencias y el porcentaje de cada categoría en la columna cp_k412, ignorando los NA
pdd_summary <- pdd %>%
  filter(!is.na(cp_k412)) %>%  # Elimina los NA
  count(cp_k412) %>%           # Calcula la frecuencia de cada categoría
  mutate(percentage = n / sum(n) * 100) %>%  # Calcula el porcentaje
  arrange(desc(n))              # Ordena de mayor a menor frecuencia

# Crear la gráfica ordenada y con etiquetas de porcentaje
ggplot(pdd_summary, aes(x = reorder(cp_k412, -n), y = n)) +  # Ordena de mayor a menor
  geom_bar(stat = "identity", fill = "gray70", color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")),  # Añade el porcentaje sobre las barras
            vjust = -0.5, size = 3) +
  labs(x = "Razón de Pérdida", y = "Frecuencia", title = "Principales razones de pérdida de superficie agrícola") +
  theme_minimal()

freq(dt$cp_k412)
# -------



# -------
# ual_prov
# ------
attr(dt$ual_prov, 'labels')

# Definir los niveles y las etiquetas
niveles <- c("10", "90", "01", "11", "21", "02", "12", "22", "03", "13", 
             "23", "04", "14", "24", "05", "15", "06", "16", "07", "17", 
             "08", "18", "09", "19")
etiquetas <- c("IMBABURA", "ZONA NO DELIMITADA", "AZUAY", "LOJA", "SUCUMBÍOS", 
               "BOLÍVAR", "LOS RÍOS", "ORELLANA", "CAÑAR", "MANABÍ", 
               "SANTO DOMINGO DE LOS TSÁCHILAS", "CARCHI", "MORONA SANTIAGO", 
               "SANTA ELENA", "COTOPAXI", "NAPO", "CHIMBORAZO", "PASTAZA", 
               "EL ORO", "PICHINCHA", "ESMERALDAS", "TUNGURAHUA", "GUAYAS", 
               "ZAMORA CHINCHIPE")

# Convertir la variable en factor con los niveles y etiquetas definidos
pdd$ual_prov <- factor(pdd$ual_prov, levels = niveles, labels = etiquetas)


pdd_prov <- pdd %>% 
  filter(cp_k412 == "Plagas") %>%  # Elimina los NA
  count(ual_prov) %>%           # Calcula la frecuencia de cada categoría
  mutate(percentage = n / sum(n) * 100) %>%  # Calcula el porcentaje
  arrange(desc(n)) %>% 
  head(7)

# Crear la gráfica ordenada y con etiquetas de porcentaje
ggplot(pdd_prov, aes(x = reorder(ual_prov, -n), y = n)) +  # Ordena de mayor a menor
  geom_bar(stat = "identity", fill = "gray70", color = "black") +
  geom_text(aes(label = paste0(round(percentage, 1), "%")),  # Añade el porcentaje sobre las barras
            vjust = -0.5, size = 3) +
  labs(x = "Provincias", y = "Frecuencia", title = "Principales provincias con pérdida de superficie agrícola") +
  theme_minimal()


# ------




