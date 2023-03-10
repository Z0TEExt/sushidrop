bool productionFlag = true;

String routeMapAPIKey =
    '5b3ce3597851110001cf624876ff4aa75ad64e2793085bcc5bd71d92';
String urlLocalServer = 'http://127.0.0.1:4399';
String urlProductionServer123 = 'http://103.30.127.83';
String urlServerPort = '8002';

String urlServer = productionFlag ? urlProductionServer123 : urlLocalServer;
