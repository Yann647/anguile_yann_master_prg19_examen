import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/my_user.dart';

class AuthentificationService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  MyUserModel? _myUserModel;

  User? get user => _user;
  MyUserModel? get myUserModel => _myUserModel;

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

}