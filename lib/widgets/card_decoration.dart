import 'package:flutter/material.dart';

BoxDecoration buildCardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(color: Color(0x12000000), blurRadius: 18, offset: Offset(0, 8)),
    ],
  );
}
