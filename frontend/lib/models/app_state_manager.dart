import 'dart:async';

import 'package:flutter/material.dart';

class AppTab {
  /// Review: Better naming
  static const int home = 0;
  static const int search = 1;
  static const int post = 2;
  static const int notify = 3;
}

enum AppState {
  none,
  initialize,
  logIn,
  signUp,
  resetPass,
  home,
}

class AppStateManager extends ChangeNotifier {
  /// Review: can use enum instead of a bunch of bool
  /// E.g : [AppState]

  AppState _appState = AppState.initialize;

  AppState get currentAppState => _appState;

  int _selectedTab = AppTab.home;

  /// Review; if the code above use one enum to describe
  /// current app state then you can reduce number of
  /// getter here.

  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    Timer(
      const Duration(seconds: 2),
      () {
        _appState = AppState.logIn;

        notifyListeners();
      },
    );
  }

  void loggedIn() {
    _appState = AppState.home;

    notifyListeners();
  }

  void signUp(bool value) {
    if (value) {
      _appState = AppState.signUp;
    } else {
      _appState = AppState.logIn;
    }
    notifyListeners();
  }

  void signedUp() {
    _appState = AppState.home;

    notifyListeners();
  }

  void resetPass(bool value) {
    if (value) {
      _appState = AppState.resetPass;
    } else {
      _appState = AppState.logIn;
    }

    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;

    notifyListeners();
  }

  void logout() {
    _selectedTab = AppTab.home;
    _appState = AppState.initialize;

    // Review: [initializeApp] will call notifyListener 2 seconds later.
    // What the point of the next [notifyListeners] call ?
    initializeApp();
  }
}
