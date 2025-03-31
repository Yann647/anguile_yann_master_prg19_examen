class ProjectModel {
  String? id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String priority;
  final String status;
  final List<String> members;

  ProjectModel({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status,
    required this.members,
  });

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProjectModel(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      startDate: DateTime.parse(data['startDate']),
      endDate: DateTime.parse(data['endDate']),
      priority: data['priority'],
      status: data['status'],
      members: List<String>.from(data['members']),
    );
  }


}
