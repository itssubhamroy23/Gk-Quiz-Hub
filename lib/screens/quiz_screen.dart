import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gk/authentication/login.dart';
import 'package:gk/constants/colors.dart';
import 'package:gk/screens/result_screen.dart';
import 'package:gk/services/api_services.dart';
import 'package:html/parser.dart' show parse;

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    // Navigate back to the Login page after logout
    Get.offAll(Login());
  } catch (e) {
    // Handle logout errors
    Get.snackbar("Logout Failed", e.toString(),
        snackPosition: SnackPosition.BOTTOM);
  }
}

class _QuizScreenState extends State<QuizScreen> {
  late Future quiz;
  int seconds = 60;
  var currentIndexofQuestion = 0;
  Timer? timer;
  bool isLoading = false;
  var optionList = <String>[];
  int correctAnswers = 0;
  int inCorrectAnswers = 0;
  List<Color> optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getQuizData();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void resetColor() {
    setState(() {
      optionColor = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
      ];
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            goToNextQuestion();
          }
        });
      }
    });
  }

  void goToNextQuestion() {
    setState(() {
      resetColor();
      isLoading = false;
      currentIndexofQuestion++;
      timer?.cancel();
      seconds = 60;
      startTimer();
    });
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    return document.body!.text;
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data["results"];
              print('Fetched data: $data'); // Debug print

              if (data.isEmpty) {
                return const Center(child: Text("No Data Found"));
              }

              if (!isLoading) {
                optionList = List.from(
                    data[currentIndexofQuestion]['incorrect_answers']);
                optionList.add(data[currentIndexofQuestion]['correct_answer']);
                optionList = optionList.map((e) => parseHtmlString(e)).toList();
                optionList.shuffle();
                isLoading = true;
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: lightgrey, width: 2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          // Adjusted the timer container for better padding
                          Container(
                            height: 50, // Increase the height for padding
                            width: 50, // Adjust width if necessary
                            padding: const EdgeInsets.all(5), // Add padding
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  "$seconds",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    value: seconds / 60,
                                    valueColor: const AlwaysStoppedAnimation(
                                        Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Image.asset(
                          'assets/images/idea.png',
                          width: 180,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Question ${currentIndexofQuestion + 1} of ${data.length}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        parseHtmlString(
                            data[currentIndexofQuestion]['question']),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: optionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var correctAnswer = parseHtmlString(
                              data[currentIndexofQuestion]['correct_answer']);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (correctAnswer.toString() ==
                                    optionList[index].toString()) {
                                  optionColor[index] = Colors.green;
                                  correctAnswers++;
                                } else {
                                  optionColor[index] = Colors.red;
                                  inCorrectAnswers++;
                                }
                                if (currentIndexofQuestion < data.length - 1) {
                                  Future.delayed(
                                      const Duration(milliseconds: 400), () {
                                    goToNextQuestion();
                                  });
                                } else {
                                  timer?.cancel();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                          correctAnswers,
                                          inCorrectAnswers,
                                          currentIndexofQuestion + 1),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 100,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: optionColor[index],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                optionList[index].toString(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                  child: Text(
                "No Data Found",
                style: TextStyle(color: Colors.white),
              ));
            }
          },
        ),
      ),
      // Floating Action Button added here
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logout();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
