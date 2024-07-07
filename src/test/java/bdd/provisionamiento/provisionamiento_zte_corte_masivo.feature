Feature: Certificar corte masivo para zte a zte en MD

  Background:
    * url urlBase
    * header Accept = "application/json"
    * def body = call read ('classpath:resources/json/provisionamiento/TMD_26_body.json')

  @name=cortemasivoztemd
  Scenario: CORTE MASIVO EN ONT ZTE EN OLT ZTE EN EMPRESA MD
    Given path  '/ws/process'
    And  request body
    * configure connectTimeout = 250000
    * configure readTimeout = 250000
    When method post
    Then status 200
    And match response.status == "OK"
    And match response.datos_cliente[0].status == "OK"
    * print response