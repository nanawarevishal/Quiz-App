import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnacKBar {

    static void success({required String title,required String message}) {
        Get.snackbar(
        "",
        "",
        backgroundColor: Colors.transparent,
        overlayBlur: 5,
        titleText: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 160, 160, 160)),
            borderRadius: BorderRadius.circular(20),
            ),
            child:  Row(
            children: [
                const Icon(
                Icons.check_circle_rounded,
                color: Color.fromARGB(255, 0, 184, 95),
                ),
                const SizedBox(width: 20),
                Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        title,
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                        message,
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        ),
                    ),
                    ],
                ),
                ),
            ],
            ),
        ),
      );
    }

    static void error({required String title,required String message}) {
        Get.snackbar(
        "",
        "",
        backgroundColor: Colors.transparent,
        overlayBlur: 5,
        titleText: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
            borderRadius: BorderRadius.circular(20),
            ),
            child:  Row(
            children: [
                const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 248, 248, 248),
                ),
                ),
                const SizedBox(width: 20),
                Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        title,
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                        message,
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        ),
                    ),
                    ],
                ),
                ),
            ],
            ),
        ),
    );
  }
}
