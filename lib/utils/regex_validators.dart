class RegexValidators {
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp passwordRegExp = RegExp(
    r"""^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@()$%^&*=_{}[\]:;\"'|\\<>,.\/~`±§+-]).{8,30}$""",
  );

  static final RegExp urlRegExp = RegExp(
    r'^(.*?)((?:https?:\/\/|www\.)[^\s/$.?#].[^\s]*)',
  );

  static bool isValidEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return passwordRegExp.hasMatch(password);
  }

  static bool isValidUrl(String text) {
    return urlRegExp.hasMatch(text);
  }
}
