# API Endpoints documentation

## User Endpoints
### Overview
* [GET /auth](API_DOC.md#get-auth)
* [GET /users](API_DOC.md#get-users)
* [GET /users/:id](API_DOC.md#get-usersid)
* [GET /sleeps/clockin](API_DOC.md#get-sleepsclockin)
* [GET /sleeps/clockout](API_DOC.md#get-sleepsclockout)

### GET /auth
#### request
```
curl -X GET \
  'http://localhost:3000/api/v1/auth?name=Trung' \
  -H 'Content-Type: application/json'
```

#### Response Successful
```
{
    "data": {
        "id": 2,
        "name": "Trung",
        "auth": "78eb7a778cd3e070d90d"
    }
}
```
- Use data[:auth] field to use as authorization in header to access other APIs

#### Response Error
Missing paramter
```
{
    "error": {
        "message": "param is missing or the value is empty: name",
        "status": 400
    }
}
```

User doesn't exist
```
{
    "error": {
        "message": "User with name: 'Trungs' doesn't exist",
        "status": 401
    }
}
```

### GET /users
#### request
```
curl -X GET \
  http://localhost:3000/api/v1/users \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/json'
```

#### Response Successful 
```
{
    "data": [
        {
            "id": 1,
            "name": "Trung"
        },
        {
            "id": 2,
            "name": "Larrison"
        }
    ]
}
```

### GET /users/:id
```
curl -X GET \
  http://localhost:3000/api/v1/users/1 \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/json'
```

### Response Successful
```
{
    "data": {
        "id": 1,
        "name": "Trung",
        "created_at": "2019-05-04T08:53:44.186Z",
        "updated_at": "2019-05-04T08:53:44.186Z"
    }
}
```

#### Response Error
Not found ID
```
{
    "error": {
        "message": "Couldn't find User with 'id'=4",
        "status": 404
    }
}
```

#### GET /sleeps/clockin
```
curl -X GET \
  http://localhost:3000/api/v1/sleeps/clockin \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": {
        "date": "2019-05-12",
        "clockin_at": "2019-05-12T07:55:47.283Z",
        "clockout_at": null,
        "created_at": "2019-05-12T07:55:47.298Z",
        "updated_at": "2019-05-12T07:55:47.298Z"
    }
}
```

### Response Error
```
{
    "error": {
        "message": "Already clocked in at: 2019-05-12 07:55:47 UTC",
        "status": 422
    }
}
```

#### GET /sleeps/clockout
```
curl -X GET \
  http://localhost:3000/api/v1/sleeps/clockout \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": {
        "date": "2019-05-12",
        "clockin_at": "2019-05-12T07:56:29.103Z",
        "clockout_at": "2019-05-12T07:56:59.712Z",
        "created_at": "2019-05-12T07:55:47.298Z",
        "updated_at": "2019-05-12T07:56:59.725Z"
    }
}
```

### Response Error
```
{
    "error": {
        "message": "Already clocked out at: 2019-05-12 07:56:59 UTC",
        "status": 422
    }
}
```
