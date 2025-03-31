
class TaskModel {
  String? _id;
  String? _title;
  String? _description;
  DateTime? _deadline;
  String? _status;
  String? _priority;
  List<String>? _assignedMembers;
  List<Map<String, String>>? _comments;

  // Getters
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  DateTime? get deadline => _deadline;
  String? get status => _status;
  String? get priority => _priority;
  List<String>? get assignedMembers => _assignedMembers;
  List<Map<String, String>>? get comments => _comments;

  // Setters
  set setId(String value) {
    _id = value;
  }

  set setTitle(String value) {
    _title = value;
  }

  set setDescription(String value) {
    _description = value;
  }

  set setDeadline(DateTime value) {
    _deadline = value;
  }

  set setStatus(String value) {
    _status = value;
  }

  set setPriority(String value) {
    _priority = value;
  }

  set setAssignedMembers(List<String> value) {
    _assignedMembers = value;
  }

  set setComments(List<Map<String, String>> value) {
    _comments = value;
  }

  // Constructeur
  TaskModel({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    String? status,
    String? priority,
    List<String>? assignedMembers,
    List<Map<String, String>>? comments
  }) {
    _id = id;
    _title = title;
    _description = description;
    _deadline = deadline;
    _status = status;
    _priority = priority;
    _assignedMembers = assignedMembers ?? [];
    _comments = comments ?? [];
  }

  // Convertir en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'description': _description,
      'deadline': _deadline?.toIso8601String(),
      'status': _status,
      'priority': _priority,
      'assignedMembers': _assignedMembers,
      'comments': _comments,
    };
  }

  // Convertir depuis Firestore
  factory TaskModel.fromFirestore(Map<String, dynamic> data, String id) {
    return TaskModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      deadline: data['deadline'] != null ? DateTime.tryParse(data['deadline']) : null,
      status: data['status'] ?? '',
      priority: data['priority'] ?? '',
      assignedMembers: List<String>.from(data['assignedMembers'] ?? []),
      comments: (data['comments'] as List<dynamic>?)
          ?.map((comment) => Map<String, String>.from(comment))
          .toList() ?? [],
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      deadline: data['deadline'] != null ? DateTime.tryParse(data['deadline']) : null,
      status: data['status'] ?? '',
      priority: data['priority'] ?? '',
      assignedMembers: List<String>.from(data['assignedMembers'] ?? []),
      comments: (data['comments'] as List<dynamic>?)
          ?.map((comment) => Map<String, String>.from(comment))
          .toList() ?? [],
    );
  }



}
