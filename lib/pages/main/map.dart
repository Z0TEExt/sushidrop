import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../settings/setting-data.dart';
import '../../settings/shared/data-shared.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool showSteam = false;
  String urlPath = urlServer;
  String urlPort = urlServerPort;
  late Uri url =
      Uri.parse('ws://${urlPath.split('//')[1]}:$urlPort/ws/delivery/0/');
  late WebSocketChannel _channel;

  MapController mapController = MapController();
  List<LatLng> polyPoints = [];
  bool isRider = UserData.userRole == 'rider' ? true : false;
  bool isMapRoute = false;
  double riderRotate = 0;
  Map? userPosision;
  Map? riderPosision;
  Map? dataMapRouting;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 0,
  );

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      if (position != null) {
        if (isRider) {
          String pos = jsonEncode({
            "rider": {
              "lat": position.latitude,
              "lng": position.longitude,
            }
          });
          _channel.sink.add(pos);
        } else {
          String pos = jsonEncode({
            "user": {
              "lat": position.latitude,
              "lng": position.longitude,
            }
          });
          _channel.sink.add(pos);
        }
      }
    });
  }

  void getJsonData(double sLat, double sLng, double eLat, double eLng) async {
    ORSapi routeMapNet =
        ORSapi(startLat: sLat, startLng: sLng, endLat: eLat, endLng: eLng);

    try {
      polyPoints.clear();
      dataMapRouting = await routeMapNet.getData();
      List<dynamic> indexData =
          (dataMapRouting!['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < indexData.length; i++) {
        polyPoints.add(LatLng(indexData[i][1], indexData[i][0]));
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void first() async {
    try {
      debugPrint('Pass');
      setState(() {
        showSteam = true;
      });
      _channel = WebSocketChannel.connect(url);
    } catch (e) {
      debugPrint('Error: $e');
      first();
    }
  }

  @override
  void initState() {
    _determinePosition();
    first();
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    var query = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before_rounded,
            size: 30,
            color: brightness ? const Color(0xFF505050) : Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Map',
          style: TextStyle(
            color: brightness ? const Color(0xFF505050) : Colors.white,
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(riderRotate.toString()),
          !showSteam
              ? const Text('Server Down | reconnect...')
              : StreamBuilder(
                  stream: _channel.stream,
                  builder: (context, snapshot) {
                    if (['ConnectionState.done']
                        .contains(snapshot.connectionState.toString())) {
                      first();
                      return const Text('ConnectionState.done | reconnect...');
                    }
                    if (snapshot.error != null) {
                      first();
                      return const Text('error | reconnect...');
                    }
                    if (snapshot.hasData) {
                      var temp = jsonDecode(jsonDecode(snapshot.data)["data"]);

                      if (temp['user'] != null) {
                        userPosision = temp['user'];
                      }

                      if (temp['rider'] != null) {
                        riderPosision = temp['rider'];
                      }

                      if (userPosision != null && riderPosision != null) {
                        if (!isMapRoute) {
                          getJsonData(
                              riderPosision!['lat'],
                              riderPosision!['lng'],
                              userPosision!['lat'],
                              userPosision!['lng']);
                          isMapRoute = true;
                        }
                        return Expanded(
                          child: Stack(
                            children: [
                              FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                  interactiveFlags: InteractiveFlag.pinchZoom |
                                      InteractiveFlag.drag,
                                  center: LatLng(userPosision!["lat"],
                                      userPosision!["lng"]),
                                  zoom: 18,
                                  minZoom: 15,
                                  maxZoom: 19,
                                ),
                                children: [
                                  TileLayer(
                                    minZoom: 15,
                                    maxZoom: 18,
                                    minNativeZoom: 15,
                                    maxNativeZoom: 18,
                                    urlTemplate:
                                        "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    userAgentPackageName:
                                        'com.example.sushidrop',
                                  ),
                                  PolylineLayer(
                                    polylineCulling: false,
                                    polylines: [
                                      Polyline(
                                        points: polyPoints,
                                        color: Colors.blue,
                                        strokeWidth: 10,
                                      ),
                                    ],
                                  ),
                                  MarkerLayer(
                                    rotate: true,
                                    markers: [
                                      Marker(
                                          point: LatLng(userPosision!["lat"],
                                              userPosision!["lng"]),
                                          anchorPos:
                                              AnchorPos.align(AnchorAlign.top),
                                          builder: ((context) => Image.asset(
                                                'assets/images/marker.png',
                                                scale: 2,
                                              ))),
                                      Marker(
                                          point: LatLng(riderPosision!["lat"],
                                              riderPosision!["lng"]),
                                          anchorPos:
                                              AnchorPos.align(AnchorAlign.top),
                                          builder: ((context) => Image.asset(
                                                'assets/images/rider_marker.png',
                                                scale: 2,
                                              )))
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.navigate_before_rounded,
                                        color: Color(0xFF505050),
                                      ),
                                      onPressed: () => false
                                      // Navigator.of(context).pop(false),
                                      ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          mapController.move(
                                              LatLng(userPosision!["lat"],
                                                  userPosision!["lng"]),
                                              18);
                                        },
                                        icon: const Icon(
                                          Icons.my_location_rounded,
                                        ))),
                              )
                            ],
                          ),
                        );
                      }
                    }
                    return const Text('Loding...',
                        style: TextStyle(fontSize: 30));
                  }),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Your role is : ${UserData.userRole}',
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
                  'Order Status: Delivering ',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: query.width * 0.9,
                  child: const Divider(
                    color: Color(0x10303030),
                    thickness: 2,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      mapController.move(
                          LatLng(riderPosision!["lat"], riderPosision!["lng"]),
                          18);
                    },
                    child: const Text(
                      'Rider Position',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class ORSapi {
  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey = routeMapAPIKey;
  final String pathParam = 'driving-car';
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  ORSapi(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  Future getData() async {
    http.Response response = await http.get(Uri.parse(
        '$url$pathParam?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}
