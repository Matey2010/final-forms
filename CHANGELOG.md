## 2.0.0

### Breaking Changes

- `FinalFieldType` is now a class with static String constants instead of an enum
- Field `type` in `FinalFormField` is now `String` instead of `FinalFieldType`

### Added

- Support for custom field types - use any string value for `type`
- Example: `type: 'rating'`, `type: 'color-picker'`

### Migration

The syntax `FinalFieldType.email` still works. Most code will work without changes.
Only code using enum-specific features (`.name`, `.index`, `.values`) needs updating.

## 1.0.0

- Initial release
- FinalForm widget with customizable field builders
- Built-in validators: required, email, phone, minLength, maxLength, pattern, age18, name
- Custom validator support via `customValidator` function
- FinalFormController for programmatic form control
- Value transformers for submission data
- Complete example app with 5 different form examples
