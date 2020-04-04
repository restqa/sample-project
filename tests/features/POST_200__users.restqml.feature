Feature: oui oui
Scenario: The super test of the year
Given I have the api gateway
  And I send a 'POST' request to '/users'
  And I add the headers:
      | Proxy-Connection | Keep-Alive |
      | content-Type | application/json |
      | Accept | */* |
  And I add the request body:
      | firstname | johnny |
      | lastname | doe |
When I run the API
Then I should receive a response with the status 200
  And the response headers should contains:
      | Content-Type | application/json; charset=utf-8 |
      | Connection | close |
      | X-Powered-By | Express |
 # And the response body at "$.id" should equal "ba30cfd8-df57-4b08-b093-df7b6a36d21b"
  And the response body at "$.firstname" should equal "johnny"
  And the response body at "$.lastname" should equal "doe"
