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
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white),
        ),
        TextButton(
          onPressed: onPositiveButtonPressed,
          child: Text('Bestätigen'),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              backgroundColor: Color(0xFF35B05C),
              foregroundColor: Colors.white),
        ),
      ],
    );
  }
}
