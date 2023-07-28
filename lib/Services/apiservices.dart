import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://wisata.surabayawebtech.com/api';

  Future<String> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );

    if (response.statusCode == 201) {
      return 'Registration successful';
    } else {
      throw json.decode(response.body)['error'];
    }
  }

  Future<String> login(
      BuildContext context, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', json.decode(response.body)['token']);

      Navigator.pushReplacementNamed(context,
          '/home'); // Replace the current route with the homepage route

      return 'Login successful';
    } else {
      print('Response Body: ${response.body}');
      print('Status Code: ${response.statusCode}');
      throw json.decode(response.body)['error'];
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<Map<String, dynamic>> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['user'];
    } else {
      throw json.decode(response.body)['error'];
    }
  }
}
