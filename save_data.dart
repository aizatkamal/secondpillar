import 'package:shared_preferences/shared_preferences.dart';

class SaveData {

  String url;
  String zone;
  String urlValue;
  String zoneValue;
  int timeFormat;
  int timeFormatValue;
  int timeFormatDisplay;

  SaveData.zoneData({this.url, this.zone});
  SaveData.timeFormatData({this.timeFormat});

  // Save zone data
  Future<void> saveZone(url, zone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final urlKey = 'urlKey';
    final zoneKey = 'zoneKey';
    urlValue = url;
    zoneValue = zone;
    await prefs.setString(urlKey, urlValue);
    await prefs.setString(zoneKey, zoneValue);
  }

  // Get zone data
  Future<void> getZone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final urlKey = 'urlKey';
    final zoneKey = 'zoneKey';
    urlValue = prefs.getString(urlKey) ?? 'WLY01';
    zoneValue = prefs.getString(zoneKey) ?? 'Kuala Lumpur, Putrajaya';
  }

  // Save time-format data
  Future<void> saveTimeFormat(timeFormat) async {
    final prefs = await SharedPreferences.getInstance();
    final tfKey = 'tfKey';
    timeFormatValue = timeFormat;
    await prefs.setInt(tfKey, timeFormatValue);
  }

  // Get time-format data
  Future<void> getTimeFormat() async {
    final prefs = await SharedPreferences.getInstance();
    final tfKey = 'tfKey';
    timeFormatValue = prefs.getInt(tfKey) ?? 12;

    // Time-format radio button display
    switch(timeFormatValue) {
      case 12:
        timeFormatDisplay = 0;
        break;
      case 24:
        timeFormatDisplay = 1;
        break;
    }

  }


}