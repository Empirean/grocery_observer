import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_observer/services/database.dart';

class UserModel{
  final String uid;
  final String firstName;
  final String lastName;
  final String id;

  UserModel({this.uid="", this.firstName="", this.lastName="", this.id=""});

  static const String fieldUID = "UID";
  static const String fieldFIRSTNAME = "FIRST_NAME";
  static const String fieldLASTNAME = "LAST_NAME";
  static const String fieldID = "ID";

  List<UserModel> _mapUserInfo(QuerySnapshot user){
    return user.docs.map((doc){
      return UserModel(
        uid: doc[UserModel.fieldUID] ?? "",
        firstName: doc[UserModel.fieldFIRSTNAME] ?? "",
        lastName: doc[UserModel.fieldLASTNAME] ?? "",
        id: doc[UserModel.fieldID] ?? ""
      );
    }).toList();
  }

  Stream<List<UserModel>> watchOtherUsers({String firebasePath="", String field="", List<String> filter = const []}) {
    return DatabaseService(path: firebasePath).watchDocumentsNotInRange(filter: filter, field: field).map(_mapUserInfo);
  }
}