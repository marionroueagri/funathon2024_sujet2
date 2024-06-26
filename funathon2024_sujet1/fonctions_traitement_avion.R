

trafic_liaison_2019 <- function(df, village_depart, village_arrivee){
  
  village_depart <- tolower(village_depart)
  village_arrivee <- tolower(village_arrivee)
  
  village_depart <- ifelse(str_detect(village_depart, pattern = "paris"), "paris", village_depart)
  village_arrivee <- ifelse(str_detect(village_arrivee, pattern = "paris"), "paris", village_arrivee)
  
  df_liaison <- df %>% 
    mutate(LSN_DEP_NOM = tolower(LSN_DEP_NOM),
           LSN_ARR_NOM = tolower(LSN_ARR_NOM)) %>% 
    filter(str_detect(string = LSN_DEP_NOM, pattern = tolower(village_depart)) & 
             str_detect(string = LSN_ARR_NOM, pattern = tolower(village_arrivee)) |
             str_detect(string = LSN_ARR_NOM, pattern = tolower(village_depart)) & 
             str_detect(string = LSN_DEP_NOM, pattern = tolower(village_arrivee)))
  
  trafic_pkt <- df_liaison %>% 
    summarise(trafic_pkt = sum(LSN_DIST*LSN_PAX_loc)) %>% 
    pull(trafic_pkt)
  
  return(trafic_pkt)
  
}