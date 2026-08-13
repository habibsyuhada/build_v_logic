class ValidationResult {
  final List<String> errors;
  final List<String> warnings;

  const ValidationResult({this.errors = const [], this.warnings = const []});

  bool get isValid => errors.isEmpty;

  static const ValidationResult ok = ValidationResult();

  ValidationResult merge(ValidationResult other) => ValidationResult(
        errors: [...errors, ...other.errors],
        warnings: [...warnings, ...other.warnings],
      );

  factory ValidationResult.error(String message) =>
      ValidationResult(errors: [message]);

  factory ValidationResult.warning(String message) =>
      ValidationResult(warnings: [message]);
}
