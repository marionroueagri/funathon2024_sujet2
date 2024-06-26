
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

# leaflet(airports_location) %>% 
#   addTiles() %>% 
#   addMarkers(popup = ~Nom)



# 4 - Valorisation 1 : le trafic par aéroport -----------------------------

liste_aeroports <- donnees_aeroport %>% distinct(apt, apt_nom)

# Tracé Toulouse
plot_airport_line(donnees_aeroport, "LFBO")
# Tracé Brest
plot_airport_line(donnees_aeroport, "LFRB")




# 4 - Valorisation 2 : Tableau HTML pour afficher les données -------------

# https://gt.rstudio.com/articles/gt.html#a-walkthrough-of-the-gt-basics-with-a-simple-table

# Truc qu'on a fait et qui sert probablement à rien :
# create_data_from_input(donnees_aeroport, "4", "2020")
# Donc finalement on a fait ça à la place :
# create_data_from_input(donnees_aeroport, "2020")

tableau_html_stat(donnees_aeroport, "2020")




# 4 - Valorisation 3 : Carte des aéroports --------------------------------

map_leaflet_airport(donnees_aeroport, airports_location, month = "4", year = "2022")


