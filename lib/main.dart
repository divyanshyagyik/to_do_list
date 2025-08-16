import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/views/email_auth/sign_in_page.dart';
import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'Todo App',
      theme: _themeController.theme,
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    ));
  }
}


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      return authController.firebaseUser.value != null
          ? HomeView()
          : SignInPage();
    });
  }
}