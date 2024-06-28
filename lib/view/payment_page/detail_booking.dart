import 'package:Busnow/view/home_page/home.dart';
import 'package:Busnow/view/payment_page/metode_pembayaran.dart';
import 'package:flutter/material.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({Key? key}) : super(key: key);

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  final TextEditingController _namaController =
      TextEditingController(text: 'Nama');
  final TextEditingController _keberangkatanController =
      TextEditingController(text: 'Kota ke Kota');
  final TextEditingController _kelasController =
      TextEditingController(text: 'Ekonomi');
  final TextEditingController _tanggalController =
      TextEditingController(text: 'Hari, 01 Bulan 2024');
  final TextEditingController _metodePembayaranController =
      TextEditingController(text: 'Rp 200.000');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF75F6F6),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Booking Detail',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: Color(0xFF75F6F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Color(0xFFF1CBCB),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      label: 'Nama Penumpang',
                      controller: _namaController,
                      editable: true,
                    ),
                    _buildInputField(
                      label: 'Keberangkatan',
                      controller: _keberangkatanController,
                      editable: false,
                    ),
                    _buildInputField(
                      label: 'Tipe / Kelas',
                      controller: _kelasController,
                      editable: false,
                      isSpecial: true,
                    ),
                    _buildInputField(
                      label: 'Tanggal Berangkat',
                      controller: _tanggalController,
                      editable: false,
                    ),
                    _buildPaymentMethodField(),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _showSuccessDialog(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFC8F8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                        ),
                        child: Text(
                          'Pesan Sekarang',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required bool editable,
    bool isSpecial = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          TextFormField(
            controller: controller,
            readOnly: !editable,
            decoration: InputDecoration(
              hintText: label,
              fillColor: isSpecial ? Colors.white : Colors.transparent,
              filled: true,
              border: isSpecial
                  ? OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    )
                  : UnderlineInputBorder(),
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Metode Pembayaran',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PilihMetodePembayaranPage(),
                    ),
                  );
                },
                child: Text(
                  'Pilih Pembayaran',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _metodePembayaranController,
            readOnly: true,
            decoration: InputDecoration(
              prefixText: 'Saldo  |  ',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 16),
              Text("Pembayaran Berhasil"),
            ],
          ),
          content: Text(
            "Pesanan Anda telah berhasil diproses.",
            textAlign: TextAlign.center,
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  void _showFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(
                Icons.remove_circle,
                color: Colors.redAccent,
                size: 100,
              ),
              SizedBox(height: 16),
              Text("Pembayaran Gagal"),
            ],
          ),
          content: Text(
            "Periksa kembali pesanan Anda.",
            textAlign: TextAlign.center,
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 4), () {
      // Navigator.of(context).pop();
      // Navigator.of(context).pop();
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }
}
