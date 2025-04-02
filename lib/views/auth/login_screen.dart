import 'package:anguile_yann_master_prg19_examen/views/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../common/constante_colors.dart';
import '../../models/my_user.dart';
import '../../services/firestore/users_db.dart';
import '../../state_management/provider/authentification_service.dart';
import '../components/input_fields.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final AuthentificationService authService = AuthentificationService();
  final UserDatabase _userDatabase = UserDatabase();

  bool isLoading =false;
  String? errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  Future<void>_signIn() async {
    if(_formkey.currentState!.validate()){
      setState(() => isLoading = true);
      try{
        final authService = Provider.of<AuthentificationService>(context, listen: false);
        final userDatabase = UserDatabase();
        await authService.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passWordController.text
        );

        MyUserModel? user = await userDatabase.fetchUserDataToFireStore(authService.user?.uid);
        Logger().i("connected user: $user");
        if(user != null) {
          context.read<AuthentificationService>().setMyUserConnected(user);
        }

        // ignore: use_build_context_synchronously
        if (!context.mounted) return;


        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Vous êtes connecté !",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
              duration: Duration(seconds: 5),
              backgroundColor: kGreenColor,
            ),
        );
      }on FirebaseAuthException catch(ex) {
        setState(() {
          isLoading = false;
          errorMessage = ex.message;
        });

        // ignore: use_build_context_synchronously
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage!,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
              duration: Duration(seconds: 5),
              backgroundColor: kErrorColor,
            ),
        );

      }finally {
        setState(() => isLoading = false);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      Icons.lock_outline,
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
                  "Connectez-vous pour continuer",
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
                const SizedBox(height: 16,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Mot de passe oublié ?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _signIn,
                    style:ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        )
                    ) ,
                    child: isLoading
                        ? SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            kPrimaryColor
                        ),
                      ),
                    ):Text(
                      "Se connecter",
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
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: kgreyColor
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()
                            )
                        );
                      },
                      child: Text(
                        "S'inscrire",
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