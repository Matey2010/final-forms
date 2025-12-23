import 'package:flutter/material.dart';
import 'package:final_forms/final_forms.dart';

class CustomFieldsExample extends StatelessWidget {
  const CustomFieldsExample({super.key});

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
        debugPrint('Custom form data: $data');
        await Future.delayed(const Duration(seconds: 1));
      },
      fieldBuilder: (context, field, value, errors, onChanged, onBlur, controller) {
        final errorText = errors.isNotEmpty ? getDefaultErrorMessage(errors.first) : null;

        switch (field.type) {
          case FinalFieldType.email:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DefaultTextField(
                field: field,
                value: value,
                onChanged: onChanged,
                onBlur: onBlur,
                errorText: errorText,
                prefixIcon: const Icon(Icons.email, color: Colors.blue),
                fillColor: Colors.blue.withValues(alpha: 0.1),
                borderRadius: 12,
              ),
            );
          case FinalFieldType.password:
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DefaultTextField(
                field: field,
                value: value,
                onChanged: onChanged,
                onBlur: onBlur,
                errorText: errorText,
                prefixIcon: const Icon(Icons.lock, color: Colors.purple),
                fillColor: Colors.purple.withValues(alpha: 0.1),
                borderRadius: 12,
              ),
            );
          default:
            return null;
        }
      },
      submitButtonBuilder: (context, isLoading, isValid, submit) {
        return ElevatedButton(
          onPressed: isLoading ? null : submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: isValid ? Colors.green : Colors.grey,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Custom Submit Button'),
        );
      },
    );
  }
}
