import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[900],
    ),
  );
}
