import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constante_colors.dart';
import '../models/task_model.dart';
import '../state_management/provider/task_provider.dart';
import 'create_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Charger les tâches au démarrage
    Provider.of<TaskProvider>(context, listen: false).loadTasks("projectId"); // Remplacez "projectId" par l'ID réel du projet
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    List<TaskModel> tasks = taskProvider.tasks;

    // Filtrer les tâches en fonction de la recherche
    if (_searchQuery.isNotEmpty) {
      tasks = tasks.where((task) => task.title!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Tâches'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Afficher une boîte de dialogue de recherche
              showSearch(
                context: context,
                delegate: TaskSearchDelegate(
                  onSearchChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title ?? 'Titre inconnu'),
                  subtitle: Text(task.description ?? 'Pas de description'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await taskProvider.deleteTask("projectId", task.id!); // Remplacez "projectId" par l'ID réel du projet
                    },
                  ),
                  onTap: () {
                    // Naviguer vers l'écran de modification de tâche (à implémenter)
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTaskScreen(projectId: "projectId"), // Remplacez "projectId" par l'ID réel du projet
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Classe pour la délégation de recherche
class TaskSearchDelegate extends SearchDelegate<String> {
  final Function(String) onSearchChanged;

  TaskSearchDelegate({required this.onSearchChanged});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearchChanged('');
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Implémentez les résultats si nécessaire
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchChanged(query);
    return Container(); // Implémentez les suggestions si nécessaire
  }
}
