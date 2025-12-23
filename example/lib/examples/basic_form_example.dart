import 'package:flutter/material.dart';
import 'package:final_forms/final_forms.dart';

class BasicFormExample extends StatelessWidget {
  const BasicFormExample({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = [
      FinalFormField(
        name: 'email',
        type: FinalFieldType.email,
        label: 'Email Address',
        validators: [
          const FinalValidator(type: ValidatorType.required),
          const FinalValidator(type: ValidatorType.email),
        ],
      ),
      FinalFormField(
        name: 'password',
        type: FinalFieldType.password,
        label: 'Password',
        validators: [
          const FinalValidator(type: ValidatorType.required),
          const FinalValidator(
            type: ValidatorType.minLength,
            params: {'min': 6},
          ),
        ],
      ),
    ];

    return FinalForm(
      fields: fields,
      onSubmit: (data) async {
        debugPrint('Submitted: $data');
        await Future.delayed(const Duration(seconds: 1));
      },
      onSuccess: () => debugPrint('Success!'),
      onError: (e) => debugPrint('Error: $e'),
    );
  }
}
