import '../models/validator.dart';

class ValidationResult {
  final List<FinalValidator> errors;

  bool get isValid => errors.isEmpty;

  const ValidationResult({
    required this.errors,
  });

  static final ValidationResult valid = ValidationResult(errors: const []);

  factory ValidationResult.withErrors(List<FinalValidator> errors) {
    return ValidationResult(errors: errors);
  }
}
