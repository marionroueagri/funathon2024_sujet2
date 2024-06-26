
plot_airport_line <- function(df, aeroport){
  
  aeroport_nom <- liste_aeroports[str_detect(string = liste_aeroports, pattern = aeroport)]
  aeroport_nom <- str_remove(string = aeroport_nom, pattern = "\\([A-Z]+\\)")
  
  df_graph <- df %>% 
    mutate(trafic = apt_pax_dep + apt_pax_arr + apt_pax_tr,
           date = ymd(paste0(anmois, "01"))) %>% 
    filter(apt == aeroport)
  
  graph <- df_graph %>% 
    plot_ly(x = ~date,
            y = ~trafic,
            type = "scatter",
            mode = "lines+markers",
            line = list(color = 'rgb(205, 12, 24)'),
            marker = list(color = 'rgb(205, 12, 24)')) %>% 
    layout(title = paste("Trafic mensuel de l'aéroport de", aeroport_nom),
           xaxis = list(title = ""),
           yaxis = list (title = "Nombre de passagers"))
  
  return(graph)
}



map_leaflet_airport <- function(df, airports_location, month, year){
  
  palette <- c("beige", "orange", "red")
  
  trafic_date <- df %>% 
    filter(mois == month & an == year) %>% 
    mutate(trafic = apt_pax_dep + apt_pax_arr + apt_pax_tr)
  
  trafic_aeroports <- airports_location %>% 
    select(-Nom, -(anmois:volume)) %>% 
    inner_join(trafic_date, by = c("Code.OACI" = "apt")) %>% 
    mutate(tercile = case_when(trafic < quantile(trafic, probs = 1/3) ~ 1,
                               trafic < quantile(trafic, probs = 2/3) ~ 2,
                               TRUE ~ 3),
           # tercile = ntile(trafic, n = 3)# solution du corrigé
           volume = palette[tercile])
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$volume
  )
  
  map_leaflet <- leaflet(trafic_aeroports) %>%
    addTiles() %>%
    addAwesomeMarkers(popup = ~paste0(apt_nom, " : ",
                                      format(trafic, big.mark = " "), " passagers "),
                      icon = icons) %>% 
    setView(lng = 2.38, lat = 48.72, zoom = 4)
  
  return(map_leaflet)
  
}

