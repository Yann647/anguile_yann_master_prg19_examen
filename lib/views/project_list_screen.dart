import 'package:anguile_yann_master_prg19_examen/common/constante_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/project_model.dart';
import '../state_management/provider/project_provider.dart';
import 'create_projet_screen.dart';

class ProjetListScreen extends StatefulWidget {
  const ProjetListScreen({super.key});

  @override
  State<ProjetListScreen> createState() => _ProjectListScreenState();

}

class _ProjectListScreenState extends State<ProjetListScreen> {
  String _searchQuery = '';
  String _filterStatus = 'Tous'; // Valeur par défaut

  @override
  void initState() {
    super.initState();
    // Charger les projets au démarrage
    Provider.of<ProjectProvider>(context, listen: false).loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    List<ProjectModel> projects = projectProvider.projects;
    // Filtrer les projets en fonction de la recherche
    if (_searchQuery.isNotEmpty){
      projects =projects.where((project) => project.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    // Filtrer les projets en fonction du statut
    if (_filterStatus != 'Tous'){
      projects = projects.where((project) => project.status == _filterStatus).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Projets'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Afficher une boîte de dialogue de recherche
              showSearch(
                context: context,
                delegate: ProjectSearchDelegate(
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
          // Barre de filtre
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filtrer par statut:'),
                DropdownButton<String>(
                  value: _filterStatus,
                  items: <String>
                  ['Tous', 'En attente', 'En cours',
                    'Terminé', 'Annulé'].map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _filterStatus = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final projet = projects[index];
                return ProjectCard(projet: projet); // Utiliser un widget personnalisé
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
              builder: (context) => const CreateProjectScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}

// Classe pour la délégation de recherche
class ProjectSearchDelegate extends SearchDelegate<String> {
  final Function(String) onSearchChanged;

  ProjectSearchDelegate({required this.onSearchChanged});

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchChanged(query);
    return Container();
  }

}