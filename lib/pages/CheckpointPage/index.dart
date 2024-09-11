import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:geogo/models/checkpoint.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geogo/pages/CheckPointRewardPage/index.dart';
import 'package:geogo/pages/RegisterPage/index.dart';
import 'package:geogo/widgets/Buttons/RoundButton/index.dart';
import 'package:geogo/widgets/RichText/index.dart';
import 'package:geogo/widgets/TabBar/index.dart';
import 'package:geogo/widgets/TextFields/RoundTextField/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slider_button/slider_button.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class CheckpointPage extends StatefulWidget {
  final LatLng? locationPosition;
  final Checkpoint checkpoint;
  const CheckpointPage(
      {required this.locationPosition, required this.checkpoint});
  @override
  _CheckpointPageState createState() => _CheckpointPageState();
}

class _CheckpointPageState extends State<CheckpointPage> {
  double _value = 0;
  Location _location = Location();
  double distance = -1;
  LatLng currentPosition = LatLng(22.279909, 114.173729);
  //helper function
  Future<double> getDistance(lat1, lon1, lat2, lon2) async {
    double distanceInMeters =
        await Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    return distanceInMeters;
  }

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((l) {
      currentPosition = LatLng(l.latitude!, l.longitude!);
      getDistance(
              currentPosition.latitude,
              currentPosition.longitude,
              widget.locationPosition?.latitude,
              widget.locationPosition?.longitude)
          .then((value) {
        setState(() {
          distance = value;
        });
        /*      print(distance.toString()); */
      });
    });

    _location.getLocation();
  }

  getLocation() async {
    await _location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Color.fromRGBO(128, 128, 128, 1), //change your color here
          ),
          title: Text(
            widget.checkpoint.name!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: themeData.backgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(255, 212, 62, 1),
                Color.fromRGBO(238, 142, 30, 1)
              ])),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                (distance < 30 && distance >= 0) ? "Arrived in location" : "",
                style: TextStyle(
                    color: Color.fromRGBO(0, 130, 44, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20),
              Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Container(
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(
                                    widget.checkpoint.coverPhotoUrl!))),
                        child: Image.asset(
                          "assets/images/spin.png",
                          width: 320,
                        )),
                  ]),
              SizedBox(height: 12),
              Text(
                widget.checkpoint.vicinity!,
                style: termTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Text(
                (distance > 30 && distance >= 0)
                    ? "You're too far from this checkpoint."
                    : "",
                style: TextStyle(
                    color: Color.fromRGBO(244, 67, 54, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              ConfirmationSlider(
                text: "Swipe to collect Coins",
                backgroundColor: themeData.primaryColor,
                textStyle: TextStyle(color: Colors.black87, fontSize: 12),
                sliderButtonContent:
                    Image.asset('assets/images/swipe_logo.png'),
                foregroundColor: Colors.black,
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                onConfirmation: () {
                  if (distance < 30 && distance >= 0)
                    showDialog(
                        barrierDismissible: false,
                        useSafeArea: false,
                        context: context,
                        builder: (BuildContext context) {
                          return CheckpointRewardPage();
                        });
                },
              ),
            ],
          )),
        ));
  }
}
