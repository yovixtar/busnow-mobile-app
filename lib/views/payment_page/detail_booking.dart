import 'package:Busnow/services/api_payment.dart';
import 'package:Busnow/views/components/snackbar_utils.dart';
import 'package:Busnow/views/home_page/home.dart';
import 'package:Busnow/views/notification_page/detail_notif.dart';
import 'package:Busnow/views/payment_page/metode_pembayaran.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDetailPage extends StatefulWidget {
  final String? id_tiket;
  final String? asal;
  final String? tujuan;
  final String? kelas;
  final String? tanggal;
  final String? tarif;
  final String? kursi;

  const BookingDetailPage({
    Key? key,
    required this.id_tiket,
    required this.asal,
    required this.tujuan,
    required this.kelas,
    required this.tanggal,
    required this.tarif,
    this.kursi = '',
  }) : super(key: key);

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _keberangkatanController =
      TextEditingController();
  final TextEditingController _kelasController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _tarifController = TextEditingController();
  final TextEditingController _kursiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

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

  handleBuyTiket() async {
    setState(() {
      isLoading = true;
    });
    final result = await APIPaymentService().buyTiket(
      nama: _namaController.text,
      id_tiket: widget.id_tiket,
      kursi: _kursiController.text,
    );
    if (result.containsKey('id_tiket')) {
      _showSuccessDialog(context, result);
    } else {
      _showFailedDialog(context, result['error']);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _keberangkatanController.text = "${widget.asal} - ${widget.tujuan}";
    _kelasController.text = widget.kelas!;
    _tanggalController.text = formatTanggal(widget.tanggal!);
    _tarifController.text = formatRibuan(widget.tarif!);
    _kursiController.text = widget.kursi!;
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
                    _buildInputField(
                      label: 'Jumlah Kursi',
                      controller: _kursiController,
                      editable: (_kursiController.text != '') ? false : true,
                      isNumber: true,
                    ),
                    _buildPaymentMethodField(),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isLoading) {
                            null;
                          } else {
                            if (_formKey.currentState!.validate()) {
                              handleBuyTiket();
                            }
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
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : Text(
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
    bool isNumber = false,
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
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Masukan ${label}',
              fillColor: isSpecial ? Colors.white : Colors.transparent,
              filled: true,
              border: isSpecial
                  ? OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    )
                  : UnderlineInputBorder(),
              hintStyle: TextStyle(color: Colors.black54),
              suffixIcon: isSpecial
                  ? Icon(Icons.arrow_right, color: Colors.grey)
                  : null,
            ),
            style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mohon masukan $label';
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
            controller: _tarifController,
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

  void _showSuccessDialog(BuildContext context, result) {
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
      Navigator.of(context).pop();
      // Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NotificationDetailPage(
            nama: result['nama'],
            keberangkatan: result['keberangkatan'],
            kelas: result['kelas'],
            tanggal: result['tanggal'],
            metode_pembayaran: result['metode_pembayaran'],
            total: result['total'],
            waktu_pesan: result['waktu_pesan'],
          ),
        ),
      );
    });
  }

  void _showFailedDialog(BuildContext context, error) {
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
            error,
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
