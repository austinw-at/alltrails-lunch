# AllTrails Lunchtime Restaurant Discovery API

## Setup
- `docker compose run web bundle install`
- `docker compose up`

App is available @ localhost:3000

## Authentication
API Authentication is handled with a Bearer token. To add a user and generate a token navigate to `localhost:3000/users`

One a user is added it will automatically generate a token. You can also generate a new token.

To use the token just pass in the header `Authorization: Bearer <token>`

## Search
The Search API endpoint can be reached at either `localhost:3000/search` or `localhost:3000/api/v1/search_results` . The reason for 2 different routes is because of the requirements docs asking for `/search` but I preferred actually implementing the controller under `api/v1`

To search:
```
- POST /search
  Params: search[query]={SOME STRING} # "tacos"
          search[latlong]={SOME LATLONG} # "40.0000,-112.0000"
          search[type]={SOME TYPE} # "restaurant" this is optional and defaults to "restaurant"

- Response
  [
    {
      "id":"ChIJJVDIj4WaTYcRR5cYyFx9ooI",
      "name":"Wing Nutz",
      "location":"40.2777,-111.6777",
      "photo_url":"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400\u0026photo_reference=Aap_uEArO3NmZh83keUIUP0PTRTvffZoNCNZx3XTLJu5zKn_9IZ5_Gz1OHu7dluMn8O3Cr0dVOav3RNd7bfo2mqVNLCCrWOU8QzMkVSAho9NpRNe_38-IIgwfA1ZZkhwiUZQ_AI6PxQ4FL0a3rYK-NO6cq0TUYB58BK6JDYVOUpkPhSqoamK\u0026key=AIzaSyDQSd210wKX_7cz9MELkxhaEOUhFP0AkSk",
      "favorited":true
    }
  ]
```

## Favorites
The favorites endpoint provides a way to list all favorited places for the current user, add a new favorite, or remove a favorite.

To list favorites:
```
- GET /api/v1/favorites

- Response
  [
    {
        "id": 1,
        "user_id": 5,
        "place_id": "ChIJJVDIj4WaTYcRR5cYyFx9ooI",
        "created_at": "2021-09-29T07:34:02.785Z"
    }
  ]
```

To add a favorite:
```
- POST /api/v1/favorites
  Params: favorite[place_id]={SOME PLACE ID} # "ChIJGV1Qyc6aTYcR8X3oTpf10c4"

- Response
  {
    "id": 3,
    "user_id": 5,
    "place_id": "ChIJGV1Qyc6aTYcR8X3oTpf10c4",
    "created_at": "2021-09-29T08:43:36.841Z"
  }
```

To remove a favorite:
```
- DELETE /api/v1/favorites/{FAVORITED PLACE ID} # "ChIJGV1Qyc6aTYcR8X3oTpf10c4"
```

## Testing
To run tests:
- `docker compose run web bundle exec rails test`
