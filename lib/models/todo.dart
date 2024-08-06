class Todo {
  final int? id;
  final String title;
  final bool isComplete;

  Todo({
    this.id,
    required this.title,
    required this.isComplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isComplete': isComplete ? 1 : 0,
    };
  }
}
