Feature: DELETE /users/:id

Background: Setup Gateway setting
Given I have the api gateway
  And the header contains "x-api-key" as "{{ API-KEY }}"


@happy
Scenario: create and detele a user
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
  And add the value "id" from the response body to the dataset as "userId"
Given I have the api gateway
  And I have the path "/api-key/users/{{userId}}"
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And I have the method "DELETE"
When I run the API
Then I should receive a response with the status 204
 And the response time is under 800 ms
 #And the response should be empty

@unhappy
Scenario: Trying to delete a user that doesnt exsit
Given I have the path "/api-key/users/123"
  And I have the method "DELETE"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 404
 And the response body at "message" should equal "The user 123 doesn't exist"
