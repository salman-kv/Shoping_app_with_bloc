import 'package:flutter/material.dart';

coustumSnackBar(String data, BuildContext context, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 500),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(10),
      content: Text(data)));
}
