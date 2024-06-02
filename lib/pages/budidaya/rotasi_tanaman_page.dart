import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pa3/widgets/sebelum_section.dart';
import 'package:pa3/widgets/sesudah_section.dart';

class RotasiTanamanPage extends StatefulWidget {
  final String namaTanaman;

  RotasiTanamanPage({required this.namaTanaman});

  @override
  State<RotasiTanamanPage> createState() => _RotasiTanamanPageState();
}

class _RotasiTanamanPageState extends State<RotasiTanamanPage> {
  bool isSebelumSection = true;

  Future<Map<String, dynamic>> _fetchData(String namaTanaman) async {
    final String baseUrl = 'http://192.168.164.211:8000/api/rotasitanaman';
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl?nama_tanaman=$namaTanaman&jenis_informasi=Sebelum'));
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
        title: Text('Rotasi Tanaman'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF5F3FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  color: isSebelumSection
                      ? Color.fromARGB(255, 19, 19, 19)
                      : Color(0xFF674AEF).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSebelumSection = true;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                      child: Text(
                        "Sebelum",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: isSebelumSection
                      ? Color(0xFF674AEF).withOpacity(0.6)
                      : Color.fromARGB(255, 14, 14, 15),
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSebelumSection = false;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                      child: Text(
                        "Sesudah",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: isSebelumSection
                  ? SebelumSection(namaTanaman: widget.namaTanaman)
                  : SesudahSection(namaTanaman: widget.namaTanaman),
            ),
          ],
        ),
      ),
    );
  }
}
