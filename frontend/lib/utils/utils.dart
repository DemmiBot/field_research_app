import 'package:flutter/material.dart';

const backGroundColor = Color(0xFF2D323D);
const fillFormColor = Color(0xFF1B1F27);
const textColorForm = Color(0xFF8F96A4);
const buttonColor = Color(0xFF1B1F27);

void showErrorDialog(dynamic error, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text("An error occurred: $error"),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}