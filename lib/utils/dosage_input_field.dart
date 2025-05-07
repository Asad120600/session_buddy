

import 'package:flutter/material.dart';

class DosageInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const DosageInputField({
    super.key,
    required this.controller,
    this.hintText = "Dosage",
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: theme.inputDecorationTheme.border?.borderSide.color ??
                colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: colorScheme.secondary),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "mg",
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}