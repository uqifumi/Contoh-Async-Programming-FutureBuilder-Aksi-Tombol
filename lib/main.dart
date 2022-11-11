import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:async_programming_futurebuilder_aksi_button/jadwal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  bool buttonKlik = false;
  late String datasubuh;
  late String datadzuhur;
  late String dataashar;
  late String datamaghrib;
  late String dataisya;
  late String datatanggal;
  Widget? progressIndicator;
  Widget? akanDitampilkan;
  Widget? inisisasiTampilanWaktu;
  Future<Jadwal>? dataSholat;

  // Function untuk request data JSON secara asynchronous.
  Future<Jadwal> fetchData() async {
    var tanggalSekarang = DateTime.now();
    var formatTanggal = DateFormat('yyyy-MM-dd');
    String formatTanggalSekarang = formatTanggal.format(tanggalSekarang);
    Response response = await get(Uri.parse(
        'https://api.banghasan.com/sholat/format/json/jadwal/kota/775/tanggal/$formatTanggalSekarang'));
    final data = jsonDecode(response.body);
    Jadwal jadwalSholat = Jadwal.fromJson(data);
    return jadwalSholat;
  }

  @override
  Widget build(BuildContext context) {
    // Bagian progress indicator.
    progressIndicator = Container(
      padding: const EdgeInsets.all(100),
      child: const CircularProgressIndicator(
        backgroundColor: Colors.grey,
        color: Colors.blue,
        strokeWidth: 5,
      ),
    );

    // Bagian futurebuilder.
    akanDitampilkan = FutureBuilder<Jadwal>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Container(
              margin: const EdgeInsets.all(50),
              alignment: const Alignment(0.0, 0.0),
              child: const Text('Gagal load data...'));
        }
        return (snapshot.hasData)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: Text(
                      snapshot.data!.jadwal.data.tanggal,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: const Text("Subuh"),
                        leading: const Icon(Icons.alarm),
                        trailing: Text(snapshot.data!.jadwal.data.subuh)),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: const Text("Dzuhur"),
                        leading: const Icon(Icons.alarm),
                        trailing: Text(snapshot.data!.jadwal.data.dzuhur)),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: const Text("Ashar"),
                        leading: const Icon(Icons.alarm),
                        trailing: Text(snapshot.data!.jadwal.data.ashar)),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: const Text("Maghrib"),
                        leading: const Icon(Icons.alarm),
                        trailing: Text(snapshot.data!.jadwal.data.maghrib)),
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: const Text("Isya"),
                        leading: const Icon(Icons.alarm),
                        trailing: Text(snapshot.data!.jadwal.data.isya)),
                  ),
                ],
              )
            : progressIndicator!;
      },
    );

    // Bagian inisiasi tampilan waktu sholat.
    inisisasiTampilanWaktu = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(25),
          child: Text(
            datatanggal,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
              title: const Text("Subuh"),
              leading: const Icon(Icons.alarm),
              trailing: Text(datasubuh)),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
              title: const Text("Dzuhur"),
              leading: const Icon(Icons.alarm),
              trailing: Text(datadzuhur)),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
              title: const Text("Ashar"),
              leading: const Icon(Icons.alarm),
              trailing: Text(dataashar)),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
              title: const Text("Maghrib"),
              leading: const Icon(Icons.alarm),
              trailing: Text(datamaghrib)),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
              title: const Text("Isya"),
              leading: const Icon(Icons.alarm),
              trailing: Text(dataisya)),
        ),
      ],
    );

    // Bagian tampilan utama.
    return MaterialApp(
      title: 'Async Program',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Sholat'),
        ),
        body: ListView(children: [
          Container(
              margin: const EdgeInsets.all(25),
              alignment: const Alignment(0.0, 0.0),
              child: Column(
                children: const [
                  Text(
                    'Kota Malang',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              )),
          Center(
              child: (buttonKlik) ? akanDitampilkan : inisisasiTampilanWaktu),
        ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.get_app_outlined),
          onPressed: () {
            setState(() {
              buttonKlik = true;
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonKlik = false;
    datasubuh = '00:00';
    datadzuhur = '00:00';
    dataashar = '00:00';
    datamaghrib = '00:00';
    dataisya = '00:00';
    datatanggal = 'Hari, tanggal';
  }
}