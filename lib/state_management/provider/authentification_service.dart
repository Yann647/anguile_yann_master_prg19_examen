import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/my_user.dart';

class AuthentificationService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  MyUserModel? _myUserModel;

  User? get user => _user;
  MyUserModel? get myUserModel => _myUserModel;

  MyUserModel? get currentUser => _myUserModel;

  Stream<User?> get autStateChanges => _auth.authStateChanges();

  AuthentificationService() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  void setMyUserConnected(MyUserModel? myUserModel) {
    _myUserModel = myUserModel;
    notifyListeners();
  }

  Future<void> signInWitchEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWitchEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    context.read<AuthentificationService>().setMyUserConnected(null);
  }

  // Méthode pour réinitialiser le mot de passe
  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Email de réinitialisation envoyé à $email");
    } catch (e) {
      print("Erreur lors de l'envoi de l'email de réinitialisation : $e");
      throw Exception("Impossible d'envoyer l'email de réinitialisation.");
    }
  }

}