
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constante_colors.dart';
import '../models/task_model.dart';
import '../state_management/provider/task_provider.dart';
import 'components/input_fields.dart';

class CreateTaskScreen extends StatefulWidget {
  final String projectId;

  const CreateTaskScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deadlineController = TextEditingController();
  String _priority = 'Moyenne'; // Priorité par défaut
  List<String> _assignedMembers = []; // Liste des membres assignés

  bool isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _createTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);

        // Création d'une nouvelle tâche
        TaskModel newTask = TaskModel(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _priority,
          deadline: DateTime.parse(_deadlineController.text.trim()),
          assignedMembers: _assignedMembers,
          status: 'En attente', // Statut initial de la tâche
        );

        await taskProvider.addTask(widget.projectId, newTask);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Tâche créée avec succès !",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: kGreenColor,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.of(context).pop(); // Retour à la page précédente
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Erreur : $e",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: kErrorColor,
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Créer une Tâche"),
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInput(
                            controller: _titleController,
                            labelText: "Titre de la Tâche",
                            isRequired: true,
                            prefixIcon: Icons.title,
                            hintText: "Entrez le titre de la tâche",
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: _descriptionController,
                            labelText: "Description",
                            isRequired: true,
                            prefixIcon: Icons.description,
                            hintText: "Entrez une description pour la tâche",
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: _deadlineController,
                            labelText: "Date Limite",
                            isRequired: true,
                            prefixIcon: Icons.calendar_today_outlined,
                            hintText: "YYYY-MM-DD",
                            onTapCallback: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                DateTime(2100), // Limite supérieure pour la date limite
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _deadlineController.text =
                                  pickedDate.toIso8601String().split('T')[0];
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                              value: _priority,
                              decoration:
                              InputDecoration(labelText:"Priorité" ,border:
                              OutlineInputBorder()),
                              items:<String>['Basse','Moyenne','Haute','Urgente'].map((String priority)=>DropdownMenuItem(value:
                              priority,child:
                              Text(priority))).toList(),onChanged:(value)=>setState(()=>_priority=value!)),SizedBox(height:
                          24),ElevatedButton(onPressed:isLoading?null:_createTask,child:isLoading?CircularProgressIndicator():Text('Créer La Tâche'))])))));}}
