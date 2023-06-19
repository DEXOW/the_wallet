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

  // Register validation

  static String? validateRegName ({required String? name}){
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Can\'t be empty';
    } else if (name.length < 2) {
      return 'Length at least 2';
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      return 'Invalid name';
    }

    return null;
  }

  static String? validateRegPassword ({required String? password}){
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Can\'t be empty';
    } else if (password.length < 6) {
      return 'Length at least 6';
    // } 
    // else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])$').hasMatch(password)) {
    //   return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)){
      return 'At least 1 uppercase letter';
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(password)){
      return 'At least 1 lowercase letter';
    } else if (!RegExp(r'(?=.*\d)').hasMatch(password)){
      return 'At least 1 digit';
    } else if (!RegExp(r'(?=.*\W)').hasMatch(password)){
      return 'At least 1 special character';
    }

    return null;
  }

  static String? validateRegConfPassword ({required String? password, required String? confPassword}){
    if (confPassword == null) {
      return null;
    }
    if (confPassword.isEmpty) {
      return 'Can\'t be empty';
    } else if (confPassword != password) {
      return 'Must be the same as password';
    }

    return null;
  }

  static String? validatePhoneNo ({required String? phoneNo}){
    if (phoneNo == null) {
      return null;
    }
    if (phoneNo.isEmpty) {
      return 'Can\'t be empty';
    } else if (!RegExp(r'^(0|)\d{9}$').hasMatch(phoneNo)) {
      return 'Invalid number';
    }
    return null;
  }
}