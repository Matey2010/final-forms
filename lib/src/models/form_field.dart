import 'possible_value.dart';
import 'validator.dart';
import 'validator_type.dart';

class FinalFormField {
  final String name;
  final String type;
  final List<FinalValidator> validators;
  final List<PossibleValue>? possibleValues;
  final bool editable;
  final int order;
  final dynamic defaultValue;
  final String? label;
  final String? hint;
  final Map<String, dynamic>? metadata;

  const FinalFormField({
    required this.name,
    required this.type,
    this.validators = const [],
    this.possibleValues,
    this.editable = true,
    this.order = 0,
    this.defaultValue,
    this.label,
    this.hint,
    this.metadata,
  });

  bool get isRequired => validators.any((v) => v.type == ValidatorType.required);

  FinalFormField copyWith({
    String? name,
    String? type,
    List<FinalValidator>? validators,
    List<PossibleValue>? possibleValues,
    bool? editable,
    int? order,
    dynamic defaultValue,
    String? label,
    String? hint,
    Map<String, dynamic>? metadata,
  }) {
    return FinalFormField(
      name: name ?? this.name,
      type: type ?? this.type,
      validators: validators ?? this.validators,
      possibleValues: possibleValues ?? this.possibleValues,
      editable: editable ?? this.editable,
      order: order ?? this.order,
      defaultValue: defaultValue ?? this.defaultValue,
      label: label ?? this.label,
      hint: hint ?? this.hint,
      metadata: metadata ?? this.metadata,
    );
  }
}
