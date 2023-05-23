import 'dart:ui';

import 'package:flutter/material.dart';

double? _deviceHeght;
void showSnackBar(BuildContext context, String text, Color color) {
  _deviceHeght = MediaQuery.of(context).size.height;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      padding: const EdgeInsets.all(18),
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
      margin: EdgeInsets.only(bottom: _deviceHeght! - 100, right: 20, left: 20),
    ),
  );
}
