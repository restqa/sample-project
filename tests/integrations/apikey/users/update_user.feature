Feature: PUT /users

Background: Setup Gateway setting
Given I have the api gateway
  And the header contains "x-api-key" as "{{ API-KEY }}"

@happy
Scenario: Create a user and update it
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
 And the response body at "id" should match "/^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{12})$/"
 And the response body at "firstname" should equal "johnny"
 And the response body at "lastname" should equal "doe"
 And the response time is under 800 ms
 And add the value "id" from the response body to the dataset as "userId"
Given I have the api gateway
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And I have the path "/api-key/users/{{userId}}"
  And I have the method "PUT"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "Jenna"
  And the payload contains "lastname" as "Carter"
When I run the API
Then I should receive a response with the status 200
 And the response body at "id" should match "/^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{12})$/"
 And the response body at "firstname" should equal "Jenna"
 And the response body at "lastname" should equal "Carter"
 And the response time is under 800 ms

@unhappy 
Scenario: Create a user and try to update it without firstname
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
 And the response body at "id" should match "/^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{12})$/"
 And the response body at "firstname" should equal "johnny"
 And the response body at "lastname" should equal "doe"
 And the response time is under 800 ms
 And add the value "id" from the response body to the dataset as "userId"
Given I have the api gateway
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And I have the path "/api-key/users/{{userId}}"
  And I have the method "PUT"
  And the header contains "content-type" as "application/json"
  And the payload contains "lastname" as "Carter"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "firstname is mandatory"
 And the response time is under 800 ms


@unhappy 
Scenario: Create a user and try to update it without lastname
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
 And the response body at "id" should match "/^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{12})$/"
 And the response body at "firstname" should equal "johnny"
 And the response body at "lastname" should equal "doe"
 And the response time is under 800 ms
 And add the value "id" from the response body to the dataset as "userId"
Given I have the api gateway
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And I have the path "/api-key/users/{{userId}}"
  And I have the method "PUT"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "Jenna"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "lastname is mandatory"
 And the response time is under 800 ms

@unhappy 
Scenario: Create a user and try to update it without firstname or lastrname
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And the response body at "id" should match "/^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{12})$/"
  And the response body at "firstname" should equal "johnny"
  And the response body at "lastname" should equal "doe"
  And the response time is under 800 ms
  And add the value "id" from the response body to the dataset as "userId"
Given I have the api gateway
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And I have the path "/api-key/users/{{userId}}"
  And I have the method "PUT"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "firstname is mandatory"
 And the response time is under 800 ms


@unhappy
Scenario: Create a user But the all body is missing
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "firstname is mandatory"
 And the response time is under 800 ms

@unhappy
Scenario: Trying to update a user that doesnt exsit
Given I have the path "/api-key/users/123"
  And I have the method "PUT"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 404
 And the response body at "message" should equal "The user 123 doesn't exist"
