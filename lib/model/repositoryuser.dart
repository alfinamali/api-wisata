import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:SM1/model/user.dart';

class RepositoryUser {
  final baseUrl = 'https://wisata.surabayawebtech.com/api/auth';

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'), // Ganti dengan endpoint login Anda
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['access_token'];
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }

  Future<User?> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile'), // Ganti dengan endpoint profil Anda
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return User.fromJson(jsonData);
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}
