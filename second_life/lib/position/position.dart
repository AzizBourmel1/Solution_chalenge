import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:secondlife/position/form.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class position extends StatefulWidget {
  const position({super.key});

  @override
  State<position> createState() => _positionState();
}

class _positionState extends State<position> {
  late Position cl;
  var lat;
  var long;
  late CameraPosition _kGooglePlex;
  Set<Marker> myMarker = Set();

  getPosts() async {
    CollectionReference postsRef =
        FirebaseFirestore.instance.collection("posts");
    await postsRef.get().then((value) {
      value.docs.forEach((element) {
        myMarker.add(
          Marker(
              markerId: MarkerId(element.id),
              infoWindow: InfoWindow(
                title: element['product'],
                snippet: "${element['quantity']} KG " +
                    " tel : ${element['phone']} ",
                onTap: () async {
                  await launchUrl(Uri.parse(element['image']),
                      mode: LaunchMode.externalApplication);
                },
              ),
              position: LatLng(element['latitude'], element['longitude'])),
        );
      });
    });
  }

  getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      print("activate service");
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }

    return per;
  }

  getLastAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
    setState(() {});
  }

  @override
  void initState() {
    getPer();
    getPosts();
    getLastAndLong();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: lat == null
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                markers: myMarker,
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
