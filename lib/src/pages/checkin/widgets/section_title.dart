import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightOrangeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: AppTheme.subTitleStyle.copyWith(
          color: AppTheme.orangeColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
