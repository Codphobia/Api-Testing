import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testing_api/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:testing_api/api_services.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController nameTextEditing = TextEditingController();
  TextEditingController jobTextEditing = TextEditingController();
  UserModel? user;

  Future<UserModel> addPost({required String name, required String job}) async {
    http.Response response = await http.post(Uri.parse(ApiServicres.addPostUrl),
        body: {'name': name, 'job': job});
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data['name']);

      return UserModel.fromJson(data);
    }
    return UserModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Qurtuba University DashBoard'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Add Post',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          ReusableTextFeild(textEditing: nameTextEditing, hintText: 'Name'),
          const SizedBox(
            height: 12,
          ),
          ReusableTextFeild(textEditing: jobTextEditing, hintText: 'Job'),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              fixedSize: const Size(300, 50),
            ),
            onPressed: () async {
              UserModel users = await addPost(
                  name: nameTextEditing.text.trim(),
                  job: jobTextEditing.text.trim());
              setState(() {
                user = users;
              });
            },
            child: const Text('Add'),
          ),
          const SizedBox(
            height: 12,
          ),
          user == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Text(user!.name.toString()),
                    Text(user!.job.toString()),
                  ],
                )
        ],
      ),
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
