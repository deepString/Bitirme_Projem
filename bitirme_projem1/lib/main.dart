import 'package:flutter/material.dart';

import 'screens/authLoading.dart';
import 'screens/changePassword.dart';
import 'screens/homeScreen.dart';
import 'screens/libraryScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/profileScreen.dart';
import 'screens/registerScreen.dart';
import 'screens/resetPassword.dart';
import 'screens/searchScreen.dart';
import 'screens/settingScreen.dart';
import 'screens/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
        '/login':(context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/resetPass': (context) => ResetPassword(),
        '/changePass': (context) => ChangePassword(),
        '/profile': (context) => ProfileScreen(),
        '/search': (context) => SearchScreen(),
        '/library': (context) => LibraryScreen(),
        '/setting': (context) => SettingScreen(),
        '/loadAuth': (context) => AuthLoadingScreen(),
      },
      initialRoute: '/loadAuth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
