import 'package:flutter/material.dart';

import '../models/field_type.dart';
import '../models/form_field.dart';
import '../models/validator.dart';

class DefaultTextField extends StatelessWidget {
  final FinalFormField field;
  final dynamic value;
  final void Function(dynamic) onChanged;
  final VoidCallback onBlur;
  final String? errorText;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Color? fillColor;
  final double? borderRadius;

  const DefaultTextField({
    super.key,
    required this.field,
    required this.value,
    required this.onChanged,
    required this.onBlur,
    this.errorText,
    this.decoration,
    this.prefixIcon,
    this.fillColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      labelText: field.label ?? field.name,
      hintText: field.hint,
      errorText: errorText,
      prefixIcon: prefixIcon,
      filled: fillColor != null,
      fillColor: fillColor,
      border: borderRadius != null
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: BorderSide.none,
            )
          : const OutlineInputBorder(),
    );

    return TextField(
      controller: TextEditingController(text: value?.toString() ?? '')
        ..selection = TextSelection.collapsed(
          offset: (value?.toString() ?? '').length,
        ),
      decoration: decoration ?? defaultDecoration,
      obscureText: field.type == FinalFieldType.password,
      keyboardType: _getKeyboardType(field.type),
      enabled: field.editable,
      onChanged: onChanged,
      onEditingComplete: onBlur,
    );
  }

  TextInputType _getKeyboardType(String type) {
    switch (type) {
      case FinalFieldType.email:
        return TextInputType.emailAddress;
      case FinalFieldType.phone:
        return TextInputType.phone;
      case FinalFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }
}

class DefaultCheckbox extends StatelessWidget {
  final FinalFormField field;
  final dynamic value;
  final void Function(dynamic) onChanged;
  final bool hasError;

  const DefaultCheckbox({
    super.key,
    required this.field,
    required this.value,
    required this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value == true,
          onChanged: field.editable ? (v) => onChanged(v ?? false) : null,
        ),
        Expanded(
          child: GestureDetector(
            onTap: field.editable ? () => onChanged(!(value == true)) : null,
            child: Text(
              field.label ?? field.name,
              style: TextStyle(
                color: hasError ? Colors.red : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String getDefaultErrorMessage(FinalValidator validator) {
  if (validator.customMessage != null) {
    return validator.customMessage!;
  }

  switch (validator.type.name) {
    case 'required':
      return 'This field is required';
    case 'email':
      return 'Invalid email address';
    case 'phone':
      return 'Invalid phone number';
    case 'minLength':
      return 'Minimum ${validator.params?['min'] ?? 0} characters required';
    case 'maxLength':
      return 'Maximum ${validator.params?['max'] ?? 0} characters allowed';
    case 'age18':
      return 'Must be at least 18 years old';
    case 'name':
      return 'Invalid name';
    default:
      return 'Invalid value';
  }
}
