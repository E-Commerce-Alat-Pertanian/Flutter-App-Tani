import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 102, 147, 244);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);

class AppConstants {
  static const namaApk = "Karim Fashion";
  static const logoApk = "assets/images/logo.png";

  static const secondary = Color.fromARGB(255, 104, 188, 247);
  static const primary = Color(0xFF002C55);
  static const danger = Color.fromARGB(255, 72, 191, 255);

  static const baseUrl = "http://192.168.116.45:5000";
  static const rekening = "BSI: 7171717"; // TODO: rekening
  static String? token;
}

enum ServerStatus { normal, loading, error }
