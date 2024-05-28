import 'dart:developer';

import 'package:app_tani_sejahtera/pages/init_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_page.dart';
import 'view_models/user_view_model.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _loading = true;
  String? get _token => context.watch<UserViewModel>().token;

  void getToken() async {
    setState(() => _loading = true);
    final viewModel = context.read<UserViewModel>();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("TOKEN");

    if (token != null) {
      viewModel.token = token;
      await viewModel.getProfile();
    }

    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    log(_token ?? "NO TOKEN");
    log(_loading.toString());
    if (_loading) return const Scaffold();
    if (_token == null) return const LoginPage();
    return const InitPage();
  }
}
