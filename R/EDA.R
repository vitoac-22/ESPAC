# Libraries
library(rio)
library(tidyverse)
library(dplyr)
library(dlookr)
library(ggplot2)
library(writexl)
library(markdown)

# Knowing the data
dt <- import("DATA/USING/cpnac2023.sav")

###
# -----------
# Variables with labels
labels_list <- sapply(dt, function(x) attr(x, "labels"))
labels_list <- labels_list[!sapply(labels_list, is.null)]
# -----------
###

dlookr::transformation_web_report(dt)
