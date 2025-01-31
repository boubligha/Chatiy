import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:mychatflutter_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCirgb7UslDxBIomD85iMPUNlude2iFSIA",
        authDomain: "mychatiy.firebaseapp.com",
        projectId: "mychatiy",
        storageBucket: "mychatiy.firebasestorage.app",
        messagingSenderId: "561461530474",
        appId: "1:561461530474:web:de9dc84c2ae5d3ba981f13",
        measurementId: "G-WG8EDCR4EV",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatiy',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(42, 117, 188, 1),
        colorScheme: ColorScheme.dark(
          primary: Color.fromRGBO(42, 117, 188, 1),
          secondary: Color.fromRGBO(42, 117, 188, 1),
          background: Color.fromRGBO(28, 27, 27, 1),
        ),
      ),
      home: LogingPage(),
    );
  }
}
