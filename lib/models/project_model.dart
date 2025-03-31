import 'task_model.dart';

class ProjectModel {
  String? _id;
  String? _title;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _status;
  String? _priority;
  List<TaskModel>? _tasks;
  List<String>? _members;

  // Getters
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String? get status => _status;
  String? get priority => _priority;
  List<TaskModel>? get tasks => _tasks;
  List<String>? get members => _members;

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

  set setStartDate(DateTime value) {
    _startDate = value;
  }

  set setEndDate(DateTime value) {
    _endDate = value;
  }

  set setStatus(String value) {
    _status = value;
  }

  set setPriority(String value) {
    _priority = value;
  }

  set setTasks(List<TaskModel> value) {
    _tasks = value;
  }

  set setMembers(List<String> value) {
    _members = value;
  }

  // Constructeur
  ProjectModel({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? priority,
    List<TaskModel>? tasks,
    List<String>? members,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _startDate = startDate;
    _endDate = endDate;
    _status = status;
    _priority = priority;
    _tasks = tasks ?? [];
    _members = members ?? [];
  }

  // Convertir en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'description': _description,
      'startDate': _startDate?.toIso8601String(),
      'endDate': _endDate?.toIso8601String(),
      'status': _status,
      'priority': _priority,
      'tasks': _tasks?.map((task) => task.toMap()).toList(),
      'members': _members,
    };
  }

  // Convertir depuis Firestore
  factory ProjectModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProjectModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      startDate: data['startDate'] != null ? DateTime.tryParse(data['startDate']) : null,
      endDate: data['endDate'] != null ? DateTime.tryParse(data['endDate']) : null,
      status: data['status'] ?? '',
      priority: data['priority'] ?? '',
      tasks: (data['tasks'] as List<dynamic>?)
          ?.map((taskData) => TaskModel.fromMap(taskData as Map<String, dynamic>))
          .toList() ?? [],
      members: List<String>.from(data['members'] ?? []),
    );
  }




}
