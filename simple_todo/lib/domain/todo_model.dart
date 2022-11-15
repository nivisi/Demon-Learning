import 'package:flutter/foundation.dart';

class TodoModel with ChangeNotifier {
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

  void toggleCompleteStatus() {
    isComplete = !isComplete;
    notifyListeners();
  }
}
