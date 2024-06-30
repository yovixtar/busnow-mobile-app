import 'dart:convert';

import 'package:Busnow/models/auth_models.dart';
import 'package:Busnow/services/session.dart';
import 'package:http/http.dart' as http;

class APIAuthService {
  String baseUrl = "https://busnow.iyabos.com/api";

  Future<Map<String, dynamic>> login({
    String? credential,
    String? password,
  }) async {
    var response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {
        'credential': credential,
        'password': password,
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 200) {
      var token = responseData['data']['token'];
      await SessionManager.saveToken(token);
      return {'success': "${responseData['message']}"};
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }

  Future<Map<String, dynamic>> signup({
    String? nama,
    String? username,
    String? email,
    String? password,
  }) async {
    var response = await http.post(
      Uri.parse("$baseUrl/signup"),
      body: {
        'nama': nama,
        'username': username,
        'email': email,
        'password': password,
      },
    );
    var responseData = jsonDecode(response.body);
    if (responseData['code'] == 201) {
      return {'success': "${responseData['message']}"};
    } else {
      return {'error': "Terjadi kendala, mohon tunggu sebentar lagi !"};
    }
  }
}
