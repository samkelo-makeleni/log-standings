import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F4EF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0B5D52),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
