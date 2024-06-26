get_coordonnees_gare <- function(nom_gare){
  coord_gare <- stations_data %>% 
    filter(tolower(libelle) == tolower(nom_gare)) %>% 
    select(lat = y_wgs84, long = x_wgs84) %>% 
    mutate(lat = as.numeric(lat),
           long = as.numeric(long))
  return(c(lat = coord_gare$lat[1], long = coord_gare$long[1]))
}


temps_entre_deux_gare <- function(gare_depart, gare_arrivee){
  
  # Si les stations sont identiques aucun trajet nécessaire
  if (gare_depart == gare_arrivee) {
    return(NA)
  }
  
  coord_gare_depart <- get_coordonnees_gare(gare_depart)
  coord_gare_arrivee <- get_coordonnees_gare(gare_arrivee)
  
  resultat <- get_travel_time_api_response(api_url = "https://api.traveltimeapp.com/v4/routes",
                                           request_body = get_routes_api_json(coord_gare_depart, coord_gare_arrivee))
  
  # Gérer la limitation du taux d'API
  if (resultat[[2]] == 429) {
    cat("Trop de requêtes, attente d'une minute...\n")
    Sys.sleep(60)
    return(temps_entre_deux_gare(gare_depart, gare_arrivee))
  }
  
  # Vérifier l'existence d'un itinéraire valide
  if (length(resultat[[1]]$results[[1]]$locations) == 0) {
    travel_time <- Inf
  } else {
    # Extraire les données de temps de trajet et trouver le temps de trajet minimum en heures
    travel_times <- sapply(resultat[[1]]$results[[1]]$locations[[1]]$properties, function(item) item$travel_time)
    travel_time <- min(travel_times) / 3600
  }
  
  # Afficher le temps de trajet si verbose
  message_text <- sprintf("%s -> %s : %s heures\n", gare_depart, gare_arrivee, ifelse(is.infinite(travel_time), "Aucun itinéraire trouvé", round(travel_time, 2)))
  cat(message_text)
  
  return(list(resultat, travel_time))
}