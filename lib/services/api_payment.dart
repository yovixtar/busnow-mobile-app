import 'dart:convert';

import 'package:Busnow/config.dart';
import 'package:Busnow/models/payment_models.dart';
import 'package:Busnow/services/session.dart';
import 'package:http/http.dart' as http;

class APIPaymentService {
  String baseUrl = Config.baseUrl;

  Future<Map<String, dynamic>> buyTiket({
    String? id_tiket,
    String? nama,
    String? kursi,
  }) async {
    var bearerToken = await SessionManager.getBearerToken();
    var response = await http.post(
      Uri.parse("$baseUrl/pesan-tiket"),
      headers: {'Authorization': 'Bearer $bearerToken'},
      body: {
        'id_tiket': id_tiket,
        'metode_pembayaran': 'Saldo',
        'nama': nama,
        'kursi': kursi,
      },
    );
    var responseData = jsonDecode(response.body);
    print(responseData);
    if (responseData['code'] == 201) {
      return responseData['data'];
    } else {
      return {'error': responseData['message']};
    }
  }

  Future<List<DaftarPesananModel>> getPesanan() async {
    var bearerToken = await SessionManager.getBearerToken();
    if (bearerToken != null) {
      var url = Uri.parse("$baseUrl/pesanan");

      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $bearerToken'},
      );

      var responseData = jsonDecode(response.body);
      if (responseData['code'] == 200) {
        var data = responseData['data'] as List;
        List<DaftarPesananModel> pesanans = data
            .map((pesanan) => DaftarPesananModel.fromJson(pesanan))
            .toList();
        return pesanans;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
