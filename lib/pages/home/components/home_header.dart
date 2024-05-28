import 'package:app_tani_sejahtera/pages/home/components/icon_button.dart';
import 'package:app_tani_sejahtera/pages/home/components/search_field.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)
      onSearch; // Mengubah tipe fungsi untuk mengirim kata kunci

  const HomeHeader({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SearchField(
              controller: controller,
              hintText: "Search...",
              onSubmit: (value) => onSearch(
                  value), // Panggil onSearch dengan nilai dari field pencarian
            ),
          ),
          const SizedBox(width: 16),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, "/keranjang"),
            numOfitem: 3,
          ),
          const SizedBox(width: 8),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}
