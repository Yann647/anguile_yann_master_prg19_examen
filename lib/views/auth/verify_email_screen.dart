import 'package:anguile_yann_master_prg19_examen/common/constante_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class VerifyEmailScreen extends StatefulWidget{
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State <VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool isResending = false;
  String? errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Vérifie si l'email est déjà vérifié
    isEmailVerified = _auth.currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      _sendVerificationEmail();
    }

  }

  Future<void> _sendVerificationEmail() async {
    try {
      setState(() => isResending = true);
      await _auth.currentUser?.sendEmailVerification();
      setState(() => isResending = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              "Un email de vérification a été envoyé.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          backgroundColor: kGreenColor,
        ),
      );
    } catch (e) {
      setState(() => isResending = false);
      errorMessage = e.toString();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              errorMessage!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          backgroundColor: kErrorColor,
        ),
      );

    }
  }

  Future<void> _checkEmailVerified() async {
    await _auth.currentUser?.reload();
    setState(() {
      isEmailVerified = _auth.currentUser?.emailVerified ?? false;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              "Votre email a été vérifié avec succès !",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          backgroundColor: kGreenColor,
        ),
      );
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vérification de l'email"),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Icon(
                    Icons.email_outlined,
                    size: 100,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Vérifiez votre email",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: kDarkColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "Un email de vérification a été envoyé à votre adresse. Veuillez vérifier votre boîte de réception et cliquer sur le lien pour activer votre compte.",
                  style:
                  TextStyle(fontSize: 16, color: kDarkColor.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                if (!isEmailVerified)
                  ElevatedButton(
                      onPressed: isResending ? null : _sendVerificationEmail,
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                      child: isResending? CircularProgressIndicator():Text('Renvoyer l\'emai'),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _checkEmailVerified,
                    child: Text('Verifier Statut')
                )
              ],
            ),
          )
      ),
    );
  }

}