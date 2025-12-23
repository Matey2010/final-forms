import '../models/field_type.dart';
import '../models/form_field.dart';

class ValueTransformers {
  static dynamic transformForSubmit(FinalFormField field, dynamic value) {
    switch (field.type) {
      case FinalFieldType.checkbox:
        return value == true ? '1' : '0';
      case FinalFieldType.date:
        return _dateToTimestamp(value);
      default:
        return value;
    }
  }

  static Map<String, dynamic> transformAllForSubmit(
    List<FinalFormField> fields,
    Map<String, dynamic> values,
  ) {
    final result = <String, dynamic>{};

    for (final field in fields) {
      final value = values[field.name];
      result[field.name] = transformForSubmit(field, value);
    }

    return result;
  }

  static int? _dateToTimestamp(dynamic value) {
    if (value == null) return null;

    DateTime? date;

    if (value is DateTime) {
      date = value;
    } else if (value is String && value.isNotEmpty) {
      // Try parsing dd/MM/yyyy format
      final parts = value.split('/');
      if (parts.length == 3) {
        try {
          date = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } catch (_) {
          return null;
        }
      }
    } else if (value is int) {
      return value;
    }

    return date?.millisecondsSinceEpoch;
  }
}
