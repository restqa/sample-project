Feature: POST /users

@happy
Scenario: Create a user
Given I have the api gateway
  And I have the path "/users"
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

@unhappy
Scenario: Create a user But the firstname is missing
Given I have the api gateway
  And I have the path "/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "firstname is mandatory"
 And the response time is under 800 ms

@unhappy
Scenario: Create a user But the lastname is missing
Given I have the api gateway
  And I have the path "/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "lastname is mandatory"
 And the response time is under 800 ms

@unhappy
Scenario: Create a user But the all body is missing
Given I have the api gateway
  And I have the path "/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 406
 And the response body at "message" should equal "firstname is mandatory"
 And the response time is under 800 ms
