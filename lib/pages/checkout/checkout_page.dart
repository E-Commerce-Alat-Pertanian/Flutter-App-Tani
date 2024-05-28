// checkout_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_tani_sejahtera/models/address.dart';
import 'package:app_tani_sejahtera/pages/address/address_page.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;
  final Address? selectedAddress;

  const CheckoutPage({
    Key? key,
    required this.totalPrice,
    this.selectedAddress,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Address? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final formattedTotalPrice =
        NumberFormat("###,###,###").format(widget.totalPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alamat Pengiriman",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedAddress?.name} - ${selectedAddress?.phone}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(selectedAddress?.address ?? ""),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      // // final newAddress = await Navigator.push<Address?>(
                      // //   context,
                      // //   MaterialPageRoute(
                      // //     builder: (context) =>
                      // //         // AddressWidget(selectedAddress: selectedAddress),
                      // //   ),
                      // );
                      // if (newAddress != null) {
                      //   setState(() {
                      //     selectedAddress = newAddress;
                      //   });
                      // }
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "Rp. $formattedTotalPrice",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Action for placing the order
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "BUAT PESANAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
