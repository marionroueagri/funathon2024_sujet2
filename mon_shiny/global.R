
# 1 - Packages ------------------------------------------------------------

library(dplyr)
library(tidyr)
library(stringr)
library(readr)
library(yaml)
library(sf)
library(leaflet)
library(lubridate)
library(ggplot2)
library(plotly)
library(gt)
library(shiny)
library(shinydashboard)
library(shinyWidgets)

# 2 - Fonctions -----------------------------------------------------------

source("R/create_data_list.R")
source("R/clean_dataframe.R")
source("R/import_data.R")
source("R/figures.R")
source("R/divers_functions.R")
source("R/tables.R")



# 3 - Données -------------------------------------------------------------

urls <- create_data_list("sources.yml")

donnees_aeroport <- import_airport_data(urls$airports)
donnees_compagnies <- import_compagnies_data(urls$compagnies)
donnees_liaisons <- import_liaisons_data(urls$liaisons)

airports_location <- st_read(urls$geojson$airport)

liste_aeroports <- unique(paste0(donnees_aeroport$apt_nom, " (", donnees_aeroport$apt, ")"))
liste_aeroports <- sort(liste_aeroports)
