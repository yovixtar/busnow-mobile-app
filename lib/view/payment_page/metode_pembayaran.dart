import 'package:flutter/material.dart';

void _showMaintenanceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Maintenance"),
        content: Text("Metode pembayaran sedang dimaintenance."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class PilihMetodePembayaranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF75F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Metode Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Pembayaran dengan Saldo Lebih Mudah dan Cepat",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, 'saldo');
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListTile(
                  title: Text('Via Saldo'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PembayaranViaBankPage(),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListTile(
                  title: Text('Via Bank'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PembayaranViaEWalletPage(),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListTile(
                  title: Text('Via E-Wallet'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PembayaranViaBankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF75F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Metode Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Pembayaran dengan Saldo Lebih Mudah dan Cepat",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Color(0xFFFC8F8F),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListTile(
                title: Text(
                  'Via Bank',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showMaintenanceDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/bca.png',
                    width: 40,
                  ),
                  title: Text('Bank BCA'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showMaintenanceDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/bni.png',
                    width: 40,
                  ),
                  title: Text('Bank BNI'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showMaintenanceDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/mandiri.png',
                    width: 40,
                  ),
                  title: Text('Bank Mandiri'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PembayaranViaEWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF75F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Metode Pembayaran',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Pembayaran dengan Saldo Lebih Mudah dan Cepat",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: Color(0xFFFC8F8F),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListTile(
                title: Text(
                  'Via E-Wallet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showMaintenanceDialog(context);
              },
              child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/dana.png',
                        width: 30,
                      ),
                      title: Text('Dana'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                _showMaintenanceDialog(context);
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/ovo.png',
                      width: 30,
                    ),
                    title: Text('Ovo'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
