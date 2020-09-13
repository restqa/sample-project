Feature: GET /users/:id


Background: Setup Gateway setting
Given I have the api gateway
  And the header contains "x-api-key" as "{{ API-KEY }}"

@happy
Scenario: Get the list of the users
Given I have the path "/api-key/users"
  And I have the method "POST"
  And the header contains "content-type" as "application/json"
  And the payload contains "firstname" as "johnny"
  And the payload contains "lastname" as "doe"
When I run the API
Then I should receive a response with the status 200
Given I have the api gateway
  And the header contains "x-api-key" as "d8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa"
  And I have the path "/api-key/users"
  And I have the method "GET"
  And the header contains "content-type" as "application/json"
When I run the API
Then I should receive a response with the status 200
 And the response time is under 800 ms
 And the response should not be empty array
