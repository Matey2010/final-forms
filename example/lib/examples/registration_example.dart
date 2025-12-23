import 'package:flutter/material.dart';
import 'package:final_forms/final_forms.dart';

class RegistrationExample extends StatelessWidget {
  const RegistrationExample({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = [
      FinalFormField(
        name: 'firstName',
        type: FinalFieldType.text,
        label: 'First Name',
        validators: [
          const FinalValidator(type: ValidatorType.required),
          const FinalValidator(type: ValidatorType.name),
        ],
      ),
      FinalFormField(
        name: 'lastName',
        type: FinalFieldType.text,
        label: 'Last Name',
        validators: [
          const FinalValidator(type: ValidatorType.required),
          const FinalValidator(type: ValidatorType.name),
        ],
      ),
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
        name: 'phone',
        type: FinalFieldType.phone,
        label: 'Phone Number',
        validators: [
          const FinalValidator(type: ValidatorType.phone),
        ],
      ),
      FinalFormField(
        name: 'birthDate',
        type: FinalFieldType.date,
        label: 'Birth Date (dd/MM/yyyy)',
        hint: '01/01/1990',
        validators: [
          const FinalValidator(type: ValidatorType.required),
          const FinalValidator(type: ValidatorType.age18),
        ],
      ),
      FinalFormField(
        name: 'country',
        type: FinalFieldType.select,
        label: 'Country',
        possibleValues: [
          const PossibleValue(value: 'us', title: 'United States'),
          const PossibleValue(value: 'uk', title: 'United Kingdom'),
          const PossibleValue(value: 'de', title: 'Germany'),
        ],
        validators: [
          const FinalValidator(type: ValidatorType.required),
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
            params: {'min': 8},
          ),
        ],
      ),
      FinalFormField(
        name: 'acceptTerms',
        type: FinalFieldType.checkbox,
        label: 'I accept the Terms and Conditions',
        validators: [
          const FinalValidator(type: ValidatorType.required),
        ],
      ),
    ];

    return FinalForm(
      fields: fields,
      onSubmit: (data) async {
        debugPrint('Registration data: $data');
        await Future.delayed(const Duration(seconds: 2));
      },
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      },
    );
  }
}
