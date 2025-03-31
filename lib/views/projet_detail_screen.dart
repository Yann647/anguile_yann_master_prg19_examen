
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constante_colors.dart';
import '../models/project_model.dart';
import '../state_management/provider/project_provider.dart';
import 'create_task_screen.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String projectId;

  const ProjectDetailScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les détails du projet au démarrage
    Provider.of<ProjectProvider>(context, listen: false)
        .loadProjectDetails(widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    ProjectModel? project = projectProvider.currentProject;

    if (project == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tâches',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: project.tasks.length,
                itemBuilder: (context, index) {
                  final task = project.tasks[index];
                  return TaskCard(task: task); // Utiliser un widget personnalisé
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTaskScreen(projectId: widget.projectId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
