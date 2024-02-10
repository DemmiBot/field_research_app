import 'package:flutter/material.dart';

class MyButtonExternal extends StatelessWidget {
  const MyButtonExternal({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Image.asset(
        'lib/assets/images/google.png',
        height: 20,
        width: 20,
      ),
      label: Text(
        'Continue with Google',
        style: TextStyle(
            fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.bold),
      ),
      onPressed: null,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
