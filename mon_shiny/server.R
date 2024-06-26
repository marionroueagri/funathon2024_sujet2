server <- function(input, output) { 
  
  output$tableau_stat <- render_gt({
    month_choisi <- month(input$choix_date)
    year_choisi <- year(input$choix_date)
    tableau_html_stat(donnees_aeroport, month = month_choisi, year = year_choisi)
  })
  
  output$carte_leaflet <- renderLeaflet({
    month_choisi <- month(input$choix_date)
    year_choisi <- year(input$choix_date)
    map_leaflet_airport(donnees_aeroport, airports_location, month = month_choisi, year = year_choisi)
  })
  
  output$graph_freq <- renderPlotly({
    aeroport_choisi <- input$choix_aeroport
    aeroport_choisi <- str_extract(string = aeroport_choisi, pattern = "(?<=\\()[A-Z]+(?=\\))")
    print(aeroport_choisi)
    plot_airport_line(donnees_aeroport, aeroport_choisi)
  })
  
}
