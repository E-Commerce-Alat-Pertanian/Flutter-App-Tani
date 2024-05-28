import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final Function(String? value) onChange;
  final String value;
  final List<DropdownMenuItem<String>> item;
  final String label;

  const Dropdown({
    super.key,
    required this.onChange,
    required this.value,
    required this.item,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Text(label),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCCCDCE)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(8),
              onChanged: onChange,
              items: item,
            ),
          ),
        ),
      ],
    );
  }
}
