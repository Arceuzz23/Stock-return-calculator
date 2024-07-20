import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  //collection reference
  final CollectionReference calcHistory =
  FirebaseFirestore.instance.collection('calculations');

  Future updateUserData(String calculations, String finalValue) async {
    return await calcHistory
        .doc("uid")
        .collection("history")
        .doc(calculations)
        .set({
      'calculations': calculations,
      'final_value': finalValue,
    });
  }

  addData(String calculations, String finalValue) async {
    if (calculations == "" && finalValue == "") {
      print("enter Required fields");
    } else {
      FirebaseFirestore.instance
          .collection("calculations")
          .doc("uid")
          .collection("history")
          .doc(calculations)
          .set({
        "Calculations": calculations,
        "Result": finalValue,
      }).then((value1) {
        print("data inserted");
      });
    }
  }

  Stream<QuerySnapshot> get calc {
    return calcHistory.snapshots();
  }
}
