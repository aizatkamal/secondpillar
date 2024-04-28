import 'package:flutter/material.dart';
import 'package:second_pillar/solat_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:second_pillar/save_data.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getWaktuSolat() async {

    // Get saved location data
    SaveData location = SaveData.zoneData();
    await location.getZone();
    String url = location.urlValue;
    String zone = location.zoneValue;

    // Get saved time-format data
    SaveData tfData = SaveData.timeFormatData();
    await tfData.getTimeFormat();
    int timeFormat = tfData.timeFormatValue;

    SolatTime jamSolat = SolatTime(url: url, zone: zone);
    await jamSolat.getData();

    // Navigate to home screen with data
    await Navigator.pushReplacementNamed(context, '/home', arguments: {
      'subuh' : jamSolat.waktuSolat[0],
      'syuruk' : jamSolat.waktuSolat[1],
      'dhuha' : jamSolat.waktuSolat[2],
      'zohor' : jamSolat.waktuSolat[3],
      'asar' : jamSolat.waktuSolat[4],
      'maghrib' : jamSolat.waktuSolat[5],
      'isya' : jamSolat.waktuSolat[6],
      'zone' : jamSolat.zone,
      'timeFormat' : timeFormat,
    });

  }


  @override
  void initState() {
    super.initState();
    getWaktuSolat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
