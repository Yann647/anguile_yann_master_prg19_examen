import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'detail_state.dart';

class Details extends StatelessWidget {
  final String prenom;
  final String nom;
  final String password;

  const Details({
    Key? key,
    required this.prenom,
    required this.nom,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details Utilisateur")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom: $nom", style: const TextStyle(fontSize: 18)),
            Text("Prénom: $prenom", style: const TextStyle(fontSize: 18)),
            Text("Mot de passe: $password",
                style: const TextStyle(fontSize: 18)),

            ElevatedButton(
              onPressed: () {
                // Aller à la page d'état
                Get.to(() => StatusScreen());
              },
              child: const Text("Voir l'état"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Changer l’état avec GetX
                //UserController.toggleStatus();
              },
              child: const Text("Changer l'état"),
            )],
        ),
      ),
    );
  }
}