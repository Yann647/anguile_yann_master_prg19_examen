
import 'package:flutter/material.dart';

import '../common/constante_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de Bord Administrateur"),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section des statistiques générales
              const Text(
                "Statistiques Générales",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard("Projets En Cours", "12", Colors.blue),
                  _buildStatCard("Projets Terminés", "8", Colors.green),
                  _buildStatCard("Projets Annulés", "2", Colors.red),
                ],
              ),
              const SizedBox(height: 20),

              // Section des graphiques
              const Text(
                "Graphiques de Performance",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: _buildPieChart(),
              ),
              const SizedBox(height: 20),

              // Section de gestion des utilisateurs
              const Text(
                "Gestion des Utilisateurs",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildUserManagementSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une carte de statistique
  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher un graphique circulaire (pie chart)
  Widget _buildPieChart() {
    final data = [
      ChartData('En Cours', 12, Colors.blue),
      ChartData('Terminés', 8, Colors.green),
      ChartData('Annulés', 2, Colors.red),
    ];

    final series = [
      charts.Series<ChartData, String>(
        id: 'Projets',
        domainFn: (ChartData data, _) => data.label,
        measureFn: (ChartData data, _) => data.value,
        colorFn: (ChartData data, _) =>
            charts.ColorUtil.fromDartColor(data.color),
        data: data,
      )
    ];

    return charts.PieChart<String>(
      series,
      animate: true,
      defaultRenderer:
      charts.ArcRendererConfig(arcWidth: 60, arcRendererDecorators: [
        charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.inside)
      ]),
    );
  }

  // Widget pour la gestion des utilisateurs
  Widget _buildUserManagementSection() {
    return Column(
        children: [
          ListTile(
              leading:
              Icon(Icons.person_outline, color: kPrimaryColor.withOpacity(0.7)),
              title:
              const Text("Activer/Désactiver un utilisateur"),
              trailing:
              IconButton(icon:
              Icon(Icons.edit),onPressed:
// Action pour gérer les utilisateurs.
                  (){})),Divider(),ListTile(leading:
          Icon(Icons.group,color:kPrimaryColor.withOpacity(0.7)),title:
          Text('Voir tous les utilisateurs'),trailing:
          IconButton(icon:
          Icon(Icons.arrow_forward),onPressed:
// Action pour naviguer vers la liste complète.
              (){}))]);}}

class ChartData{final String label;final int value;final Color color;ChartData(this.label,this.value,this.color);}
