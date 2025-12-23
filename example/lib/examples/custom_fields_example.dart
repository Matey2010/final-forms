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
        switch (field.type) {
          case FinalFieldType.email:
            return _buildEmailField(field, value, errors, onChanged, onBlur);
          case FinalFieldType.password:
            return _buildPasswordField(field, value, errors, onChanged, onBlur);
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

  Widget _buildEmailField(
    FinalFormField field,
    dynamic value,
    List<FinalValidator> errors,
    void Function(dynamic) onChanged,
    VoidCallback onBlur,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${field.label} (Custom Email Field)',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: onChanged,
            onEditingComplete: onBlur,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email, color: Colors.blue),
              filled: true,
              fillColor: Colors.blue.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              errorText: errors.isNotEmpty ? 'Invalid email' : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    FinalFormField field,
    dynamic value,
    List<FinalValidator> errors,
    void Function(dynamic) onChanged,
    VoidCallback onBlur,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${field.label} (Custom Password Field)',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            obscureText: true,
            onChanged: onChanged,
            onEditingComplete: onBlur,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock, color: Colors.purple),
              filled: true,
              fillColor: Colors.purple.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              errorText: errors.isNotEmpty ? 'Password must be at least 6 characters' : null,
            ),
          ),
        ],
      ),
    );
  }
}
