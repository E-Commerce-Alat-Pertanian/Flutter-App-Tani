import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

import '../models/produk_model.dart';

class ProductCard extends StatelessWidget {
  final ProdukModel model;
  const ProductCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###,000");
    final harga = formatter.format(model.price);
    return SizedBox(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          "/DetailProduk",
          arguments: model,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(model.gambar, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  model.nama,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rp $harga",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    // InkWell(
                    //   borderRadius: BorderRadius.circular(50),
                    //   onTap: () {
                    //     setState(() {
                    //       isFavourite = !isFavourite;
                    //     });
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.all(6),
                    //     height: 24,
                    //     width: 24,
                    //     decoration: BoxDecoration(
                    //       color: isFavourite
                    //           ? kPrimaryColor.withOpacity(0.15)
                    //           : kSecondaryColor.withOpacity(0.1),
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: SvgPicture.asset(
                    //       "assets/icons/Heart Icon_2.svg",
                    //       color: isFavourite
                    //           ? const Color(0xFFFF4848)
                    //           : const Color(0xFFDBDEE4),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
