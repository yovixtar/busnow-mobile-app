import 'dart:convert';

import 'package:Busnow/config.dart';
import 'package:Busnow/models/bus_models.dart';
import 'package:Busnow/services/session.dart';
import 'package:http/http.dart' as http;

class APIBusService {
  String baseUrl = Config.baseUrl;

  Future<List<DaftarBusModel>> getAllBus() async {
    var bearerToken = await SessionManager.getBearerToken();
    if (bearerToken != null) {
      var response = await http.get(
        Uri.parse("$baseUrl/bus"),
        headers: {'Authorization': 'Bearer $bearerToken'},
      );
      var responseData = jsonDecode(response.body);
      if (responseData['code'] == 200) {
        var data = responseData['data'] as List;
        List<DaftarBusModel> buses =
            data.map((bus) => DaftarBusModel.fromJson(bus)).toList();
        return buses;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
