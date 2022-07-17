import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';
import 'package:sus_app/screens/post_screen.dart';

import '../utilities/project_post.dart';

List<Widget> projects = const [
  ProjectPost(
    title: "TITLE",
    author: "author",
    description: "DESCRIPTION",
    tag: "enveronment",
    location: "HCM city",
    upvotes: 10,
  ),
  ProjectPost(
    title: "TITLE",
    author: "author",
    description: "DESCRIPTION",
    tag: "enveronment",
    location: "HCM city",
    upvotes: 10,
  ),
];

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: projects[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PostScreen(),
          ),
        );
        },
        backgroundColor: textColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
