Feature: my first test 1
Scenario: Testing Gets
Given I have the api gateway
  And I send a 'POST' request to '/users'
  And I add the headers:
      | User-Agent | insomnia/7.1.1 |
      | Proxy-Connection | Keep-Alive |
      | Accept | */* |
  And I add the query string parameters:
      | hello | mark |
  And I add the request body:
      | firstname | johnny |
      | lastname | doe |
When I run the API
Then I should receive a response with the status 200
  And the response headers should contains:
      | Content-Type | application/json; charset=utf-8 |
      | Connection | close |
      | X-Powered-By | Express |
  #And the response body at "$.id" should equal "8cc6b775-1182-406f-94ef-e1c25c58a8e0"
  And the response body at "firstname" should equal "johnny"
  And the response body at "$.lastname" should equal "doe"
