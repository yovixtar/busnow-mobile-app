import 'package:Busnow/models/payment_models.dart';
import 'package:Busnow/services/api_payment.dart';
import 'package:Busnow/views/components/bottom_nav.dart';
import 'package:Busnow/views/notification_page/detail_notif.dart';
import 'package:Busnow/views/notification_page/item_notif.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNotificationPage extends StatefulWidget {
  const ListNotificationPage({Key? key}) : super(key: key);

  @override
  State<ListNotificationPage> createState() => _ListNotificationPageState();
}

class _ListNotificationPageState extends State<ListNotificationPage> {
  late Future<List<DaftarPesananModel>> _dataPesanan;

  @override
  void initState() {
    super.initState();
    _dataPesanan = fetchDaftarPesanan();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataPesanan = fetchDaftarPesanan();
    });
  }

  Future<List<DaftarPesananModel>> fetchDaftarPesanan() async {
    List<DaftarPesananModel> dataPesanan =
        await APIPaymentService().getPesanan();
    return dataPesanan;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEE7E7),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFF75F6F6),
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<List<DaftarPesananModel>?>(
                  future: _dataPesanan,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      return RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            DaftarPesananModel pesanan = snapshot.data![index];
                            return Column(
                              children: [
                                NotificationItem(
                                  id_pesanan: pesanan.id_pesanan!,
                                  nama: pesanan.nama!,
                                  keberangkatan:
                                      'Tiket ${pesanan.keberangkatan}',
                                  kelas: pesanan.kelas!,
                                  tanggal: pesanan.tanggal!,
                                  total: pesanan.total!,
                                  metode_pembayaran: pesanan.metode_pembayaran!,
                                  waktu_pesan: pesanan.waktu_pesan!,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(currentPage: 'notification'),
      ),
    );
  }
}
