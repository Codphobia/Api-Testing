import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_api/api_services.dart';
import 'package:testing_api/home_page.dart';
import 'package:testing_api/signup.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditing = TextEditingController();
  TextEditingController passwordTextEditing = TextEditingController();
  bool isLogin = false;
  void loginPost(String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse(
            ApiServicres.loginUrl,
          ),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Succesfully SignUp');
        Get.to(() => const HomePageScreen());
      } else {
        Get.snackbar('Failed', response.statusCode.toString());
      }
    } catch (e) {
      print(e.toString());
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
              'Login ',
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
                loginPost(emailTextEditing.text, passwordTextEditing.text);
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(() => const SignUpScreen());
              },
              child: const Text('Want to Login..?'),
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
