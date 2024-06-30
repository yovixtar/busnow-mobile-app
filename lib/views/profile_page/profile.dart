import 'package:Busnow/services/session.dart';
import 'package:Busnow/views/auth_page/login.dart';
import 'package:flutter/material.dart';
import 'package:Busnow/views/components/bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _namaController =
      TextEditingController(text: 'Nama');
  final TextEditingController _usernameController =
      TextEditingController(text: 'Username');
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(text: 'Email');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await SessionManager.getData();
    if (userData != null) {
      setState(() {
        _namaController.text = userData['nama'] ?? 'Nama';
        _usernameController.text = userData['username'] ?? 'Username';
        _phoneNumberController.text = userData['phone'] ?? '';
        _emailController.text = userData['email'] ?? 'Email';
      });
    }
  }

  // void _showComingSoonDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Coming Soon'),
  //         content: Text('This feature is coming soon.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _logout() async {
    await SessionManager.clearToken();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // _showComingSoonDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF1CBCB),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFF75F6F6),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Akun Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _logout,
                            icon: Icon(Icons.logout, color: Colors.black),
                            label: Text('Logout',
                                style: TextStyle(color: Colors.black)),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFFC8F8F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person,
                                size: 60, color: Colors.grey),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                // _showComingSoonDialog(context);
                                null;
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  color: Color(0xFFF1CBCB),
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputField(
                          label: 'Nama',
                          hint: 'Masukkan Nama',
                          controller: _namaController,
                        ),
                        _buildInputField(
                          label: 'Username',
                          hint: 'Masukkan Username',
                          controller: _usernameController,
                        ),
                        _buildInputField(
                          label: 'Nomor Telepon',
                          hint: 'Masukkan Nomor Telepon',
                          controller: _phoneNumberController,
                          isNumber: true,
                        ),
                        _buildInputField(
                          label: 'Email',
                          hint: 'Masukkan Email',
                          controller: _emailController,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _updateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFC8F8F),
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Perbarui Profile',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(currentPage: 'profile'),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              labelText: hint,
              filled: true,
              fillColor: Colors.white,
              border: UnderlineInputBorder(),
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
}
