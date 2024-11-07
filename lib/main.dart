import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:twofort/pages/home_page.dart';
import 'package:twofort/pages/login_page.dart';
import 'package:twofort/pages/signup_page.dart';
import 'ApiKeys/api_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: MyKeys.apiKey,
          appId: MyKeys.appId,
          messagingSenderId: MyKeys.messagingSenderId,
          projectId: MyKeys.projectId,
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/singUpPage':(context) => const SignupPage(),
      },
    );
  }
}
