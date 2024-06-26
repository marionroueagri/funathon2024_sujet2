library(dplyr)
library(yaml)
library(httr)

source("funathon2024_sujet1/fonction_requete.R")

ROUTES_API_URL <- "https://api.traveltimeapp.com/v4/routes"

requete_exemple <- '{
  "locations": [
    {
      "id": "point-from",
      "coords": {
        "lat": 51.5119637,
        "lng": -0.1279543
      }
    },
    {
      "id": "point-to-1",
      "coords": {
        "lat": 51.5156177,
        "lng": -0.0919983
      }
    }
  ],
  "departure_searches": [
    {
      "id": "departure-search",
      "transportation": {
        "type": "public_transport"
      },
      "departure_location_id": "point-from",
      "arrival_location_ids": [
        "point-to-1"
      ],
      "departure_time": "2024-06-26T07:00:00.000Z",
      "properties": [
        "travel_time",
        "route"
      ],
      "range": {
        "enabled": true,
        "max_results": 5,
        "width": 900
      }
    }
  ]
}'

response_from_function <- get_travel_time_api_response(ROUTES_API_URL, requete_exemple)
list_itinerary <- response_from_function[[1]]$results[[1]]$locations[[1]]$properties
