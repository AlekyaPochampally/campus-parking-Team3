import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
    @override
    _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

    Completer<GoogleMapController> _controller = Completer();

    static const LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
        _controller.complete(controller);
    }

    @override
    Widget build(BuildContext context) {
        return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
            )
        );
    }
}
