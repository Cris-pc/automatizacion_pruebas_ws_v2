Feature: Certificar provisionamiento zte

  Background:flujocompletohw.feature
    * url urlBase
    * header Accept = "application/json"
    * def tiempo_espera =
		"""
		function(seconds){
			for(i=0; i<=seconds; i++){
				java.lang.Thread.sleep(3500);
			}
		}
		"""

   @name=flujoztemd
  Scenario Outline: FLUJO DE PROCESO CLIENTE ZTE EN MD
    * print "****************************INICIA ACTIVACION FLUJO ZTE A ZTE MEGADATOS ***********************************"
    Given path  '/ws/process'
    And  request
    """
    {
     "nombre_cliente": "<NOM_CLIENTE>",  "login": "<LOGIN>",   "identificacion": "<IDENTIFICACION>",
     "datos": {
     "serial_ont": "<SERIALONT>",  "mac_ont": "<MACONT>",
     "nombre_olt": "<NOM_OLT>",   "ip_olt": "<IP_OLT>",    "puerto_olt": "<PUERTO_OLT>",
     "modelo_olt": "<MODELO_OLT>",    "gemport": "",    "service_profile": "<SERVICE_PROFILE>",
     "line_profile": "",    "traffic_table": "",    "vlan": "",
     "estado_servicio": "Asignada",    "ip": "",    "ip_fijas_activas": 0,
     "tipo_negocio_actual": "HOME",    "mac_wifi": "",    "scope": "",
     "capacidad_up": "<CAPACIDAD_UP>",    "capacidad_down": "<CAPACIDAD_DOWN>",  "equipoOntDualBand": "NO",
     "tipoOrden": "NUEVO"
	 },
     "opcion": "ACTIVAR",  "ejecutaComando": "<EJECUTACOMANDO>",  "usrCreacion": "TESTE2E",
     "ipCreacion": "172.24.15.71",  "comandoConfiguracion": "SI",  "empresa": "MD"
    }
    """
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
    And call tiempo_espera 25
    * print "****************************ESCENARIO DE CAMBIO DE PLAN ZTE***********************************"
    Given path  '/ws/process'
    And  request
    """
     {
     "nombre_cliente": "<NOM_CLIENTE>", "login": "<LOGIN>", "identificacion": "<IDENTIFICACION>",
     "datos": {
       "serial_ont": "<SERIALONT>", "mac_ont": "<MACONT>", "nombre_olt": "<NOM_OLT>", "ip_olt": "<IP_OLT>",
       "puerto_olt": "<PUERTO_OLT>", "modelo_olt":  "<MODELO_OLT>", "gemport": "",
       "service_profile": "<SERVICE_PROFILE>",  "line_profile": "",  "traffic_table": "",
        "ont_id": "#(ontid)",  "service_port": "#(spid)", "vlan": "301", "estado_servicio": "Activo",
        "mac_wifi": "",   "tipo_negocio_actual": "HOME",   "line_profile_nuevo": "",   "gemport_nuevo": "1",
        "traffic_table_nueva": "",  "tipo_negocio_nuevo": "HOME", "vlan_nueva": "301",
        "ip": "",   "scope": "", "ip_fijas_activas": 0,   "capacidad_up": "30000",  "capacidad_down": "30000",
       "capacidad_up_nueva": "120000",    "capacidad_down_nueva": "120000"
       },
        "opcion": "CAMBIAR_PLAN",     "ejecutaComando": "<EJECUTACOMANDO>",    "usrCreacion": "TESTE2E",
       "ipCreacion": "172.24.15.71",   "comandoConfiguracion": "SI",     "empresa": "MD"
       }
    """
    And call tiempo_espera 10
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    * print response
    And call tiempo_espera 15
    Then status 200
    And match response.status == "OK"
    And match response.opcion == "CAMBIAR_PLAN"
    * print "******************************** ESCENARIO DE SUSPENSIÓN ZTE *********************************************"
    Given path  '/ws/process'
    And  request
    """
    {
  "nombre_cliente": "<NOM_CLIENTE>", "login": "<LOGIN>",  "identificacion": "<IDENTIFICACION>",
  "datos": {
    "ont_id": "#(ontid)",    "service_port": "#(spid)",    "serial_ont": "<SERIALONT>",
    "mac_ont": "<MACONT>",    "nombre_olt": "<NOM_OLT>",    "ip_olt": "<IP_OLT>",
    "puerto_olt": "<PUERTO_OLT>",    "modelo_olt": "<MODELO_OLT>",    "gemport": "",
    "service_profile": "<SERVICE_PROFILE>",    "line_profile": "",    "traffic_table": "",
    "vlan": "",    "estado_servicio": "Activo",    "mac_wifi": null,
    "capacidad_up": "<CAPACIDAD_UP>",    "capacidad_down": "<CAPACIDAD_DOWN>",    "tipo_negocio_actual": "HOME"
  },
  "opcion": "CORTAR",  "ejecutaComando": "<EJECUTACOMANDO>",  "usrCreacion": "TESTE2E",
  "ipCreacion": "172.24.15.71",  "comandoConfiguracion": "SI",  "empresa": "MD"
}
    """
    And call tiempo_espera 10
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    * print response
    And call tiempo_espera 15
    Then status 200
    And match response.status == "OK"
    And match response.opcion == "CORTAR"
    * print "******************************** ESCENARIO DE REACTIVACION ZTE *********************************************"
    Given path  '/ws/process'
    And  request
    """
    {
  "nombre_cliente": "<NOM_CLIENTE>",   "login": "<LOGIN>",  "identificacion": "<IDENTIFICACION>",
  "datos": {     "ont_id": "#(ontid)",    "service_port": "#(spid)",
    "serial_ont": "<SERIALONT>",    "mac_ont": "<MACONT>",    "nombre_olt": "<NOM_OLT>",
    "ip_olt": "<IP_OLT>",    "puerto_olt": "<PUERTO_OLT>",    "modelo_olt": "<MODELO_OLT>",
    "gemport": "",    "service_profile": "<SERVICE_PROFILE>",    "line_profile": "",
    "traffic_table": "",    "vlan": "",    "estado_servicio": "In-Corte",
    "mac_wifi": null,    "capacidad_up": "<CAPACIDAD_UP>",    "capacidad_down": "<CAPACIDAD_DOWN>",
    "tipo_negocio_actual": "HOME",    "ip_fijas_activas": 0
  },
  "opcion": "REACTIVAR",  "ejecutaComando": "<EJECUTACOMANDO>",  "usrCreacion": "cguerra",
  "ipCreacion": "172.24.15.71",  "comandoConfiguracion": "SI",  "empresa": "MD"
}
    """
    And call tiempo_espera 20
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    * print response
    Then status 200
    And call tiempo_espera 36
    And match response.status == "OK"
    And match response.opcion == "REACTIVAR"
    * print "******************************** ESCENARIO DE CANCELAR ZTE *********************************************"
    Given path  '/ws/process'
    And  request
    """
    {
  "nombre_cliente": "<NOM_CLIENTE>",  "login": "<LOGIN>",  "identificacion": "<IDENTIFICACION>",
  "datos": {    "serial_ont": "<SERIALONT>",    "mac_ont": "<MACONT>",
    "nombre_olt":  "<NOM_OLT>",    "ip_olt": "<IP_OLT>",    "puerto_olt": "<PUERTO_OLT>",
    "modelo_olt": "<MODELO_OLT>",    "gemport": "",    "service_profile": "<SERVICE_PROFILE>",
    "line_profile": "",    "traffic_table": "",    "vlan": "",
    "estado_servicio": "Asignada",    "ip": "",    "ip_fijas_activas": 0,
    "tipo_negocio_actual": "HOME",    "mac_wifi": "",    "scope": "",
    "capacidad_up": "<CAPACIDAD_UP>",    "capacidad_down": "<CAPACIDAD_DOWN>",    "equipoOntDualBand": "NO",
    "tipoOrden": "NUEVO",    "ont_id": "#(ontid)",    "service_port": "#(spid)",
    "ip_cancelar": []
  },
  "opcion": "CANCELAR",  "ejecutaComando": "<EJECUTACOMANDO>",  "usrCreacion": "cguerra",
  "ipCreacion": "172.24.15.71",  "comandoConfiguracion": "SI",  "empresa": "MD"
}
    """
    When method post
    * print response
    And match response.opcion == "CANCELAR"
    And match response.status == "OK"
    Then status 200
    Examples:
      | NOM_CLIENTE      |        LOGIN        | IDENTIFICACION    | SERIALONT        | MACONT              | NOM_OLT               | IP_OLT            | PUERTO_OLT | MODELO_OLT |SERVICE_PROFILE|CAPACIDAD_UP | CAPACIDAD_DOWN |EJECUTACOMANDO |
      | CRISTHIAN FLORES | md-uiocifloresh3    | 1308845260        | 5A544547D164D265 | 20:65:8E:69:6F:9B   | olt-zte-8-labuio-uio  |  10.221.18.61     |  3/16      |    C610    |ZTEG-F670L     |30000        | 30000          |   NO          |

