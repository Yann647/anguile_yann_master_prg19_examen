import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/controleur_utilisateur.dart';

class StatusScreen extends StatelessWidget {
  StatusScreen({Key? key}) : super(key: key);

  final UserController userController = Get.find(); // Récupérer le contrôleur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("État de l'utilisateur")),
      body: Center(
        child: Obx(() => Text(
          "État actuel : ${userController.status.value}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}