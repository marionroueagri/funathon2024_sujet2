library(yaml)

get_routes_api_json <- function(coords1, coords2) {
  # On créé le JSON pour l'API de routage en se basant sur celui de la sous-partie "Interaction avec l'API de routage de TravelTime"
  request_body <- sprintf('{
    "locations": [
      {
        "id": "point-from",
        "coords": {
          "lat": %f,
          "lng": %f
        }
      },
      {
        "id": "point-to-1",
        "coords": {
          "lat": %f,
          "lng": %f
        }
      }
    ],
    "departure_searches": [
      {
        "id": "departure-search",
        "transportation": {
          "type": "public_transport",
          "walking_time": 900,
          "cycling_time_to_station": 100,
          "parking_time": 0,
          "boarding_time": 0,
          "driving_time_to_station": 1800,
          "pt_change_delay": 0,
          "disable_border_crossing": false
        },
        "departure_location_id": "point-from",
        "arrival_location_ids": [
          "point-to-1"
        ],
        "departure_time": "2024-06-26T18:00:00.000Z",
        "properties": [
          "travel_time",
          "route"
        ],
        "range": {
          "enabled": true,
          "max_results": 5,
          "width": 43200
        }
      }
    ]
  }', coords1[1], coords1[2], coords2[1], coords2[2])
  return(request_body)
}


get_travel_time_api_response <- function(api_url, request_body) {
  
  ident_api <- read_yaml("funathon2024_sujet1/secrets.yaml")
  
  # On prépare les headers
  headers <- httr::add_headers(
    "Content-Type" = "application/json",
    "X-Application-Id" = ident_api$travelTime$X_API_ID,
    "X-Api-Key" = ident_api$travelTime$X_API_KEY
  )
  ## On envoie la requête avec les headers spécifiés
  response <- httr::POST(api_url, body = request_body, encode = "json", headers)
  
  # On vérifie s'il y a eu une erreur
  if (!httr::http_error(response)) {
    return(list(
      "Content" = httr::content(response, as = "parsed"),
      "Status_code" = httr::status_code(response)
    ))
  } else {
    # On affiche une message d'avertissement lorsque la requête n'a rien renvoyé
    warning("Failed to retrieve data: ", httr::http_status(response)$message)
    return(list(
      "Content" = NA,
      "Status_code" = httr::status_code(response)
    ))
  }
}


