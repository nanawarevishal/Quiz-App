import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/components/SnackBar.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/ProfilePage.dart';
import 'package:quizapp/pages/loginPage.dart';

class DialogBox {
  static void showDialogBox({required String title,required String message}) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                       Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 15),
                       Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor:Colors.red,
                                foregroundColor: Colors.white
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'NO',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white
                              ),
                              onPressed: () {
                                    MainApp.storage.remove("token");
                                    SnacKBar.success(title: "Congratulations...!", message: "Logout Successfully");
                                    Get.to(()=>const LoginPage());   
                              },
                              child: const Text(
                                'YES',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
