import 'package:Busnow/models/bus_models.dart';
import 'package:Busnow/services/api_bus.dart';
import 'package:Busnow/services/api_user.dart';
import 'package:Busnow/views/components/bottom_nav.dart';
import 'package:Busnow/views/components/snackbar_utils.dart';
import 'package:Busnow/views/search_page/cari_bus.dart';
import 'package:Busnow/views/search_page/cari_tiket_by_agen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  late Future<Map<String, dynamic>> _dataSaldo;
  late Future<List<DaftarBusModel>> _dataBus;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _dataSaldo = fetchSaldo();
    _dataBus = fetchDaftarBus();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataBus = fetchDaftarBus();
    });
  }

  Future<Map<String, dynamic>> fetchSaldo() async {
    Map<String, dynamic> dataSaldo = await APIUserService().getSaldo();
    return dataSaldo;
  }

  Future<List<DaftarBusModel>> fetchDaftarBus() async {
    List<DaftarBusModel> dataBus = await APIBusService().getAllBus();
    return dataBus;
  }

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Coming Soon'),
          content: Text('This feature is coming soon.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showBalanceInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Isi Saldo'),
          content: TextField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukkan jumlah saldo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                      });
                      final result = await APIUserService()
                          .addSaldo(_balanceController.text);
                      if (result.containsKey('success')) {
                        Navigator.of(context).pop();
                        setState(() {
                          _dataSaldo = APIUserService().getSaldo();
                        });
                      } else {
                        setState(() {
                          SnackbarUtils.showErrorSnackbar(
                              context, result['error']);
                        });
                      }

                      setState(() {
                        isLoading = false;
                      });
                    },
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    )
                  : Text('Isi Saldo'),
            ),
          ],
        );
      },
    );
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Busnow',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Cari',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Handle search action
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CariBusPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 24),
                            ),
                            child: Icon(Icons.search, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFF75F6F6),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Saldo',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  ElevatedButton(
                                    onPressed: _showBalanceInputDialog,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFD9D9D9),
                                      shape: CircleBorder(),
                                    ),
                                    child: Icon(Icons.add, color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _dataSaldo = APIUserService().getSaldo();
                                  });
                                },
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: _dataSaldo,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Silahkan reload!'),
                                      );
                                    } else {
                                      var saldo = snapshot.data!['saldo'];
                                      var saldoFormatted =
                                          NumberFormat.decimalPattern()
                                              .format(double.parse(saldo));
                                      return Text(
                                        'Rp $saldoFormatted',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: _showComingSoonDialog,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Point',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '0', // Replace with actual point value
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<List<DaftarBusModel>?>(
                  future: _dataBus,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Mohon maaf, data yang anda minta sedang tidak tersedia !'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No data available'));
                    } else {
                      return RefreshIndicator(
                        onRefresh: _refreshData,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            DaftarBusModel bus = snapshot.data![index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Color(0xFFE5BFBF),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      bus.gambar!,
                                      height: 64,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/bus.png',
                                          height: 64,
                                        );
                                      },
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      bus.nama!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${bus.asal!} - ${bus.tujuan!}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Spacer(),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CariTiketByAgenPage(
                                                id_bus: bus.id_bus!,
                                                nama: bus.nama!,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFC8F8F),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        child: Text(
                                          'Pesan',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        bottomNavigationBar: BottomNav(
          currentPage: 'home',
        ),
      ),
    );
  }
}
