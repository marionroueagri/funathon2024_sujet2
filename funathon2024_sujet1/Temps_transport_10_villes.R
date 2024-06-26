library(dplyr)
library(tidyr)
library(purrr)
library(readr)

source("funathon2024_sujet1/fonctions_requetes.R")
source("funathon2024_sujet1/fonctions_traitement.R")


# Lecture et correction des données
STATIONS_DATA_URL <- "https://www.data.gouv.fr/fr/datasets/r/d22ba593-90a4-4725-977c-095d1f654d28"
stations_data <- read.csv2(STATIONS_DATA_URL)

# Correction Strasbourg
stations_data$x_wgs84[stations_data$libelle == "Strasbourg-Ville"] <- "7.735626"
stations_data$y_wgs84[stations_data$libelle == "Strasbourg-Ville"] <- "48.584488"
  

# Matrice des gares principales
gares_principales <- c("Paris-Nord", 
                       "Lyon-Perrache", 
                       "Marseille-St-Charles", 
                       "Toulouse-Matabiau", 
                       "Lille-Flandres", 
                       "Bordeaux-St-Jean", 
                       "Nice-Ville", 
                       "Nantes", 
                       "Strasbourg-Ville",
                       "Montpellier-St-Roch")

matrice_gares_principales <- expand.grid(gares_principales, gares_principales) %>% 
  rename(gare_depart = Var1, gare_arrivee = Var2)

# On réduit le nombre de requêtes à lancer en disant a -> b = b -> a
matrice_gares_principales_reduite <- matrice_gares_principales %>% 
  mutate(gare_depart = as.character(gare_depart),
         gare_arrivee = as.character(gare_arrivee)) %>% 
  filter(gare_depart > gare_arrivee)

# On lance les requêtes
resultat_requetes <- map2(.x = matrice_gares_principales_reduite$gare_depart,
                          .y = matrice_gares_principales_reduite$gare_arrivee,
                          possibly(temps_entre_deux_gare, otherwise = "Echec !"))
# Finalement, seul le temps de trajet nous intéresse
matrice_gares_principales_reduite$temps <- map_dbl(.x = resultat_requetes,
                                                   ~ .x[[2]])

# On reporte dans la table complète et on transpose pour avoir une vraie matrice
matrice_gares_principales <- matrice_gares_principales %>% 
  left_join(matrice_gares_principales_reduite, 
            by = c("gare_depart", "gare_arrivee")) %>% 
  left_join(matrice_gares_principales_reduite, 
            by = c("gare_depart" = "gare_arrivee", "gare_arrivee" = "gare_depart"),
            suffix = c("_1", "_2")) %>% 
  mutate(temps_trajet = case_when(is.na(temps_1) & is.na(temps_2) ~ NA,
                                  is.na(temps_1) ~ temps_2,
                                  is.na(temps_2) ~ temps_1)) %>% 
  select(-temps_1, -temps_2) %>% 
  pivot_wider(names_from = gare_arrivee, values_from = temps_trajet)
  
write_csv2(matrice_gares_principales, "funathon2024_sujet1/matrice_temps_gares_10_principales.csv")
  
remove(matrice_gares_principales_reduite, resultat_requetes)
