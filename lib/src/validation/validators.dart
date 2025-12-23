import '../models/form_field.dart';
import '../models/validator.dart';
import '../models/validator_type.dart';
import 'validation_result.dart';

class Validators {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegex = RegExp(
    r'^[\d\s\-\+\(\)]+$',
  );

  static final RegExp _nameRegex = RegExp(
    r"^[\p{L}\s\-']+$",
    unicode: true,
  );

  static ValidationResult validateField(
    FinalFormField field,
    dynamic value,
  ) {
    final errors = <FinalValidator>[];

    for (final validator in field.validators) {
      if (!_isValid(validator, value, field)) {
        errors.add(validator);
      }
    }

    return ValidationResult(errors: errors);
  }

  static bool _isValid(
    FinalValidator validator,
    dynamic value,
    FinalFormField field,
  ) {
    // Custom validator
    if (validator.type == ValidatorType.custom && validator.customValidator != null) {
      return validator.customValidator!(value, validator.params);
    }

    switch (validator.type) {
      case ValidatorType.required:
        return _validateRequired(value);
      case ValidatorType.email:
        return _validateEmail(value);
      case ValidatorType.phone:
        return _validatePhone(value);
      case ValidatorType.minLength:
        return _validateMinLength(value, validator.params?['min'] ?? 0);
      case ValidatorType.maxLength:
        return _validateMaxLength(value, validator.params?['max'] ?? 999999);
      case ValidatorType.pattern:
        return _validatePattern(value, validator.params?['pattern']);
      case ValidatorType.age18:
        return _validateAge18(value);
      case ValidatorType.name:
        return _validateName(value);
      case ValidatorType.custom:
        return true; // Already handled above
    }
  }

  static bool _validateRequired(dynamic value) {
    if (value == null) return false;
    if (value is String) return value.trim().isNotEmpty;
    if (value is bool) return value == true;
    return true;
  }

  static bool _validateEmail(dynamic value) {
    if (value == null || value is! String || value.isEmpty) return true;
    return _emailRegex.hasMatch(value);
  }

  static bool _validatePhone(dynamic value) {
    if (value == null || value is! String || value.isEmpty) return true;
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    return cleaned.length >= 7 && _phoneRegex.hasMatch(value);
  }

  static bool _validateMinLength(dynamic value, int min) {
    if (value == null || value is! String || value.isEmpty) return true;
    return value.length >= min;
  }

  static bool _validateMaxLength(dynamic value, int max) {
    if (value == null || value is! String) return true;
    return value.length <= max;
  }

  static bool _validatePattern(dynamic value, String? pattern) {
    if (value == null || value is! String || value.isEmpty || pattern == null) {
      return true;
    }
    return RegExp(pattern).hasMatch(value);
  }

  static bool _validateAge18(dynamic value) {
    if (value == null) return true;

    DateTime? date;

    if (value is DateTime) {
      date = value;
    } else if (value is String && value.isNotEmpty) {
      // Try parsing dd/MM/yyyy format
      final parts = value.split('/');
      if (parts.length == 3) {
        try {
          date = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } catch (_) {
          return false;
        }
      }
    } else if (value is int) {
      // Unix timestamp in milliseconds
      date = DateTime.fromMillisecondsSinceEpoch(value);
    }

    if (date == null) return true;

    final now = DateTime.now();
    final age = now.year - date.year;
    final hasHadBirthday = now.month > date.month ||
        (now.month == date.month && now.day >= date.day);

    return hasHadBirthday ? age >= 18 : age - 1 >= 18;
  }

  static bool _validateName(dynamic value) {
    if (value == null || value is! String || value.isEmpty) return true;
    return _nameRegex.hasMatch(value);
  }
}
