import 'dart:convert';
import 'dart:developer';
import 'package:hoxton/register_form/util/api_urls.dart';
import 'package:http/http.dart' as http;

class DataSource {
  DataSource._internal();
  static final DataSource _instance = DataSource._internal();
  static DataSource get instance => _instance;

  Future<void> init() async {}

  Future<String> registerUser(Map<String, dynamic> userData) async {
    const String url = ApiUrl.registerForm;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        // Handle success
        log('User registered successfully: ${response.body}');
        return "success";
      } else if (response.statusCode == 403) {
        // Handle error
        log('Failed to register user: ${response.statusCode}');
        return "This account already exist";
      }
      throw Exception("Failed to register user: ${response.statusCode}");
    } catch (e) {
      // Handle exception
      log('Error occurred while registering user: $e');
     throw Exception(e.toString());
    }
  }
}
