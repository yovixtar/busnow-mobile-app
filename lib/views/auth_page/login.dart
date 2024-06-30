import 'package:Busnow/models/auth_models.dart';
import 'package:Busnow/services/api_auth.dart';
import 'package:Busnow/services/session.dart';
import 'package:Busnow/views/auth_page/signup.dart';
import 'package:Busnow/views/components/snackbar_utils.dart';
import 'package:Busnow/views/home_page/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _loginMessage = '';
  bool _loginStatus = true;
  bool isLoading = false;

  handleLogin() async {
    setState(() {
      isLoading = true;
    });
    final result = await APIAuthService().login(
        credential: _emailController.text, password: _passwordController.text);
    if (result.containsKey('success')) {
      if (await SessionManager.hasToken()) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        setState(() {
          _loginStatus = false;
        });
        SnackbarUtils.showErrorSnackbar(context, "Token gagal disimpan");
      }
    } else {
      setState(() {
        setState(() {
          _loginStatus = false;
        });
        _loginMessage = 'Email / Password atau password anda masukan salah.';
        SnackbarUtils.showErrorSnackbar(context, _loginMessage);
      });
    }

    setState(() {
      isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF75F6F6),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email / Username',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Masukan email / username anda',
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon masukan email / username anda';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Masukan password anda',
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon masukan password anda';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _showComingSoonDialog,
                            child: Text('Lupa Password?'),
                          ),
                        ),
                        (!_loginStatus)
                            ? Text(
                                "Email / Password atau password anda masukan salah.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : SizedBox(),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (isLoading) {
                                      null;
                                    } else {
                                      if (_formKey.currentState!.validate()) {
                                        handleLogin();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFD9D9D9),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 32),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoading
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        )
                                      : Text('Masuk'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text('atau masuk menggunakan'),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: _showComingSoonDialog,
                            icon: Image.asset(
                              'assets/icons/google.png',
                              width: 24,
                              height: 24,
                            ),
                            label: Text('Google'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9D9D9),
                              textStyle: TextStyle(
                                color: Colors.black,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Color(0xFFD9D9D9)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Belum punya akun? '),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Daftar',
                                style: TextStyle(color: Color(0xFF75F6F6)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
