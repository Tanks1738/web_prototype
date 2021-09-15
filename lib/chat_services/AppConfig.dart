class AppConfig {
  static const APP_ID = '<2593bb203bd8cdb36944a71d074a16ca0 >';

  static bool isValidEmail(String emailId) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailId);
  }
}