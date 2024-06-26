library(dplyr)
library(tidyr)
library(purrr)
library(stringr)

source("funathon2024_sujet1/fonctions_requetes.R")
source("funathon2024_sujet1/fonctions_traitement.R")
source("funathon2024_sujet1/fonctions_traitement_avion.R")

# On définit l'URL des données
AIR_TRAFFIC_DATA_URL <- "https://www.data.gouv.fr/fr/datasets/r/0c0a451e-983b-4f06-9627-b5ff1bccd2fc"
air_traffic_df <- read.csv2(AIR_TRAFFIC_DATA_URL)

# Trafic aérien sur la ligne Paris Toulouse
trafic_liaison_2019(air_traffic_df, "Paris", "Toulouse")
