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
* [/auth (GET)](API_DOC.md#get-auth)
* [/sleeps/clockin (GET)](API_DOC.md#get-sleepsclockin)
* [/sleeps/clockout (GET)](API_DOC.md#get-sleepsclockout)
* [/users (GET)](API_DOC.md#get-users)
* [/users/:user_id (GET)](API_DOC.md#get-usersid)
* [/users/:user_id/follows (POST)](API_DOC.md#post-usersidfollows)
* [/users/:user_id/follows (GET)](API_DOC.md#get-usersidfollows)
* [/users/:user_id/followers (GET)](API_DOC.md#get-usersidfollowers)
* [/follows/:follow_id (DELETE)](API_DOC.md#delete-followsid)

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

* Add controller, rspec-request for :users

* Add authentication for GET/users, GET /users/:id
    - add seed_fu gem and Seed 7 users for authentication testing.
    - add simple `authenticate!` with no encyption. (Could implemnt JWT later)
    - add rspec's `ShareExampleHelper`, `Request::AuthenticationHelper`
    - add rspec test cases with error message

* Add login with GET /auth
    - add rspec 2 error cases: no parameter name, user doesnt exists

* Add GET /sleeps/clockin & GET /sleeps/clockout
    - add rspec error cases: already checkin or checkout

* Add POST&GET /users/:id/follows & GET /users/:id/follower
    - add rspec

* Add DELETE /follows/:id
    - add rspec 2 cases: follow_id not found, not allowed operation

* Add Postgre gem and connection

* Add `last_week_sleeps` to GET /users/:id
    - add fixture 02_sleeps data.
    - group by for correct database select.

## Todo
- Add time_zone to user.
- better clockin clockout responses