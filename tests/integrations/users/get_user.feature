Feature: GET /users/:id

@happy
Scenario: Get a user
Given I have the api gateway
  And I have the path "/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
  And add the value "id" from the response body to the dataset as "userId"
Given I have the api gateway
  And I have the path "/users/{{userId}}"
  And I have the method "GET"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 200
 And the response body at "id" should match "/^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{4})-([a-z0-9]{12})$/"
 And the response body at "firstname" should equal "johnny"
 And the response body at "lastname" should equal "doe"
 And the response time is under 800 ms

@unhappy
Scenario: Trying to get a user that doesnt exsit
Given I have the api gateway
  And I have the path "/users/123"
  And I have the method "GET"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 404
 And the response body at "message" should equal "The user 123 doesn't exist"
