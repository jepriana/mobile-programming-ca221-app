import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class LocationInputPage extends StatelessWidget {
  final Function(String location, double latitude, double longitude)
      onLocationSelected;
  final String? initialLocation;
  final double? initialLatitude;
  final double? initialLongitude;

  const LocationInputPage({
    super.key,
    required this.onLocationSelected,
    this.initialLocation,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: FlutterLocationPicker(
        onPicked: (pickedData) {
          onLocationSelected(
            pickedData.address,
            pickedData.latLong.latitude,
            pickedData.latLong.longitude,
          );
          Navigator.of(context).pop();
        },
        loadingWidget: const CircularProgressIndicator(),
        initPosition: const LatLong(-2.7966701, 117.3848847),
        initZoom: 5,
        trackMyPosition: true,
      ),
    );
  }
}
