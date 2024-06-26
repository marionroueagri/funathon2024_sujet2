

create_data_from_input <- function(df, month, year){
  
  df <- df %>% filter(mois == month & an == year)
  
  return(df)
}


summary_stat_airport <- function(df){
  
  df <- df %>% 
    group_by(apt, apt_nom) %>% 
    summarise(across(c(apt_pax_dep, apt_pax_arr, apt_pax_tr), sum), .groups = "drop") %>% 
    mutate(apt_pax_tot = apt_pax_dep + apt_pax_arr + apt_pax_tr) %>% 
    arrange(desc(apt_pax_tot)) %>% 
    mutate(apt_nom = str_replace_all(apt_nom, pattern = "_", replacement = " "),
           apt_nom = str_to_title(apt_nom),
           apt_nom = paste0(apt_nom, " (", apt, ")")) %>% 
    select(-apt)
  
  return(df)
}
