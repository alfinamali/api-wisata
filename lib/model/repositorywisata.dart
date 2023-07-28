import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:SM1/model/listwisata.dart';

class RepositoryWisata {
  final baseUrl = 'https://wisata.surabayawebtech.com/api/wisata';

  Future<List<Destinasi>> getData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> data = json['data'];
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        List<Destinasi> destinasiList =
            dataList.map((item) => Destinasi.fromJson(item)).toList();
        return destinasiList;
      }
    } catch (e) {
      print(e.toString());
    }

    return []; // Return an empty list if an error occurs
  }

  String getImageUrl(String filename) {
    return Uri.parse('https://wisata.surabayawebtech.com/api/file/$filename')
        .toString(); // Include the base URL when constructing the image URL
  }
}
