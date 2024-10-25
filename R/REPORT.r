# Librerías
library(dlookr)
library(rmarkdown)

# Knowing the data
dt <- import("DATA/USING/cpnac2023.sav")

# Generar el reporte
report(dt, title = "Reporte de Análisis Exploratorio de Datos")

# Guardar el reporte como un archivo HTML
output_file <- "reporte_dlookr.html"
rmarkdown::render("path_to_your_r_script.R", output_file = output_file)


rmarkdown::pandoc_version()
