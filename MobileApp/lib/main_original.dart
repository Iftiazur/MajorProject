import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trial/login_register/firebase_options.dart';
import 'package:trial/login_register/pages/Home_page.dart';
import 'package:trial/login_register/pages/login_page.dart';
import 'package:trial/login_register/pages/main_page.dart';
import 'package:trial/login_register/pages/stud_page.dart';
import 'package:trial/login_register/styles/app_colors.dart';

FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/main': (context) => MainPage(),
        '/stud': (context) => StudPage(),
      },
    );
  }
}
