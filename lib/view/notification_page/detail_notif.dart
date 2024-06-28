import 'package:Busnow/view/home_page/home.dart';
import 'package:Busnow/view/payment_page/metode_pembayaran.dart';
import 'package:flutter/material.dart';

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage({Key? key}) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
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
                      editable: false,
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
          isSpecial
              ? SizedBox(
                  height: 5,
                )
              : SizedBox(),
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
          Text(
            'Metode Pembayaran',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
            controller: _metodePembayaranController,
            readOnly: true,
            decoration: InputDecoration(
              prefixText: 'Saldo  |  ',
              fillColor: Colors.transparent,
              filled: true,
              border: UnderlineInputBorder(),
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
