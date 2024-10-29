class Ingredient {
  int id;
  String name;
  double quantity;
  String? unit;
  String? preparation;
  bool isDone;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isDone,
  });

  // Ingredient to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'preparation': preparation,
      'isDone': isDone,
    };
  }
}
