import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  final VoidCallback onPositiveButtonPressed;
  final VoidCallback onNegativeButtonPressed;

  CustomDialog({
    required this.text,
    required this.onPositiveButtonPressed,
    required this.onNegativeButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Custom Dialog'),
      content: Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: onNegativeButtonPressed,
          child: Text('Abbrechen'),
        ),
        TextButton(
          onPressed: onPositiveButtonPressed,
          child: Text('Bestätigen'),
        ),
      ],
    );
  }
}
