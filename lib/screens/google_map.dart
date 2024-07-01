import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-8.1116602, 115.0988789);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Map Example'),
          backgroundColor: Colors.green[700],
        ),
        body:
            // GoogleMap(
            //   onMapCreated: _onMapCreated,
            //   initialCameraPosition: CameraPosition(
            //     target: _center,
            //     zoom: 11.0,

            //   ),
            // ),
            GoogleMap(
          initialCameraPosition: CameraPosition(target: _center, zoom: 15),
          markers: {
            Marker(markerId: const MarkerId('initial location'),
          position: _center,
          icon: BitmapDescriptor.defaultMarker)
          },
        )
        );
  }
}
