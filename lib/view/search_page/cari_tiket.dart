import 'package:Busnow/view/payment_page/detail_booking.dart';
import 'package:Busnow/view/search_page/cari_bus.dart';
import 'package:Busnow/view/search_page/item_tiket.dart';
import 'package:flutter/material.dart';

class CariTiketPage extends StatefulWidget {
  const CariTiketPage({Key? key}) : super(key: key);

  @override
  State<CariTiketPage> createState() => _CariTiketPageState();
}

class _CariTiketPageState extends State<CariTiketPage> {
  void _showChangeSearch() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ganti Pencarian'),
          content: Text('Ingin mengganti detail pencarian ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const CariBusPage(),
                  ),
                );
              },
              child: Text('Ganti Pencarian'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE7E7),
      appBar: AppBar(
        backgroundColor: Color(0xFF75F6F6),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Bus Partners',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF75F6F6),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _showChangeSearch,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Kota Asal ke Kota Tujuan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Divider(
                              thickness: 2,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Hari, 01 Bulan 2024',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '1 Kursi',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10, // Replace with actual item count
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      BusItem(
                        agenBus: 'Agen Bus $index',
                        kelasBus: 'Kelas Bus $index',
                        keberangkatan: '00 : 00',
                        kedatangan: '00 : 00',
                        harga: 'Rp 205.000 / Seat',
                        onPesan: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BookingDetailPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
