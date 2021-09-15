//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class crudProduct {
  Future<void> addData(jobs) async {
    FirebaseFirestore.instance
        .collection('job posts')
        .add(jobs)
        .catchError((e) {
      print(e);
    });
  }
}
