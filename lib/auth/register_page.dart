import 'package:app_tani_sejahtera/auth/login_page.dart';
import 'package:app_tani_sejahtera/models/provinsi_model.dart';
import 'package:app_tani_sejahtera/widgets/dropdown.dart';
import 'package:app_tani_sejahtera/widgets/form_input.dart';
import 'package:app_tani_sejahtera/widgets/form_input_pass.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/kecamatan_model.dart';
import '../models/user_model.dart';
import '../view_models/daerah_view_model.dart';
import '../view_models/user_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _scrollController = ScrollController();

  String _idProvinsi = "";
  String _idKecamatan = "";
  bool _loading = false;
  String _error = "";

  List<ProvinsiModel> _listProvinsi = [];
  List<KecamatanModel> _listKecamatan = [];

  bool validate() {
    if (_usernameController.text.isEmpty) {
      setState(() => _error = "Username tidak boleh kosong");
      return false;
    }
    if (_emailController.text.isEmpty) {
      setState(() => _error = "Email tidak boleh kosong");
      return false;
    }
    if (_noHpController.text.isEmpty) {
      setState(() => _error = "No. HP tidak boleh kosong");
      return false;
    }
    if (_passwordController.text.isEmpty) {
      setState(() => _error = "Password tidak boleh kosong");
      return false;
    }
    if (_alamatController.text.isEmpty) {
      setState(() => _error = "Alamat tidak boleh kosong");
      return false;
    }
    if (_idKecamatan.isEmpty) {
      setState(() => _error = "Kecamatan tidak boleh kosong");
      return false;
    }
    if (_passwordController.text != _confirmpasswordController.text) {
      setState(() => _error = "Kedua password tidak sama");
      return false;
    }

    return true;
  }

  void submitSignup() {
    if (!validate()) {
      _scrollController.jumpTo(0);
      return;
    }
    setState(() {
      _loading = true;
      _error = "";
    });
    final user = UserModel(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      noHp: _noHpController.text,
      alamat: _alamatController.text.trim(),
      password: _passwordController.text,
      idKecamatan: _idKecamatan,
    );

    context.read<UserViewModel>().register(user).then((error) {
      setState(() {
        _loading = false;
        _error = error ?? "";
      });
      if (_error.isNotEmpty) {
        _scrollController.jumpTo(0);
        return;
      }
      Navigator.pop(context);
    }).catchError((e) {
      setState(() {
        _loading = false;
        _error = "Terjadi kesalahan. Silakan coba lagi.";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getProvinsi();
  }

  void getProvinsi() async {
    _listProvinsi = await context.read<DaerahViewModel>().getProvinsi();
    if (_listProvinsi.isNotEmpty) {
      _idProvinsi = _listProvinsi.first.id;
      getKecamatan();
    } else {
      setState(() {
        _error = "Gagal mengambil data provinsi";
      });
    }
  }

  void getKecamatan() async {
    _listKecamatan =
        await context.read<DaerahViewModel>().getKecamatan(_idProvinsi);
    if (_listKecamatan.isNotEmpty) {
      _idKecamatan = _listKecamatan.first.id;
    } else {
      setState(() {
        _error = "Gagal mengambil data kecamatan";
      });
    }
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _noHpController.dispose();
    _alamatController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'Selamat Datang di Tani Sejahtera',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Silahkan Masukkan Data Untuk Register',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 15),
                FormInput(
                  hintText: "Username",
                  controller: _usernameController,
                ),
                const SizedBox(height: 10),
                FormInput(
                  hintText: "Email",
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                FormInput(
                  hintText: "Nomor HP",
                  controller: _noHpController,
                ),
                const SizedBox(height: 10),
                FormInput(
                  hintText: "Masukkan alamat",
                  controller: _alamatController,
                  multiline: true,
                ),
                const SizedBox(height: 10),
                FormInputPass(
                  hintText: "Password",
                  controller: _passwordController,
                ),
                const SizedBox(height: 10),
                FormInputPass(
                  hintText: "Confirm Password",
                  controller: _confirmpasswordController,
                ),
                Dropdown(
                  value: _idProvinsi,
                  onChange: (value) {
                    setState(() {
                      _idProvinsi = value!;
                      _listKecamatan = [];
                      _idKecamatan = "";
                    });
                    getKecamatan();
                  },
                  label: "Provinsi",
                  item: _listProvinsi.map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.nama),
                    );
                  }).toList(),
                ),
                Dropdown(
                  value: _idKecamatan,
                  onChange: (value) => setState(() => _idKecamatan = value!),
                  label: "Kecamatan",
                  item: _listKecamatan.map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.nama),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: submitSignup,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 114, 206),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you have an account?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
