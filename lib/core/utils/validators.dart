class Validators {

  static String? mobile(String? value) {

    if (value == null || value.isEmpty) {
      return "Enter mobile number";
    }

    if (value.length < 10) {
      return "Enter valid mobile number";
    }

    return null;
  }

  static String? mpin(String? value) {

    if (value == null || value.isEmpty) {
      return "Enter MPIN";
    }

    if (value.length < 4) {
      return "MPIN should be 4 digits";
    }

    return null;
  }
}