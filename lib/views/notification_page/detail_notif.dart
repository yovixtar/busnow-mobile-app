import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage({
    Key? key,
    required this.nama,
    required this.keberangkatan,
    required this.kelas,
    required this.tanggal,
    required this.metode_pembayaran,
    required this.total,
    required this.waktu_pesan,
  }) : super(key: key);

  final String nama;
  final String keberangkatan;
  final String kelas;
  final String tanggal;
  final String metode_pembayaran;
  final String total;
  final String waktu_pesan;

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _keberangkatanController =
      TextEditingController();
  final TextEditingController _kelasController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.nama;
    _keberangkatanController.text = widget.keberangkatan;
    _kelasController.text = widget.kelas;
    _tanggalController.text = formatTanggal(widget.tanggal);
    _totalController.text = formatRibuan(widget.total);
  }

  String formatTanggal(String tanggal) {
    DateTime date = DateTime.parse(tanggal);
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
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
          'E-Ticket',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                width: 150,
                height: 150,
              ),
              Card(
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
            ],
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
            controller: _totalController,
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
