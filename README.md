# Good night

## Description
An application that lets you record your sleeping time and share it with you friends.
[API Documentation](API_DOC.md)

## User Stories (How a user uses Good night app)
* As a user I can login by inputing my name
* As a user I can click `Clock in` button to record the time when I sleep.
* As a user I can click `Clock out` button to record the time when I wake up.
* As a user I can see a list of users by name and id.
* As a user I can click `Follow` on the user that I want to follow.
* As a user I can see all user that I'm following.
* As a user I can see all user that follows me (my followers).
* As a user I can see my friend's (user I follow) sleep records in past week.

## API Endpoints
* /login (POST)
* /logout (POST)
* /clockin (POST)
* /clockout (POST)
* [/users (GET)](API_DOC.md#get-users)
* [/users/:user_id (GET)](API_DOC.md#get-users-id)
* /users/:user_id/follows (GET, POST)
* /users/:user_id/followers (GET)
* /follows/:follow_id (DELETE)

## Database
* users :id, :name, :auth
* sleeps :id, :user_id, :date, :clockin_at, :clockout_at
* follows :id, :from_user_id, :to_user_id

## Setup
### Docker way
* Run docker-composer to setup db & api services
```
docker-composer up
```

### Normal way
* Check ruby version `2.4.1` & rails version `5.2.0`
* have db postgre install with version `10.3`
    - or use db sqlite by using `database.sqlite.yml`
* Run commands
```
bundle install
rails server -p 3000
```

## Development Process Log
* New rails app with only api & no bundle install
```
rails new good-night-api --api-only --skip-bundle
```

* Add docker-composer & dockerfiles
    - db usage change to postgres

* Add User Stories & API endpoints from specfication

* Add Rspec & TDD related gems

* Add rubocop (cuz i like coding standards)

* Add model, migration, rspec-model for [:users, :sleeps, :follows]
