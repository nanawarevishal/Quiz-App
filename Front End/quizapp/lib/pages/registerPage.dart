import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Service/RegisterService.dart';
import 'package:quizapp/components/backGround.dart';
import 'package:quizapp/pages/loginPage.dart';

class RegisterPage extends StatefulWidget{
    const RegisterPage({super.key});
    @override
    State createState()=>_RegisterPageState();
}

class _RegisterPageState extends State {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGround(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 10),
               TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
               TextField(
                keyboardType: TextInputType.emailAddress,
                controller: lastNameController,
                decoration:const InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
               TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
               TextField(
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: (){
                     RegisterService.registerUser(
                          firstNameController: firstNameController.text,
                          lastNameController:lastNameController.text,
                          emailController: emailController.text,
                          passwordController: passwordController.text,
                          );
                
                          firstNameController.clear();
                          lastNameController.clear();
                          emailController.clear();
                          passwordController.clear();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      RegisterService.registerUser(
                          firstNameController: firstNameController.text,
                          lastNameController:lastNameController.text,
                          emailController: emailController.text,
                          passwordController: passwordController.text,
                          );
                
                          firstNameController.clear();
                          lastNameController.clear();
                          emailController.clear();
                          passwordController.clear();
                
                       
                    },
                    child: const Text('SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '''Already have an account?''',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    
                    onTap: () {
                      Get.to(()=>const LoginPage());
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
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
