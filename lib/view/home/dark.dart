// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controller/theme_controller.dart';

// class HomeScreeqn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ThemeController themeController = Get.find();

//     return Scaffold(
//       appBar: AppBar(title: Text("Session Buddy")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Welcome to Session Buddy!"),
//             Obx(() => Switch(
//                   value: themeController.isDarkMode.value,
//                   onChanged: (value) {
//                     themeController.toggleTheme(value);
//                   },
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
