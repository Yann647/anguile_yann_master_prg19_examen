class MyUserModel {
  String? _uid;
  String? _email;
  String? _nom;
  String? _prenom;

  String? get uid => _uid;
  String? get email => _email;
  String? get nom => _nom;
  String? get prenom => _prenom;

  set setprenom(String value) {
    _prenom = value;
  }

  set setnom(String value) {
    _nom = value;
  }

  set setemail(String value) {
    _email = value;
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