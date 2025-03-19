import 'package:flutter/material.dart';
import 'package:brelax/core/constants/font_style.dart';

class CustomizedBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const CustomizedBtn({super.key, this.onPressed, required this.label,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42))),
        child: Text(
          label,
          style: FontStyles.content,
        ));
  }
}
