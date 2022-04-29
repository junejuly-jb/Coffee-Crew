import 'package:flutter/material.dart';

class SignInHeader extends StatefulWidget {
  final String title1;
  final String title2;
  const SignInHeader({Key? key, required this.title1, required this.title2}) : super(key: key);

  @override
  State<SignInHeader> createState() => _SignInHeaderState();
}

class _SignInHeaderState extends State<SignInHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100.0),
        Text(
          widget.title1,
          style: const TextStyle(
              fontSize: 40.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          widget.title2,
          style: const TextStyle(
              fontSize: 40.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        )
      ]
    );
  }
}
