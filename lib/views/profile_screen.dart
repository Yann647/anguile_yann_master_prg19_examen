import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constante_colors.dart';
import '../models/my_user.dart';
import '../state_management/provider/authentification_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthentificationService>(context);
    final MyUserModel? user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Utilisateur"),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Photo de profil
              CircleAvatar(
                radius: 50,
                backgroundImage: user?.photoUrl != null
                    ? NetworkImage(user!.photoUrl!)
                    : const AssetImage('assets/images/default_avatar.png')
                as ImageProvider,
              ),
              const SizedBox(height: 16),

              // Nom complet
              Text(
                "${user?.nom ?? ''} ${user?.prenom ?? ''}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Email
              Text(
                user?.email ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Bouton pour modifier le profil
              ElevatedButton.icon(
                onPressed: () {
                  // Naviguer vers l'écran d'édition du profil (à implémenter)
                  Navigator.pushNamed(context, '/edit-profile');
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text("Modifier le Profil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Liste des options supplémentaires
              ListTile(
                leading:
                Icon(Icons.lock_outline, color: kPrimaryColor.withOpacity(0.7)),
                title: const Text("Sécurité"),
                subtitle:
                const Text("Modifier le mot de passe ou les paramètres"),
                trailing:
                Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
                onTap: () {
                  // Naviguer vers l'écran de sécurité (à implémenter)
                  Navigator.pushNamed(context, '/security');
                },
              ),
              const Divider(),
              ListTile(
                leading:
                Icon(Icons.logout, color: kPrimaryColor.withOpacity(0.7)),
                title: const Text("Déconnexion"),
                subtitle:
                const Text("Se déconnecter de votre compte"),
                trailing:
                Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
                onTap: () async {
                  await authService.signOut(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
