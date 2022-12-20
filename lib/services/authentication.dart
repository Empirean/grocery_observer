import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_observer/models/user.dart';
import 'package:grocery_observer/services/database.dart';

import '../constants/paths.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserModel?> get userInfo{
    return _firebaseAuth.authStateChanges().map((e) => e != null ? UserModel(uid: e.uid) : null);
  }

  Future signUpEmail({String email="", String password="", String firstName="", String lastName=""}) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      Map<String, String> data = {
        UserModel.fieldUID : uid,
        UserModel.fieldFIRSTNAME : firstName,
        UserModel.fieldLASTNAME : lastName
      };

      DatabaseService(path: Paths.users).addEntry(data);
      print("complete");
    }
    catch(e){
      return e.toString();
    }
  }

  Future signInEmail({String email="", String password=""}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      return e.toString();
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    }
    catch(e) {
      return e.toString();
    }
  }
}