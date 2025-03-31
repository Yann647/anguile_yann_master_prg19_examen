import 'package:flutter/material.dart';

import '../../common/constante_colors.dart';
import '../../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback? onTap;

  const ProjectCard({Key? key, required this.project, this.onTap}) : super(key: key);

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
              // Titre du projet
              Text(
                project.title?? 'pas de titre',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Description du projet
              Text(
                project.description??'Pas de description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),

              // Dates et statut
              Row(
                children: [
                  // Date de début
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: kPrimaryColor),
                      const SizedBox(width: 4),
                      Text(
                        project.startDate != null ? project.startDate!.toLocal().toString().split(' ')[0] : 'N/A',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),

                  // Date de fin
                  Row(
                    children: [
                      const Icon(Icons.event, size: 16, color: kPrimaryColor),
                      const SizedBox(width: 4),
                      Text(
                        project.endDate != null ? project.endDate!.toLocal().toString().split(' ')[0] : 'N/A',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Priorité et statut
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Priorité
                  Chip(
                    label: Text(
                      project.priority?? 'Proprieté inconnue',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: _getPriorityColor(project.priority?? ''),
                  ),

                  // Statut
                  Chip(
                    label: Text(project.status ??'Statut inconnu'),
                    backgroundColor: _getStatusColor(project.status?? ''),
                  ),
                ],
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
