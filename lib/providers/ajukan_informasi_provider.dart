// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:retry/retry.dart';
// import 'package:pa3/models/ajukan_informasi.dart';

// class AjukanInformasiProvider with ChangeNotifier {
//   List<AjukanInformasi> _ajukanInformasiList = [];

//   List<AjukanInformasi> get ajukanInformasiList => _ajukanInformasiList;

//   Future<void> fetchAjukanInformasi() async {
//     final r = RetryOptions(maxAttempts: 5);

//     try {
//       final response = await r.retry(
//         () => http
//             .get(Uri.parse('http://192.168.25.158:8000/api/ajukanInformasi'))
//             .timeout(Duration(seconds: 5)),
//         retryIf: (e) =>
//             e is http.ClientException ||
//             e is TimeoutException ||
//             (e is http.Response && e.statusCode == 429),
//       );

//       if (response is http.Response && response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);
//         _ajukanInformasiList =
//             data.map((item) => AjukanInformasi.fromJson(item)).toList();
//         notifyListeners();
//       } else {
//         throw Exception('Failed to load AjukanInformasi: ${response}');
//       }
//     } catch (error) {
//       print('Error fetching data: $error');
//       throw error;
//     }
//   }

//   Future<void> addAjukanInformasi(AjukanInformasi ajukanInformasi) async {
//     final r = RetryOptions(maxAttempts: 5);

//     try {
//       final response = await r.retry(
//         () => http
//             .post(
//               Uri.parse('http://192.168.25.158:8000/api/ajukanInformasi'),
//               headers: {'Content-Type': 'application/json'},
//               body: json.encode(ajukanInformasi.toJson()),
//             )
//             .timeout(Duration(seconds: 5)),
//         retryIf: (e) =>
//             e is http.ClientException ||
//             e is TimeoutException ||
//             e is http.Response && e.statusCode == 429,
//       );

//       if (response.statusCode == 201) {
//         _ajukanInformasiList
//             .add(AjukanInformasi.fromJson(json.decode(response.body)));
//         notifyListeners();
//       } else {
//         throw Exception('Failed to add AjukanInformasi: ${response.body}');
//       }
//     } catch (error) {
//       print('Error adding data: $error');
//       throw error;
//     }
//   }

//   Future<void> updateAjukanInformasi(AjukanInformasi ajukanInformasi) async {
//     final r = RetryOptions(maxAttempts: 5);

//     try {
//       final response = await r.retry(
//         () => http
//             .put(
//               Uri.parse(
//                   'http://192.168.25.158:8000/api/ajukanInformasi/${ajukanInformasi.id}'),
//               headers: {'Content-Type': 'application/json'},
//               body: json.encode(ajukanInformasi.toJson()),
//             )
//             .timeout(Duration(seconds: 5)),
//         retryIf: (e) =>
//             e is http.ClientException ||
//             e is TimeoutException ||
//             e is http.Response && e.statusCode == 429,
//       );

//       if (response.statusCode == 200) {
//         int index = _ajukanInformasiList
//             .indexWhere((item) => item.id == ajukanInformasi.id);
//         if (index != -1) {
//           _ajukanInformasiList[index] =
//               AjukanInformasi.fromJson(json.decode(response.body));
//           notifyListeners();
//         }
//       } else {
//         throw Exception('Failed to update AjukanInformasi: ${response.body}');
//       }
//     } catch (error) {
//       print('Error updating data: $error');
//       throw error;
//     }
//   }

//   Future<void> deleteAjukanInformasi(int id) async {
//     final r = RetryOptions(maxAttempts: 5);

//     try {
//       final response = await r.retry(
//         () => http
//             .delete(
//                 Uri.parse('http://192.168.25.158:8000/api/ajukanInformasi/$id'))
//             .timeout(Duration(seconds: 5)),
//         retryIf: (e) =>
//             e is http.ClientException ||
//             e is TimeoutException ||
//             e is http.Response && e.statusCode == 429,
//       );

//       if (response.statusCode == 204) {
//         _ajukanInformasiList.removeWhere((item) => item.id == id);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to delete AjukanInformasi: ${response.body}');
//       }
//     } catch (error) {
//       print('Error deleting data: $error');
//       throw error;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:pa3/theme.dart';

class AjukanInformasiProvider with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      appBar: AppBar(
        backgroundColor: backgroundWhite,
        title: Text(
          'Profile',
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15),
      ),
    );
  }
}
