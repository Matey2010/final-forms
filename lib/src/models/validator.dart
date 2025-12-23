import 'validator_type.dart';

class FinalValidator {
  final ValidatorType type;
  final Map<String, dynamic>? params;
  final String? customMessage;
  final bool Function(dynamic value, Map<String, dynamic>? params)? customValidator;

  const FinalValidator({
    required this.type,
    this.params,
    this.customMessage,
    this.customValidator,
  });

  FinalValidator copyWith({
    ValidatorType? type,
    Map<String, dynamic>? params,
    String? customMessage,
    bool Function(dynamic value, Map<String, dynamic>? params)? customValidator,
  }) {
    return FinalValidator(
      type: type ?? this.type,
      params: params ?? this.params,
      customMessage: customMessage ?? this.customMessage,
      customValidator: customValidator ?? this.customValidator,
    );
  }
}
