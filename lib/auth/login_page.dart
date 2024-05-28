import 'package:app_tani_sejahtera/pages/init_page.dart';
import 'package:app_tani_sejahtera/widgets/form_input.dart';
import 'package:app_tani_sejahtera/widgets/form_input_pass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/user_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String _error = "";

  void submitLogin() {
    setState(() {
      _loading = true;
      _error = "";
    });
    final nama = _emailController.text.trim();
    final password = _passwordController.text;
    context.read<UserViewModel>().login(nama, password).then((error) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          _loading = false;
          _error = error;
        });
        if (_error.isEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InitPage()),
          );
        }
      }
    }).catchError((e) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          _loading = false;
          _error = "Terjadi kesalahan. Silakan coba lagi.";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, right: 10, left: 22),
                child: Text(
                  'Selamat Datang Kembali di Tani Sejahtera',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Silahkan Masukkan Data Untuk Login',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FormInput(
                hintText: "Email",
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              FormInputPass(
                hintText: "Password",
                controller: _passwordController,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: submitLogin,
                  // Panggil fungsi signIn saat tombol ditekan
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 114, 206),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/SignUp");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
