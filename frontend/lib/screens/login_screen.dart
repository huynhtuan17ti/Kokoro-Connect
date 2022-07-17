//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sus_app/colors/colors.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:sus_app/models/models.dart';
import 'package:sus_app/services/api_service.dart';
import 'package:sus_app/validation/validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'app_pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      name: AppPages.loginPath,
      key: ValueKey(AppPages.loginPath),
      child: LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextStyle focusedStyle = const TextStyle(color: textColor, height: 1);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showSpinner = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Review: consider using Widget instead of Function.
                /// Cons:
                /// 1. Re-useable widgets
                /// 2. Avoid debug problems when finding specific component
                const SizedBox(height: 60),
                const Text(
                  'Log in.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Welcome back! Login with your data that you entered during registration',
                        style: TextStyle(
                          fontSize: 18,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                TextFormField(
                  autofocus: false,
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    /// Review: should have an utility to do the validation in order to
                    /// seperate logics with views
                    //return Validator.validateEmail(value);
                  },
                  onSaved: (value) {
                    usernameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  cursorColor: textColor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2,
                      ),
                    ),
                    hintText: 'Username',
                    hintStyle: focusedStyle,
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    /// Review: should have an utility to do the validation in order to
                    /// seperate logics with views
                    return Validator.validatePassword(value);
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  cursorColor: textColor,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2,
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: focusedStyle,
                    prefixIcon: const Icon(
                      Icons.vpn_key,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 55,
                  child: MaterialButton(
                    color: textColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        showSpinner = true;
                      });

                      /// Review: should trim your email and password to prevent empty characters
                      /// This usually happen when user use quick suggestion on real devices.
                      signIn(
                        usernameController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  child: MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: textColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Don\'t have an account, Sign Up here',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () async {
                      context.read<AppStateManager>().signUp(true);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.read<AppStateManager>().resetPass(true);
                  },
                  child: const Text(
                    'Forgot password ?',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String username, String password) async {
    try {
      await ApiService.logIn(username, password);
      context.read<AppStateManager>().loggedIn();
    } catch (e) {
      Fluttertoast.showToast(msg: "Cannot login!");
      setState(() {
        showSpinner = false;
      });
    }
  }
}
