// ignore_for_file: empty_catches

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controller/QuizController.dart';
import 'package:quizapp/Models/RankersModel.dart';
import 'package:quizapp/Models/SingleUserModel.dart';
import 'package:quizapp/Service/HomePageService.dart';
import 'package:quizapp/Service/QuizService.dart';
import 'package:quizapp/pages/HomePage.dart';

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({super.key});

  @override
  State createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State {

  User? user;
  late ConfettiController _confettiController;

  List<Rankers>rankers = [];

  QuizController quizController = Get.put(QuizController());

  var totalCorrectAns = 0;
  var totalIncorrectAns = 0;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
    rankers.clear();
    initRankers();
    initUserData();
    calculate();
    quizController.resetScore();
  }

  Future<void> initRankers()async{

      try{
          List<Rankers>ranker =await QuizService.getRankers();
          setState(() {
            rankers = ranker;
          });

      }catch(e){

      }
  }

    Future<void> initUserData() async {
    try {
      final userData = await HomePageService.getUserData();
      setState(() {
        user = userData;
      });
    } catch (e) {
      // print("Error initializing user data: $e");
    }
  }

  void calculate() {
    totalCorrectAns = quizController.score.value;
    totalIncorrectAns = quizController.quizList.length - totalCorrectAns;
  }

  @override
  Widget build(BuildContext context) {
    if(rankers.isEmpty){
        return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(),
            ),
        );
    }
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 90, 217, 255),
      child: Column(
        children: [
          ConfettiWidget(
            confettiController: _confettiController,
            colors: const [Colors.green, Colors.red, Colors.black, Colors.blue],
            shouldLoop: true,
            gravity: .2,
            blastDirection: -pi * 5.5,
            numberOfParticles: 20,
            blastDirectionality: BlastDirectionality.directional,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(top: 95),
            width: MediaQuery.of(context).size.width * .90,
            height: MediaQuery.of(context).size.height * .75,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/trophy.png",
                  height: 200,
                ),
                const SizedBox(
                  height: 8,
                ),
                 Text(
                  "Hi ${user!.firstName.capitalizeFirst}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Congratulations!",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text("You have got the ${user!.ranks} place in ${rankers.length}"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text("$totalCorrectAns Correct"),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text("$totalIncorrectAns InCorrect")
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Stack(
                  children: [
                  Positioned(
                    
                    child: Image.asset("assets/images/LeaderImg.png",
                    width: 300,
                    height: 40,),
                  ),
                
                  const Positioned(
                      left: 120,
                      top: 7,
                      child:  Text("Rankers",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w900),))
                
                ]),

                const SizedBox(height: 15,),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .80,
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 174, 244, 201),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child:  Text(rankers[0].ranks.toString(),
                        style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                       Text(rankers[0].firstName.capitalizeFirst!,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                      const Spacer(),
                       Text(rankers[0].score.toString(),style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .80,
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 174, 244, 201),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child:  Text(rankers[1].ranks.toString(),style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                       Text(rankers[1].firstName.capitalizeFirst!,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                      const Spacer(),
                      Text(rankers[1].score.toString(),style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .80,
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 174, 244, 201),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child:  Text(rankers[2].ranks.toString(),style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                       Text(rankers[2].firstName.capitalizeFirst!,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                      const Spacer(),
                       Text(rankers[2].score.toString(),style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                       ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => const HomePage());
              },
              child: const Text(
                "Home Page",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ))
        ],
      ),
    ));
  }
}
