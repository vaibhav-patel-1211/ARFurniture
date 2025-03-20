import 'package:ar_furniture/Screen/Auth/auth_screen.dart';
import 'package:ar_furniture/Screen/Auth/auth_service.dart';
import 'package:ar_furniture/services/profile_service.dart';
import 'package:ar_furniture/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',

      // Applying theme
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      // Initial binding for AuthService
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
        Get.put(ProfileService());
      }),

      // Home page
      home: const AuthScreen(),
    );
  }
}
