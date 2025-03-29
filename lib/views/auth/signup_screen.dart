import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/constante_colors.dart';
import '../../models/my_user.dart';
import '../../services/firestore/users_db.dart';
import '../../state_management/provider/authentification_service.dart';
import '../components/input_fields.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final AuthentificationService authService = AuthentificationService();
  final UserDatabase _userDatabase = UserDatabase();

  bool isLoading =false;
  String? errorMessage = '';

  Future<void>_signUp() async {
    setState(() => isLoading = true);
    await authService.createUserWitchEmailAndPassword(
        email: _emailController.text,
        password: _passWordController.text
    );

    MyUserModel user = MyUserModel(
      uid:  authService.user?.uid,
      email:  authService.user?.email,
      nom:  _nomController.text,
      prenom:  _prenomController.text,
    );

    await _userDatabase.saveUserDataToFireStore(user);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Inscription réussie !",
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
            ),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: kGreenColor,
        )
    );
    try{
      setState(() => isLoading = false);
    }on FirebaseAuthException catch(e) {
      setState(() {
        isLoading = false;
        errorMessage = e.message;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage!,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold
              ),
            ),
            duration: Duration(seconds: 5),
            backgroundColor: kErrorColor,
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Text(
                  "Bienvenue",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kDarkColor
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  "Créez un compte pour continuer",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kDarkColor
                  ),
                ),
                const SizedBox(height: 40,),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomInput(
                        controller: _prenomController,
                        labelText: "Prenom",
                        isRequired: true,
                        prefixIcon: Icons.person,
                        hintText: "Entrez votre prenom",
                      ),
                      const SizedBox(height: 20,),
                      CustomInput(
                        controller: _nomController,
                        labelText: "Nom",
                        isRequired: true,
                        prefixIcon: Icons.person,
                        hintText: "Entrez votre nom",
                      ),
                      const SizedBox(height: 20,),
                      CustomInput(
                        controller: _emailController,
                        labelText: "Email",
                        isRequired: true,
                        prefixIcon: Icons.email_outlined,
                        hintText: "Entrez votre email",
                      ),
                      const SizedBox(height: 20,),
                      CustomInput(
                        controller: _passWordController,
                        labelText: "Mot de passe",
                        isRequired: true,
                        isPassWord: true,
                        prefixIcon: Icons.lock_outline,
                        hintText: "Entrez votre mot de passe",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signUp,
                    style:ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ) ,
                    child: isLoading
                        ? SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation(
                            kPrimaryColor
                        ),
                      ),
                    ):Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: kWhiteColor
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Vous avez un compte ?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kgreyColor
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()
                            )
                        );
                      },
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}