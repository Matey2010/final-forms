/// Field type constants for form fields.
///
/// Use these predefined constants or any custom string value.
/// Example: `type: FinalFieldType.email` or `type: 'custom-rating'`
class FinalFieldType {
  static const String text = 'text';
  static const String password = 'password';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String date = 'date';
  static const String select = 'select';
  static const String checkbox = 'checkbox';

  // Private constructor prevents instantiation
  FinalFieldType._();
}
