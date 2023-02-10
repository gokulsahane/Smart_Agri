


class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return ' Please enter a valid Email Address.';
    } else {
      return null;
    }
  }

  static String? AddressValidate(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.][a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
       return' Please enter Address.';
    } else {
      return null;
    }
  }

  static String? DonationAmountValidate(String value) {
    Pattern pattern = r'[1-9]';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return ' Please enter Donation Amount.';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.length != 10) {
      return ' Please enter 10 digit Phone Number';
    } else {
      return null;
    }
  }

   static String? ValidatePassword(String value) {
    if (value.length != 10) {
      return ' Please enter 6 digit Password';
    } else {
      return null;
    }
  }

  static String? fullNameValidate(String fullName) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (fullName.isEmpty) {
      return 'Please enter Full Name';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter valid Full Name';
    }
    return null;
  }

   static String? OccopationValidate(String fullName) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (fullName.isEmpty) {
      return 'Please enter Occopation';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter valid Occopation';
    }
    return null;
  }

   static String? TalukaValidate(String fullName) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (fullName.isEmpty) {
      return 'Please enter Taluka';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter Valid Taluka';
    }
    return null;
  }

   static String? DistrictValidate(String fullName) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(patttern);
    if (fullName.isEmpty) {
      return 'Please enter District';
    } else if (!regExp.hasMatch(fullName)) {
      return 'Please enter Valid District';
    }
    return null;
  }

   static String? PinCodeValidate(String value) {
    if (value.length !=6 ) {
      return ' Please Enter 6 digit Pin Code';
    } else {
      return null;
    }
  }
}
