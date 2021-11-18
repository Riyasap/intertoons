import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intertoons/core/constant/custom_colors.dart';
import 'package:intertoons/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'Oman Phone',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: CustomColors.red),
        accentColor: CustomColors.red,
      ),
      home: const MainScreen(),
    );
  }
}
