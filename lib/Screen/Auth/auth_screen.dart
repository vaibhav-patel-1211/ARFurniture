import 'package:ar_furniture/Screen/Auth/login_screen.dart';
import 'package:ar_furniture/Screen/entry_point.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ** if user is signed in
          if (snapshot.hasData) {
            return const EntryPoint();
          }
          // ** if user is not signed in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
