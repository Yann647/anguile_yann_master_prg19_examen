import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../models/my_user.dart';

class UserDatabase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserDataToFireStore(MyUserModel user) async {
    try{
      await _db.collection("users").doc(user.uid).set({
        'email': user.email,
        'nom': user.nom,
        'prenom': user.prenom,
      });
    }catch (error) {
      Logger().e('Error saving user data to fireStore : $error');
    }
  }

  Future<void> updateUserDataToFireStore(MyUserModel user) async {
    try{
      await _db.collection("users").doc(user.uid).update({
        'email': user.email,
        'nom': user.nom,
        'prenom': user.prenom,
      });
    }catch (error) {
      Logger().e('Error saving user data to fireStore : $error');
    }
  }

  Future<MyUserModel?> fetchUserDataToFireStore(String? uid) async {
    Logger().i("fetchUserDataToFireStore uid: $uid");
    if (uid == null) return null;
    try{
      final userDoc = await _db.collection("users").doc(uid).get();
      Logger().i("fetchUserDataToFireStore userDoc: $userDoc");
      if(userDoc.exists) {
        return MyUserModel(
          uid:  uid,
          email:  userDoc.get('email'),
          nom:  userDoc.get('nom'),
          prenom:  userDoc.get('prenom'),
        );
      }
    }catch (error) {
      Logger().e('Error saving user data to fireStore : $error');
    }
  }

}