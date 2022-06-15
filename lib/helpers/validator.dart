class Validator {

  static String? validateMail(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp  = RegExp(pattern);

    return regExp.hasMatch(value ?? '') ? null : 'The value entered does not look like a mail';
  }

  static String? validatePassword(String? value) {
    return (value != null && value.length >= 6) 
      ? null
      : 'The password must be at least 6 characters';
  }

  static String? validateName(String? value) {
    return (value != null && value.length >= 2) 
      ? null
      : 'The name must be at least 2 characters';
  }

  static String? validateLastName(String? value) {
    return (value != null && value.length >= 2) 
      ? null
      : 'The last name must be at least 2 characters';
  }

}