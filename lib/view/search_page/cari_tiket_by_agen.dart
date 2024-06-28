import 'package:Busnow/view/payment_page/detail_booking.dart';
import 'package:Busnow/view/search_page/cari_bus.dart';
import 'package:Busnow/view/search_page/item_tiket.dart';
import 'package:flutter/material.dart';
import 'bus_item.dart'; // Impor file BusItem

class CariTiketByAgenPage extends StatefulWidget {
  const CariTiketByAgenPage({Key? key}) : super(key: key);

  @override
  State<CariTiketByAgenPage> createState() => _CariTiketByAgenPageState();
}

class _CariTiketByAgenPageState extends State<CariTiketByAgenPage> {
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xFF75F6F6),
                    padding: EdgeInsets.all(16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                        child: Text(
                          'Agen Bus',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
