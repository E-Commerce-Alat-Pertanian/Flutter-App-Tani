// import 'package:app_tani_sejahtera/models/cart.dart';
// import 'package:app_tani_sejahtera/pages/cart/cart_card.dart';
// import 'package:app_tani_sejahtera/pages/cart/checkout_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CartPage extends StatefulWidget {
//   static String routeName = "/cart";

//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     double totalPrice = demoCarts.fold(
//         0, (sum, item) => sum + item.product.price * item.numOfItem);

//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             const Text(
//               "Your Cart",
//               style: TextStyle(color: Colors.black),
//             ),
//             Text(
//               "${demoCarts.length} items",
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: ListView.builder(
//           itemCount: demoCarts.length,
//           itemBuilder: (context, index) => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Dismissible(
//               key: Key(demoCarts[index].product.id.toString()),
//               direction: DismissDirection.endToStart,
//               onDismissed: (direction) {
//                 setState(() {
//                   demoCarts.removeAt(index);
//                 });
//               },
//               background: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFE6E6),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   children: [
//                     const Spacer(),
//                     SvgPicture.asset("assets/icons/Trash.svg"),
//                   ],
//                 ),
//               ),
//               child: CartCard(
//                 cart: demoCarts[index],
//                 onRemove: () {
//                   setState(() {
//                     demoCarts.removeAt(index);
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: CheckoutCard(totalPrice: totalPrice),
//     );
//   }
// }
