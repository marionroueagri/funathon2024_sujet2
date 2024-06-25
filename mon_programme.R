
# 1 - Packages ------------------------------------------------------------

library(dplyr)
library(tidyr)
library(stringr)
library(readr)
library(purrr)
library(yaml)



# 2 - Fonctions -----------------------------------------------------------

source("R/create_data_list.R")
source("R/clean_dataframe.R")
source("R/import_data.R")





# 3 - Données -------------------------------------------------------------

urls <- create_data_list("sources.yml")

donnees_aeroport <- import_airport_data(urls$airports)
donnees_compagnies <- import_compagnies_data(urls$compagnies)
donnees_liaisons <- import_liaisons_data(urls$liaisons)

