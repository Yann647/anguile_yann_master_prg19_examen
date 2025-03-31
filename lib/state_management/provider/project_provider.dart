import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/project_model.dart';

class ProjectProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ProjectModel> _projects = [];
  ProjectModel? _currentProject;

  List<ProjectModel> get projects => _projects;
  ProjectModel? get currentProject => _currentProject;

  // Charger tous les projets depuis Firestore
  Future<void> loadProjects() async {
    try {
      final snapshot = await _firestore.collection('projects').get();
      _projects = snapshot.docs
          .map((doc) => ProjectModel.fromFirestore(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Erreur lors du chargement des projets : $e");
      throw Exception("Impossible de charger les projets.");
    }
  }

  // Charger les détails d'un projet spécifique
  Future<void> loadProjectDetails(String projectId) async {
    try {
      final doc = await _firestore.collection('projects').doc(projectId).get();
      if (doc.exists) {
        _currentProject = ProjectModel.fromFirestore(doc.data()!, doc.id);
        notifyListeners();
      } else {
        throw Exception("Projet introuvable.");
      }
    } catch (e) {
      print("Erreur lors du chargement des détails du projet : $e");
      throw Exception("Impossible de charger les détails du projet.");
    }
  }

  // Ajouter un nouveau projet
  Future<void> addProject(ProjectModel project) async {
    try {
      final docRef = await _firestore.collection('projects').add(project.toMap());
      project.setId = docRef.id; // Assigner l'ID généré par Firestore
      _projects.add(project);
      notifyListeners();
    } catch (e) {
      print("Erreur lors de l'ajout du projet : $e");
      throw Exception("Impossible d'ajouter le projet.");
    }
  }

  // Mettre à jour un projet existant
  Future<void> updateProject(ProjectModel project) async {
    try {
      await _firestore.collection('projects').doc(project.id).update(project.toMap());
      final index = _projects.indexWhere((p) => p.id == project.id);
      if (index != -1) {
        _projects[index] = project;
        notifyListeners();
      }
    } catch (e) {
      print("Erreur lors de la mise à jour du projet : $e");
      throw Exception("Impossible de mettre à jour le projet.");
    }
  }

  // Supprimer un projet
  Future<void> deleteProject(String projectId) async {
    try {
      await _firestore.collection('projects').doc(projectId).delete();
      _projects.removeWhere((project) => project.id == projectId);
      notifyListeners();
    } catch (e) {
      print("Erreur lors de la suppression du projet : $e");
      throw Exception("Impossible de supprimer le projet.");
    }
  }

  // Réinitialiser le projet actuel
  void clearCurrentProject() {
    _currentProject = null;
    notifyListeners();
  }
}
