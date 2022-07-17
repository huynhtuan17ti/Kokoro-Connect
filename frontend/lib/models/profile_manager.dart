import 'package:flutter/cupertino.dart';

/// Review: should create a constant for anonymous user
/// E.g

// const kAnonymousUser = User(
//   uid: 'None',
//   useName: 'None',
//   fullName: 'None',
//   email: 'None',
// );

class ProfileManager extends ChangeNotifier {
  //User user = kAnonymousUser;
  //User get getUser => user;

  bool _didSelectUser = false;

  bool _darkMode = false;

  bool get didSelectUser => _didSelectUser;

  bool get darkMode => _darkMode;

  /// Review: better naming -> onProfilePressed. Why ? Because it sound like a callback
  /// that will be triggered when profile btn pressed
  void onProfilePressed(bool selected) {
    _didSelectUser = selected;

    notifyListeners();
  }

  /// Review:
  set darkMode(bool darkMode) {
    _darkMode = darkMode;

    notifyListeners();
  }

  /// Review: better naming. [getDataUser] sound like you doing an API
  /// call to get the data which is clearly not what we're doing.
  /// E.g updateUserData

}
