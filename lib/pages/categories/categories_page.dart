// import 'package:app_tani_sejahtera/pages/details/detail_page.dart';
// import 'package:flutter/material.dart';
// import 'package:app_tani_sejahtera/components/product_card.dart';
// import 'package:app_tani_sejahtera/models/products.dart';

// class ProductsByCategoryPage extends StatelessWidget {
//   final String category;

//   const ProductsByCategoryPage({Key? key, required this.category})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<Product> filteredProducts = demoProducts
//         .where((product) => product.categories
//             .any((cat) => cat.toLowerCase() == category.toLowerCase()))
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(category),
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(16),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: filteredProducts.length,
//         itemBuilder: (context, index) {
//           return ProductCard(
//             produk: filteredProducts[index],
//             onPress: () {
//               Navigator.pushNamed(
//                 context,
//                 "/DetailProduk",
//                 arguments:
//                     ProductDetailsArguments(product: filteredProducts[index]),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
