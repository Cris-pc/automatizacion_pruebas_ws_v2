Feature: Certificar activacion hw

  Background:
    * url urlBase
    * header Accept = "application/json"
    * def body = call read ('classpath:resources/json/provisionamiento/TMD_1_body.json')

  @name=activar
  Scenario Outline:ACTIVACION DE ONT HW EN OLT HW EN EMPRESA MD
    Given path  '/ws/process'
    And  request body
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    Then status 200
    And match response.status == "OK"
    And match response.opcion == "ACTIVAR"
    * print response
    And def vontid = $.ont_id
    And def vspid = $.spid
    * def ontid = ''+vontid
    * def spid = ''+vspid
    Examples:
      |read('classpath:resources/csv/provisionamiento/Data_driven_TMD_1.csv')|