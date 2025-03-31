import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../models/project_model.dart';
import '../../models/task_model.dart';

class ProjectDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ajouter un projet à Firestore
  Future<void> saveProjectToFireStore(ProjectModel project) async {
    try {
      await _db.collection("projects").doc(project.id).set(project.toMap());
    } catch (error) {
      Logger().e('Erreur lors de l\'ajout du projet : $error');
    }
  }

  // Mettre à jour un projet
  Future<void> updateProjectToFireStore(ProjectModel project) async {
    try {
      await _db.collection("projects").doc(project.id).update(project.toMap());
    } catch (error) {
      Logger().e('Erreur lors de la mise à jour du projet : $error');
    }
  }

  // Récupérer un projet depuis Firestore
  Future<ProjectModel?> fetchProjectFromFireStore(String? id) async {
    if (id == null) return null;
    try {
      final projectDoc = await _db.collection("projects").doc(id).get();
      if (projectDoc.exists) {
        return ProjectModel.fromFirestore(projectDoc.data() as Map<String, dynamic>, id);
      }
    } catch (error) {
      Logger().e('Erreur lors de la récupération du projet : $error');
    }
    return null;
  }
}
