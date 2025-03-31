import 'package:anguile_yann_master_prg19_examen/common/constante_colors.dart';
import 'package:anguile_yann_master_prg19_examen/views/components/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state_management/provider/authentification_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();

}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>{
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future <void> _resetPassword() async {
    if (_formkey.currentState!.validate()){
      setState(() => isLoading = true);
      try{
        final authService = Provider.of<AuthentificationService>(context, listen: false);
        await authService.resetPassword(email: _emailController.text.trim());

        // Affichage d'un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Un email de réinitialisation a été envoyé à votre adresse.",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: kGreenColor,
          ),
        );

        Navigator.of(context).pop(); // Retour à la page de connexion

      } on Exception catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = e.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage!,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold
              ),
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: kErrorColor,
          ),
        );
      } finally {
        setState(() => isLoading = false );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réinitialiser le mot de passe"),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_reset_outlined,
                    size: 50,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Mot de passe oublié ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kDarkColor
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Entrez votre email pour réinitialiser votre mot de passe.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDarkColor
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    CustomInput(
                      controller: _emailController,
                      labelText: "Email",
                      isRequired: true,
                      prefixIcon: Icons.email_outlined,
                      hintText: "Entrez votre email",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kWhiteColor),
                  )
                      : const Text(
                    "Réinitialiser le mot de passe",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}