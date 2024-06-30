import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusItem extends StatelessWidget {
  final String agenBus;
  final String kelasBus;
  final String keberangkatan;
  final String kedatangan;
  final String harga;
  final String tanggal;
  final VoidCallback onPesan;

  const BusItem({
    required this.agenBus,
    required this.kelasBus,
    required this.keberangkatan,
    required this.kedatangan,
    required this.harga,
    required this.tanggal,
    required this.onPesan,
    Key? key,
  }) : super(key: key);

  String formatTanggal(String tanggal) {
    DateTime date = DateTime.parse(tanggal);
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  String formatJam(String jam) {
    DateTime time = DateFormat('HH:mm:ss').parse(jam);
    return DateFormat('HH:mm').format(time);
  }

  String formatRibuan(String harga) {
    try {
      return NumberFormat.currency(
              locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
          .format(int.parse(harga.replaceAll('.', '')));
    } catch (e) {
      return harga;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Color(0xFFE5BFBF),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agenBus,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatTanggal(tanggal),
                ),
                Text(
                  kelasBus,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFD10303),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  formatJam(keberangkatan) + ' - ' + formatJam(kedatangan),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatRibuan(harga) + '/Seat',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: onPesan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFC8F8F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Pesan',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
