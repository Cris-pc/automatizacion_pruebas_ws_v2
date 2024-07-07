Feature: Proceso de cancelacion de servicio para limpiar recursos


  Background:
    * url urlBase
    * header Accept = "application/json"
    * def body = call read ('classpath:resources/json/provisionamiento/TMD_cancelar_body.json')

  Scenario Outline: Cancelar servicio para recursos limpios
    Given path  '/ws/process'
    And  request body
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    Then status 200
    And match response.status == "OK"
    And match response.opcion == "CANCELAR"
    * print response
    Examples:
      |read('classpath:resources/csv/provisionamiento/Data_driven_cancelar.csv')|