import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:xml2json/xml2json.dart';
import 'package:intl/intl.dart';

class SolatTime {

  String url;
  String zone;
  List waktuSolat = [];
  Map data = {};

  SolatTime({this.url, this.zone});

  Future<void> getData() async {

    try {

      Response response = await get('https://www.e-solat.gov.my/index.php?r=esolatApi/xmlfeed&zon=$url');

      // Convert XML to JSON
      var xmlToJson = Xml2Json();
      xmlToJson.parse(response.body);
      var dJson = xmlToJson.toParker();

      // Decode JSON
      Map rss = jsonDecode(dJson);

      // Iterate to get to actual waktu solat data
      Map channel = rss['rss'];
      Map title = channel['channel'];

      List solatList = title['item'];
      Map subuh = solatList[1];
      Map syuruk = solatList[2];
      Map zohor = solatList[3];
      Map asar = solatList[4];
      Map maghrib = solatList[5];
      Map isya = solatList[6];

      dynamic waktuSubuh = subuh['description'];
      dynamic waktuSyuruk = syuruk['description'];
      dynamic waktuDhuha;
      dynamic waktuZohor = zohor['description'];
      dynamic waktuAsar = asar['description'];
      dynamic waktuMaghrib = maghrib['description'];
      dynamic waktuIsya = isya['description'];

      // Add waktu dhuha (not available from JAKIM)
      var dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now());
      waktuDhuha = DateTime.parse('$dateNow $waktuSyuruk');
      waktuDhuha = waktuDhuha.add(Duration(minutes: 28));
      waktuDhuha = DateFormat("HH:mm:ss").format(waktuDhuha);

      waktuSolat = [waktuSubuh, waktuSyuruk, waktuDhuha, waktuZohor, waktuAsar, waktuMaghrib, waktuIsya];

      for (var i = 0; i < waktuSolat.length; i++) {
        waktuSolat[i] = DateTime.parse('$dateNow ${waktuSolat[i]}');
      }


    } catch (error) {

      print('Caught error: $error');

    }

  }

}