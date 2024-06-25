create_data_list <- function(source_file){
  return(yaml::read_yaml(source_file))
}