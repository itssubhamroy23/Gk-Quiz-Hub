import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gk/authentication/login.dart';
import 'package:gk/screens/quiz_slpash_screen.dart';
import '../constants/colors.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswer;
  final int inCorrectAnswer;
  final int totalQuestion;
  const ResultScreen(
      this.correctAnswer, this.inCorrectAnswer, this.totalQuestion,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double correctPercentage = (correctAnswer / totalQuestion * 100);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Colors.blue, blue, darkblue],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events,
                color: Colors.yellow.shade700,
                size: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Congratulations!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                "${correctPercentage.toStringAsFixed(1)}%",
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    "Correct Answers: $correctAnswer",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.cancel, color: Colors.red, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    "Incorrect Answers: $inCorrectAnswer",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  var pushReplacement = Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizSplashScreen()), // Corrected the screen name
                  );
                },
                child: const Text("Back to Home"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut();
            // Navigate the user to the Login screen or show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully logged out")),
            );
            // Push the Login screen directly
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false,
            );
          } catch (e) {
            // Handle error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to log out: $e")),
            );
          }
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
