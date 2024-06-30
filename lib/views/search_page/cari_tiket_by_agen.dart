import 'package:Busnow/models/tiket_models.dart';
import 'package:Busnow/services/api_tiket.dart';
import 'package:Busnow/views/payment_page/detail_booking.dart';
import 'package:Busnow/views/search_page/item_tiket.dart';
import 'package:flutter/material.dart';

class CariTiketByAgenPage extends StatefulWidget {
  const CariTiketByAgenPage(
      {Key? key, required this.id_bus, required this.nama})
      : super(key: key);

  final String? id_bus;
  final String? nama;

  @override
  State<CariTiketByAgenPage> createState() => _CariTiketByAgenPageState();
}

class _CariTiketByAgenPageState extends State<CariTiketByAgenPage> {
  late Future<List<DaftarTiketModel>?> _dataTiket;

  @override
  void initState() {
    super.initState();
    _dataTiket = fetchDaftarTiket();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataTiket = fetchDaftarTiket();
    });
  }

  Future<List<DaftarTiketModel>> fetchDaftarTiket() async {
    List<DaftarTiketModel> dataBus =
        await APITiketService().getTiketByBus(widget.id_bus);
    return dataBus;
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
                          widget.nama!,
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
              child: FutureBuilder<List<DaftarTiketModel>?>(
                future: _dataTiket,
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
                        itemCount: snapshot
                            .data!.length, // Replace with actual item count
                        itemBuilder: (BuildContext context, int index) {
                          DaftarTiketModel tiket = snapshot.data![index];
                          return Column(
                            children: [
                              BusItem(
                                agenBus: tiket.nama_bus!,
                                kelasBus: tiket.kelas!,
                                keberangkatan: tiket.jam_berangkat!,
                                kedatangan: tiket.jam_sampai!,
                                harga: tiket.tarif!,
                                tanggal: tiket.tanggal_berangkat!,
                                onPesan: () {
                                  print(tiket);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookingDetailPage(
                                        asal: tiket.asal!,
                                        tujuan: tiket.tujuan!,
                                        kelas: tiket.kelas!,
                                        tanggal: tiket.tanggal_berangkat!,
                                        tarif: tiket.tarif!,
                                      ),
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
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
