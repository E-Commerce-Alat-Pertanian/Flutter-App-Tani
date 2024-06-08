import 'package:flutter/material.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final EdgeInsetsGeometry margin;
  final Color color;
  final Color textColor;
  final bool rounded;
  final TextStyle? textStyle;
  final double? minWidth;
  final bool loading;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.minWidth,
    this.rounded = false,
    this.textColor = Colors.white,
    this.margin = EdgeInsets.zero,
    this.color = AppConstants.secondary,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: MaterialButton(
        onPressed: loading ? null : onPressed,
        color: color,
        textColor: textColor,
        shape: rounded
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              )
            : null,
        minWidth: minWidth,
        disabledColor: color.withOpacity(.5),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
