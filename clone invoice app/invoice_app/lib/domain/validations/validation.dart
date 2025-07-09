
class Validation {
  static bool emailValidation(String email) {
    RegExp regExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
    );

    bool hasMatch = regExp.hasMatch(email);

    return hasMatch;
  }

  static bool passwordValidation(String password) {
    RegExp regExp =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');

    bool hasMatch = regExp.hasMatch(password);
    return hasMatch;
  }
}
