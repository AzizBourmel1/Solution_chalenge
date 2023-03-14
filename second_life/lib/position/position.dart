import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:secondlife/position/form.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class position extends StatefulWidget {
  const position({super.key});

  @override
  State<position> createState() => _positionState();
}

class _positionState extends State<position> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => form(),
              ));
        },
        label: const Text('Share'),
        icon: const Icon(Icons.shopping_cart_checkout_sharp),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
