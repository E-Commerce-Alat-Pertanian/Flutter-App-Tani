import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../view_models/user_view_model.dart';
import '../../widgets/my_button.dart';

class BerhasilPage extends StatelessWidget {
  const BerhasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final total = ModalRoute.of(context)!.settings.arguments as int;

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
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Icon(Icons.history_rounded,
                              size: 60, color: Colors.white),
                          const Text(
                            "Menunggu pembayaran...",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
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

                    // Rekening Tujuan Section
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
                    const SizedBox(height: 30),

                    // Jumlah Bayar Section
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
                    const SizedBox(height: 50),

                    Center(
                      child: MyButton(
                        onPressed: () => Navigator.pop(context),
                        margin: const EdgeInsets.only(top: 20),
                        color: AppConstants.primary,
                        text: "Kembali",
                      ),
                    ),
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
