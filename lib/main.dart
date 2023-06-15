import 'package:flutter/material.dart';
import 'package:flutter_social_clean/src/config/app_router.dart';
import 'package:flutter_social_clean/src/config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomTheme.theme(),
      routerConfig: AppRouter().router,
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter App with Clean Architecture"),
//       ),
//       bottomNavigationBar: const CustomNavBar(),
//     );
//   }
// }
