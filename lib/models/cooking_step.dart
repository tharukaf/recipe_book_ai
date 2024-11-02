class Ingredient {
  int id;
  String name;
  double quantity;
  String? unit;
  bool isDone;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isDone,
  });

  // Ingredient to Json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'isDone': isDone,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'].toDouble() ?? 0.0,
      unit: map['unit'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
}
