// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.username,
        required this.fullname,
        required this.email,
        required this.phonenumber,
        required this.avatar,
        required this.status,
    });

    String username;
    String fullname;
    String email;
    String phonenumber;
    dynamic avatar;
    String status;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        avatar: json["avatar"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "email": email,
        "phonenumber": phonenumber,
        "avatar": avatar,
        "Status": status,
    };
}
