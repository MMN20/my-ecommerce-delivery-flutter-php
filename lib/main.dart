import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_ecommerce_delivery/core/constants/colors.dart';
import 'package:my_ecommerce_delivery/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Cairo",
        colorScheme: const ColorScheme.light(primary: AppColors.thirdColor10),
        scaffoldBackgroundColor: AppColors.mainColor60,
        appBarTheme: const AppBarTheme(color: AppColors.mainColor60),
        textTheme: const TextTheme(
          // Texts uses it
          bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.thirdColor10,
          ),
          // TextForms uses it
          bodyLarge: TextStyle(fontSize: 15),
        ),
        useMaterial3: true,
      ),
      getPages: pages,
    );
  }
}
