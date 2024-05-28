import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool multiline;

  const FormInput({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hintText,
    this.multiline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            minLines: multiline ? 3 : 1,
            maxLines: multiline ? 3 : 1,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: hintText,
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
