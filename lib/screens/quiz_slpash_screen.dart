import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gk/components/button.dart';
import 'package:gk/constants/colors.dart';

class QuizSplashScreen extends StatelessWidget {
  QuizSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, blue, darkblue],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/inner.png',
                height: 200,
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  const Text(
                    "Welcome to our",
                    style: TextStyle(
                      color: lightgrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Quiz App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  const MyButton(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const Text(
                    "Made with ❤️ by Subham",
                    style: TextStyle(
                      color: lightgrey,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    "App Version: 1.0.0",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
