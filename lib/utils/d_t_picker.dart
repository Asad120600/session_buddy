// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../core/app_colors.dart';

// class DateTimePicker extends StatefulWidget {
//   final Function(DateTime) onDateTimeSelected;

//   const DateTimePicker({required this.onDateTimeSelected});

//   @override
//   _DateTimePickerState createState() => _DateTimePickerState();
// }

// class _DateTimePickerState extends State<DateTimePicker> {
//   DateTime selectedDateTime = DateTime.now();

//   Future<void> _selectDateTime(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDateTime,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (pickedDate != null) {
//       TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(selectedDateTime),
//       );

//       if (pickedTime != null) {
//         setState(() {
//           selectedDateTime = DateTime(
//             pickedDate.year,
//             pickedDate.month,
//             pickedDate.day,
//             pickedTime.hour,
//             pickedTime.minute,
//           );
//         });
//         widget.onDateTimeSelected(selectedDateTime);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _selectDateTime(context),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.borderColor),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(Icons.calendar_today, color: AppColors.text),
//             Text(
//               DateFormat('MMM dd, yyyy - hh:mm a').format(selectedDateTime),
//               style: TextStyle(color: AppColors.text),
//             ),
//             Icon(Icons.access_time, color: AppColors.text),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final Function(DateTime) onDateTimeSelected;

  const DateTimePicker({super.key, required this.onDateTimeSelected});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        widget.onDateTimeSelected(selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => _selectDateTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
              color: theme.inputDecorationTheme.border?.borderSide.color ??
                  colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.calendar_today, color: theme.iconTheme.color),
            Text(
              DateFormat('MMM dd, yyyy - hh:mm a').format(selectedDateTime),
              style: theme.textTheme.bodyMedium,
            ),
            Icon(Icons.access_time, color: theme.iconTheme.color),
          ],
        ),
      ),
    );
  }
}