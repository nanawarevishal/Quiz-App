// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:quizapp/Models/RankersModel.dart';
import 'package:quizapp/Service/QuizService.dart';

class LearderBoardPage extends StatefulWidget {
  const LearderBoardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LeaderBoardPage();
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height) // Move to bottom-left
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 50,
        size.width,
        size.height, // Quad curve to bottom-right
      )
      ..lineTo(size.width, 0); // Line to top-right

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _LeaderBoardPage extends State<LearderBoardPage> {

  List<Rankers>rankers = [];

  @override
  void initState(){
    super.initState();
    initRankers();  
  }

  Future<void>initRankers()async{

      try {
          List<Rankers>ranks = await QuizService.getRankers();
          setState(() {
              rankers = ranks;
          });
      } catch (e) {
        
      }
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
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 255, 119, 119),
      //   foregroundColor: const Color.fromARGB(255, 255, 119, 119),
      //     // title: const Text("data"),
      // ),
      backgroundColor: const Color.fromARGB(255, 225, 224, 224),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: 350.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Color.fromARGB(255, 255, 94, 82),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: const Text(
                              "LeaderBoard",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 300,
                                margin: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 88,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(left: 7),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.redAccent),
                                      child: const Text(
                                        "All Time",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 95,
                                      alignment: Alignment.center,
                                      
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4),
                                        color: Colors.redAccent
                                      ),
                                     
                                        child:const Text(
                                          "This Week",
                                          
                                          style: TextStyle(fontSize: 15,color: Colors.black),
                                        ),
                                      ),
                                    
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 88,
                                      margin: const EdgeInsets.only(right: 2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4),
                                        color: Colors.redAccent
                                      ),
                                      child: const Text(
                                        "Month",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 135,
                            width: 85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.vertical(
                                    top: Radius.elliptical(
                                        MediaQuery.of(context).size.width, 165),
                                    bottom: const Radius.elliptical(400, 200)),
                                color:
                                    const Color.fromARGB(255, 252, 134, 124)),
                            child:  Column(
                              children: [
                                const CircleAvatar(
                                  maxRadius: 30,
                                  foregroundImage: NetworkImage(
                                      "https://img.freepik.com/premium-vector/young-man-face-avater-vector-illustration-design_968209-13.jpg"),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                   " ${rankers[1].firstName}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                
                                const SizedBox(
                                  height: 0,
                                ),
                                 Text(
                                  "${rankers[1].score.toString()} Points",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.vertical(
                                    top: Radius.elliptical(
                                        MediaQuery.of(context).size.width, 150),
                                    bottom: const Radius.elliptical(400, 200)),
                                color:
                                    const Color.fromARGB(255, 252, 134, 124)),
                            child:  Column(
                              children: [
                                const CircleAvatar(
                                  maxRadius: 30,
                                  foregroundImage: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHDHiJHyJ7y9lpOHQewoKqdq7LYZjSDgC6g5HnlqZW6fjiQeEaqAGq4Qe-CvXtbsCaFqg&usqp=CAU"),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                 Text(
                                   " ${rankers[0].firstName}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                
                                const SizedBox(
                                  height: 0,
                                ),
                                 Text(
                                  "${rankers[0].score.toString()} Points",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 136,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.vertical(
                                    top: Radius.elliptical(
                                        MediaQuery.of(context).size.width, 150),
                                    bottom: const Radius.elliptical(400, 200)),
                                color:
                                    const Color.fromARGB(255, 252, 134, 124)),
                            child:  Column(
                              children: [
                                const CircleAvatar(
                                  maxRadius: 30,
                                  foregroundImage: NetworkImage(
                                      "https://i.pinimg.com/originals/a9/a2/15/a9a215cadc81daa174607b3930e40858.png"),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                 Text(
                                   " ${rankers[2].firstName}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                
                                const SizedBox(
                                  height: 0,
                                ),
                                 Text(
                                  "${rankers[2].score.toString()} Points",
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: QuizService.getRankers(),
                builder: (context,AsyncSnapshot<List<Rankers>> snapshot){
                    print(snapshot.data);
                    if(!snapshot.hasData){
                      return const CircularProgressIndicator();
                    }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: rankers.length-3,
                  itemBuilder: (BuildContext context,index){
                  return  Container(
                    height: 60,
                    width: 450,
                    
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child:  Row(
                      children: [
                        Text(snapshot.data![index+3].ranks.toString()),
                        const SizedBox(
                          width: 20,
                        ),
                        const CircleAvatar(
                          maxRadius: 20,
                          foregroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2j0_vnbTEYnELVY8tlXWYTqSjv91hZap8Naeq58C4wEJSUmodyaaMRhGqvkuyumO7T3g&usqp=CAU"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${snapshot.data![index+3].firstName} ${snapshot.data![index+3].lastName}",
                          style:const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                         Text(
                          snapshot.data![index+3].score.toString(),
                          style:
                              const TextStyle(color: Color.fromARGB(255, 252, 134, 124)),
                        )
                      ],
                    ),
                  );
                  }
                 );
                },
              ),
           
              
            ],
          ),
        ),
      ),
    );
  }
}
