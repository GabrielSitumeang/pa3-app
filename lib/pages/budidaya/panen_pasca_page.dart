import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PanenPascaPage extends StatefulWidget {
  final String? namaTanaman;

  const PanenPascaPage({Key? key, this.namaTanaman}) : super(key: key);

  @override
  _PanenPascaPageState createState() => _PanenPascaPageState();
}

class _PanenPascaPageState extends State<PanenPascaPage> {
  late Future<List<dynamic>> _futurePanen;
  late Future<List<dynamic>> _futurePascapanen;

  @override
  void initState() {
    super.initState();
    _futurePanen = _fetchData('/panen');
    _futurePascapanen = _fetchData('/pascapanen');
  }

  Future<List<dynamic>> _fetchData(String endpoint) async {
    final String baseUrl =
        'http://192.168.164.211:8000/api$endpoint?nama_tanaman=${widget.namaTanaman}';
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
        title: Text(widget.namaTanaman ?? 'Panen & Pasca Panen'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Panen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _futurePanen,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                snapshot.data?[index]['gambar_tanaman'] != null
                                    ? 'http://192.168.164.211:8000/gambar_tanaman/${snapshot.data?[index]['gambar_tanaman']}'
                                    : 'https://via.placeholder.com/500x100.png?text=Placeholder+Image',
                                width: 500,
                                height: 100,
                              ),
                              ListTile(
                                title: Text(
                                  '${snapshot.data?[index]['keterangan']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Data Pascapanen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _futurePascapanen,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                snapshot.data?[index]['gambar_tanaman'] != null
                                    ? 'http://192.168.164.211:8000/gambar_tanaman/${snapshot.data?[index]['gambar_tanaman']}'
                                    : 'https://via.placeholder.com/500x100.png?text=Placeholder+Image',
                                width: 500,
                                height: 100,
                              ),
                              ListTile(
                                title: Text(
                                  '${snapshot.data?[index]['keterangan']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
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
        title: Text('${data['judul']}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'http://192.168.164.211:8000/gambar_tanaman/${data['gambar_tanaman'] ?? ''}',
              width: 500,
              height: 100,
            ),
            SizedBox(height: 10),
            Text('${data['isi'] ?? ''}'),
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
