import 'package:flutter/material.dart';

class OutlineTextButtonComp extends StatelessWidget {
  const OutlineTextButtonComp({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
  });

  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: backgroundColor ?? Colors.white,
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color(0xffDDDDDD),
            width: 1,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color(0xff303538),
        ),
      ),
    );
  }
}
