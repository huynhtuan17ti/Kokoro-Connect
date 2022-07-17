import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/project.dart';
import '../models/user.dart';

const homeScreenUrl = 'http://192.168.8.102:8000/api/home-screen';
const logInUrl = 'http://192.168.8.102:8000/api/login/';
const postUrl = 'http://192.168.8.102:8000/api/post-screen/';
const profileUrl = 'http://192.168.8.102:8000/api/profile-screen/';
const searchUrl = 'http://192.168.8.102:8000/api/search/';
const logoutUrl = 'http://192.168.8.102:8000/api/logout/';
const signupUrl = 'http://192.168.8.102:8000/api/signup/';

var client = http.Client();

var kAnonymousProjectList = ProjectList(
  projectid: "",
  title: "",
  author: "",
  description: "",
  tag: "",
  location: "",
  upvotes: -1,
);
var kAnonymousProject = Project(
  status: "",
  projectList: [kAnonymousProjectList],
);

String sessionId = "";
String userId = "";

class ApiService {
  static Future<Project> getProjectData() async {
    var response = await client.get(Uri.parse(homeScreenUrl));

    if (response.statusCode != 200) {
      return kAnonymousProject;
    }

    if (response == null) {
      return kAnonymousProject;
    }

    //print(response.body);

    return projectFromJson(response.body);
  }

  static logIn(String username, String password) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode({"username": username, "password": password});
    var response = await client.post(
      Uri.parse(logInUrl),
      headers: headers,
      body: body,
    );
    var json = jsonDecode(response.body);

    sessionId = json["SessionID"];
    userId = json["UserInfo"]["userid"];
  }

  static post(
    String title,
    String description,
    String tag,
    String location,
    int upvotes,
  ) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode({
      "title": title,
      "author": userId,
      "description": description,
      "tag": tag,
      "location": location,
      "upvotes": upvotes,
    });
    var response = await client.post(
      Uri.parse(postUrl),
      headers: headers,
      body: body,
    );
  }

  static Future<User> profile() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "sessionid": sessionId,
      "userid": userId
    };
    var response = await client.get(Uri.parse(profileUrl), headers: headers);

    return userFromJson(response.body);
  }

  static Future<Project> search(String tag) async {
    var response = await client.get(Uri.parse('$searchUrl$tag/'));

    return projectFromJson(response.body);
  }

  static logout() async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode({"userid": userId, "sessionid": sessionId});
    var response = await client.post(
      Uri.parse(logoutUrl),
      headers: headers,
      body: body,
    );
  }

  static signup(
    String username,
    String fullname,
    String email,
    String phone,
    String password,
  ) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode({
      "username": username,
      "fullname": fullname,
      "email": email,
      "phone": phone,
      "password": password,
    });
    var response = await client.post(
      Uri.parse(signupUrl),
      headers: headers,
      body: body,
    );
  }
}
