import 'package:flutter/material.dart';
import 'package:pudez_plogging/src/common/color.family.dart';

class TextButtonComp extends StatelessWidget {
  const TextButtonComp({
    super.key,
    required this.onPressed,
    required this.text,
    this.child,
    this.backgroundColor,
  });

  final Function()? onPressed;
  final String text;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        backgroundColor: backgroundColor ?? ColorFamily.primary,
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Center(
        child: child ??
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
