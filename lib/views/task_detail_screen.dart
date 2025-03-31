import 'package:flutter/material.dart';
import '../common/constante_colors.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(task.title ?? 'Sans titre'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de la tâche
            Text(
              "Titre : ${task.title}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Description
            Text(
              "Description : ${task.description}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Priorité
            Row(
              children: [
                const Text(
                  "Priorité : ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(
                    task.priority ?? 'Non défini',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getPriorityColor(task.priority),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Statut
            Row(
              children: [
                const Text(
                  "Statut : ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(task.status ?? 'Non défini'),
                  backgroundColor:
                  task.status == 'En cours' ? kPrimaryColor : kgreyColor,
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Date limite
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Date limite : ${task.deadline != null ? task.deadline!.toLocal().toString().split(' ')[0] : 'Non définie'}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Membres assignés
            const Text(
              "Membres assignés :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...(task.assignedMembers ?? []).map(
                  (member) => ListTile(
                leading: const Icon(Icons.person_outline, color: kPrimaryColor),
                title: Text(member),
              ),
            ),

            const Divider(height: 30),

            // Fil de discussion
            const Text(
              "Fil de discussion",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: task.comments != null && task.comments!.isNotEmpty
                  ? ListView.builder(
                itemCount: task.comments!.length,
                itemBuilder: (context, index) {
                  final comment = task.comments![index];
                  return ListTile(
                    leading: const Icon(Icons.message, color: kPrimaryColor),
                    title: Text(comment['author'] ?? 'Anonyme'),
                    subtitle: Text(comment['content'] ?? ''),
                  );
                },
              )
                  : const Center(child: Text("Aucun commentaire")),
            ),

            // Ajout d'un commentaire
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: 'Ajouter un commentaire',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String newComment = commentController.text.trim();
                      if (newComment.isNotEmpty) {
                        // TODO: Ajouter la logique pour envoyer un commentaire
                        print("Nouveau commentaire: $newComment");
                        commentController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fonction pour la couleur des priorités
Color _getPriorityColor(String? priority) {
  switch (priority) {
    case 'Basse':
      return Colors.green;
    case 'Moyenne':
      return Colors.orange;
    case 'Haute':
      return Colors.red;
    case 'Urgente':
      return Colors.purple;
    default:
      return Colors.grey;
  }
}
