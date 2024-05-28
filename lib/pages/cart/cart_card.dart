// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';

// import '../../../constants.dart';

// class CartCard extends StatelessWidget {
//   const CartCard({
//     Key? key,
//     // required this.cart,
//     required this.onRemove,
//   }) : super(key: key);

//   // final Cart cart;
//   final VoidCallback onRemove;

//   @override
//   Widget build(BuildContext context) {
//     final price = NumberFormat("###,###,###").format(cart.product.price);
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 1),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 88,
//             child: AspectRatio(
//               aspectRatio: 0.88,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF5F6F9),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Image.asset(produk.images[0]),
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   cart.product.title,
//                   style: const TextStyle(color: Colors.black, fontSize: 16),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),
//                 Text.rich(
//                   TextSpan(
//                     text: "Rp $price",
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600, color: kPrimaryColor),
//                     children: [
//                       TextSpan(
//                         text: " x${cart.numOfItem}",
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               _showDeleteConfirmationDialog(context);
//             },
//             child: SvgPicture.asset(
//               "assets/icons/Trash.svg",
//               color: kPrimaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Konfirmasi"),
//           content: const Text(
//               "Apakah Anda yakin ingin menghapus item ini dari keranjang?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text("Batal"),
//             ),
//             TextButton(
//               onPressed: () {
//                 onRemove();
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text("Hapus"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
