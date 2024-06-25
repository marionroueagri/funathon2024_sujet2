
plot_airport_line <- function(df, aeroport){
  
  aeroport_nom <- liste_aeroports$apt_nom[liste_aeroports$apt == aeroport]
  
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

