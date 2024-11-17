import 'package:fastporte/common/constants/id_type_configs.constant.dart';

class InputValidators {
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(r'(?=.*[A-Z])');

    return passwordRegex.hasMatch(password);
  }

  /* General validations */
  static String? validateEmail(String value) {
    String? emailError;
    value = value.trim();

    if (value.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!isValidEmail(value)) {
      emailError = 'Please enter a valid email';
    }

    return emailError;
  }

  static String? validatePassword(String value) {
    String? passwordError;

    if (value.isEmpty) {
      passwordError = 'Password cannot be empty';
    } else if (value.length < 8) {
      passwordError = 'Password must be at least 8 characters long';
    } else if (!isValidPassword(value)) {
      passwordError = 'Password must contain at least one uppercase letter';
    }

    return passwordError;
  }

  static String? validateConfirmPassword(String password, String confirmPassword) {
    String? confirmPasswordError;

    if (confirmPassword.isEmpty) {
      confirmPasswordError = 'Confirm Password cannot be empty';
    } else if (password != confirmPassword) {
      confirmPasswordError = 'Passwords do not match';
    }

    return confirmPasswordError;
  }

  static bool hasOnlyNumbers(String value) {
    final RegExp numberRegex = RegExp(r'^[0-9]+$');
    return numberRegex.hasMatch(value);
  }

  /*  Login validations */
  static String? validateLoginUsername(String value) {
    String? usernameError;

    if (value.isEmpty) {
      usernameError = 'Please enter your username';
    }

    return usernameError;
  }

  static String? validateLoginPassword(String value) {
    String? passwordError;

    if (value.isEmpty) {
      passwordError = 'Please enter your password';
    }

    return passwordError;
  }

  /* Reset password validations */

  /// [validateEmail]
  /// [validatePassword]
  /// [validateConfirmPassword]

  /* Register validations - personal information */
  static String? validateRegisterFirstName(String value) {
    String? firstNameError;

    if (value.isEmpty) {
      firstNameError = 'Please enter your first name';
    }

    return firstNameError;
  }

  static String? validateRegisterLastName(String value) {
    String? lastNamesError;

    if (value.isEmpty) {
      lastNamesError = 'Please enter your last names';
    }

    return lastNamesError;
  }

  /// [validateEmail]

  static String? validateRegisterPhoneNumber(String value) {
    String? phoneNumberError;

    if (value.isEmpty) {
      return 'Please enter your phone number';
    }

    value = value.replaceAll(' ', '');

    if (value.length < 9) {
      return 'The phone number must have 9 digits';
    }

    return phoneNumberError;
  }

  static String? validateRegisterId(String value, String selectedIdType) {
    String? idError;

    if (value.isEmpty) {
      idError = 'Please enter your id';
    } else if (value.length < IdTypeConfigs.configs[selectedIdType]!.length) {
      idError = 'The id must have ${IdTypeConfigs.configs[selectedIdType]!.length} digits';
    }

    return idError;
  }

  static String? validateRegisterBirthdate(String value) {
    String? birthdateError;

    if (value.isEmpty) {
      birthdateError = 'Please enter your birthdate';
    }

    return birthdateError;
  }

  /* Register validations - account information */
  static String? validateRegisterUsername(String value) {
    String? usernameError;

    if (value.isEmpty) {
      usernameError = 'Please enter your username';
    }

    return usernameError;
  }

  /// [validatePassword]
  /// [validateConfirmPassword]

  static String? validateRegisterDescription(String value) {
    String? descriptionError;

    if (value.isEmpty) {
      descriptionError = 'Please enter a description';
    }

    return descriptionError;
  }

  /* Request service form */
  static String? validateOrigin(String value) {
    String? originError;

    if (value.isEmpty) {
      originError = 'Please enter the origin';
    }

    return originError;
  }

  static String? validateDestination(String value) {
    String? destinationError;

    if (value.isEmpty) {
      destinationError = 'Please enter the destination';
    }

    return destinationError;
  }

  static String? validateDate(String value) {
    String? dateError;

    if (value.isEmpty) {
      dateError = 'Please enter the date';
    }

    return dateError;
  }

  static String? validateStartTime(String value) {
    String? startTimeError;

    if (value.isEmpty) {
      startTimeError = 'Please enter the start time';
    }

    return startTimeError;
  }

  static String? validateEndTime(String? start, String end) {
    String? endTimeError;

    if (end.isEmpty) {
      endTimeError = 'Please enter the end time';
    }
    //Validar que la hora de fin sea mayor a la hora de inicio - formato: HH:mm
    else if (int.parse(end.split(':')[0]) < int.parse(start!.split(':')[0]) ||
        (int.parse(end.split(':')[0]) == int.parse(start.split(':')[0]) &&
            int.parse(end.split(':')[1]) <= int.parse(start.split(':')[1]))) {
      endTimeError = 'The end time must be greater than the start time';
    }

    return endTimeError;
  }

  static String? validateAmount(String value) {
    String? amountError;

    if (value.isEmpty) {
      amountError = 'Please enter the amount';
    } else if (!hasOnlyNumbers(value)) {
      amountError = 'The amount must contain only numbers';
    } else if (int.parse(value) <= 0) {
      amountError = 'The amount must be greater than 0';
    }

    return amountError;
  }
}
