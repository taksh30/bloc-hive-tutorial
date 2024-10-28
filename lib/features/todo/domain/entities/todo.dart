class Todo {
  final String id, title, description;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  Todo toggleCompletion() {
    return Todo(
      id: id,
      title: title,
      description: description,
      isCompleted: !isCompleted,
    );
  }

  Todo copyWith({String? title, String? description, bool? isCompleted}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
