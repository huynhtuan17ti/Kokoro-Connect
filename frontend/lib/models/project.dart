// To parse this JSON data, do
//
//     final project = projectFromJson(jsonString);

import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    required this.status,
    required this.projectList,
  });

  String status;
  List<ProjectList> projectList;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        status: json["Status"],
        projectList: List<ProjectList>.from(
            json["project_list"].map((x) => ProjectList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "project_list": List<dynamic>.from(projectList.map((x) => x.toJson())),
      };
}

class ProjectList {
  ProjectList({
    required this.projectid,
    required this.title,
    required this.author,
    required this.description,
    required this.tag,
    required this.location,
    required this.upvotes,
  });

  String projectid;
  String title;
  String author;
  String description;
  String tag;
  String location;
  int upvotes;

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
        projectid: json["projectid"],
        title: json["title"],
        author: json["author"] == null ? null : json["author"],
        description: json["description"],
        tag: json["tag"],
        location: json["location"] == null ? null : json["location"],
        upvotes: json["upvotes"],
      );

  Map<String, dynamic> toJson() => {
        "projectid": projectid,
        "title": title,
        "author": author == null ? null : author,
        "description": description,
        "tag": tag,
        "location": location == null ? null : location,
        "upvotes": upvotes,
      };
}
