// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;  // Made nullable to handle disabled state
//   final bool isLoading;           // Added loading state
//   final double? width;            // Added optional width
//   final double? height;           // Added optional height

//   const CustomButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.isLoading = false,
//     this.width,
//     this.height = 40,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final ColorScheme colorScheme = theme.colorScheme;

//     return SizedBox(
//       width: width ?? double.infinity,
//       height: height,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: colorScheme.onPrimary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25.0),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           elevation: isLoading ? 0 : 2,  // Reduced elevation when loading
//         ).merge(theme.elevatedButtonTheme.style),  // Merge with theme if available
//         onPressed: isLoading ? null : onPressed,   // Disable button when loading
//         child: isLoading
//             ? SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
//                 ),
//               )
//             : Text(
//                 text,
//                 style: theme.textTheme.labelLarge?.copyWith(
//                   color: colorScheme.onPrimary,
//                   fontWeight: FontWeight.bold,
//                 ) ?? TextStyle(
//                   color: colorScheme.onPrimary,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white, // Force white foreground
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          elevation: isLoading ? 0 : 2,
        ).merge(theme.elevatedButtonTheme.style),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white, // Force white text
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
