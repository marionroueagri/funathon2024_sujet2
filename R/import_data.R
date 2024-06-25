# Import données aéroports ------------------------------------------------

import_airport_data <- function(list_files){
  
  list_df <- read_csv2(file = unlist(list_files), 
                             col_types = cols(ANMOIS = col_character(),
                                              APT = col_character(),
                                              APT_NOM = col_character(),
                                              APT_ZON = col_character(),
                                              .default = col_double()))
  
  list_df <- list_df %>% clean_data_frame()
  
  return(list_df)
}



# Import données compagnies -----------------------------------------------

import_compagnies_data <- function(list_files){
  
  list_df <- read_csv2(file = unlist(list_files), 
                             col_types = cols(ANMOIS = col_character(),
                                              CIE = col_character(),
                                              CIE_NOM = col_character(),
                                              CIE_NAT = col_character(),
                                              CIE_PAYS = col_character(),
                                              .default = col_double()))
  
  list_df <- list_df %>% clean_data_frame()
  
  return(list_df)
}



# Import données liaisons -------------------------------------------------

import_liaisons_data <- function(list_files){
  
  list_df <- read_csv2(file = unlist(list_files), 
                             col_types = cols(ANMOIS = col_character(),
                                              LSN = col_character(),
                                              LSN_DEP_NOM = col_character(),
                                              LSN_ARR_NOM = col_character(),
                                              LSN_SCT = col_character(),
                                              LSN_FSC = col_character(),
                                              .default = col_double()))
  
  list_df <- list_df %>% clean_data_frame()
  
  return(list_df)
}