Feature: As a api consumer i want to know if selim exist
Scenario: Test user not found
Given I have the api gateway
  And I send a 'GET' request to '/users/selim1'
  And I add the headers:
      | Proxy-Connection | Keep-Alive |
      | Accept | */* |
When I run the API
Then I should receive a response with the status 404
  And the response headers should contains:
      | Content-Type | application/json; charset=utf-8 |
      | Content-Length | 35 |
      | Connection | close |
      | X-Powered-By | Express |
  And the response body at "$.code" should equal "404"
  And the response body at "$.msg" should equal "user not found"
