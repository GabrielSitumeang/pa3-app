// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:pa3/pages/pupuk/pupuk_page.dart';
// import 'dart:convert';
// import 'package:pa3/theme.dart';

// class PilihtanamanPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundWhite,
//       appBar: AppBar(
//         backgroundColor: backgroundWhite,
//         title: Text(
//           'Pupuk',
//           style: primaryTextStyle.copyWith(
//             fontSize: 20,
//             fontWeight: semiBold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: TanamanList(),
//     );
//   }
// }

// class TanamanList extends StatefulWidget {
//   @override
//   _TanamanListState createState() => _TanamanListState();
// }

// class _TanamanListState extends State<TanamanList> {
//   late Future<List<dynamic>> _futureTanaman;

//   @override
//   void initState() {
//     super.initState();
//     _futureTanaman = _fetchTanaman();
//   }

//   Future<List<dynamic>> _fetchTanaman() async {
//     final String baseUrl =
//         'http://10.0.2.2:8000/api/tanaman'; // Ubah URL sesuai dengan struktur rute API di Laravel
//     try {
//       final response = await http.get(Uri.parse(baseUrl));
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Gagal mengambil data: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Gagal mengambil data: ${e.toString()}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Lihat informasi relevan tentang pupuk',
//             style: subtitleTextStyle.copyWith(
//               fontSize: 18,
//             ),
//           ),
//           SizedBox(
//             height: 2,
//           ),
//           Text(
//             'Pilih Tanaman',
//             style: subtitleTextStyle,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           FutureBuilder<List<dynamic>>(
//             future: _futureTanaman,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Menampilkan indicator loading
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return Expanded(
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, // Atur jumlah kolom di sini
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 0.8, // Sesuaikan rasio gambar dan teks
//                     ),
//                     itemCount: snapshot.data?.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return TanamanItem(
//                         namaTanaman: snapshot.data?[index]['nama_tanaman'],
//                         gambarTanaman: snapshot.data?[index]['gambar_tanaman'],
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TanamanItem extends StatelessWidget {
//   final String? namaTanaman;
//   final String? gambarTanaman;

//   const TanamanItem({Key? key, this.namaTanaman, this.gambarTanaman})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PupukPage(namaTanaman: namaTanaman),
//           ),
//         );
//       },
//       child: CircleAvatar(
//         radius: 50,
//         backgroundColor: Colors.blue,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(
//               'http://10.0.2.2:8000/gambar_tanaman/$gambarTanaman',
//               width: 50,
//               height: 50,
//             ),
//             Text(
//               namaTanaman ?? '',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pa3/pages/pupuk/pupuk_page.dart';
import 'package:pa3/theme.dart';

class PilihtanamanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        backgroundColor: backgroundWhite,
        title: Text(
          'Pupuk',
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
            color: Colors.black,
          ),
        ),
      ),
      body: TanamanList(),
    );
  }
}

class TanamanList extends StatefulWidget {
  @override
  _TanamanListState createState() => _TanamanListState();
}

class _TanamanListState extends State<TanamanList> {
  late Future<List<dynamic>> _futureTanaman;

  @override
  void initState() {
    super.initState();
    _futureTanaman = _fetchTanaman();
  }

  Future<List<dynamic>> _fetchTanaman() async {
    final String baseUrl =
        'http://192.168.25.158:8000/api/tanaman'; // Ubah URL sesuai dengan struktur rute API di Laravel
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil data: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lihat informasi relevan tentang pupuk',
            style: subtitleTextStyle.copyWith(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'Pilih Tanaman',
            style: subtitleTextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<List<dynamic>>(
            future: _futureTanaman,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Menampilkan indicator loading
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Atur jumlah kolom di sini
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8, // Sesuaikan rasio gambar dan teks
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TanamanItem(
                        namaTanaman: snapshot.data?[index]['nama_tanaman'],
                        gambarTanaman: snapshot.data?[index]['gambar_tanaman'],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class TanamanItem extends StatelessWidget {
  final String? namaTanaman;
  final String? gambarTanaman;

  const TanamanItem({Key? key, this.namaTanaman, this.gambarTanaman})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PupukPage(namaTanaman: namaTanaman),
          ),
        );
      },
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'http://192.168.25.158:8000/gambar_tanaman/$gambarTanaman',
              width: 50,
              height: 50,
            ),
            Text(
              namaTanaman ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
