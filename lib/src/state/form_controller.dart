import 'package:flutter/foundation.dart';

import '../models/form_field.dart';
import '../models/validator.dart';
import '../validation/validation_result.dart';
import '../validation/validators.dart';

class FinalFormController extends ChangeNotifier {
  final List<FinalFormField> fields;
  final bool validateOnChange;
  final bool showErrorsOnlyWhenTouched;

  final Map<String, dynamic> _values = {};
  final Map<String, ValidationResult> _validationResults = {};
  final Set<String> _touchedFields = {};
  bool _isLoading = false;

  FinalFormController({
    required this.fields,
    Map<String, dynamic>? initialValues,
    this.validateOnChange = true,
    this.showErrorsOnlyWhenTouched = true,
  }) {
    _initializeValues(initialValues);
  }

  void _initializeValues(Map<String, dynamic>? initialValues) {
    for (final field in fields) {
      if (initialValues != null && initialValues.containsKey(field.name)) {
        _values[field.name] = initialValues[field.name];
      } else if (field.defaultValue != null) {
        _values[field.name] = field.defaultValue;
      }
    }
  }

  // Getters
  bool get isLoading => _isLoading;

  bool get isValid {
    for (final field in fields) {
      final result = Validators.validateField(field, _values[field.name]);
      if (!result.isValid) return false;
    }
    return true;
  }

  Set<String> get fieldNames => fields.map((f) => f.name).toSet();

  Map<String, dynamic> get values => Map.unmodifiable(_values);

  // Field operations
  dynamic getValue(String fieldName) => _values[fieldName];

  void setValue(String fieldName, dynamic value) {
    _values[fieldName] = value;

    if (validateOnChange) {
      _validateField(fieldName);
    }

    notifyListeners();
  }

  List<FinalValidator> getErrors(String fieldName) {
    if (showErrorsOnlyWhenTouched && !_touchedFields.contains(fieldName)) {
      return [];
    }
    return _validationResults[fieldName]?.errors ?? [];
  }

  bool isTouched(String fieldName) => _touchedFields.contains(fieldName);

  void markTouched(String fieldName) {
    _touchedFields.add(fieldName);
    _validateField(fieldName);
    notifyListeners();
  }

  void _validateField(String fieldName) {
    final field = fields.firstWhere(
      (f) => f.name == fieldName,
      orElse: () => throw ArgumentError('Field $fieldName not found'),
    );
    _validationResults[fieldName] = Validators.validateField(
      field,
      _values[fieldName],
    );
  }

  bool validateAll() {
    bool allValid = true;

    for (final field in fields) {
      _touchedFields.add(field.name);
      final result = Validators.validateField(field, _values[field.name]);
      _validationResults[field.name] = result;
      if (!result.isValid) allValid = false;
    }

    notifyListeners();
    return allValid;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void reset() {
    _values.clear();
    _validationResults.clear();
    _touchedFields.clear();
    _isLoading = false;
    _initializeValues(null);
    notifyListeners();
  }

}
