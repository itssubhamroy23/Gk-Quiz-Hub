import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gk/authentication/Verify.dart';
import 'package:gk/authentication/login.dart';
import 'package:gk/screens/quiz_screen.dart';
// Import your splash screen

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null && user.emailVerified) {
              return const QuizScreen(); // Navigate to QuizScreen if verified
            } else {
              return const Verify(); // If not verified, navigate to Verify screen
            }
          } else {
            return const Login(); // No user logged in, navigate to Login
          }
        } else {
          return const Center(
              child:
                  CircularProgressIndicator()); // Waiting for Firebase connection
        }
      },
    );
  }
}
