import 'package:flutter/material.dart';

class ToastMessage extends StatelessWidget {
  final String msg;

  const ToastMessage({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color(0xFFFBE8C6),
      ),
      child: Text(
        msg,
        style: const TextStyle(
          color: Color(0xFF505050),
        ),
      ),
    );
  }
}
