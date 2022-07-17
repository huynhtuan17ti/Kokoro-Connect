//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:sus_app/models/models.dart';
import 'package:sus_app/services/api_service.dart';
import 'package:sus_app/validation/validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'app_pages.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      name: AppPages.signUpPath,
      key: ValueKey(AppPages.signUpPath),
      child: SignUpScreen(),
    );
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextStyle focusedStyle = const TextStyle(color: textColor, height: 1);

  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool showSpinner = false;

  @override
  void dispose() {
    userNameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  //final _auth = FirebaseAuth.instance;

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          child: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context, true);
          },
        ),
      ),
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
                const Text(
                  'Sign Up.',
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
                        'Create your account today',
                        style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                          //color: Colors.green[700],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                TextFormField(
                  autofocus: false,
                  controller: userNameController,
                  validator: (value) {
                    return Validator.validateUserName(value);
                  },
                  onSaved: (value) {
                    userNameController.text = value!;
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
                    hintText: 'Usename',
                    hintStyle: focusedStyle,
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  controller: fullNameController,
                  validator: (value) {
                    return Validator.validateFullName(value);
                  },
                  onSaved: (value) {
                    fullNameController.text = value!;
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
                    hintText: 'Full name',
                    hintStyle: focusedStyle,
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },
                  onSaved: (value) {
                    emailController.text = value!;
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
                    hintText: 'Email',
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
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return Validator.validateEmail(value);
                  },
                  onSaved: (value) {
                    phoneController.text = value!;
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
                    hintText: 'Phone',
                    hintStyle: focusedStyle,
                    prefixIcon: const Icon(
                      Icons.phone,
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
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    return Validator.confirmPassword(
                      value,
                      confirmPasswordController.text,
                      passwordController.text,
                    );
                  },
                  onSaved: (value) {
                    confirmPasswordController.text = value!;
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
                    hintText: 'Confirm password',
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
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Sign up',
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
                      signUp(emailController.text, passwordController.text);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    ApiService.signup(
      userNameController.text,
      fullNameController.text,
      emailController.text,
      phoneController.text,
      passwordController.text,
    );
    context.read<AppStateManager>().signedUp();
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     await _auth
    //         .createUserWithEmailAndPassword(email: email, password: password)
    //         .then((value) => {postDetailsToFirestore()});
    //     Provider.of<AppStateManager>(context, listen: false).register();
    //     setState(() {
    //       showSpinner = false;
    //     });
    //   } on FirebaseAuthException catch (error) {
    //     switch (error.code) {
    //       case "invalid-email":
    //         errorMessage = "Your email address appears to be malformed.";
    //         break;
    //       case "wrong-password":
    //         errorMessage = "Your password is wrong.";
    //         break;
    //       case "user-not-found":
    //         errorMessage = "User with this email doesn't exist.";
    //         break;
    //       case "user-disabled":
    //         errorMessage = "User with this email has been disabled.";
    //         break;
    //       case "too-many-requests":
    //         errorMessage = "Too many requests";
    //         break;
    //       case "operation-not-allowed":
    //         errorMessage = "Signing in with Email and Password is not enabled.";
    //         break;
    //       default:
    //         errorMessage = "An undefined Error happened.";
    //     }
    //     Fluttertoast.showToast(msg: errorMessage!);
    //     setState(() {
    //       showSpinner = false;
    //     });
    //     // ignore: avoid_print
    //     print(error.code);
    //   }
    // }
  }
}
