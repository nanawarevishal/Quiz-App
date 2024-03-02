import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quizapp/Controller/QuizController.dart';
import 'package:quizapp/Models/QuizModel.dart';
import 'package:quizapp/Service/QuizService.dart';
import 'package:quizapp/main.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizQuestions();
  }
}

class _QuizQuestions extends State<Quiz> {
  // late Timer _timer;
  QuizController quizController = Get.put(QuizController());

//   List<QuizModel> quizController.quizList = [];

  @override
  void initState() {
    super.initState();
    initQuizService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      quizController.reset(); // Reset the controller after the widget has finished building
      quizController.startTimer();
    });
  }

  Future<void> initQuizService() async {
    try {
      List<QuizModel> quiz = await QuizService.getQuestions(
          quizId: MainApp.storage.read("quizId"));
      setState(() {
        quizController.quizList = quiz;
      });
    } catch (e) {
      // print("Error initializing user data: $e");
    }
  }

  int choiceAnsIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (quizController.quizList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      MainApp.storage.write("quizLisLength", quizController.quizList.length);
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          return LinearPercentIndicator(
                            width: 236,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent:
                                (quizController.currentQuestionIndex.value +
                                        1) /
                                    quizController.quizList.length,
                            center: Obx(
                              () => Text(
                                  "${(((quizController.currentQuestionIndex.value + 1) / quizController.quizList.length) * 100).toStringAsFixed(2)}%"),
                            ),
                            progressColor: Colors.green,
                            barRadius: const Radius.circular(10),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(alignment: Alignment.topCenter, children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 75, left: 25, right: 25, bottom: 25),
                      // width: 300,
                      // height: 230,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 165, 237, 254),
                          borderRadius: BorderRadius.circular(20)),
                      child: Obx(() {
                        int currentIndex =
                            quizController.currentQuestionIndex.value;
                        return Text(
                          quizController.quizList[currentIndex].content,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      })),
                  Obx(
                    () => CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: quizController.secondsPassed.value / 30,
                      center: Obx(() =>
                          Text(quizController.secondsPassed.value.toString())),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.red,
                    ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      if (quizController.choiceAnsIndex.value == 0) {
                        setState(() {
                          quizController.choiceAnsIndex.value = 1;
                        });
                      }
                    },
                    child: Obx(
                      () => Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, bottom: 10, right: 20),
                          width: 300,
                          // height: 50,
                          decoration: BoxDecoration(
                              color: quizController.getColor(1),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: 235,
                                  child: Text(
                                    quizController.quizList[quizController
                                            .currentQuestionIndex.value]
                                        .answers["1"]!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Spacer(),
                              quizController.getSign(1)
                            ],
                          )),
                    )),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      if (quizController.choiceAnsIndex.value == 0) {
                        setState(() {
                          quizController.choiceAnsIndex.value = 2;
                        });
                      }
                    },
                    child: Obx(
                      () => Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, bottom: 10, right: 20),
                          width: 300,
                          // height: 50,
                          decoration: BoxDecoration(
                              color: quizController.getColor(2),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: 235,
                                  child: Text(
                                    quizController.quizList[quizController
                                            .currentQuestionIndex.value]
                                        .answers["2"]!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Spacer(),
                              quizController.getSign(2)
                            ],
                          )),
                    )),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      if (quizController.choiceAnsIndex.value == 0) {
                        setState(() {
                          quizController.choiceAnsIndex.value = 3;
                        });
                      }
                    },
                    child: Obx(
                      () => Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, bottom: 10, right: 20),
                          width: 300,
                          // height: 50,

                          decoration: BoxDecoration(
                              color: quizController.getColor(3),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: 235,
                                  child: Text(
                                    quizController.quizList[quizController
                                            .currentQuestionIndex.value]
                                        .answers["3"]!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Spacer(),
                              quizController.getSign(3)
                            ],
                          )),
                    )),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      if (quizController.choiceAnsIndex.value == 0) {
                        setState(() {
                          quizController.choiceAnsIndex.value = 4;
                        });
                      }
                    },
                    child: Obx(
                      () => Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, bottom: 10, right: 20),
                          width: 300,
                          // height: 50,
                          decoration: BoxDecoration(
                              color: quizController.getColor(4),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Obx(
                                () => SizedBox(
                                  width: 235,
                                  child: Text(
                                    quizController.quizList[quizController
                                            .currentQuestionIndex.value]
                                        .answers["4"]!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Spacer(),
                              quizController.getSign(4)
                            ],
                          )),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 1, 113, 141),
                  ),
                  child: Obx(() {
                    return quizController.currentQuestionIndex.value + 1 <
                            quizController.quizList.length
                        ? ElevatedButton(
                            style: ButtonStyle(
                                fixedSize: const MaterialStatePropertyAll(Size(300, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 1, 113, 141),
                              ),
                            ),
                            onPressed: () {
                              Future.microtask(() {
                                if(quizController.choiceAnsIndex.value!=0){
                                  quizController.updateScore();
                                }
                                quizController
                                    .gotoNextQuestion(quizController.quizList.length);
                              });
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(Size(300, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 1, 113, 141),
                              ),
                            ),
                            onPressed: () {
                              if(quizController.choiceAnsIndex.value!=0){
                                  quizController.updateScore();
                              }
                              quizController.stopTimer();
                              quizController.choiceAnsIndex.value = 0;
                              quizController.currentQuestionIndex.value = 0;
                              QuizService.updateUserScore(score: quizController.score.value);
                             
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          );
                  }),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
