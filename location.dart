import 'package:flutter/material.dart';
import 'package:second_pillar/solat_time.dart';
import 'package:second_pillar/save_data.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  List<SolatTime> locationZone = [
    SolatTime(url: 'JHR01', zone: 'Johor - Pulau Aur dan Pulau Pemanggil'),
    SolatTime(url: 'JHR02', zone: 'Johor - Johor Bahru, Kota Tinggi, Mersing'),
    SolatTime(url: 'JHR03', zone: 'Johor - Kluang, Pontian'),
    SolatTime(url: 'JHR04', zone: 'Johor - Batu Pahat, Muar, Segamat, Gemas Johor'),
    SolatTime(url: 'KDH01', zone: 'Kedah - Kota Setar, Kubang Pasu, Pokok Sena (Daerah Kecil)'),
    SolatTime(url: 'KDH02', zone: 'Kedah - Kuala Muda, Yan, Pendang'),
    SolatTime(url: 'KDH03', zone: 'Kedah - Padang Terap, Sik'),
    SolatTime(url: 'KDH04', zone: 'Kedah - Baling'),
    SolatTime(url: 'KDH05', zone: 'Kedah - Bandar Baharu, Kulim'),
    SolatTime(url: 'KDH06', zone: 'Kedah - Langkawi'),
    SolatTime(url: 'KDH07', zone: 'Kedah - Puncak Gunung Jerai'),
    SolatTime(url: 'KTN01', zone: 'Kelantan - Bachok, Kota Bharu, Machang, Pasir Mas, Pasir Puteh, Tanah Merah, Tumpat, Kuala Krai, Mukim Chiku'),
    SolatTime(url: 'KTN03', zone: 'Kelantan - Gua Musang (Daerah Galas dan Bertam), Jeli'),
    SolatTime(url: 'MLK01', zone: 'Melaka - Seluruh Negeri Melaka'),
    SolatTime(url: 'NGS01', zone: 'Negeri Sembilan - Tampin, Jempol'),
    SolatTime(url: 'NGS02', zone: 'Negeri Sembilan - Jelebu, Kuala Pilah, Port Dickson, Rembau, Seremban'),
    SolatTime(url: 'PHG01', zone: 'Pahang - Pulau Tioman'),
    SolatTime(url: 'PHG02', zone: 'Pahang - Kuantan, Pekan, Rompin, Muadzam Shah'),
    SolatTime(url: 'PHG03', zone: 'Pahang - Jerantut, Temerloh, Maran, Bera, Chenor, Jengka'),
    SolatTime(url: 'PHG04', zone: 'Pahang - Bentong, Lipis, Raub'),
    SolatTime(url: 'PHG05', zone: 'Pahang - Genting Sempah, Janda Baik, Bukit Tinggi'),
    SolatTime(url: 'PHG06', zone: 'Pahang - Cameron Highlands, Genting Highlands, Bukit Fraser'),
    SolatTime(url: 'PLS01', zone: 'Perlis - Kangar, Padang Besar, Arau'),
    SolatTime(url: 'PNG01', zone: 'Pulau Pinang - Seluruh Negeri Pulau Pinang'),
    SolatTime(url: 'PRK01', zone: 'Perak - Tapah, Slim River, Tanjung Malim'),
    SolatTime(url: 'PRK02', zone: 'Perak - Kuala Kangsar, Sg. Siput, Ipoh, Batu Gajah, Kampar'),
    SolatTime(url: 'PRK03', zone: 'Perak - Lenggong, Pengkalan Hulu, Grik'),
    SolatTime(url: 'PRK04', zone: 'Perak - Temengor, Belum'),
    SolatTime(url: 'PRK05', zone: 'Perak - Kg Gajah, Teluk Intan, Bagan Datuk, Seri Iskandar, Beruas, Parit, Lumut, Sitiawan, Pulau Pangkor'),
    SolatTime(url: 'PRK06', zone: 'Perak - Selama, Taiping, Bagan Serai, Parit Buntar'),
    SolatTime(url: 'PRK07', zone: 'Perak - Bukit Larut'),
    SolatTime(url: 'SBH01', zone: 'Sabah - Bahagian Sandakan(Timur), Bukit Garam, Semawang, Temanggong, Tambisan, Bandar Sandakan, Sukau'),
    SolatTime(url: 'SBH02', zone: 'Sabah - Beluran, Telupod, Pinangah, Terusan, Kuamut, Bahagian Sandakan(Barat)'),
    SolatTime(url: 'SBH03', zone: 'Sabah - Lahad Datu, Silabukan, Kunak, Sahabat, Semporna, Tungku, Bahagian Tawau(Timur)'),
    SolatTime(url: 'SBH04', zone: 'Sabah - Bandar Tawau, Balong, Merotai, Kalabakan, Bahagian Tawau(Barat)'),
    SolatTime(url: 'SBH05', zone: 'Sabah - Kudat, Kota Marudu, Pitas, Pulau Banggi, Bahagian Kudat'),
    SolatTime(url: 'SBH06', zone: 'Sabah - Gunung Kinabalu'),
    SolatTime(url: 'SBH07', zone: 'Sabah - Kota Kinabalu, Ranau, Kota Belud, Tuaran, Penampang, Papar, Putatan, Bahagian Pantai Barat'),
    SolatTime(url: 'SBH08', zone: 'Sabah - Pensiangan, Keningau, Tambunan, Nabawan, Bahagian Pedalaman(Atas)'),
    SolatTime(url: 'SBH09', zone: 'Sabah - Beaufort, Kuala Penyu, Sipitang, Tenom, Long Pa Sia, Membakut, Weston, Bahagian Pedalaman(Bawah)'),
    SolatTime(url: 'SGR01', zone: 'Selangor - Gombak, Petaling, Sepang, Hulu Langat, Hulu Selangor, Shah Alam'),
    SolatTime(url: 'SGR02', zone: 'Selangor - Kuala Selangor, Sabak Bernam'),
    SolatTime(url: 'SGR03', zone: 'Selangor - Klang, Kuala Langat'),
    SolatTime(url: 'SWK01', zone: 'Sarawak - Limbang, Lawas, Sundar, Trusan'),
    SolatTime(url: 'SWK02', zone: 'Sarawak - Miri, Niah, Bekenu, Sibuti, Marudi'),
    SolatTime(url: 'SWK03', zone: 'Sarawak - Pandan, Belaga, Suai, Tatau, Sebauh, Bintulu'),
    SolatTime(url: 'SWK04', zone: 'Sarawak - Sibu, Mukah, Dalat, Song, Igan, Oya, Balingian, Kanowit, Kapit'),
    SolatTime(url: 'SWK05', zone: 'Sarawak - Sarikei, Matu, Julau, Rajang, Daro, Bintangor, Belawai'),
    SolatTime(url: 'SWK06', zone: 'Sarawak - Lubuk Antu, Sri Aman, Roban, Debak, Kabong, Lingga, Engkelili, Betong, Spaoh, Pusa, Saratok'),
    SolatTime(url: 'SWK07', zone: 'Sarawak - Serian, Simunjan, Samarahan, Sebuyau, Meludam'),
    SolatTime(url: 'SWK08', zone: 'Sarawak - Kuching, Bau, Lundu, Sematan'),
    SolatTime(url: 'SWK09', zone: 'Sarawak - Zon Khas (Kampung Patarikan)'),
    SolatTime(url: 'TRG01', zone: 'Terengganu - Kuala Terengganu, Marang, Kuala Nerus'),
    SolatTime(url: 'TRG02', zone: 'Terengganu - Besut, Setiu'),
    SolatTime(url: 'TRG03', zone: 'Terengganu - Hulu Terengganu'),
    SolatTime(url: 'TRG04', zone: 'Terengganu - Dungun, Kemaman'),
    SolatTime(url: 'WLY01', zone: 'Wilayah Persekutuan - Kuala Lumpur, Putrajaya'),
    SolatTime(url: 'WLY02', zone: 'Wilayah Persekutuan - Labuan'),
  ];

  void getNewZone(index) async {

    // Save the new location
    SaveData location = SaveData.zoneData();
    await location.saveZone(locationZone[index].url, locationZone[index].zone);

    // Get time-format from saved one
    SaveData tfData = SaveData.timeFormatData();
    await tfData.getTimeFormat();
    int timeFormat = tfData.timeFormatValue;

    // Get data from the new location
    SolatTime getLocation = locationZone[index];
    await getLocation.getData();
    Navigator.pop(context, {
      'subuh' : getLocation.waktuSolat[0],
      'syuruk' : getLocation.waktuSolat[1],
      'dhuha' : getLocation.waktuSolat[2],
      'zohor' : getLocation.waktuSolat[3],
      'asar' : getLocation.waktuSolat[4],
      'maghrib' : getLocation.waktuSolat[5],
      'isya' : getLocation.waktuSolat[6],
      'zone' : getLocation.zone,
      'timeFormat' : timeFormat,
    });


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose location/zone'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: locationZone.length,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: (index.isEven ? Colors.grey[900] : Colors.grey[850]),
              selectedTileColor: Colors.indigo[900],
              focusColor: Colors.indigo[900],
              onTap: () {
                getNewZone(index);
              },
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(locationZone[index].zone,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
