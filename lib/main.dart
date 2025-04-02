import 'package:anguile_yann_master_prg19_examen/state_management/provider/authentification_service.dart';
import 'package:anguile_yann_master_prg19_examen/state_management/provider/project_provider.dart';
import 'package:anguile_yann_master_prg19_examen/state_management/provider/task_provider.dart';
import 'package:anguile_yann_master_prg19_examen/views/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'common/themes.dart';
import 'views/auth/login_screen.dart';
import 'views/components/controleur_utilisateur.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialisation du contrôleur utilisateur avec GetX
  Get.put(UserController());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthentificationService()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        StreamProvider<User?>(
          create: (context) => AuthentificationService().autStateChanges,
          initialData: null,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darktheme(context),
      home: user == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
