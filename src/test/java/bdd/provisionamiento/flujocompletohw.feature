Feature: Certificar provisionamiento ont HW a olt HW en empresa MEGADATOS

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
  @name=flujohwmd
  Scenario Outline: Flujo HW (activacion - cambio de plan - cortar - reactivar - cancelar) en empresa MD
    * print "****************************INICIA ACTIVACION FLUJO HW A HW ***********************************"
    Given path  '/ws/process'
    And  request
    """
    {
     "nombre_cliente": "<NOM_CLIENTE>","login": "<LOGIN>","identificacion": "<IDENTIFICACION>","datos": {
     "serial_ont": "<SERIALONT>", "mac_ont": "<MACONT>", "nombre_olt": "<NOM_OLT>", "ip_olt": "<IP_OLT>","puerto_olt": "<PUERTO_OLT>",
     "modelo_olt": "<MODELO_OLT>", "gemport": "","service_profile": "<SERVICE_PROFILE>","line_profile": "","traffic_table": "","vlan": "",
     "estado_servicio": "Asignada", "ip": "","ip_fijas_activas": 0,"tipo_negocio_actual": "HOME","mac_wifi": "","scope": "", "capacidad_up": "<CAPACIDAD_UP>",
     "capacidad_down": "<CAPACIDAD_DOWN>","equipoOntDualBand": "NO","tipoOrden": "NUEVO" },"opcion": "ACTIVAR","ejecutaComando": "<EJECUTACOMANDO>","usrCreacion": "TESTE2E",
     "ipCreacion": "172.24.15.71","comandoConfiguracion": "SI", "empresa": "MD" }
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
    * print "****************************ESCENARIO DE CAMBIO DE PLAN***********************************"
    Given path  '/ws/process'
    And  request
    """
     {
     "nombre_cliente": "<NOM_CLIENTE>", "login": "<LOGIN>", "identificacion": "<IDENTIFICACION>", "datos": {
       "serial_ont": "<SERIALONT>", "mac_ont": "<MACONT>", "nombre_olt": "<NOM_OLT>", "ip_olt": "<IP_OLT>",
       "puerto_olt": "<PUERTO_OLT>", "modelo_olt":  "<MODELO_OLT>", "gemport": "", "service_profile": "<SERVICE_PROFILE>",
        "line_profile": "", "traffic_table": "", "ont_id": "#(ontid)", "service_port": "#(spid)","vlan": "301",
        "estado_servicio": "Activo", "mac_wifi": "", "tipo_negocio_actual": "HOME", "line_profile_nuevo": "",
        "gemport_nuevo": "1","traffic_table_nueva": "", "tipo_negocio_nuevo": "HOME", "vlan_nueva": "301", "ip": "",
       "scope": "",  "ip_fijas_activas": 0, "capacidad_up": "<CAPACIDAD_UP>", "capacidad_down": "<CAPACIDAD_DOWN>", "capacidad_up_nueva": "120000",
       "capacidad_down_nueva": "120000" }, "opcion": "CAMBIAR_PLAN", "ejecutaComando": "<EJECUTACOMANDO>", "usrCreacion": "TESTE2E",
       "ipCreacion": "172.24.15.71", "comandoConfiguracion": "SI",  "empresa": "MD"  }
    """
    And call tiempo_espera 20
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    * print response
    And call tiempo_espera 36
    Then status 200
    And match response.status == "OK"
    And match response.opcion == "CAMBIAR_PLAN"
    * print "******************************** ESCENARIO DE SUSPENSIÓN *********************************************"
    Given path  '/ws/process'
    And  request
    """
    {
     "nombre_cliente": "<NOM_CLIENTE>", "login": "<LOGIN>", "identificacion": "<IDENTIFICACION>", "datos": {
     "ont_id": "#(ontid)", "service_port": "#(spid)", "serial_ont": "<SERIALONT>", "mac_ont": "<MACONT>",
     "nombre_olt": "<NOM_OLT>", "ip_olt": "<IP_OLT>",  "puerto_olt": "<PUERTO_OLT>", "modelo_olt": "<MODELO_OLT>",
     "gemport": "", "service_profile": "<SERVICE_PROFILE>", "line_profile": "",  "traffic_table": "", "vlan": "",
     "estado_servicio": "Activo",  "mac_wifi": null,  "capacidad_up": "<CAPACIDAD_UP>",  "capacidad_down": "<CAPACIDAD_DOWN>",
     "tipo_negocio_actual": "HOME"  },  "opcion": "CORTAR", "ejecutaComando": "<EJECUTACOMANDO>", "usrCreacion": "TESTE2E",
     "ipCreacion": "172.24.15.71", "comandoConfiguracion": "SI", "empresa": "MD"
     }
    """
    And call tiempo_espera 20
    * configure connectTimeout = 150000
    * configure readTimeout = 150000
    When method post
    * print response
    And call tiempo_espera 36
    Then status 200
    And match response.status == "OK"
    And match response.opcion == "CORTAR"
    * print "******************************** ESCENARIO DE REACTIVACION *********************************************"
    Given path  '/ws/process'
    And  request
    """
    {
      "nombre_cliente": "<NOM_CLIENTE>", "login": "<LOGIN>",  "identificacion": "<IDENTIFICACION>", "datos": {
       "ont_id": "#(ontid)", "service_port": "#(spid)", "serial_ont": "<SERIALONT>",  "mac_ont": "<MACONT>",
       "nombre_olt": "<NOM_OLT>",  "ip_olt": "<IP_OLT>", "puerto_olt": "<PUERTO_OLT>", "modelo_olt": "<MODELO_OLT>",
       "gemport": "", "service_profile": "<SERVICE_PROFILE>", "line_profile": "",  "traffic_table": "", "vlan": "",
       "estado_servicio": "Activo", "mac_wifi": null,  "capacidad_up": "<CAPACIDAD_UP>", "capacidad_down": "<CAPACIDAD_DOWN>",
       "tipo_negocio_actual": "HOME", "ip_fijas_activas": 0 },
       "opcion": "REACTIVAR",   "ejecutaComando": "<EJECUTACOMANDO>",  "usrCreacion": "cguerra",  "ipCreacion": "172.24.15.71",
       "comandoConfiguracion": "SI",  "empresa": "MD"
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
    * print "******************************** ESCENARIO DE CANCELAR *********************************************"
    Given path  '/ws/process'
    And  request
    """
    {
     "nombre_cliente": "<NOM_CLIENTE>", "login": "<LOGIN>",  "identificacion": "<IDENTIFICACION>",  "datos": {
     "serial_ont": "<SERIALONT>", "mac_ont": "<MACONT>",   "nombre_olt":  "<NOM_OLT>",  "ip_olt": "<IP_OLT>",
     "puerto_olt": "<PUERTO_OLT>", "modelo_olt": "<MODELO_OLT>", "gemport": "", "service_profile": "<SERVICE_PROFILE>",
     "line_profile": "",  "traffic_table": "",  "vlan": "",  "estado_servicio": "Asignada", "ip": "",
     "ip_fijas_activas": 0, "tipo_negocio_actual": "HOME", "mac_wifi": "", "scope": "",
     "capacidad_up": "<CAPACIDAD_UP>",  "capacidad_down": "<CAPACIDAD_DOWN>",  "equipoOntDualBand": "NO", "tipoOrden": "NUEVO",
     "ont_id": "#(ontid)",  "service_port": "#(spid)", "ip_cancelar": [] }, "opcion": "CANCELAR","ejecutaComando": "<EJECUTACOMANDO>",
     "usrCreacion": "cguerra",  "ipCreacion": "172.24.15.71", "comandoConfiguracion": "SI",  "empresa": "MD"
    }
    """
    When method post
    * print response
    And match response.opcion == "CANCELAR"
    And match response.status == "OK"
    Then status 200
    Examples:
      | NOM_CLIENTE      |        LOGIN        | IDENTIFICACION    | SERIALONT        | MACONT              | NOM_OLT              | IP_OLT            | PUERTO_OLT | MODELO_OLT |SERVICE_PROFILE|CAPACIDAD_UP | CAPACIDAD_DOWN | EJECUTACOMANDO |
      | CRISTHIAN FLORES | md-uiocifloresh3    | 1308845260        | 4857544301FF8EA6 | C0:FF:A8:3E:CE:57   | olt-hw-7-labuio-uio  |  10.221.18.54     |  0/15      |    MA5608T |EG8M8145V5G06  |30000        | 30000          |        NO      |