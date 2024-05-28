import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final Function(String? value) onChange;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final String label;

  const DropdownWidget({
    Key? key,
    required this.onChange,
    required this.value,
    required this.items,
    required this.label,
  }) : super(key: key);

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
            child: DropdownButton<String>(
              value:
                  items.isNotEmpty && items.any((item) => item.value == value)
                      ? value
                      : null,
              isExpanded: true,
              borderRadius: BorderRadius.circular(8),
              onChanged: onChange,
              items: items,
              hint: const Text('Please select'),
            ),
          ),
        ),
      ],
    );
  }
}
