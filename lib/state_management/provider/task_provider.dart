
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TaskModel> _tasks = [];
  TaskModel? _currentTask;

  List<TaskModel> get tasks => _tasks;
  TaskModel? get currentTask => _currentTask;

  // Charger toutes les tâches d'un projet depuis Firestore
  Future<void> loadTasks(String projectId) async {
    try {
      final snapshot = await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .get();
      _tasks = snapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Erreur lors du chargement des tâches : $e");
      throw Exception("Impossible de charger les tâches.");
    }
  }

  // Charger les détails d'une tâche spécifique
  Future<void> loadTaskDetails(String projectId, String taskId) async {
    try {
      final doc = await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .get();
      if (doc.exists) {
        _currentTask = TaskModel.fromFirestore(doc);
        notifyListeners();
      } else {
        throw Exception("Tâche introuvable.");
      }
    } catch (e) {
      print("Erreur lors du chargement des détails de la tâche : $e");
      throw Exception("Impossible de charger les détails de la tâche.");
    }
  }

  // Ajouter une nouvelle tâche à un projet
  Future<void> addTask(String projectId, TaskModel task) async {
    try {
      final docRef = await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .add(task.toMap());
      task.id = docRef.id; // Assigner l'ID généré par Firestore
      _tasks.add(task);
      notifyListeners();
    } catch (e) {
      print("Erreur lors de l'ajout de la tâche : $e");
      throw Exception("Impossible d'ajouter la tâche.");
    }
  }

  // Mettre à jour une tâche existante
  Future<void> updateTask(String projectId, TaskModel task) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(task.id)
          .update(task.toMap());
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
    } catch (e) {
      print("Erreur lors de la mise à jour de la tâche : $e");
      throw Exception("Impossible de mettre à jour la tâche.");
    }
  }

  // Supprimer une tâche d'un projet
  Future<void> deleteTask(String projectId, String taskId) async {
    try {
      await _firestore
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .delete();
      _tasks.removeWhere((task) => task.id == taskId);
      notifyListeners();
    } catch (e) {
      print("Erreur lors de la suppression de la tâche : $e");
      throw Exception("Impossible de supprimer la tâche.");
    }
  }

  // Réinitialiser la tâche actuelle
  void clearCurrentTask() {
    _currentTask = null;
    notifyListeners();
  }
}
