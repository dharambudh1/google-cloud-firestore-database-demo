import "package:firebase_core/firebase_core.dart";
import "package:firestore_database_demo/firebase_options.dart";
import "package:firestore_database_demo/util/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:keyboard_dismisser/keyboard_dismisser.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: GetMaterialApp(
        navigatorKey: Get.key,
        title: "Firestore Database",
        theme: themeData(brightness: Brightness.light),
        darkTheme: themeData(brightness: Brightness.dark),
        getPages: AppRoutes.instance.getPages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  ThemeData themeData({required Brightness brightness}) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
