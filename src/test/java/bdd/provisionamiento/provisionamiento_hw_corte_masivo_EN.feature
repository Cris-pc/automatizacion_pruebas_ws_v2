Feature: Certificar corte masivo para hw a hw en EN

  Background:
    * url urlBase
    * header Accept = "application/json"
    * def body = call read ('classpath:resources/json/provisionamiento/TMD_27_body.json')

  @name=corteHWasivoen
  Scenario: CORTE MASIVO EN ONT HW EN OLT HW EN EMPRESA EN
    Given path  '/ws/process'
    And  request body
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    Then status 200
    And match response.status == "OK"
    And match response.datos_cliente[0].status == "OK"
    * print response