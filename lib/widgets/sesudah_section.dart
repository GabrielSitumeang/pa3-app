import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pa3/pages/budidaya_page.dart';

class SesudahSection extends StatefulWidget {
  final String namaTanaman;

  SesudahSection({required this.namaTanaman});

  @override
  _SesudahSectionState createState() => _SesudahSectionState();
}

class _SesudahSectionState extends State<SesudahSection> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchData(widget.namaTanaman);
  }

  Future<List<dynamic>> _fetchData(String namaTanaman) async {
    final String baseUrl =
        'http://192.168.164.211:8000/api/rotasitanaman'; // Update URL according to your API route
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl?nama_tanaman=$namaTanaman&jenis_informasi=Sesudah'));
      if (response.statusCode == 200) {
        // Parse the response body as a JSON array
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Display loading indicator
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            ); // Display error message if any
          } else {
            final List<dynamic> data = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
              children: [
                Padding(
                  padding: EdgeInsets.all(10), // Add padding to the Column
                  child: Column(
                    children: [
                      Text(
                        'Informasi Sesudah Rotasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Render data if available
                      if (data.isNotEmpty)
                        ...data.map((item) {
                          if (item is Map<String, dynamic>) {
                            // Check if all required properties exist
                            if (item.containsKey('judul') &&
                                item.containsKey('gambar_tanaman') &&
                                item.containsKey('isi') &&
                                item.containsKey('keterangan')) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['judul'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Image.network(
                                    'http://192.168.164.211:8000/${item['gambar_tanaman']}',
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    item['isi'] ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                ],
                              );
                            }
                          }
                          return SizedBox(); // Return empty container if data is not valid
                        }).toList(),
                    ],
                  ),
                ),
                // Render button to navigate back to BudidayaPage
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BudidayaPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Button color
                      ),
                      child: Text(
                        'Kembali ke Budidaya Tanaman',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
