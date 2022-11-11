# Contoh Asynchronous Programming Flutter (FutureBuilder dengan Aksi Button Tap)
Program yang menampilkan waktu sholat wajib untuk mendemonstrasikan asynchronous programming dengan widget futurebuilder pada framework flutter. Program dalam contoh ini terdiri dari dua file yaitu main.dart merupakan program utama dan PODO (plain old dart object) yang tersimpan dalam file jadwal.dart untuk konversi data dari JSON menjadi objek. Agar mudah dipahami maka program utama (main.dart) dibagi menjadi beberapa bagian widget dan method.
## Method
Program memiliki satu method yaitu fetchData() yang bekerja secara asynchronous dan mengembalikan data berupa objek Jadwal. Fungsi dari method ini adalah untuk request data JSON waktu sholat ke server melalui jaringan internet dengan url endpoint.
## Widget
Tampilan dari program disusun oleh beberapa widget yang terdapat di dalam class turunan dari statefull widget. Masing-masing widget tersebut adalah:
-	widget progressIndicator yang menampilkan animasi progress indicator selama proses request data dan menunggu respon dari server.
-	widget akanDitampilkan yang merupakan widget FutureBuilder dimana properti future berisi pemanggilan method fetchData() yang mengembalikan data bertipe objek Jadwal. Sedangkan untuk properti builder ada pemeriksaan kondisi jika terjadi error maka akan ditampilkan widget Text yang menampilkan string ‘Gagal load data …’. Jika tidak terjadi error maka akan dikembalikan lima widget card yang terbungkus dalam widget column yang menampilkan tanggal hari ini dan waktu sholat apabila terdapat data. Jika data belum ada maka ditampilkan progress indicator yang terbungkus dalam widget container.
-	widget inisiasiTampilanWaktu berupa lima card yang terbungkus dalam column yang menginisiasi tampilan waktu sholat dengan “00:00” dan tanggal dengan “Hari, tanggal” ketika program baru dijalankan dan tombol floating action button belum di-tap. Widget Text dalam masing-masing card berisi waktu dari variabel yang diinasiasi dari method initState() dan diberi nilai “00:00”. Demikian juga untuk tanggal diberi nilai “Hari, tanggal”.
-	widget floatingActionButton apabila di-tap/klik akan memicu penggunaan widget akanDitampilkan (FutureBuilder) dalam properti body widget scaffold dengan mengubah nilai buttonKlik menjadi true yang sebelumnya false yang diinisiasi dalam method initState(). Jadi dalam properti body terdapat pemeriksaan kondisi apakah buttonKlik bernilai benar? jika ya, maka widget akanDitampilkan (futurebuilder) yang digunakan dan  widget inisiasiTampilanWaktu yang digunakan jika sebaliknya.
Adapun tampilan dari program ini adalah sebagai berikut:
<br><br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Aksi-Tombol/blob/master/dokumentasi/Gambar%2001%20waktu%20sholat.png" width="250"/><br>
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Aksi-Tombol/blob/master/dokumentasi/Gambar%2002%20waktu%20sholat.png" width="250"/><br>
<br><img src="https://github.com/uqifumi/Contoh-Async-Programming-FutureBuilder-Aksi-Tombol/blob/master/dokumentasi/Gambar%2003%20waktu%20sholat.png" width="250"/><br>
## Paket yang Digunakan
- http: ^0.13.5 (https://pub.dev/packages/http)
- intl: ^0.17.0 (https://pub.dev/packages/intl)
## Referensi
Dokumentasi JSON API dan URL endpoint yang digunakan di program dapat diakses di: https://fathimah.docs.apiary.io/#reference/sholat.
