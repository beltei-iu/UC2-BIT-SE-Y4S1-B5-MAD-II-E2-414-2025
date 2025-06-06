import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/google.png", width: 30, height: 30),
        SizedBox(width: 4),
        Image.asset("assets/images/facebook.png", width: 30, height: 30),
      ],
    );
  }
}
