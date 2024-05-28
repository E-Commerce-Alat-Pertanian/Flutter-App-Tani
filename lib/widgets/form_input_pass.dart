import 'package:flutter/material.dart';

class FormInputPass extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;

  const FormInputPass({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
  }) : super(key: key);

  @override
  _FormInputPassState createState() => _FormInputPassState();
}

class _FormInputPassState extends State<FormInputPass> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            obscureText: _isObscure,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: widget.hintText ?? 'Password',
              fillColor: Colors.grey[200],
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
