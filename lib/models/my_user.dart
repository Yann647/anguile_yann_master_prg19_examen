class MyUserModel {
  String? _uid;
  String? _email;
  String? _nom;
  String? _prenom;
  String? _photoUrl;

  String? get uid => _uid;
  String? get email => _email;
  String? get nom => _nom;
  String? get prenom => _prenom;
  String? get photoUrl => _photoUrl;

  set setprenom(String value) {
    _prenom = value;
  }

  set setnom(String value) {
    _nom = value;
  }

  set setemail(String value) {
    _email = value;
  }

  set setphotoUrl(String value) {
    _photoUrl = value;
  }

  MyUserModel({
      String? uid,
      String? email,
      String? nom,
      String? prenom}){
    _uid = uid;
    _email = email;
    _nom = nom;
    
  }
}