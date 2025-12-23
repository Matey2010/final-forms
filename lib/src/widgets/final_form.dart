import 'package:flutter/material.dart';

import '../models/field_type.dart';
import '../models/form_field.dart';
import '../models/validator.dart';
import '../state/form_controller.dart';
import 'default_field.dart';

typedef FieldBuilder = Widget? Function(
  BuildContext context,
  FinalFormField field,
  dynamic value,
  List<FinalValidator> errors,
  void Function(dynamic value) onChanged,
  VoidCallback onBlur,
  FinalFormController controller,
);

typedef SubmitButtonBuilder = Widget Function(
  BuildContext context,
  bool isLoading,
  bool isValid,
  VoidCallback submit,
);

typedef ErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
);

class FinalForm extends StatefulWidget {
  final List<FinalFormField> fields;
  final Future<void> Function(Map<String, dynamic> data) onSubmit;
  final VoidCallback? onSuccess;
  final void Function(Object error)? onError;
  final FieldBuilder? fieldBuilder;
  final SubmitButtonBuilder? submitButtonBuilder;
  final ErrorBuilder? errorBuilder;
  final Map<String, dynamic>? initialValues;
  final bool validateOnChange;
  final bool showErrorsOnlyWhenTouched;

  const FinalForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.onSuccess,
    this.onError,
    this.fieldBuilder,
    this.submitButtonBuilder,
    this.errorBuilder,
    this.initialValues,
    this.validateOnChange = true,
    this.showErrorsOnlyWhenTouched = true,
  });

  @override
  State<FinalForm> createState() => _FinalFormState();
}

class _FinalFormState extends State<FinalForm> {
  late FinalFormController _controller;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _controller = FinalFormController(
      fields: widget.fields,
      initialValues: widget.initialValues,
      validateOnChange: widget.validateOnChange,
      showErrorsOnlyWhenTouched: widget.showErrorsOnlyWhenTouched,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_controller.isLoading) return;

    setState(() => _error = null);

    if (!_controller.validateAll()) return;

    _controller.setLoading(true);

    try {
      await widget.onSubmit(_controller.values);
      widget.onSuccess?.call();
    } catch (e) {
      setState(() => _error = e);
      widget.onError?.call(e);
    } finally {
      if (mounted) {
        _controller.setLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...widget.fields.map(_buildField),
            if (_error != null) _buildError(),
            const SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        );
      },
    );
  }

  Widget _buildField(FinalFormField field) {
    final value = _controller.getValue(field.name);
    final errors = _controller.getErrors(field.name);

    void onChanged(dynamic newValue) {
      _controller.setValue(field.name, newValue);
    }

    void onBlur() {
      _controller.markTouched(field.name);
    }

    if (widget.fieldBuilder != null) {
      final customWidget = widget.fieldBuilder!(
        context,
        field,
        value,
        errors,
        onChanged,
        onBlur,
        _controller,
      );
      if (customWidget != null) return customWidget;
    }

    return _buildDefaultField(field, value, errors, onChanged, onBlur);
  }

  Widget _buildDefaultField(
    FinalFormField field,
    dynamic value,
    List<FinalValidator> errors,
    void Function(dynamic) onChanged,
    VoidCallback onBlur,
  ) {
    final hasError = errors.isNotEmpty;
    final errorText = hasError ? getDefaultErrorMessage(errors.first) : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: field.type == FinalFieldType.checkbox
          ? DefaultCheckbox(
              field: field,
              value: value,
              onChanged: onChanged,
              hasError: hasError,
            )
          : DefaultTextField(
              field: field,
              value: value,
              onChanged: onChanged,
              onBlur: onBlur,
              errorText: errorText,
            ),
    );
  }

  Widget _buildError() {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(context, _error!);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        _error.toString(),
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildSubmitButton() {
    if (widget.submitButtonBuilder != null) {
      return widget.submitButtonBuilder!(
        context,
        _controller.isLoading,
        _controller.isValid,
        _submit,
      );
    }

    return ElevatedButton(
      onPressed: _controller.isLoading ? null : _submit,
      child: _controller.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Submit'),
    );
  }
}
