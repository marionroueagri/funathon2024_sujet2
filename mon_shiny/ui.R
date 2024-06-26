# Exemple sur : https://shiny.posit.co/r/gallery/interactive-visualizations/bus-dashboard/
# code sur : https://github.com/rstudio/shiny-examples/blob/main/086-bus-dashboard/ui.R

header <- dashboardHeader(
  title = "Tableau de bord des aéroports français",
  titleWidth = 1000
)

body <- dashboardBody(
  fluidRow(
    column(width = 7,
           box(width = NULL,
               airDatepickerInput(inputId = "choix_date", label = "Mois choisi", value = "2019-01-01",
                                  view = "months", minView = "months",
                                  minDate = min(ymd(paste0(donnees_aeroport$anmois, "01"))),
                                  maxDate = max(ymd(paste0(donnees_aeroport$anmois, "01"))),
                                  dateFormat = "MMMM yyyy", language = "fr"),
               gt_output(outputId = "tableau_stat")
           )
    ),
    column(width = 5,
           box(width = NULL,
               leafletOutput("carte_leaflet", height = 300)
           ),
           box(title = "Fréquentation d'un aéroport", width = NULL, status = "warning", solidHeader = TRUE,
               selectInput(inputId = "choix_aeroport", label = "Aéroport choisi",
                           choices = liste_aeroports,
                           selected = "PARIS-CHARLES DE GAULLE (LFPG)"),
               plotlyOutput(outputId = "graph_freq")
           )
    )
  )
)

ui <- dashboardPage(
  skin = "yellow",
  header,
  dashboardSidebar(disable = TRUE),
  body
)