

class FieldListItem {
  final String label;
  final String fieldType;
  final List<String>? enumValues; // For enum type fields

  FieldListItem({
    required this.label,
    required this.fieldType,
    this.enumValues, // Optional, only needed for enum types
  });
}