class Validator {
  static String? validatePassword(String? value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return ("Password is required for login");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
    return null;
  }

  static String? confirmPassword(
      String? value, String confirmPassword, String password) {
    if (confirmPassword != password) {
      return "Password don't match";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return ("Please Enter Your Email");
    }
    // reg expression for email validation
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  }

  static String? validateUserName(String? value) {
    RegExp regex = RegExp(r'^.{2,}$');
    if (value!.isEmpty) {
      return ("User name cannot be Empty");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid name(Min: 2 Characters)");
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return ("Full name cannot be Empty");
    }
    return null;
  }
}
