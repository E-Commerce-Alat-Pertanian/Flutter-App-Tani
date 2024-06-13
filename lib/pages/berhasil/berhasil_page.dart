import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../view_models/order_view_model.dart';
import '../../view_models/user_view_model.dart';
import '../../widgets/my_button.dart';

class BerhasilPage extends StatefulWidget {
  const BerhasilPage({
    super.key,
  });

  @override
  _BerhasilPageState createState() => _BerhasilPageState();
}

class _BerhasilPageState extends State<BerhasilPage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(int idOrder) async {
    if (_image != null) {
      final success = await context
          .read<OrderViewModel>()
          .uploadImagePembayaran(_image!, idOrder);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image uploaded successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final total = args['total'] as int;
    final idOrder = args['idOrder'] as int;
    final expire = DateTime.now().add(const Duration(days: 1));
    final expireString = DateFormat("dd/MM/yyyy hh:mm").format(expire);
    final user = context.read<UserViewModel>().currentUser;
    final totalString = NumberFormat("###,###,###").format(total + user!.id!);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Menunggu pembayaran...",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          const Text("Silahkan bayar sebelum:",
                              style: TextStyle(color: Colors.white)),
                          Text(
                            expireString,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/bags.png', // Path to your image asset
                            height: 150,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Card(
                      color: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Rekening tujuan:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              AppConstants.rekening,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Card(
                      color: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jumlah bayar:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Stack(
                              children: [
                                const Positioned(
                                  right: 0,
                                  child: ColoredBox(
                                    color: Color(0xFFffc107),
                                    child: Text(
                                      "000",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Rp$totalString",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Upload Pembayaran:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 170,
                            width: 150,
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: _image != null
                                        ? DecorationImage(
                                            image: FileImage(_image!),
                                            fit: BoxFit.cover,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/profile.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Positioned(
                                  right: -10,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 46,
                                    width: 46,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: kSecondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: _pickImage,
                                      child: const Icon(Icons.camera_alt),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        text: "Kirim Bukti Pembayaran",
                        onPressed: () => _uploadImage(idOrder),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: MyButton(
                        text: "Kembali ke Home",
                        onPressed: () => Navigator.pushNamed(context, "/main"),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
