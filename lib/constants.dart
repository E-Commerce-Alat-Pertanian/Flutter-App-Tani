import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 102, 147, 244);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);

class AppConstants {
  static const namaApk = "UD";
  static const logoApk = "assets/images/logo.png";

  static const secondary = Color.fromARGB(255, 104, 188, 247);
  static const primary = Color.fromARGB(255, 21, 201, 48);
  static const danger = Color.fromARGB(255, 72, 191, 255);

  static const baseUrl = "http://192.168.46.45:5000";
  static const rekening = "BSI: 71737274"; // TODO: rekening1
  static String? token;
}

enum ServerStatus { normal, loading, error }
