import 'package:Busnow/models/tiket_models.dart';
import 'package:Busnow/services/api_tiket.dart';
import 'package:Busnow/views/payment_page/detail_booking.dart';
import 'package:Busnow/views/search_page/cari_bus.dart';
import 'package:Busnow/views/search_page/item_tiket.dart';
import 'package:flutter/material.dart';

class CariTiketPage extends StatefulWidget {
  const CariTiketPage({
    Key? key,
    required this.asal,
    required this.tujuan,
    required this.tanggalBerangkat,
    required this.formatedDate,
    required this.kursi,
  }) : super(key: key);

  final String asal;
  final String tujuan;
  final String tanggalBerangkat;
  final String formatedDate;
  final String kursi;
  @override
  State<CariTiketPage> createState() => _CariTiketPageState();
}

class _CariTiketPageState extends State<CariTiketPage> {
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
    List<DaftarTiketModel> dataBus = await APITiketService().getTiketByFilter(
      asal: widget.asal,
      tujuan: widget.tujuan,
      tanggalBerangkat: widget.tanggalBerangkat,
      kursi: widget.kursi,
    );
    return dataBus;
  }

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
                    builder: (context) => CariBusPage(
                      asal: widget.asal,
                      tujuan: widget.tujuan,
                      formatedDate: widget.formatedDate,
                      kursi: widget.kursi,
                      tanggalBerangkat: widget.tanggalBerangkat,
                    ),
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
                              '${widget.asal} ke ${widget.tujuan}',
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
                                    widget.formatedDate,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.kursi} Kursi',
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
                              TiketItem(
                                agenBus: tiket.nama_bus!,
                                kelasBus: tiket.kelas!,
                                keberangkatan: tiket.jam_berangkat!,
                                kedatangan: tiket.jam_sampai!,
                                harga: tiket.tarif!,
                                tanggal: tiket.tanggal_berangkat!,
                                onPesan: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BookingDetailPage(
                                        id_tiket: tiket.id_tiket!,
                                        asal: tiket.asal!,
                                        tujuan: tiket.tujuan!,
                                        kelas: tiket.kelas!,
                                        tanggal: tiket.tanggal_berangkat!,
                                        tarif: tiket.tarif!,
                                        kursi: widget.kursi,
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
