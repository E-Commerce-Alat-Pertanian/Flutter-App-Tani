import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 102, 147, 244);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);

class AppConstants {
  static const namaApk = "Karim Fashion";
  static const logoApk = "assets/images/logo.png";

  static const secondary = Color(0xFFF2994A);
  static const primary = Color(0xFF002C55);
  static const danger = Color(0xFFFF4A4A);

  static const baseUrl = "http://192.168.19.45:5000";
  static const UrlImage = "http://localhost:5000";
  static const rekening = "7171717"; // TODO: rekening
  static String? token;
}

enum ServerStatus { normal, loading, error }
