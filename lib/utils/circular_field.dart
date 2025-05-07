// import 'package:flutter/material.dart';
// import 'package:session_buddy/core/app_colors.dart';
// class CircularTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   const CircularTextField({
//     required this.hintText,
//     required this.controller,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(color: AppColors.greyColor),
//         contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25.0),
//           borderSide: BorderSide(color: AppColors.borderColor),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25.0),
//           borderSide: BorderSide(color: AppColors.borderColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25.0),
//           borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CircularTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CircularTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.secondary,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: theme.inputDecorationTheme.border?.borderSide ??
              BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: theme.inputDecorationTheme.enabledBorder?.borderSide ??
              BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
