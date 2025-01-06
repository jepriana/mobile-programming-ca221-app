import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

class LocationInputPage extends StatefulWidget {
  static const String routeName = '/location-input';
  const LocationInputPage({
    super.key,
    required this.onSelectedLocation,
    this.selectedLocation,
    this.latitude,
    this.longitude,
  });
  final Function(String location, double latitude, double longitude)
      onSelectedLocation;
  final String? selectedLocation;
  final double? latitude;
  final double? longitude;

  @override
  State<LocationInputPage> createState() => _LocationInputPageState();
}

class _LocationInputPageState extends State<LocationInputPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Location'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: FlutterLocationPicker(
        key: UniqueKey(),
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        initPosition: const LatLong(-2.8530416,117.553452),
        // minZoomLevel: context.read<MapsBloc>().minZoom,
        // maxZoomLevel: context.read<MapsBloc>().maxZoom,
        initZoom: 6,
        trackMyPosition: true,
        // searchBarHintText: LocaleKeys.searchLocation.tr(),
        // selectLocationButtonText: LocaleKeys.chooseLocation.tr(),
        onPicked: (pickedData) {
          widget.onSelectedLocation(pickedData.address,
              pickedData.latLong.latitude, pickedData.latLong.longitude);
          Navigator.pop(context);
        },
      ),
    );
  }
}
