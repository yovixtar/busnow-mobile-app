import 'package:Busnow/components/bottom_nav.dart';
import 'package:Busnow/view/search_page/cari_tiket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CariBusPage extends StatefulWidget {
  const CariBusPage({Key? key}) : super(key: key);

  @override
  State<CariBusPage> createState() => _CariBusPageState();
}

class _CariBusPageState extends State<CariBusPage> {
  final TextEditingController _dariController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _kursiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  void _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      String formattedDate =
          DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(selectedDate);
      setState(() {
        _tanggalController.text = formattedDate;
      });
    }
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
                          'Booking Bus',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xFFEEE7E7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Color(0xFFFC8F8F),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputField(
                              label: 'Dari',
                              controller: _dariController,
                              hintText: 'Masukkan kota asal',
                            ),
                            _buildInputField(
                              label: 'Tujuan',
                              controller: _tujuanController,
                              hintText: 'Masukkan kota tujuan',
                            ),
                            _buildDateField(
                              label: 'Atur Tanggal',
                              controller: _tanggalController,
                              hintText: 'Pilih tanggal keberangkatan',
                              onTap: _selectDate,
                            ),
                            _buildInputField(
                              label: 'Jumlah Kursi',
                              controller: _kursiController,
                              hintText: 'Masukkan jumlah kursi',
                              keyboardType: TextInputType.number,
                              icon: Icons.event_seat,
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Handle search action
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CariTiketPage(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFE2AEAE),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 14, horizontal: 24),
                                      ),
                                      child: Text(
                                        'Cari Tiket Bus',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(currentPage: 'search'),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: UnderlineInputBorder(),
              prefixIcon: icon != null ? Icon(icon, color: Colors.black) : null,
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
            keyboardType: keyboardType,
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

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: UnderlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: TextStyle(color: Colors.black),
            readOnly: true,
            onTap: onTap,
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
}
