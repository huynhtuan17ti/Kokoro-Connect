import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';
import 'package:sus_app/screens/screens.dart';
import '../models/project.dart';
import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextStyle focusedStyle = const TextStyle(color: textColor, height: 1);
  final String tag = 'Search';
  String dropdownValue = 'people';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.expand_more),
            elevation: 16,
            style: const TextStyle(color: textColor),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                // send value to server
              });
            },
            items: <String>['people', 'environment', 'animal']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: textColor,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<Project>(
              future: ApiService.search(dropdownValue),
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
                      return buildProjectList(project.projectList);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


