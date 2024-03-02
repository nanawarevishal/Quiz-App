import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Models/QuizModel.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/CongratulationsPage.dart';

class QuizController extends GetxController {
    
  RxInt currentQuestionIndex = 0.obs;
  RxInt counter = 30.obs;
  RxInt secondsPassed = 30.obs;
  late Timer timer;
  RxInt choiceAnsIndex = 0.obs;
  List<QuizModel> quizList = [];
  RxInt score = 0.obs;

  void reset() {
    currentQuestionIndex.value = 0;
    resetTimer();
  }

  void decrementCounter() {
    secondsPassed.value--;
    if (secondsPassed.value == 0) {
      gotoNextQuestion(MainApp.storage.read("quizLisLength"));
    }
  }

  void incrementQueCounter() {
    currentQuestionIndex.value = currentQuestionIndex.value + 1;
  }

  void gotoNextQuestion(int queListLength) {
    if (currentQuestionIndex.value + 1 < queListLength) {
      // if (choiceAnsIndex.value ==
      //     quizList[currentQuestionIndex.value].correctAnswer) {
      //   score.value = score.value + 1;
      // }
      choiceAnsIndex.value = 0;
      resetTimer();
      incrementQueCounter();
    } else if (currentQuestionIndex.value + 1 == queListLength) {
      stopTimer();
      currentQuestionIndex.value = 0;
      Get.to(() => const CongratulationsPage());
    }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      decrementCounter();
      if (secondsPassed.value == 0) {
        gotoNextQuestion(MainApp.storage.read("quizLisLength"));
      }
    });
  }

  stopTimer() {
    timer.cancel();
  }

  resetTimer() {
    secondsPassed.value = 30;
  }

  resetScore() {
    score.value = 0;
  }

  updateScore(){
    if (choiceAnsIndex.value == quizList[currentQuestionIndex.value].correctAnswer) {
        score.value = score.value + 1;
      }
  }

  Widget getSign(int buttonNo) {
    if (choiceAnsIndex.value != 0) {
      if (quizList[currentQuestionIndex.value].correctAnswer == buttonNo) {
        return const CircleAvatar(
          backgroundColor: Colors.green,
          radius: 10,
          child: Icon(
            Icons.check,
            size: 15,
          ),
        );
      }
      if (buttonNo == choiceAnsIndex.value) {
        return const CircleAvatar(
          backgroundColor: Colors.red,
          radius: 10,
          child: Icon(
            Icons.close,
            size: 15,
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return const SizedBox();
  }

  Color? getColor(int buttonNo) {
    if (choiceAnsIndex.value != 0) {
      if (quizList[currentQuestionIndex.value].correctAnswer == buttonNo &&
          choiceAnsIndex.value != 0) {
        return Colors.green.shade100;
      }
      if (buttonNo == choiceAnsIndex.value) {
        return Colors.red.shade100;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
