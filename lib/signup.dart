// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_api/api_services.dart';
import 'package:testing_api/home_page.dart';
import 'package:testing_api/login.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditing = TextEditingController();
  TextEditingController passwordTextEditing = TextEditingController();
  ApiServicres apiServicres = ApiServicres();

  void signUpPost({required String emails, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiServicres.signUpUrl),
        body: {
          'email': emails,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Succesfully SignUp');
        Get.to(
          () => const LoginScreen(),
        );
      } else {
        Get.snackbar('Failed', response.statusCode.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text('Qurtuba University'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            ReusableTextFeild(textEditing: emailTextEditing, hintText: 'Email'),
            const SizedBox(
              height: 12,
            ),
            ReusableTextFeild(
                textEditing: passwordTextEditing, hintText: 'Password'),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: const Size(300, 50),
              ),
              onPressed: () {
                signUpPost(
                    emails: emailTextEditing.text,
                    password: passwordTextEditing.text);
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(() => const LoginScreen());
              },
              child: const Text('Already SignUp..?'),
            )
          ]),
    );
  }
}

class ReusableTextFeild extends StatelessWidget {
  final String hintText;
  const ReusableTextFeild(
      {Key? key, required this.textEditing, required this.hintText})
      : super(key: key);

  final TextEditingController textEditing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: textEditing,
        decoration: InputDecoration(
            hintText: hintText,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.cyan,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.cyan,
              ),
            )),
      ),
    );
  }
}
