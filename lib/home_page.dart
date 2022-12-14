import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_api/Models/post_model.dart';
import 'package:testing_api/Models/time_model.dart';
import 'package:testing_api/add_post_screen.dart';
import 'package:testing_api/api_services.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getAllPost() async {
    final response = await http.get(Uri.parse(ApiServicres.allPostUrl));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostModel.fromJson(i as Map<String, dynamic>));
      }

      return postList;
    } else {
      return postList;
    }
  }

  CurrentTime? currentTime;
  Future<void> getCurrentTime() async {
    final response = await http.get(
      Uri.parse(ApiServicres.timeUrl),
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      currentTime = CurrentTime.fromJson(data);
      print(currentTime!.dateTime.toString());
    } else {
      print('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Qurtuba University DashBoard'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getCurrentTime(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('milliSeconds Time :'),
                        Text(currentTime!.milliSeconds.toString() ?? 'loading'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('day : '),
                        Text(currentTime!.day.toString() ?? 'loading'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('dayOfWeek'),
                        Text(currentTime!.dayOfWeek.toString() ?? 'loading'),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getAllPost(),
              builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                if (!snapshot.hasData && snapshot.hasError) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    PostModel postModel = postList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.cyan,
                            child: Text(
                              postModel.userId.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            postModel.title.toString(),
                          ),
                          subtitle: Text(
                            postModel.body.toString(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => const AddPostScreen(),
          );
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
    );
  }
}
