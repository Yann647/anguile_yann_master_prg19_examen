import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../models/task_model.dart';

class TaskDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ajouter une tâche à Firestore
  Future<void> saveTaskToFireStore(TaskModel task) async {
    try {
      await _db.collection("tasks").doc(task.id).set(task.toMap());
    } catch (error) {
      Logger().e('Erreur lors de l\'ajout de la tâche : $error');
    }
  }

  // Mettre à jour une tâche existante
  Future<void> updateTaskToFireStore(TaskModel task) async {
    try {
      await _db.collection("tasks").doc(task.id).update(task.toMap());
    } catch (error) {
      Logger().e('Erreur lors de la mise à jour de la tâche : $error');
    }
  }

  // Récupérer une tâche depuis Firestore
  Future<TaskModel?> fetchTaskFromFireStore(String? id) async {
    if (id == null) return null;
    try {
      final taskDoc = await _db.collection("tasks").doc(id).get();
      if (taskDoc.exists) {
        return TaskModel.fromFirestore(taskDoc.data() as Map<String, dynamic>, id);
      }
    } catch (error) {
      Logger().e('Erreur lors de la récupération de la tâche : $error');
    }
    return null;
  }
}
