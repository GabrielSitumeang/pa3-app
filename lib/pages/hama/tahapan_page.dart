// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class TahapanPage extends StatefulWidget {
//   final String? namaTanaman;
//   final dynamic data;

//   const TahapanPage({Key? key, this.namaTanaman, this.data}) : super(key: key);

//   @override
//   _TahapanPageState createState() => _TahapanPageState();
// }

// class _TahapanPageState extends State<TahapanPage> {
//   late Future<List<dynamic>> _futureTahapan;

//   @override
//   void initState() {
//     super.initState();
//     _futureTahapan = _fetchTahapan();
//   }

//   Future<List<dynamic>> _fetchTahapan() async {
//     final String baseUrl =
//         'https://cropsystem.cloud/api/hama?nama_tanaman=${widget.namaTanaman}';
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
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.namaTanaman ??
//             'Hama dan Penyakit'), // Menggunakan widget.namaTanaman sebagai judul AppBar
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: FutureBuilder<List<dynamic>>(
//           future: _futureTahapan,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//             //   return ListView.builder(
//             //     itemCount: snapshot.data!.length,
//             //     itemBuilder: (context, index) {
//             //       return Column(
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           SizedBox(height: 10),
//             //           Image.network(
//             //             'https://cropsystem.cloud/gambar_tanaman/${snapshot.data?[index]['gambar_tanaman']}',
//             //             width: 550,
//             //             height: 120,
//             //           ),
//             //           ListTile(
//             //             title: Text(
//             //               '${snapshot.data?[index]['keterangan']}',
//             //             ),
//             //           ),
//             //           ListTile(
//             //             title: Text(
//             //               '${snapshot.data?[index]['judul']}',
//             //               style: TextStyle(fontWeight: FontWeight.bold),
//             //             ),
//             //             onTap: () {
//             //               Navigator.push(
//             //                 context,
//             //                 MaterialPageRoute(
//             //                   builder: (context) => FullDetailPupukPage(
//             //                       data: snapshot.data?[index]),
//             //                 ),
//             //               );
//             //             },
//             //           ),
//             //         ],
//             //       );
//             //     },
//             //   );
//             // }
//             return ListView.builder(
//       padding: const EdgeInsets.all(8),
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text('${snapshot.data?[index]['keterangan']}',),
//           subtitle: Text('${snapshot.data?[index]['judul']}',),
//           leading: Image.network(
//             'https://cropsystem.cloud/gambar_tanaman/${data[index]['gambar_tanaman']}',
//             width: 40,
//             height: 40,
//           ),
//         );
//       },
//             );
//         )};
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TahapanPage extends StatefulWidget {
  final String? namaTanaman;
  final dynamic data;

  const TahapanPage({Key? key, this.namaTanaman, this.data}) : super(key: key);

  @override
  _TahapanPageState createState() => _TahapanPageState();
}

class _TahapanPageState extends State<TahapanPage> {
  late Future<List<dynamic>> _futureTahapan;

  @override
  void initState() {
    super.initState();
    _futureTahapan = _fetchTahapan();
  }

  Future<List<dynamic>> _fetchTahapan() async {
    final String baseUrl =
        'http://192.168.164.211:8000/api/hama?nama_tanaman=${widget.namaTanaman}';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaTanaman ??
            'Hama dan Penyakit'), // Menggunakan widget.namaTanaman sebagai judul AppBar
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<dynamic>>(
          future: _futureTahapan,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${snapshot.data?[index]['keterangan']}'),
                    subtitle: Text('${snapshot.data?[index]['judul']}'),
                    leading: Image.network(
                      'http://192.168.164.211:8000/gambar_tanaman/${snapshot.data?[index]['gambar_tanaman']}',
                      width: 40,
                      height: 40,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class FullDetailPupukPage extends StatelessWidget {
  final dynamic data;

  const FullDetailPupukPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${data['judul']}',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'http://192.168.164.211:8000/gambar_tanaman/${data['gambar_tanaman']}',
              width: 500,
              height: 100,
            ),
            SizedBox(height: 10),
            Text('${data['isi']}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement bagikan functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                    ),
                    child: Text('Bagikan'),
                  ),
                ),
                SizedBox(width: 10), // Spacer antara tombol
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to previous page
                      Navigator.pop(context);
                    },
                    child: Text('Mengerti'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
