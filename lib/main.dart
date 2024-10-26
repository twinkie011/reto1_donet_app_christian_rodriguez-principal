import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reto1_donet_app_christian_rodriguez/firebase_options.dart';
import 'package:reto1_donet_app_christian_rodriguez/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Quitar el banner de "Debug"
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.pink,
        ),
      ),
    );
  }
}
