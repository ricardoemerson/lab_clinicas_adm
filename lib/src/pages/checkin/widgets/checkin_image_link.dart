import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class CheckinImageLink extends StatelessWidget {
  final String label;

  const CheckinImageLink({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.blueColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
