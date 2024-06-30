import 'dart:convert';

import 'package:Busnow/config.dart';
import 'package:Busnow/services/session.dart';
import 'package:http/http.dart' as http;

class APIUserService {
  String baseUrl = Config.baseUrl;

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

  Future<Map<String, dynamic>> getSaldo() async {
    var bearerToken = await SessionManager.getBearerToken();
    if (bearerToken != null) {
      var response = await http.get(
        Uri.parse("$baseUrl/saldo"),
        headers: {'Authorization': 'Bearer $bearerToken'},
      );
      var responseData = jsonDecode(response.body);
      if (responseData['code'] == 200) {
        var data = responseData['data'];
        return {
          'saldo': "${data}",
          'success': "${responseData['message']}",
        };
      } else {
        return {
          'saldo': "0 !",
          'error': "Terjadi kendala, mohon tunggu sebentar lagi !",
        };
      }
    } else {
      return {
        'saldo': "0 !!",
        'error': "Terjadi kendala, mohon tunggu sebentar lagi !",
      };
    }
  }

  Future<Map<String, dynamic>> addSaldo(String? saldo) async {
    var bearerToken = await SessionManager.getBearerToken();
    if (bearerToken != null) {
      var response = await http.post(Uri.parse("$baseUrl/saldo"), headers: {
        'Authorization': 'Bearer $bearerToken'
      }, body: {
        'saldo': saldo,
      });
      var responseData = jsonDecode(response.body);
      if (responseData['code'] == 201) {
        var data = responseData['data'];
        return {
          'saldo': "${data}",
          'success': "${responseData['message']}",
        };
      } else {
        return {
          'saldo': "0 !",
          'error': "Terjadi kendala, mohon tunggu sebentar lagi !",
        };
      }
    } else {
      return {
        'saldo': "0 !!",
        'error': "Terjadi kendala, mohon tunggu sebentar lagi !",
      };
    }
  }
}
