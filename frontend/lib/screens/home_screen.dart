import 'package:flutter/material.dart';
import 'package:sus_app/models/project.dart';
import 'package:sus_app/services/api_service.dart';

import '../utilities/project_post.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Project>(
      future: ApiService.getProjectData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text('Some errors occurred!'),
              );
            } else {
              final Project project = snapshot.data;
              return RefreshIndicator(
                onRefresh: () {
                  return Future(() { setState(() {}); });
                },
                child: buildProjectList(project.projectList),
              );
            }
        }
      },
    );
  }
}

Widget buildProjectList(List<ProjectList> projects) {
  return SizedBox(
    height: double.infinity,
    width: double.infinity,
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ProjectPost(
            title: projects[index].title,
            author: projects[index].author,
            description: projects[index].description,
            tag: projects[index].tag,
            location: projects[index].location,
            upvotes: projects[index].upvotes,
          ),
        );
      },
    ),
  );
}
