class PossibleValue {
  final String value;
  final String? title;

  const PossibleValue({
    required this.value,
    this.title,
  });

  String get displayTitle => title ?? value;
}
