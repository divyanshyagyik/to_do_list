class Todo {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });

  // Convert model to JSON for Firebase
  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'createdAt': createdAt.toIso8601String(),
  };

  // Create model from Firebase snapshot
  factory Todo.fromJson(Map<String, dynamic> json, String id) => Todo(
    id: id,
    title: json['title'],
    description: json['description'],
    isCompleted: json['isCompleted'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}
