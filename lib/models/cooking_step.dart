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
}
