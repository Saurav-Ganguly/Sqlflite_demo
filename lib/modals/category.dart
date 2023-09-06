class Category {
  int? id;
  final String name;
  final String description;

  Category({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> categoryMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
