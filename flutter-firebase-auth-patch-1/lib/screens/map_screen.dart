import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(45.0447894, 42.002853);

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  //change map type
  void _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Future<void> _goToDefaultLocation() async {
    const _defaultPosition = currentLocation;
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 12));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentLocation,
            zoom: 12,
          ),
          mapType: _currentMapType,
          onMapCreated: (controller) {
            mapController = controller;
            addMarker('test', currentLocation);
          },
          markers: _markers.values.toSet(),
        ),
        Container(
          padding: EdgeInsets.only(top: 24, right: 12),
          alignment: Alignment.topRight,
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: _changeMapType,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.map,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  (controller) {
                    mapController = controller;
                    addMarker('test', currentLocation);
                  };
                },
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(
                  Icons.add_location,
                  size: 36,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: _goToDefaultLocation,
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(
                  Icons.home_rounded,
                  size: 36,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  addMarker(String id, LatLng location) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'img/59.png');

    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: 'Title of place',
        snippet: 'Some description of the place',
      ),
      icon: markerIcon,
    );

    _markers[id] = marker;
    setState(() {});
  }
}
