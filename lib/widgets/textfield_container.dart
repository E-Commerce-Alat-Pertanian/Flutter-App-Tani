import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TextFieldContainerWidget extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? hinText;
  final double? borderRadius;
  final Color? color;
  final VoidCallback? iconClickEvent;
  final bool readOnly;
  const TextFieldContainerWidget({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.hinText,
    this.borderRadius,
    this.color,
    this.iconClickEvent,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color == null ? Colors.grey.withOpacity(.2) : color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        readOnly: readOnly,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
            hintText: hinText,
            border: InputBorder.none,
            prefixIcon:
                InkWell(onTap: iconClickEvent, child: Icon(prefixIcon))),
      ),
    );
  }
}
