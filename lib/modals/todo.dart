class Todos {
  int? id;
  final String title;
  final String description;
  final String category;
  final String todoDate;
  final int isFinished;

  Todos({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.todoDate,
    required this.isFinished,
  });

  Map<String, dynamic> todoMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'todoDate': todoDate,
      'isFinished': isFinished,
    };
  }
}
