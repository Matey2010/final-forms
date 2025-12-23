# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FinalForms is a standalone Flutter form package with validation, custom field builders, and programmatic control. Zero external dependencies—only requires Flutter SDK.

## Common Commands

```bash
# Run the example app
cd example && flutter run

# Analyze code for issues
flutter analyze

# Run tests
cd example && flutter test

# Format code
dart format .

# Get dependencies (run from both root and example/)
flutter pub get
```

## Architecture

**Multi-package structure:**
- `lib/` - Main library code (public API at `lib/final_forms.dart`)
- `example/` - Demo app with 5 form examples

**Core components in `lib/src/`:**

| Directory | Purpose |
|-----------|---------|
| `models/` | `FinalFormField`, `FinalValidator`, field types, validator types |
| `widgets/` | `FinalForm` - main stateful widget |
| `state/` | `FinalFormController` - state management via `ChangeNotifier` |
| `validation/` | `Validators` class with 8 built-in validators + custom support |
| `utils/` | `ValueTransformers` for submission data transformation |

**State flow:**
1. `FinalForm` widget creates/uses `FinalFormController`
2. Controller extends `ChangeNotifier` and tracks field values, errors, touched state
3. Widget uses `ListenableBuilder` for reactive updates
4. Validation runs on change (configurable) and before submission

**Built-in validators:** required, email, phone, minLength, maxLength, pattern, age18, name, custom

**Field types:** String-based (v2.0+). Built-in constants: `FinalFieldType.text`, `.password`, `.email`, `.phone`, `.date`, `.select`, `.checkbox`. Custom types supported via any string value.

## SDK Requirements

- Dart: >=3.0.0 <4.0.0
- Flutter: >=3.10.0
