import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pa3/constant.dart';
import 'package:pa3/models/api_response.dart';
import 'package:pa3/models/ajukan_informasi.dart';

Future<ApiResponse> createAjukan(
    String namaTanaman, String judul, String isi, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(ajukanURL),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'namaTanaman': namaTanaman,
          'judul': judul,
          'isi': isi,
          if (image != null) 'image': image,
        }));

    // Di sini jika image null, kita hanya mengirim namaTanaman, judul, dan isi, jika tidak kita kirim juga image.

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> editAjukan(
    int id, String namaTanaman, String judul, String isi, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.put(Uri.parse('$ajukanURL/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'namaTanaman': namaTanaman,
          'judul': judul,
          'isi': isi,
          if (image != null) 'image': image,
        }));

    // Di sini jika image null, kita hanya mengirim namaTanaman, judul, dan isi, jika tidak kita kirim juga image.

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        print(response.body);
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
