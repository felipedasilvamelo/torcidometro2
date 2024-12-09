import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const TabButton({required this.label, required this.isActive, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isActive ? Colors.white : Colors.white70,
        ),
      ),
    );
  }
}
