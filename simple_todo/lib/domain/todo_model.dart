class TodoModel {
  final String id;
  final String title;
  final DateTime createdAt;
  bool isComplete;
  final String? description;

  TodoModel({
    required this.id,
    this.isComplete = false,
    required this.title,
    required this.createdAt,
    this.description,
  });
}
