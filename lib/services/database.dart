import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference _ref;
  String path;

  DatabaseService({this.path = ""}) {
    _ref = _firebaseFirestore.collection(path);
  }

  Future addEntry(Map<String, dynamic> data) async {
    return await _ref.add(data);
  }

  Future updateEntry(Map<String, dynamic> data, String id) async {
    return await _ref.doc(id).update(data);
  }

  Future deleteEntry(Map<String, dynamic> data, String id) async {
    return await _ref.doc(id).delete();
  }

  Stream<QuerySnapshot> watchAllDocuments() {
    return _ref.snapshots();
  }

  Stream<QuerySnapshot> watchAllDocumentsSorted(
      {String field = "", bool descending = false}) {
    return _ref.orderBy(field, descending: descending).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsInRange(
      {String field = "", List<String> filter = const []}) {
    return _ref.where(field, whereIn: filter).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsNotInRange(
      {String field = "", List<String> filter = const[]}) {
    return _ref.where(field, whereNotIn: filter).snapshots();
  }

  Stream<QuerySnapshot> watchDocumentsFilter({String field = "", String filter = ""}) {
    return _ref.where(field, isEqualTo: filter).snapshots();
  }

  Future<QuerySnapshot> getDocumentsAnyArray({String field="", String filter=""}) {
    return _ref.where(field, arrayContainsAny: [filter]).get();
  }

}