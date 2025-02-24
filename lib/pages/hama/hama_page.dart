import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pa3/theme.dart';

class HamaPage extends StatefulWidget {
  final String? namaTanaman;

  const HamaPage({Key? key, this.namaTanaman}) : super(key: key);

  @override
  _HamaPageState createState() => _HamaPageState();
}

class _HamaPageState extends State<HamaPage> {
  late Future<List<dynamic>> _futurePupuk;

  @override
  void initState() {
    super.initState();
    _futurePupuk = _fetchPupuk();
  }

  Future<List<dynamic>> _fetchPupuk() async {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lihat informasi relevan tentang Hama',
              style: subtitleTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Penyakit berdasarkan Tahapan',
              style: subtitleTextStyle.copyWith(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Semua hama dan penyakit yang mungkin muncul ',
              style: subtitleTextStyle,
            ),
            Text(
              'di tanaman anda pada tahap yang berbeda. ',
              style: subtitleTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<dynamic>>(
              future: _futurePupuk,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Card(
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  'http://192.168.164.211:8000/gambar_tanaman/${snapshot.data?[index]['gambar_tanaman']}',
                                  width: 550,
                                  height: 150,
                                ),
                                ListTile(
                                  title: Text(
                                    '${snapshot.data?[index]['tahapanPupuk']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPupukPage(
                                          data: snapshot.data?[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPupukPage extends StatelessWidget {
  final dynamic data;

  const DetailPupukPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data['tahapanPupuk']}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 400, // Lebar card
          height: 320,
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    '${data['keterangan']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Image.network(
                  'http://192.168.164.211:8000/gambar_tanaman/${data['gambar_tanaman']}',
                  width: 500,
                  height: 100,
                ),
                ListTile(
                  title: Text('${data['judul']}'),
                ),
                ListTile(
                  title: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullDetailPupukPage(data: data),
                        ),
                      );
                    },
                    child: Text(
                      'Baca lebih lanjut',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
