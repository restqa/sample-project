# Sample Project E2e

> Sample project to run API End to End Automation Tests using [RestQA](https://github.com/restqa/restqa)



## Installation

The current setup relies on Docker

```sh
docker pull restqa/restqa
```

## Usage example


### Get Some help

To get to know what are the step definitions available on restqapi you can run the command : 

```sh
docker run --rm -it -v $PWD:/app restqa/restqa restqa steps then
```

The output will be :

```
╔═════════╦═════════════════════════════════════════════════════════╦═════════════════════════════════════════════════════════════════════════════╗
║ Keyword ║ Step                                                    ║ Comment                                                                     ║
╟═════════╬═════════════════════════════════════════════════════════╬═════════════════════════════════════════════════════════════════════════════╢
║ then    ║ I should receive a response with the status {int}       ║ Check the response http code                                                ║
║ then    ║ the response headers should contains:                   ║                                                                             ║
║ then    ║ the response time is under {int} ms                     ║ Check the response latency                                                  ║
║ then    ║ {string} should be on the response header               ║ Check if a property is in the response header                               ║
║ then    ║ {string} should not be on the response header           ║ Check if a property is in the response header                               ║
║ then    ║ the response should be empty array                      ║ Check a value in the body response that it is empty array                   ║
║ then    ║ the response should be empty                            ║ Check a value in the body response that it is empty array                   ║
║ then    ║ the response body at {string} should equal {string}     ║ Check a value in the body response as a string (dot-object pattern)         ║
║ then    ║ the response body at {string} should equal {int}        ║ Check a value in the body response as a int (dot-object pattern)            ║
║ then    ║ the response body at {string} should equal {float}      ║ Check a value in the body response as a float (dot-object pattern)          ║
║ then    ║ the response body at {string} should equal true         ║ Check if a value is true in the body response (dot-object pattern)          ║
║ then    ║ the response body at {string} should equal false        ║ Check if a value is false in the body response (dot-object pattern)         ║
║ then    ║ the response body at {string} should equal null         ║ Check if a value is null in the body response (dot-object pattern)          ║
║ then    ║ the response body at {string} should equal empty        ║ Check if a value is empty in the body response (dot-object pattern)         ║
║ then    ║ the response body at {string} should equal close to now ║ Check if a date is close to now (ex: to check if a createdAt date is valid) ║
║ then    ║ the response body at {string} should not be null        ║ Check if a value is not null in the body response (dot-object pattern)      ║
║ then    ║ the response body at {string} should match {string}     ║ Check if a value match a specific regex                                     ║
║ then    ║ the response list should contain {int} item             ║ Check if the response list is of a certain size                             ║
║ then    ║ the header {string} should be {string}                  ║ Check if a property in the response header has the exact string value       ║
║ then    ║ clean                                                   ║ Cleaning the api buffer ??                                                  ║
╚═════════╩═════════════════════════════════════════════════════════╩═════════════════════════════════════════════════════════════════════════════╝
```

You can use the different keywords :
  * given
  * when
  * then


### Run the tests

To run the current test : 

```
docker run --rm -v $(pwd):/app restqa/restqa restqa run 
```

If you want to specify an environment just run : 

```
docker run --rm -v $(pwd):/app -e RESTQA_ENV=uat restqa/restqa run
```

## FAQ

### Why i can't access to an endpoint like http://localhost:8080 ?

Because actually in this example we are running restqapi inside a container.
The if you want to access to the localhost from the container i recommend to use the url : http://host.docker.internal:8080 or do a link between container by using the option [--link](https://docs.docker.com/network/links/)
