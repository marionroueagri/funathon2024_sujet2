
# Nettoyage générique -----------------------------------------------------

clean_data_frame <- function(df){
  df <- df %>% 
    mutate(an = substr(ANMOIS, 1, 4),
           mois = substr(ANMOIS, 5, 6),
           mois = str_remove(mois, pattern = "^0")) %>% 
    rename_with(str_to_lower)
  return(df)
}
