import 'dart:convert';

import 'package:Busnow/config.dart';
import 'package:Busnow/models/tiket_models.dart';
import 'package:Busnow/services/session.dart';
import 'package:http/http.dart' as http;

class APITiketService {
  String baseUrl = Config.baseUrl;

  Future<List<DaftarTiketModel>> getTiketByBus(id_bus) async {
    var bearerToken = await SessionManager.getBearerToken();
    if (bearerToken != null) {
      var response = await http.get(
        Uri.parse("$baseUrl/tiket-by-bus/${id_bus}"),
        headers: {'Authorization': 'Bearer $bearerToken'},
      );
      var responseData = jsonDecode(response.body);
      if (responseData['code'] == 200) {
        var data = responseData['data'] as List;
        List<DaftarTiketModel> tikets =
            data.map((tiket) => DaftarTiketModel.fromJson(tiket)).toList();
        return tikets;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<List<DaftarTiketModel>> getTiketByFilter({
    required String asal,
    required String tujuan,
    required String tanggalBerangkat,
    required String kursi,
  }) async {
    var bearerToken = await SessionManager.getBearerToken();
    if (bearerToken != null) {
      var url = Uri.parse("$baseUrl/tiket-by-filter");
      var queryParams = {
        'asal': asal,
        'tujuan': tujuan,
        'tanggal_berangkat': tanggalBerangkat,
        'kursi': kursi,
      };
      url = Uri.https(url.authority, url.path, queryParams);

      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $bearerToken'},
      );

      var responseData = jsonDecode(response.body);
      if (responseData['code'] == 200) {
        var data = responseData['data'] as List;
        List<DaftarTiketModel> tikets =
            data.map((tiket) => DaftarTiketModel.fromJson(tiket)).toList();
        return tikets;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
