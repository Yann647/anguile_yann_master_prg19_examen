class TaskModel {
  String? id;
  final String title;
  final String description;
  final String priority;
  final DateTime deadline;
  final List<String> assignedMembers;
  final String status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.deadline,
    required this.assignedMembers,
    required this.status,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      priority: data['priority'],
      deadline: DateTime.parse(data['deadline']),
      assignedMembers: List<String>.from(data['assignedMembers']),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'deadline': deadline.toIso8601String(),
      'assignedMembers': assignedMembers,
      'status': status,
    };
  }
}
