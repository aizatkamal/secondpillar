import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:second_pillar/save_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  int timeFormat;
  int tfRadioValue;

  dynamic subuh;
  dynamic syuruk;
  dynamic dhuha;
  dynamic zohor;
  dynamic asar;
  dynamic maghrib;
  dynamic isya;

  String currentSolatName;
  String currentSolatTime;
  String locationZone;

  updateTimeFormat(theTF) async {
    SaveData newTF = SaveData.timeFormatData();
    await newTF.saveTimeFormat(theTF);
  }

  void manageTimeFormat(int value) {
    setState(() {
      tfRadioValue = value;

      switch(tfRadioValue) {
        case 0 :
          timeFormat = 12;
          updateTimeFormat(timeFormat);
          break;
        case 1 :
          timeFormat = 24;
          updateTimeFormat(timeFormat);
          break;
      }

    });
  }
  
  initTimeFormat() async {
    SaveData initialTF = SaveData.timeFormatData();
    await initialTF.getTimeFormat();
    tfRadioValue = initialTF.timeFormatDisplay;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      initTimeFormat();
    });
  }


  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    data.isNotEmpty ? timeFormat = data['timeFormat'] : timeFormat = 12;
    locationZone = data['zone'].toString();

    List colorOne = [Colors.grey[900], Colors.grey[900]];
    List colorTwo = [Colors.grey[850], Colors.grey[850]];
    List colorMasukWaktu = [Colors.indigo[900], Colors.indigo[800]];

    // Gregorian Date
    var nowG = DateTime.now();
    var yesterdayG = nowG.subtract(Duration(days: 1));
    var todayG = DateFormat("dd MMMM yyyy").format(nowG);

    // Hijri Date
    var nowH = HijriCalendar.fromDate(yesterdayG); // New date after Maghrib
    nowH = nowG.isAfter(data['maghrib']) ? HijriCalendar.now() : nowH;
    var todayH = nowH.toFormat("dd MMMM yyyy");

    // Masuk waktu time range
    var timeSubuh = (nowG.isAfter(data['subuh']) && nowG.isBefore(data['syuruk']));
    var timeSyuruk = (nowG.isAfter(data['syuruk']) && nowG.isBefore(data['dhuha']));
    var timeDhuha = (nowG.isAfter(data['dhuha']) && nowG.isBefore(data['zohor']));
    var timeZohor = (nowG.isAfter(data['zohor']) && nowG.isBefore(data['asar']));
    var timeAsar = (nowG.isAfter(data['asar']) && nowG.isBefore(data['maghrib']));
    var timeMaghrib = (nowG.isAfter(data['maghrib']) && nowG.isBefore(data['isya']));
    var timeIsya = (nowG.isAfter(data['isya']) || nowG.isBefore(data['subuh']));


    // Time Format display
    if (timeFormat == 12) {

      subuh = DateFormat.jm().format(data['subuh']);
      syuruk = DateFormat.jm().format(data['syuruk']);
      dhuha = DateFormat.jm().format(data['dhuha']);
      zohor = DateFormat.jm().format(data['zohor']);
      asar = DateFormat.jm().format(data['asar']);
      maghrib = DateFormat.jm().format(data['maghrib']);
      isya = DateFormat.jm().format(data['isya']);

    } else if (timeFormat == 24) {

      subuh = DateFormat.Hm().format(data['subuh']);
      syuruk = DateFormat.Hm().format(data['syuruk']);
      dhuha = DateFormat.Hm().format(data['dhuha']);
      zohor = DateFormat.Hm().format(data['zohor']);
      asar = DateFormat.Hm().format(data['asar']);
      maghrib = DateFormat.Hm().format(data['maghrib']);
      isya = DateFormat.Hm().format(data['isya']);

    }

    if(timeSubuh) {
      currentSolatName = 'Subuh';
      currentSolatTime = subuh;
    } else if(timeSyuruk) {
      currentSolatName = 'Syuruk';
      currentSolatTime = syuruk;
    } else if(timeDhuha) {
      currentSolatName = 'Dhuha';
      currentSolatTime = dhuha;
    } else if(timeZohor) {
      currentSolatName = 'Zohor';
      currentSolatTime = zohor;
    } else if(timeAsar) {
      currentSolatName = 'Asar';
      currentSolatTime = asar;
    } else if(timeMaghrib) {
      currentSolatName = 'Maghrib';
      currentSolatTime = maghrib;
    } else if(timeIsya) {
      currentSolatName = 'Isya\'';
      currentSolatTime = isya;
    } else {
      currentSolatName = 'Loading...';
      currentSolatTime = 'Loading...';
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Second Pillar'),
          centerTitle: true,
          actions: [
            GestureDetector(
              child: IconButton(
                icon: Icon(Icons.refresh, size: 28.0),
                onPressed: () async {
                  await Navigator.pushReplacementNamed(context, '/loading');
                },
              ),
            ),
          ],
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.grey[900],
          ),
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Second Pillar', style: TextStyle(fontSize: 18.0, color: Colors.white),),
                    subtitle: Text('Your Solat Companion', style: TextStyle(fontSize: 12.0, color: Colors.white70),),
                  ),
                  Column(
                    children: [
                      RadioListTile(
                        title: Text('12-Hour Format', style: TextStyle(color: Colors.white),),
                        value: 0,
                        groupValue: tfRadioValue,
                        onChanged: manageTimeFormat,
                      ),
                      RadioListTile(
                        title: Text('24-Hour Format', style: TextStyle(color: Colors.white),),
                        value: 1,
                        groupValue: tfRadioValue,
                        onChanged: manageTimeFormat,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                        child: RaisedButton(
                          color: Colors.indigo[900],
                          child: Text('Save', style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            Navigator.pop(context);
                            await Navigator.pushReplacementNamed(context, '/loading');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.indigo[50],
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          dynamic result = await Navigator.pushNamed(context, '/location');

                          if(result != null) {
                            setState(() {
                              data = {
                                'subuh': result['subuh'],
                                'syuruk': result['syuruk'],
                                'dhuha': result['dhuha'],
                                'zohor': result['zohor'],
                                'asar': result['asar'],
                                'maghrib': result['maghrib'],
                                'isya': result['isya'],
                                'zone': result['zone'],
                                'timeFormat': result['timeFormat'],
                              };
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit_location, color: Colors.red),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Container(
                                child: Text(locationZone,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(currentSolatName,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Text(currentSolatTime,
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('$todayG | $todayH',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SolatTimeBox(solatName: 'Subuh', solatTime: subuh, colorList: (timeSubuh ? colorMasukWaktu : colorOne),),
            SolatTimeBox(solatName: 'Syuruk', solatTime: syuruk, colorList: (timeSyuruk ? colorMasukWaktu : colorTwo),),
            SolatTimeBox(solatName: 'Dhuha', solatTime: dhuha, colorList: (timeDhuha ? colorMasukWaktu : colorOne),),
            SolatTimeBox(solatName: 'Zohor', solatTime: zohor, colorList: (timeZohor ? colorMasukWaktu : colorTwo),),
            SolatTimeBox(solatName: 'Asar', solatTime: asar, colorList: (timeAsar ? colorMasukWaktu : colorOne),),
            SolatTimeBox(solatName: 'Maghrib', solatTime: maghrib, colorList: (timeMaghrib ? colorMasukWaktu : colorTwo),),
            SolatTimeBox(solatName: 'Isya\'', solatTime: isya, colorList: (timeIsya ? colorMasukWaktu : colorOne),),
          ],
        ),
      ),
    );
  }
}

class SolatTimeBox extends StatelessWidget {

  final String solatName;
  final String solatTime;
  List colorList = [];

  SolatTimeBox({Key key, this.solatName, this.solatTime, this.colorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorList[0], colorList[1]],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(solatName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                ),
              ),
              Text((solatTime == null ? 'Const Error' : solatTime),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}