# FinalForms

A standalone, reusable Flutter form package with validation, custom field builders, and programmatic control. Zero external dependencies.

## Features

- **Declarative Form Definition** - Define forms with a simple list of field configurations
- **Built-in Validators** - Required, email, phone, minLength, maxLength, pattern, age18, name
- **Custom Validators** - Add your own validation logic with custom functions
- **Custom Field Builders** - Override default UI with your own widgets
- **Programmatic Control** - Access form state via `FinalFormController`
- **Value Transformers** - Transform values before submission (e.g., dates to timestamps)
- **Zero Dependencies** - Only depends on Flutter SDK

## Installation

```yaml
dependencies:
  final_forms: ^1.0.0
```

Or run:

```bash
flutter pub add final_forms
```

## Usage

### Basic Form

```dart
import 'package:final_forms/final_forms.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fields = [
      FinalFormField(
        name: 'email',
        type: FinalFieldType.email,
        label: 'Email',
        validators: [
          FinalValidator(type: ValidatorType.required),
          FinalValidator(type: ValidatorType.email),
        ],
      ),
      FinalFormField(
        name: 'password',
        type: FinalFieldType.password,
        label: 'Password',
        validators: [
          FinalValidator(type: ValidatorType.required),
          FinalValidator(type: ValidatorType.minLength, params: {'min': 6}),
        ],
      ),
    ];

    return FinalForm(
      fields: fields,
      onSubmit: (data) async {
        print('Form data: $data');
        // Call your API
      },
      onSuccess: () => print('Success!'),
      onError: (e) => print('Error: $e'),
    );
  }
}
```

### Custom Field Builders

```dart
FinalForm(
  fields: fields,
  onSubmit: (data) async => submitForm(data),
  fieldBuilder: (context, field, value, errors, onChanged, onBlur, controller) {
    // Return your custom widget
    return MyCustomTextField(
      label: field.label,
      value: value,
      error: errors.isNotEmpty ? errors.first.customMessage : null,
      onChanged: onChanged,
    );
  },
  submitButtonBuilder: (context, isLoading, isValid, submit) {
    return ElevatedButton(
      onPressed: isLoading ? null : submit,
      child: isLoading ? CircularProgressIndicator() : Text('Submit'),
    );
  },
);
```

## Field Types

- `FinalFieldType.text` - Text input
- `FinalFieldType.password` - Password input (obscured)
- `FinalFieldType.email` - Email input with email keyboard
- `FinalFieldType.phone` - Phone input with phone keyboard
- `FinalFieldType.date` - Date input
- `FinalFieldType.select` - Dropdown select
- `FinalFieldType.checkbox` - Checkbox

## Validators

| Type | Description | Params |
|------|-------------|--------|
| `required` | Field must have a value | - |
| `email` | Valid email format | - |
| `phone` | Valid phone format | - |
| `minLength` | Minimum string length | `{'min': int}` |
| `maxLength` | Maximum string length | `{'max': int}` |
| `pattern` | Regex pattern match | `{'pattern': String}` |
| `age18` | Must be 18+ years old | - |
| `name` | Valid name (letters, spaces, hyphens) | - |
| `custom` | Custom validation function | - |

### Custom Validator Example

```dart
FinalValidator(
  type: ValidatorType.custom,
  customMessage: 'Must contain "test"',
  customValidator: (value, params) {
    if (value == null || value is! String) return true;
    return value.toLowerCase().contains('test');
  },
)
```

## FinalFormController

Access the form controller for programmatic control:

```dart
// Get field value
controller.getValue('email');

// Set field value
controller.setValue('email', 'test@example.com');

// Check if form is valid
controller.isValid;

// Check if form is loading
controller.isLoading;

// Get field errors
controller.getErrors('email');

// Reset form
controller.reset();
```

## Example App

See the [example](example/) directory for a complete example app with multiple form examples.

## License

MIT License - see [LICENSE](LICENSE) for details.
