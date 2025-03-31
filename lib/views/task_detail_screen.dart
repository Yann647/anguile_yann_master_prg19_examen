
import 'package:flutter/material.dart';

import '../common/constante_colors.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(task.title),
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
                    task.priority,
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
                  label: Text(task.status),
                  backgroundColor:
                  task.status == 'En cours' ? kPrimaryColor : kGreyColor,
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
                  "Date limite : ${task.deadline.toLocal()}".split(' ')[0],
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
            ...task.assignedMembers.map((member) => ListTile(
    leading:
    const Icon(Icons.person_outline, color: kPrimaryColor),
    title: Text(member),
    )),

    const Divider(height: 30),

    // Fil de discussion
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text(
    "Fil de discussion",
    style:
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Expanded(
    child:
    ListView.builder( // Liste des commentaires
    itemCount:
    task.comments.length, // Nombre de commentaires
    itemBuilder:(context,index){final comment=task.comments[index];return ListTile(leading:
    Icon(Icons.message,color:kPrimaryColor),title:
    Text(comment['author']),subtitle:
    Text(comment['content']));}))),TextField(decoration:
    InputDecoration(labelText:'Ajouter un commentaire',suffixIcon:
    IconButton(icon:
    Icon(Icons.send),onPressed:
// Action pour envoyer un commentaire.
    (){},))))))));}}Color _getPriorityColor(String priority){switch(priority){case'Basse':return Colors.green;case'Moyenne':return Colors.orange;case'Haute':return Colors.red;case'Urgente':return Colors.purple;default:return Colors.grey;}}
