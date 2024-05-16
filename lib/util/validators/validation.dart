class TValidator {
  static String? validateEmptyText(String? userName, String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên không được trống.';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được trống.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Sai định dạng email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được trống.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Mật khẩu ít nhất có 6 ký tự.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number không được trống.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Sai định dạng phone number format (10 digits required).';
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}
