import 'package:flutter/material.dart';
import 'package:final_forms/final_forms.dart';

class LoginExample extends StatelessWidget {
  const LoginExample({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = [
      FinalFormField(
        name: 'email',
        type: FinalFieldType.email,
        label: 'Email',
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
        ],
      ),
      FinalFormField(
        name: 'rememberMe',
        type: FinalFieldType.checkbox,
        label: 'Remember me',
        defaultValue: false,
      ),
    ];

    return FinalForm(
      fields: fields,
      onSubmit: (data) async {
        debugPrint('Login data: $data');
        await Future.delayed(const Duration(seconds: 1));
      },
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      },
      onError: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      },
    );
  }
}
