import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Models/CategoryModel.dart';
import 'package:quizapp/Service/CategoryQuizService.dart';
import 'package:quizapp/components/ColorsList.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/ProfilePage.dart';
import 'package:quizapp/pages/Quiz.dart';

class CategoryQuiz extends StatefulWidget {
  const CategoryQuiz({super.key});

  @override
  State createState() => _CategoryQuizState();
}

class _CategoryQuizState extends State {
  List<CategoryModel> _categoryQuizList = [];

  @override
  void initState() {
    super.initState();
    initCategoryQuiz();
  }

  Future<void> initCategoryQuiz() async {
    try {
      List<CategoryModel> catQuiz = await CategoryQuizService.getQuizCategory(
          categoryId: MainApp.storage.read("categoryId"));
      setState(() {
        _categoryQuizList = catQuiz;
      });
    } catch (e) {
      // print("Error initializing user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_categoryQuizList.isEmpty){
        return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(),
            ),
        );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                        color: Colors.blue,
                        onPressed: () {},
                        icon: const Icon(Icons.favorite)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40)),
                    child: IconButton(
                        color: Colors.blue,
                        onPressed: () {
                          Get.to(()=>const ProfilePage());
                        },
                        icon: const Icon(Icons.person_3_rounded)),
                  ),
                ],
              ),
              const Text(
                "Let's Play",
                style: TextStyle(
                    color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Be the first",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                  itemCount: _categoryQuizList.length,
                  itemBuilder: (BuildContext context, index){
                  return SizedBox(
                  height: 200,
                  width: 400,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          height: 165,
                          width: 300,
                          decoration:  BoxDecoration(
                              gradient: LinearGradient(stops: const[
                                .1,
                                .9
                              ], colors: colorList[index % colorList.length]
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Text(
                                  "Level 1",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    MainApp.storage.remove("quizId");
                                    MainApp.storage.write("quizId", _categoryQuizList[index].id);
                                    Get.to(()=>const Quiz());
                                    
                                  },
                                  child:   Text(
                                  _categoryQuizList[index].title,
                                  style:const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                        //   Positioned(
                        //     right: 20,
                        //     top: -10,
                        //     child: SizedBox(
                        //         width: 100,
                        //         height: 150,
                        //         child: Image.network(
                        //             _categoryQuizList[0].catImage)),
                        //   )
                    ],
                  ),
                );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
