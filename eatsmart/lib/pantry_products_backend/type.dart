class PantryItem {
  final int id;
  final String name;
  final int count;
  final String quantity;
  final int pantry_id;

  PantryItem(this.id, this.count, this.pantry_id, {required this.name, required this.quantity});
  

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
      'pantry_id': pantry_id,
      'name': name,
      'quantity': quantity,
    };
  }
  
}

class Pantry {
  final int id;
  final String name;
  final List<PantryItem> items;

  Pantry({required this.id, required this.name, required this.items});
}
