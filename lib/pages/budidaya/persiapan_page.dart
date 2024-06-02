import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersiapanPage extends StatefulWidget {
  final String? namaTanaman;

  const PersiapanPage({Key? key, this.namaTanaman}) : super(key: key);

  @override
  _PersiapanPageState createState() => _PersiapanPageState();
}

class _PersiapanPageState extends State<PersiapanPage> {
  late Future<List<dynamic>> _futurePersiapan;

  @override
  void initState() {
    super.initState();
    _futurePersiapan = _fetchPersiapan();
  }

  Future<List<dynamic>> _fetchPersiapan() async {
    final String baseUrl =
        'http://192.168.164.211:8000/api/persiapan?nama_tanaman=${widget.namaTanaman}';
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
            'Persiapan Lahan'), // Menggunakan widget.namaTanaman sebagai judul AppBar
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<dynamic>>(
          future: _futurePersiapan,
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
                              snapshot.data?[index]['gambar_tanaman'] != null
                                  ? 'http://192.168.164.211:8000/gambar_tanaman/${snapshot.data?[index]['gambar_tanaman']}'
                                  : 'https://via.placeholder.com/500x100.png?text=Placeholder+Image',
                              width: 550,
                              height: 150,
                            ),
                            ListTile(
                              title: Text(
                                '${snapshot.data?[index]['keterangan']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      data: snapshot.data?[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullDetailPupukPage(
                                          data: snapshot.data?[index]),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue, // Text color
                                ),
                                child: Text('Baca Selengkapnya'),
                              ),
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
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final dynamic data;

  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data['keterangan']}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2, // Menentukan jumlah kolom
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        '${data['keterangan']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Image.network(
                      data['gambar_tanaman'] != null
                          ? 'http://192.168.164.211:8000/gambar_tanaman/${data['gambar_tanaman']}'
                          : 'https://via.placeholder.com/500x100.png?text=Placeholder+Image',
                      width: 500,
                      height: 100,
                    ),
                    ListTile(
                      title: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullDetailPupukPage(data: data),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Text color
                        ),
                        child: Text('Baca Selengkapnya'),
                      ),
                    ),
                  ],
                ),
              ),
              // Tambahkan card kedua di sini jika diperlukan
            ],
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
          style: TextStyle(fontSize: 14),
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
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                    ),
                    child: Text('Kembali ke Budidaya Tanaman'),
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
