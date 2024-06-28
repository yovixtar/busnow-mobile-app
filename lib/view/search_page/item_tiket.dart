import 'package:flutter/material.dart';

class BusItem extends StatelessWidget {
  final String agenBus;
  final String kelasBus;
  final String keberangkatan;
  final String kedatangan;
  final String harga;
  final VoidCallback onPesan;

  const BusItem({
    required this.agenBus,
    required this.kelasBus,
    required this.keberangkatan,
    required this.kedatangan,
    required this.harga,
    required this.onPesan,
    Key? key,
  }) : super(key: key);

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
                  keberangkatan,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  kedatangan,
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    harga,
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
