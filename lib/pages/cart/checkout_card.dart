// import 'package:app_tani_sejahtera/pages/checkout/checkout_page.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class CheckoutCard extends StatelessWidget {
//   final double totalPrice;

//   const CheckoutCard({
//     Key? key,
//     required this.totalPrice,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final formattedTotalPrice = NumberFormat("###,###,###").format(totalPrice);

//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: 16,
//         horizontal: 20,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, -15),
//             blurRadius: 20,
//             color: const Color(0xFFDADADA).withOpacity(0.15),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text.rich(
//                     TextSpan(
//                       text: "Total:\n",
//                       children: [
//                         TextSpan(
//                           text: "Rp. $formattedTotalPrice",
//                           style: const TextStyle(
//                               fontSize: 16, color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               CheckoutPage(totalPrice: totalPrice),
//                         ),
//                       );
//                     },
//                     child: const Text("Check Out"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
