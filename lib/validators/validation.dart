class Validation {
  static bool isValidName(String name) {
    return name != null && name.length > 5;
  }

  static bool isValidPhone(String phone) {
    return RegExp(r"([0]{1}[235789]{1}[0-9]{8})").hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool isValidInput(String str) {
    return str != null && str.length > 0;
  }
}
