@Adjust
  Feature: reqRes

    Background:
      * url 'https://reqres.in/'

    @test1
    Scenario: Successful register
      * def registerRequest = {"email": "eve.holt@reqres.in", "password": "pistol"}
      Given path '/api/register'
      And request registerRequest
      When method POST
      Then status 200
      Then print response
      * def resultControl = response.token
      * match resultControl == '#notnull'

    @test2
    Scenario: Unsuccessful login
      * def loginRequest = {"email": "eve.holt@reqres.in"}
      Given path '/api/login'
      And request loginRequest
      When method POST
      Then status 400
      Then print response
      * def resultControl = response.error
      * match resultControl == 'Missing password'

    @test3
    Scenario: Successful login
      * def loginRequest = {"email": "eve.holt@reqres.in", "password": "pistol"}
      Given path '/api/login'
      And request loginRequest
      When method POST
      Then status 200
      Then print response
      * def resultControl = response.token
      * match resultControl == '#notnull'

    @test4
    Scenario Outline: List users from first page
      Given path '/api/users?<pageParam>'
      When method GET
      Then status 200
      Then print response
      * def idControl1 = response.data[<index>].id
      * match idControl1 == <id>
      Examples:
      |pageParam| index         | id              |
      |  page=1 | 0,1,2,3,4,5   | 1,2,3,4,5,6     |
      |  page=2 | 0,1,2,3,4,5   | 7,8,9,10,11,12  |

    @test5
    Scenario: Update user information
      * def updateRequest = {"name": "ronald billius", "job": "hogwarts student"}
      Given path '/api/users/1'
      And request updateRequest
      When method PUT
      Then status 200
      Then print response
      * def responseName = response.name
      * match responseName contains "ronald"
      * def responseDate = response.updatedAt
      * match responseDate == "#notnull"