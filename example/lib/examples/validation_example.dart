import 'package:flutter/material.dart';
import 'package:final_forms/final_forms.dart';

class ValidationExample extends StatelessWidget {
  const ValidationExample({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = [
      FinalFormField(
        name: 'required_field',
        type: FinalFieldType.text,
        label: 'Required Field',
        validators: [
          const FinalValidator(
            type: ValidatorType.required,
            customMessage: 'This field cannot be empty',
          ),
        ],
      ),
      FinalFormField(
        name: 'email_field',
        type: FinalFieldType.email,
        label: 'Email Validation',
        validators: [
          const FinalValidator(type: ValidatorType.email),
        ],
      ),
      FinalFormField(
        name: 'phone_field',
        type: FinalFieldType.phone,
        label: 'Phone Validation',
        validators: [
          const FinalValidator(type: ValidatorType.phone),
        ],
      ),
      FinalFormField(
        name: 'min_length_field',
        type: FinalFieldType.text,
        label: 'Min Length (5 chars)',
        validators: [
          const FinalValidator(
            type: ValidatorType.minLength,
            params: {'min': 5},
          ),
        ],
      ),
      FinalFormField(
        name: 'max_length_field',
        type: FinalFieldType.text,
        label: 'Max Length (10 chars)',
        validators: [
          const FinalValidator(
            type: ValidatorType.maxLength,
            params: {'max': 10},
          ),
        ],
      ),
      FinalFormField(
        name: 'pattern_field',
        type: FinalFieldType.text,
        label: 'Pattern (only letters)',
        hint: 'Only letters allowed',
        validators: [
          const FinalValidator(
            type: ValidatorType.pattern,
            params: {'pattern': r'^[a-zA-Z]+$'},
            customMessage: 'Only letters are allowed',
          ),
        ],
      ),
      FinalFormField(
        name: 'name_field',
        type: FinalFieldType.text,
        label: 'Name Validation',
        hint: 'Letters, spaces, hyphens, apostrophes',
        validators: [
          const FinalValidator(type: ValidatorType.name),
        ],
      ),
      FinalFormField(
        name: 'age_field',
        type: FinalFieldType.date,
        label: 'Age 18+ (dd/MM/yyyy)',
        hint: '01/01/2000',
        validators: [
          const FinalValidator(type: ValidatorType.age18),
        ],
      ),
      FinalFormField(
        name: 'custom_field',
        type: FinalFieldType.text,
        label: 'Custom Validation (must contain "test")',
        validators: [
          FinalValidator(
            type: ValidatorType.custom,
            customMessage: 'Value must contain "test"',
            customValidator: (value, params) {
              if (value == null || value is! String) return true;
              return value.toLowerCase().contains('test');
            },
          ),
        ],
      ),
    ];

    return FinalForm(
      fields: fields,
      validateOnChange: true,
      showErrorsOnlyWhenTouched: true,
      onSubmit: (data) async {
        debugPrint('Validation example data: $data');
        await Future.delayed(const Duration(seconds: 1));
      },
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All validations passed!'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
