import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class GoogleMapSample extends StatefulWidget {
  @override
  State<GoogleMapSample> createState() => MapSampleState();
}

class MapSampleState extends State<GoogleMapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final MarkerId markerId = MarkerId('123');


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15.0,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
        compassEnabled: true,
        mapToolbarEnabled: true,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        zoomGesturesEnabled: true,
        indoorViewEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  void _add( LatLng position ) {
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: 'Marker position', snippet: '${position.latitude},${position.longitude}'),
      onTap: () {},
    );

    setState(() {
      markers.clear( );
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  Future<void> _goToTheLake() async {
    _add(_kLake.target);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }



  @override
  initState() {
    super.initState( );
    _initLocationService();
  }

  String error;
  LocationData _currentLocation;
  Location _locationService  = new Location();
  _initLocationService() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    LocationData location;

    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      if (serviceStatus) {
        PermissionStatus _permissionGranted;
        _permissionGranted = await _locationService.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await _locationService.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }
        location = await _locationService.getLocation();
        _locationService.onLocationChanged.listen((LocationData result) async {
          if(mounted){
            _currentLocation = result;
          }
        });

      } else {
        bool serviceStatusResult = await _locationService.requestService();
        if(serviceStatusResult){
          _initLocationService();
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
      print(e);
      print(error);
    }

    setState(() {
      _currentLocation = location;
      _add(LatLng( _currentLocation.latitude, _currentLocation.longitude));
    });

  }

}