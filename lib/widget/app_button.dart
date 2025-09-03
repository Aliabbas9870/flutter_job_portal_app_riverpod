import 'package:flutter/material.dart';



class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;
  const AppButton({super.key, required this.label, required this.onPressed, this.filled = true});

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return ElevatedButton(onPressed: onPressed, child: Text(label));
    }
    return OutlinedButton(onPressed: onPressed, child: Text(label));
  }
}
