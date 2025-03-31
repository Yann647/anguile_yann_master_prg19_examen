import 'package:flutter/material.dart';

import '../../common/constante_colors.dart';
import '../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;

  const TaskCard({Key? key, required this.task, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre de la tâche
              Text(
                task.title ?? 'Tâche sans titre',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Description de la tâche
              Text(
                task.description ?? 'Aucune description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),

              // Priorité et date limite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Priorité
                  Chip(
                    label: Text(
                      task.priority ?? 'Priorité inconnue',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _getPriorityColor(task.priority ?? ''),
                  ),

                  // Date limite
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: kPrimaryColor),
                      const SizedBox(width: 4),
                      Text(
                        task.deadline != null
                            ? task.deadline!.toLocal().toString().split(' ')[0]
                            : 'Pas de date',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Statut
              Chip(
                label: Text(task.status ?? 'Statut inconnu'),
                backgroundColor: _getStatusColor(task.status ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Couleur en fonction de la priorité
  Color _getPriorityColor(String priority) {
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

  // Couleur en fonction du statut
  Color _getStatusColor(String status) {
    switch (status) {
      case 'En attente':
        return Colors.blue;
      case 'En cours':
        return Colors.orange;
      case 'Terminé':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
