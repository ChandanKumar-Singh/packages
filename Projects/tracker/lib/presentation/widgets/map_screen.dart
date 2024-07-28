import 'dart:async';

import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../business_logics/blocs/index.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state.locations.isEmpty) {
          return const Center(child: const Text('No locations available'));
        }

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  state.locations.first.latitude!,
                  state.locations.first.longitude!,
                ),
                zoom: 12.0,
              ),
              markers: state.locations.map((location) {
                return Marker(
                  markerId: MarkerId(location.time.validate().toString()),
                  position: LatLng(location.latitude!, location.longitude!),
                  infoWindow: InfoWindow(
                      title: location.latitude.validate().toString()),
                );
              }).toSet(),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: state.locations
                      .map((loc) => LatLng(loc.latitude!, loc.longitude!))
                      .toList(),
                  color: Colors.blue,
                  width: 5,
                ),
              },
            ),

            /// add location widget
            addLocationButton(state),

            /// listen location widget
            listenLocationButton(),

            /// stop listen location widget
            stopListeningLocationButton(),
          ],
        );
      },
    );
  }

  Positioned stopListeningLocationButton() {
    return Positioned(
      bottom: 100.0,
      left: 20.0,
      child: FloatingActionButton(
        onPressed: () async {
          context.read<LocationBloc>().add(StopListenLocationsEvent());
        },
        child: const Icon(Icons.stop),
      ),
    );
  }

  Positioned listenLocationButton() {
    return Positioned(
      bottom: 20.0,
      left: 20.0,
      child: FloatingActionButton(
        onPressed: () async {
          context.read<LocationBloc>().add(ListenLocationsEvent());
        },
        child: const Icon(Icons.location_history_rounded),
      ),
    );
  }

  Positioned addLocationButton(LocationState state) {
    return Positioned(
      bottom: 20.0,
      right: 60.0,
      child: FloatingActionButton(
        onPressed: () async {
          context.read<LocationBloc>().add(AddLocationEvent());
        },
        child: state.status == LocationStatus.loading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Icon(Icons.location_on_outlined),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
