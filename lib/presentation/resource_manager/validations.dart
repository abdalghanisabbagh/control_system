import 'package:multi_dropdown/multiselect_dropdown.dart';

abstract class Validations {
  static bool checkEmail(String email) {
    /// Regular expression for email validation
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  static bool checkPassword(String password) {
    /// Check if the password meets the criteria
    if (password.isEmpty) {
      return false; // Password cannot be empty
    }

    /// Check password length
    if (password.length < 8) {
      return false; // Password must be at least 8 characters long
    }

    /// Check if password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false; // Password must contain at least one uppercase letter
    }

    /// Check if password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false; // Password must contain at least one lowercase letter
    }

    /// Check if password contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false; // Password must contain at least one digit
    }

    /// Check if password contains at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false; // Password must contain at least one special character
    }

    return true; // Password meets all criteria
  }

  /// MultiSelectDropDown Required Field Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? multiSelectDropDownRequiredValidator(
      List<ValueItem<dynamic>>? value) {
    if (value == null || value.isEmpty) {
      return 'Field Is Required';
    }
    return null;
  }

  /// Required Field Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? requiredValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Field  Is Required';
      }
    } else if (value == null) {
      return 'Field  Is Required';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value!.isEmpty) {
      return 'Please confirm password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Email Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter email';
    } else if (!checkEmail(value)) {
      return 'Please enter valid email';
    }
    return null;
  }

  /// Name Validator
  ///
  /// check if value is null or empty
  /// return `Please enter name` as a [String]
  /// otherwise check if value length is less than 3
  /// return `Name must be at least 3 characters long`
  /// otherwise check if value length is more than 20
  /// return `Name must be at most 20 characters long`
  /// otherwise check if value contains numbers
  /// return `Name must not contain numbers`
  /// otherwise check if value contains special characters
  /// return `Name must not contain special characters`
  /// otherwise return `null`
  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (value.length > 20) {
      return 'Name must be at most 20 characters long';
    } else if (value.contains(RegExp(r'[0-9]'))) {
      return 'Name must not contain numbers';
    } else if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Name must not contain special characters';
    }
    return null;
  }

  /// Validator for special characters
  ///
  /// check if value contains special characters
  /// return `No special characters allowed` as a [String]
  /// otherwise return `null`
  static String? validateNoSpecialCharacters(String? value) {
    if (value!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'No special characters allowed';
    }

    return null;
  }

  /// Password Validator
  ///
  /// check if value is null or empty
  /// return `Field Is Required` as a [String]
  /// otherwise return `null`
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    } else if (!checkPassword(value)) {
      return 'Please enter valid password';
    }
    return null;
  }

  /// Username Validator
  ///
  /// check if value is null or empty
  /// return `Please enter username` as a [String]
  /// otherwise check if value length is less than 3
  /// return `Username must be at least 3 characters long`
  /// otherwise check if value length is more than 20
  /// return `Username must be at most 20 characters long`
  /// otherwise check if value contains special characters
  /// return `Username must not contain special characters`
  /// otherwise return `null`
  static String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Please enter username';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    } else if (value.length > 20) {
      return 'Username must be at most 20 characters long';
    } else if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Username must not contain special characters';
    }
    return null;
  }
}
