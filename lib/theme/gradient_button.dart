import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Text text;
  final VoidCallback onPressed;
  const GradientButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
    const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
    const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);

    const Color transparentColor = Colors.transparent;

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [gradient1, gradient2, gradient3],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: transparentColor,
          shadowColor: transparentColor,
        ),
        onPressed: onPressed,
        child: text,
      ),
    );
  }
}
