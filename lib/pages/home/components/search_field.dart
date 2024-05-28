import 'package:flutter/material.dart';
import 'package:app_tani_sejahtera/constants.dart';

const searchOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: kPrimaryColor),
);

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry margin;
  final Function(String)?
      onSubmit; // Ubah tipe fungsi untuk menerima satu argumen string

  const SearchField({
    Key? key,
    this.keyboardType,
    this.onSubmit,
    required this.hintText,
    required this.controller,
    this.margin = const EdgeInsets.symmetric(vertical: 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14),
        cursorColor: AppConstants.primary,
        onFieldSubmitted: onSubmit != null
            ? (value) => onSubmit!(value)
            : null, // Perbarui implementasi onSubmit di dalam build
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        ),
      ),
    );
  }

  InputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(999),
    );
  }
}
