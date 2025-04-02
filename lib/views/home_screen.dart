import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constante_colors.dart';
import '../state_management/provider/authentification_service.dart';
import 'project_list_screen.dart';
import 'task_list_screen.dart';
import 'profile_screen.dart';
import 'admin_dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthentificationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Deux colonnes
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            children: [
              _buildNavigationCard(
                context,
                title: "Projets",
                icon: Icons.folder_open,
                color: Colors.blue,
                routeName: '/projects',
                destinationScreen: const ProjetListScreen(),
              ),
              _buildNavigationCard(
                context,
                title: "Tâches",
                icon: Icons.task_alt,
                color: Colors.green,
                routeName: '/tasks',
                destinationScreen: const TaskListScreen(),
              ),
              _buildNavigationCard(
                context,
                title: "Profil",
                icon: Icons.person,
                color: Colors.orange,
                routeName: '/profile',
                destinationScreen: const ProfileScreen(),
              ),
              _buildNavigationCard(
                context,
                title: "Admin",
                icon: Icons.admin_panel_settings,
                color: Colors.red,
                routeName: '/admin',
                destinationScreen: const AdminDashboardScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour créer une carte de navigation
  Widget _buildNavigationCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        required String routeName,
        required Widget destinationScreen,
      }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration:
          BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
