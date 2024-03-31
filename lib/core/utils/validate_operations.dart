import 'package:flutter/foundation.dart' show immutable;
import 'package:fridge/core/resources/app_strings.dart';

@immutable
class ValidateOperations {
  const ValidateOperations._();

  static normalValidation(
      dynamic value,
      ) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }
}