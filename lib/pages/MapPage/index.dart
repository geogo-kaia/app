import 'dart:convert';
import 'dart:typed_data';
import 'package:geogo/models/checkpoint.dart';
import 'package:geogo/models/media.dart';
import 'package:geogo/repositories/checkpoint_repo.dart';
import 'package:geogo/widgets/LoadingIndicator/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/pages/CheckpointPage/index.dart';
import 'package:geogo/pages/LoginPage/index.dart';
import 'package:geogo/pages/SplashPage/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController googleMapController;
  late TextEditingController _searchController;
  late Set<Marker> markers = Set();
  late List<Checkpoint> checkpointsList = [];
  static const LatLng showLocation = const LatLng(22.279909, 114.173729);
  BitmapDescriptor? bitmapIcon;
  Set<Marker>? _markers;
  static LatLng _initialcameraposition = LatLng(0, 0);
  LatLng? _clickedlocationposition;
  Location _location = Location();
  double checkpointDistance = 0.0;
  var showCPDetail = false;
  Checkpoint _selectedMarker =
      Checkpoint("", "", "", LatLng(22.2790614, 114.1736855), 1, "");

  //this is the function to load custom map style json
  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/map_style.json")
        .then((value) => setMapStyle(value, mapController));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  //helper function
  Future<double> getDistance(lat1, lon1, lat2, lon2) async {
    double distanceInMeters =
        await Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters;
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    _searchController = TextEditingController();
    _location.onLocationChanged.listen((l) {
      /*     _initialcameraposition = LatLng(l.latitude!, l.longitude!); */

      print("location changed");
      print("${l.latitude!}, ${l.longitude!}");
      setState(() {
        _initialcameraposition = LatLng(l.latitude!, l.longitude!);
      });
    });
  }

  void setMarkerIcons(LatLng position) async {
    markers = <Marker>{};
    bitmapIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/marker.png');
    CheckpointRepository().list(currentPosition: position).then((checkpoints) {
      setState(() {
        checkpointsList = checkpoints;
        print(checkpoints.length);
      });
    });
    for (var checkpoint in checkpointsList) {
      markers.add(Marker(
          //add first marker
          markerId: MarkerId(checkpoint.googlePlaceId),
          position: checkpoint.location, //position of marker
          icon: bitmapIcon!, //Icon for Marker
          onTap: () {
            setState(() {
              _clickedlocationposition = checkpoint.location;
              _selectedMarker = checkpoint;
              getDistance(
                      checkpoint.location.latitude,
                      checkpoint.location.longitude,
                      _initialcameraposition.latitude,
                      _initialcameraposition.longitude)
                  .then((value) {
                checkpointDistance = value;
                showCPDetail = true;
              });
            });
          }));
    }
    setState(() {
      _markers = markers;
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    changeMapMode(googleMapController);
    var currentPosition = await _location.getLocation();
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(currentPosition.latitude!, currentPosition.longitude!),
            zoom: 17),
      ),
    );
  }

  getLocation() async {
    await _location.getLocation();
  }

  _onCameraMove(CameraPosition position) {
    LatLng center = position.target;
    print("position${center.latitude},${center.longitude}");
    setMarkerIcons(LatLng(center.latitude!, center.longitude!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeData.backgroundColor,
      appBar: _setSearchAppBar(context),
      body: LayoutBuilder(builder: (context, constraints) {
        var maxWidth = constraints.biggest.width;
        var maxHeight = constraints.biggest.height;
        return SafeArea(
          child: _initialcameraposition == LatLng(0, 0)
              ? Container(child: LoadingIndicator())
              : Padding(
                  padding: const EdgeInsets.all(0),
                  child: Stack(children: [
                    GoogleMap(
                      onTap: (latlang) {
                        setState(() {
                          showCPDetail = false;
                        });
                      },
                      markers: markers,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: _initialcameraposition, zoom: 17),
                      onCameraMove: _onCameraMove,
                      onMapCreated: _onMapCreated,
                    ),
                    Positioned(
                      bottom: maxHeight / 2,
                      right: (maxWidth - 40) / 2,
                      child: SvgPicture.asset(
                        "assets/images/location.svg",
                        height: 40,
                      ),
                    ),
                    Visibility(
                      visible: showCPDetail,
                      child: Positioned(
                          left: 12,
                          right: 12,
                          bottom: 12,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => CheckpointPage(
                                            locationPosition:
                                                _clickedlocationposition,
                                            checkpoint: _selectedMarker,
                                          )))
                            },
                            child: Card(
                                color: Colors.white,
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 12),
                                  child: Row(children: [
                                    CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.25 *
                                                3 /
                                                4,
                                        imageUrl:
                                            _selectedMarker.coverPhotoUrl!),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(_selectedMarker.name!),
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: [
                                              Text(_selectedMarker.vicinity!,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black54),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Chip(
                                                  labelPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4,
                                                          vertical: -4),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  label: Text(
                                                      "Get \$BGT ${_selectedMarker.rewardPoint}",
                                                      style: buttonTextStyle
                                                          .copyWith(
                                                              fontSize: 8)),
                                                  backgroundColor:
                                                      themeData.primaryColor,
                                                  shape: StadiumBorder(
                                                      side: BorderSide(
                                                          color: themeData
                                                              .primaryColor)))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                )),
                          )),
                    )
                  ])),
        );
      }),
    );
  }

  _setSearchAppBar(context) {
    return AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        titleSpacing: 24,
        iconTheme: IconThemeData(color: themeData.primaryColor),
        elevation: 1,
        title: Column(
          children: [
            TextField(
              onTap: () => {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const LoginPage()))
              },
              readOnly: true,
              controller: _searchController,
              textInputAction: TextInputAction.search,
              maxLines: 1,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: "Where checkpoint did you want to visit?",
                  prefixIcon:
                      Icon(size: 24, Icons.location_on, color: Colors.black45),
                  suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.filter_list_rounded,
                          color: Colors.black45),
                      onPressed: () => {}),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 0.5,
                          style: BorderStyle.solid)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: Colors.black26,
                          width: 0.5,
                          style: BorderStyle.solid))),
            ),
          ],
        ));
  }
}
