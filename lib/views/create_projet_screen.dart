
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constante_colors.dart';
import '../models/project_model.dart';
import '../state_management/provider/project_provider.dart';
import 'components/input_fields.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  String _priority = 'Moyenne'; // Priorité par défaut
  bool isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _createProject() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final projectProvider = Provider.of<ProjectProvider>(context, listen: false);

        // Création d'un nouveau projet
        ProjectModel newProject = ProjectModel(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          startDate: DateTime.parse(_startDateController.text.trim()),
          endDate: DateTime.parse(_endDateController.text.trim()),
          priority: _priority,
          status: 'En attente', // Statut initial du projet
          members: [], // Les membres seront ajoutés ultérieurement
        );

        await projectProvider.addProject(newProject);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Projet créé avec succès !",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: kGreenColor,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.of(context).pop(); // Retour à la liste des projets
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
          title: const Text("Créer un Projet"),
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
                            labelText: "Titre du Projet",
                            isRequired: true,
                            prefixIcon: Icons.title,
                            hintText: "Entrez le titre du projet",
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: _descriptionController,
                            labelText: "Description",
                            isRequired: true,
                            prefixIcon: Icons.description,
                            hintText: "Entrez une description du projet",
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: _startDateController,
                            labelText: "Date de Début",
                            isRequired: true,
                            prefixIcon: Icons.date_range,
                            hintText: "YYYY-MM-DD",
                            onTapCallback: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _startDateController.text =
                                  pickedDate.toIso8601String().split('T')[0];
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            controller: _endDateController,
                            labelText: "Date de Fin",
                            isRequired: true,
                            prefixIcon: Icons.date_range_outlined,
                            hintText: "YYYY-MM-DD",
                            onTapCallback: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                DateTime.now().add(const Duration(days: 1)),
                                firstDate:
                                DateTime.now().add(const Duration(days: 1)),
                                lastDate:
                                DateTime(2100), // Limite supérieure pour la date de fin
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _endDateController.text =
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
                          24),ElevatedButton(onPressed:isLoading?null:_createProject,child:isLoading?CircularProgressIndicator():Text('Créer le Projet')
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}
