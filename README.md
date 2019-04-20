# Basic Rack Application

This basic rack application is used to search and return matching names of users from a user table..

## PreRequisites

* It should only accept 'GET' method calls
* It should only serve 'JSON' response
* Make use of any authentication e.g. http basic authentication
* Can make use of Etag cache response

## Getting Started

* Start Database

```
  cp config/database.yml.example config/database.yml
```

* Start Application

```
  bundle exec rackup --port 3000 --host 0.0.0.0
```
* Valid URLS

```
  http://localhost:3000/
  http://localhost:3000/users
  http://localhost:3000/users?name=abc
  http://localhost:3000/show
  http://localhost:3000/goodbye
```
* Using Curl

```
  curl http://localhost:3000/users -u user:password -X GET # returns all users
  curl http://localhost:3000/test -u user:password -X GET # returns Invalid Url
  curl http://localhost:3000/users -u user:password -X GET -d "name=abc" # returns users with name=abc

  curl -i http://localhost:3000/users -u user:password -X GET
  curl -i http://localhost:3000/users -u user:password -X GET -d "name=abc"
  curl -i -H 'If-None-Match: "b4c2d4c067d904d5611bcaab1dd23e68"' http://localhost:3000/user -u user:password -X GET -d "name=abc"
```

* TODO

* ...
