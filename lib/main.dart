import 'package:anguile_yann_master_prg19_examen/state_management/provider/authentification_service.dart';
import 'package:anguile_yann_master_prg19_examen/views/auth/login_screen.dart';
import 'package:anguile_yann_master_prg19_examen/views/components/controleur_utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'common/constante_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion de Projets Collaboratifs',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}




