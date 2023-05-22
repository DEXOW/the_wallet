class Validate {
  static String? validateEmail ({required String? email}){
    if (email == null) {
      return null;
    }
    if (email.isEmpty) {
      return 'Can\'t be empty';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.replaceAll(RegExp(r'\s'),''))) {
      return 'Invalid email';
    }

    return null;
  }


  // Login validation

  static String? validateLoginPassword ({required String? password}){
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Can\'t be empty';
    } else if (password.length < 6) {
      return 'Length at least 6';
    } 
    // else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$').hasMatch(password)) {
    //   return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character';
    // }

    return null;
  }
}