# API Endpoints documentation

## User Endpoints
### Overview
* [GET /auth](API_DOC.md#get-auth)
* [GET /users](API_DOC.md#get-users)
* [GET /users/:id](API_DOC.md#get-usersid)
* [GET /users/:id/last_week_order_sleep_time](API_DOC.md#get-usersidlast_week_order_sleep_time)
* [POST /users/:user_id/follows](API_DOC.md#post-usersidfollows)
* [GET /users/:user_id/follows](API_DOC.md#get-usersidfollows)
* [GET /users/:user_id/followers](API_DOC.md#get-usersidfollowers)
* [POST /sleeps/clockin](API_DOC.md#post-sleepsclockin)
* [POST /sleeps/:id/clockout](API_DOC.md#post-sleepsidclockout)
* [DELETE /follows/:id](API_DOC.md#delete-followsid)

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
        "created_at": "2019-05-12T11:50:07.088Z",
        "updated_at": "2019-05-12T11:50:07.088Z",
        "last_week_sleeps": [
            {
                "id": 8,
                "date": "2019-05-05",
                "clockin_at": "2019-05-05T19:59:59.999Z",
                "clockout_at": "2019-05-05T23:59:59.999Z",
                "sleep_time": "04:00:00"
            },
            {
                "id": 9,
                "date": "2019-05-06",
                "clockin_at": "2019-05-06T23:59:59.999Z",
                "clockout_at": "2019-05-07T06:59:59.999Z",
                "sleep_time": "07:00:00"
            },
            {
                "id": null,
                "date": "2019-05-07",
                "clockin_at": null,
                "clockout_at": null,
                "sleep_time": null
            },
            {
                "id": 11,
                "date": "2019-05-08",
                "clockin_at": "2019-05-08T20:59:59.999Z",
                "clockout_at": null,
                "sleep_time": null
            },
            {
                "id": 12,
                "date": "2019-05-09",
                "clockin_at": "2019-05-09T19:59:59.999Z",
                "clockout_at": "2019-05-10T05:59:59.999Z",
                "sleep_time": "10:00:00"
            },
            {
                "id": 13,
                "date": "2019-05-10",
                "clockin_at": "2019-05-10T20:59:59.999Z",
                "clockout_at": "2019-05-11T00:59:59.999Z",
                "sleep_time": "04:00:00"
            },
            {
                "id": 14,
                "date": "2019-05-11",
                "clockin_at": "2019-05-11T20:59:59.999Z",
                "clockout_at": "2019-05-11T23:59:59.999Z",
                "sleep_time": "03:00:00"
            },
            {
                "id": 15,
                "date": "2019-05-12",
                "clockin_at": "2019-05-12T19:59:59.999Z",
                "clockout_at": "2019-05-13T05:59:59.999Z",
                "sleep_time": "10:00:00"
            }
        ]
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

### GET /users/:id/last_week_order_sleep_time
```
curl -X GET \
  http://localhost:3000/api/v1/users/1/last_week_order_sleep_time \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/json'
```

### Response Successful
```
{
    "data": [
        {
            "id": 12,
            "date": "2019-05-09",
            "clockin_at": "2019-05-09T19:59:59.999Z",
            "clockout_at": "2019-05-10T05:59:59.999Z",
            "sleep_time": "10:00:00"
        },
        {
            "id": 15,
            "date": "2019-05-12",
            "clockin_at": "2019-05-12T19:59:59.999Z",
            "clockout_at": "2019-05-13T05:59:59.999Z",
            "sleep_time": "10:00:00"
        },
        {
            "id": 9,
            "date": "2019-05-06",
            "clockin_at": "2019-05-06T23:59:59.999Z",
            "clockout_at": "2019-05-07T06:59:59.999Z",
            "sleep_time": "07:00:00"
        },
        {
            "id": 8,
            "date": "2019-05-05",
            "clockin_at": "2019-05-05T19:59:59.999Z",
            "clockout_at": "2019-05-05T23:59:59.999Z",
            "sleep_time": "04:00:00"
        },
        {
            "id": 13,
            "date": "2019-05-10",
            "clockin_at": "2019-05-10T20:59:59.999Z",
            "clockout_at": "2019-05-11T00:59:59.999Z",
            "sleep_time": "04:00:00"
        },
        {
            "id": 14,
            "date": "2019-05-11",
            "clockin_at": "2019-05-11T20:59:59.999Z",
            "clockout_at": "2019-05-11T23:59:59.999Z",
            "sleep_time": "03:00:00"
        },
        {
            "id": 11,
            "date": "2019-05-08",
            "clockin_at": "2019-05-08T20:59:59.999Z",
            "clockout_at": null,
            "sleep_time": null
        }
    ]
}
```

## POST /sleeps/clockin
```
curl -X POST \
  http://localhost:3000/api/v1/sleeps/clockin \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": {
        "id": 16,
        "date": "2019-05-12",
        "clockin_at": "2019-05-12T15:02:48.835Z",
        "clockout_at": null,
        "created_at": "2019-05-12T15:02:48.848Z",
        "updated_at": "2019-05-12T15:02:48.848Z"
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

## POST /sleeps/:id/clockout
```
curl -X POST \
  http://localhost:3000/api/v1/sleeps/:id/clockout \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": {
        "id": 16,
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

```
{
    "error": {
        "message": "Couldn't find Sleep with 'id'=1000",
        "status": 404
    }
}
```

Not allowed operation
```
{
    "error": {
        "message": "Not allowed doing this operation",
        "status": 422
    }
}
```

## POST /users/:id/follows
```
```

### Response Successful
```
{
    "data": {
        "id": 3,
        "to_user": {
            "id": 4,
            "name": "Brian"
        }
    }
}
```

### Response Error
```
{
    "error": {
        "message": "Already followed user_id: 4",
        "status": 422
    }
}
```

## GET /users/:id/follows
```
curl -X GET \
  http://localhost:3000/api/v1/users/2/follows \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": [
        {
            "id": 2,
            "to_user": {
                "id": 5,
                "name": "Daniel"
            }
        },
        {
            "id": 1,
            "to_user": {
                "id": 6,
                "name": "Brock"
            }
        }
    ]
}
```

## GET /users/:id/followers
```
curl -X GET \
  http://localhost:3000/api/v1/users/5/followers \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": [
        {
            "id": 2,
            "from_user": {
                "id": 2,
                "name": "Trung"
            }
        }
    ]
}
```

## DELETE /follows/:id
```
curl -X DELETE \
  http://localhost:3000/api/v1/follows/7 \
  -H 'Authorization: Bearer 78eb7a778cd3e070d90d' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
```

### Response Successful
```
{
    "data": {
        "message": "Unfollowed successful",
        "id": 7,
        "to_user": {
            "id": 4,
            "name": "Brian"
        }
    }
}
```

### Response error
```
{
    "error": {
        "message": "Couldn't find Follow with 'id'=10",
        "status": 404
    }
}
```

Not allowed operation
```
{
    "error": {
        "message": "Not allowed doing this operation",
        "status": 422
    }
}
```