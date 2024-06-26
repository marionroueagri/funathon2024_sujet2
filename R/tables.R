tableau_html_stat <- function(df, month, year){
  
  df_stats <- summary_stat_airport(create_data_from_input(df, month, year))
  
  month_litt <- c("Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                  "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre")
  month_litt <- month_litt[as.numeric(month)]
  
  tableau_stat <- gt(df_stats) %>% 
    fmt_number(columns = where(is.numeric), suffixing = TRUE) %>% 
    cols_label(apt_nom = md("**Aéroport**"),
               apt_pax_dep = md("**Départs**"),
               apt_pax_arr = md("**Arrivées**"),
               apt_pax_tr = md("**Transit**"),
               apt_pax_tot = md("**Total**")) %>% 
    tab_header(title = md("**Statistiques de fréquentation**"),
               subtitle = paste("Classement des aéroports :", month_litt, year)) %>% 
    tab_source_note(source_note = "Source: DGAC, à partir des données sur data.gouv.fr") %>% 
    opt_interactive()
  
  return(tableau_stat)
}
